# TriVoxel
ポリゴン（三角形）と ボクセル（軸平行直方体）との 衝突/交差/干渉（Collision）を判定する方法。この手法を利用することで、任意のポリゴンモデルをボクセルモデルへ高速に変換することが可能となる。

アルゴリズムとしては、PEF法 と SAT法 の両方を実装。もちろん"接触"に近い衝突の場合、数値誤差によって結果が曖昧になるが、その他の一般的な状態において基本的に同一の結果が得られることを確認した。

![](https://media.githubusercontent.com/media/LUXOPHIA/TriVoxel/master/--------/_SCREENSHOT/TriVoxel.png)

なお、三角形を完全に覆う 26-separating 形式の衝突判定アルゴリズムを対象とする。
> ![](https://shikihuiku.files.wordpress.com/2012/08/voxel_cross_tri_voxelize.png)  
> \* [GPU上でのvoxel構築手法](https://shikihuiku.wordpress.com/2012/08/02/gpu上でのvoxel構築手法/)：[shikihuiku](https://shikihuiku.wordpress.com)

----
３Ｄ空間での **点座標** は、以下のレコード型によって定義される。

> [`LUX.D3`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX/LUX.D3.pas).pas

> * [`TSingle3D`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX/LUX.D3.pas#L205) = **record**
> * [`TDouble3D`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX/LUX.D3.pas#L277) = **record**
>     * `X`/`Y`/`Z` :Double  
>     座標値。

３Ｄ空間での **軸平行な直方体(AABB:Axis Aligned Bounding Box)** は、以下のレコード型によって定義される。

> [`LUX.D3`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX/LUX.D3.pas).pas
> * [`TSingleArea3D`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX/LUX.D3.pas#L503) = **record**
> * [`TDoubleArea3D`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX/LUX.D3.pas#L555) = **record**
>     * `Min` :TDouble3D  
>     XYZ軸方向の最小値。
>     * `Max` :TDouble3D  
>     XYZ軸方向の最大値。
>     * **function** [`Collision`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX/LUX.D3.pas#L602)( **const** Area_:TDoubleArea3D ) :Boolean  
>     3D-AABB 同士の衝突判定。

３Ｄ空間での **三角形平面** は、以下のレコード型によって定義される。

> [`LUX.Geometry.D3`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX.Geometry/LUX.Geometry.D3.pas).pas
> * [`TSingleTria3D`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX.Geometry/LUX.Geometry.D3.pas#L80) = **record**
> * [`TDoubleTria3D`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX.Geometry/LUX.Geometry.D3.pas#L127) = **record**
>     * `Poin1`/`2`/`3` :TDouble3D  
> 三頂点の座標。
>     * **property** `Norv` :TDouble3D  
> 法線ベクトル。
>     * **property** `Edge1`/`2`/`3` :TDouble3D  
> 頂点`Poin1`/`2`/`3`に正対する辺のベクトル。
>     * **property** `ProjXY` :TDoubleTria2D  
> ＸＹ平面上へ投影した２Ｄの三角形。
>     * **property** `ProjYZ` :TDoubleTria2D  
> ＹＺ平面上へ投影した２Ｄの三角形。
>     * **property** `ProjZX` :TDoubleTria2D  
> ＺＸ平面上へ投影した２Ｄの三角形。
>     * **property** `AABB` :TDoubleArea3D  
> 三角面を内包する 3D-AABB 。
>     * **function** [`CollisionPEF`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX.Geometry/LUX.Geometry.D3.pas#L161)( **const** Area_:TDoubleArea3D ) :Boolean  
> PEF法 による 3D-AABB との衝突判定。
>     * **function** [`CollisionSAT`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX.Geometry/LUX.Geometry.D3.pas#L162)( **const** Area_:TDoubleArea3D ) :Boolean  
> SAT法 による 3D-AABB との衝突判定。

----
## PEF : Projected Edge Function
３Ｄの三角形を XY, YZ, ZX 平面へ投影した上で、２次元の衝突判定を利用する方法。
> ![](https://developer.nvidia.com/sites/default/files/akamai/gameworks/images/Voxelization/Voxelization_blog_fig_5.png)  
> \* [The Basics of GPU Voxelization](https://developer.nvidia.com/content/basics-gpu-voxelization)：[NVIDIA Developer](https://developer.nvidia.com)

２Ｄ空間での **点座標** は、以下のレコード型によって定義される。

> `LUX.D2`.pas
> * `TSingle2D` = **record**
> * `TDouble2D` = **record**
>     * `X`/`Y` :Double  
> 座標値。

２Ｄ空間での **軸平行な長方形(AABB:Axis Aligned Bounding Box)** は、以下のレコード型によって定義される。

> `LUX.D2`.pas
> * `TSingleArea2D` = **record**
> * `TDoubleArea2D` = **record**
>     * `Min` :TSingle2D  
> X/Y軸方向の最小値。
>     * `Max` :TSingle2D  
> X/Y軸方向の最大値。
>     * **function** `Collision`( **const** Area_:TSingleArea2D ) :Boolean  
> 2D-AABB 同士の衝突判定。

２Ｄ空間での **三角形** は、以下のレコード型によって定義される。

> `LUX.Geometry.D2`.pas
> * `TSingleTria2D` = **record**
> * `TDoubleTria2D` = **record**
>     * `Poin1`/`2`/`3` :TDouble2D  
> 三頂点の座標。
>     * **property** `Norv` :Double  
> 概念的な法線のＺ成分。正ならば表。負ならば裏。
>     * **property** `Edge1`/`2`/`3` :TDouble2D  
> 頂点`Poin1`/`2`/`3` に正対する辺のベクトル。
>     * **property** `Enor1`/`2`/`3` :Double  
> **辺法線**：辺に垂直な内側向きのベクトル。
>     * **property** `AABB` :TSingleArea2D  
> 三角形を内包する 2D-AABB 。
>     * **function** `Collision`( **const** Area_:TDoubleArea2D ) :Boolean  
> 2D-AABB との衝突判定。

２Ｄにおける三角形と長方形の衝突判定には、三角形の辺に垂直な**内向き**のベクトル（辺法線）を用い、以下の２つの条件が満たされる場合、三角形と長方形は衝突していると判定できる。

> 1. 三角形`TDoubleTria2D`の AABB が、長方形`TDoubleArea2D`と衝突する。  
> 1. 三角形の３辺すべてにおいて、辺法線`Enor*`の方向に沿って**最も前方**の長方形の頂点が辺の内側に入る。  
> `function TDoubleTria2D.ColliEdge( const Area_:TDoubleArea2D ) :Boolean`メソッドを用いる。

![](https://media.githubusercontent.com/media/LUXOPHIA/TriVoxel/master/--------/_README/Collision2D_TRI-BOX.png)  

２Ｄにおける三角形と長方形の衝突判定を実装すると以下のようになる。

```pascal
function TDoubleTria2D.Collision( const Area_:TDoubleArea2D ) :Boolean;
begin
     Result := AABB.Collision( Area_ ) and ColliEdge( Area_ );
end;
```

ただ、第１条件の 2D-AABB 同士の衝突は、わざわざ射影した２Ｄ上で判定せずとも、元の３Ｄ空間での 3D-AABB 同士の衝突としてまとめることができるので、最終的な実装としては以下のようになる。

```pascal
function TDoubleTria3D.CollisionPEF( const Area_:TDoubleArea3D ) :Boolean;
//······································
     function CheckPlane :Boolean;
     begin
          ～
     end;
//······································
begin
     Result := AABB.Collision( Area_ )
           and CheckPlane
           and ProjXY.ColliEdge( Area_.ProjXY )
           and ProjYZ.ColliEdge( Area_.ProjYZ )
           and ProjZX.ColliEdge( Area_.ProjZX );
end;
```

なお、２Ｄの衝突判定を３軸方向から行ったとしても、三角ポリゴンの法線方向の衝突は判定できないため、ポリゴンの法線方向に沿った衝突を判定する`CheckPlane`関数が加えられている。
> ![](https://shikihuiku.files.wordpress.com/2012/08/voxel_cross_plane1.png)  
> \* [GPU上でのvoxel構築手法](https://shikihuiku.wordpress.com/2012/08/02/gpu上でのvoxel構築手法/)：[shikihuiku](https://shikihuiku.wordpress.com)

----

## SAT : Separating Axis Theorem
[分離超平面定理](https://ja.wikipedia.org/wiki/分離超平面定理) を利用することで、３次元的にポリゴンとボクセルの衝突判定を行う方法。
> [[YouTube]](https://www.youtube.com)  
> [![Separating Axis Theorem (SAT) Explanation.](http://img.youtube.com/vi/Ap5eBYKlGDo/maxresdefault.jpg)](https://youtu.be/Ap5eBYKlGDo)  
> \* [Separating Axis Theorem (SAT) Explanation.](https://youtu.be/Ap5eBYKlGDo)：[Hilze Vonck](https://www.youtube.com/channel/UC8C7ncaMYnXyu-pRU0S9FLg)

２つの凸体が衝突していなければ、必ず分離面を差し挟むことのできる方向（分離軸：Separating axis）が存在する。つまり、どの方向から見ても隙間が存在しなければ、２つの凸体は衝突している。
> ![Illustration of the hyperplane separation theorem.](https://upload.wikimedia.org/wikipedia/commons/9/9b/Separating_axis_theorem2008.png)  
> \* [Hyperplane separation theorem](https://en.wikipedia.org/wiki/Hyperplane_separation_theorem)：[Wikipedia](https://en.wikipedia.org)

凸体を多面体に限るのであれば、調べるべき方向の数は有限となる。ポリゴンとボクセルの場合、13方向について調べるだけでよい。
> ![](https://www.researchgate.net/profile/Carsten_Preusche/publication/224990152/figure/fig2/AS:302767072661505@1449196703470/Figure-3-Collision-detection-between-triangle-and-voxel-using-the-Separating-Axis.png)  
> \* [Improvements of the Voxmap-PointShell Algorithm - Fast Generation of Haptic Data-Structures](https://www.researchgate.net/publication/224990152_Improvements_of_the_Voxmap-PointShell_Algorithm_-_Fast_Generation_of_Haptic_Data-Structures)：[ResearchGate](https://www.researchgate.net)

----
## ■実装



----

* [The Basics of GPU Voxelization](https://developer.nvidia.com/content/basics-gpu-voxelization)：[NVIDIA Developer](https://developer.nvidia.com)
* [GPU上でのvoxel構築手法](https://shikihuiku.wordpress.com/2012/08/02/gpu上でのvoxel構築手法/)：[shikihuiku](https://shikihuiku.wordpress.com)
* [Improvements of the Voxmap-PointShell Algorithm - Fast Generation of Haptic Data-Structures](https://www.researchgate.net/publication/224990152_Improvements_of_the_Voxmap-PointShell_Algorithm_-_Fast_Generation_of_Haptic_Data-Structures)：[ResearchGate](https://www.researchgate.net)
* [Fast Parallel Surface and Solid Voxelization on GPUs](http://research.michael-schwarz.com/publ/files/vox-siga10.pdf)：[Michael Schwarz](http://research.michael-schwarz.com)
* [VoxelPipe: A Programmable Pipeline for 3D Voxelization](http://research.nvidia.com/publication/voxelpipe-programmable-pipeline-3d-voxelization)：[NVIDIA Research](https://www.nvidia.com/en-us/research/)

[![Delphi Starter](http://img.en25.com/EloquaImages/clients/Embarcadero/%7B063f1eec-64a6-4c19-840f-9b59d407c914%7D_dx-starter-bn159.png)](https://www.embarcadero.com/jp/products/delphi/starter)
