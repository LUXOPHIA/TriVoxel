# TriVoxel
 How to detect collision between a polygon (triangle) and a voxel (AABB)?
 
[ポリゴン](https://ja.wikipedia.org/wiki/ポリゴン)：[Polygon](https://en.wikipedia.org/wiki/Polygon_(computer_graphics))（三角形）と [ボクセル](https://ja.wikipedia.org/wiki/ボクセル)：[Voxel](https://en.wikipedia.org/wiki/Voxel)（軸平行直方体）との [衝突/交差/干渉を判定](https://ja.wikipedia.org/wiki/衝突判定)([Collision detection](https://en.wikipedia.org/wiki/Collision_detection)) する方法。この手法を利用することで、任意のポリゴンモデルをボクセルモデルへ高速に変換することが可能となる。

アルゴリズムとしては、PEF法 と SAT法 の両方を実装。もちろん"接触"に近い衝突の場合、数値誤差によって結果が曖昧になるが、そのようなレアケースを除いて、本質的に同一の結果が得られることを確認した。

![](https://media.githubusercontent.com/media/LUXOPHIA/TriVoxel/master/--------/_SCREENSHOT/TriVoxel.png)

なお、三角形を完全に覆う 26-separating 形式の衝突判定アルゴリズムを対象とする。
> ![](https://shikihuiku.files.wordpress.com/2012/08/voxel_cross_tri_voxelize.png)  
> \* [GPU上でのvoxel構築手法](https://shikihuiku.wordpress.com/2012/08/02/gpu上でのvoxel構築手法/)：[shikihuiku](https://shikihuiku.wordpress.com)

----
３Ｄでの **点座標** は、以下のレコード型によって定義される。

> [`LUX.D3`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX/LUX.D3.pas).pas
> 
> * [`TSingle3D`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX/LUX.D3.pas#L205) = **record**
> * [`TDouble3D`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX/LUX.D3.pas#L277) = **record**
>     * `X`/`Y`/`Z` :Double  
>     座標値。

３Ｄでの **軸平行な直方体(AABB:Axis Aligned Bounding Box)** は、以下のレコード型によって定義される。

> [`LUX.D3`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX/LUX.D3.pas).pas
> 
> * [`TSingleArea3D`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX/LUX.D3.pas#L503) = **record**
> * [`TDoubleArea3D`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX/LUX.D3.pas#L555) = **record**
>     * `Min` :TDouble3D  
>     XYZ軸方向の最小値。
>     * `Max` :TDouble3D  
>     XYZ軸方向の最大値。
>     * **function** `ProjVec`( **const** Vec_:TDouble3D ) :TDoubleArea  
> 任意のベクトル方向へ射影した１Ｄの範囲を返す。
>     * **function** [`Collision`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX/LUX.D3.pas#L602)( **const** Area_:TDoubleArea3D ) :Boolean  
> 3D-AABB 同士の衝突判定。

３Ｄでの **三角形平面** は、以下のレコード型によって定義される。

> [`LUX.Geometry.D3`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX.Geometry/LUX.Geometry.D3.pas).pas
> 
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
>     * **function** `ProjVec`( **const** Vec_:TDouble3D ) :TDoubleArea  
> 任意のベクトル方向へ射影した１Ｄの範囲を返す。
>     * **function** [`CollisionPEF`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX.Geometry/LUX.Geometry.D3.pas#L161)( **const** Area_:TDoubleArea3D ) :Boolean  
> PEF法 による 3D-AABB との衝突判定。
>     * **function** [`CollisionSAT`](https://github.com/LUXOPHIA/TriVoxel/blob/master/_LIBRARY/LUXOPHIA/LUX.Geometry/LUX.Geometry.D3.pas#L162)( **const** Area_:TDoubleArea3D ) :Boolean  
> SAT法 による 3D-AABB との衝突判定。

----
## ■ PEF : Projected Edge Function
３Ｄの三角形を XY, YZ, ZX 平面へ投影した上で、２Ｄの衝突判定を利用する方法。
> ![](https://developer.nvidia.com/sites/default/files/akamai/gameworks/images/Voxelization/Voxelization_blog_fig_5.png)  
> \* [The Basics of GPU Voxelization](https://developer.nvidia.com/content/basics-gpu-voxelization)：[NVIDIA Developer](https://developer.nvidia.com)

２Ｄでの **点座標** は、以下のレコード型によって定義される。

> `LUX.D2`.pas
> 
> * `TSingle2D` = **record**
> * `TDouble2D` = **record**
>     * `X`/`Y` :Double  
> 座標値。

２Ｄでの **軸平行な長方形(AABB:Axis Aligned Bounding Box)** は、以下のレコード型によって定義される。

> `LUX.D2`.pas
> 
> * `TSingleArea2D` = **record**
> * `TDoubleArea2D` = **record**
>     * `Min` :TSingle2D  
> X/Y軸方向の最小値。
>     * `Max` :TSingle2D  
> X/Y軸方向の最大値。
>     * **function** `Collision`( **const** Area_:TSingleArea2D ) :Boolean  
> 2D-AABB 同士の衝突判定。

２Ｄでの **三角形** は、以下のレコード型によって定義される。

> `LUX.Geometry.D2`.pas
> 
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
> 
> ![](https://media.githubusercontent.com/media/LUXOPHIA/TriVoxel/master/--------/_README/Collision2D_TRI-BOX.png) 

２Ｄにおける三角形と長方形の衝突判定を実装すると以下のようになる。

```pascal
function TDoubleTria2D.Collision( const Area_:TDoubleArea2D ) :Boolean;
begin
     Result := AABB.Collision( Area_ ) and ColliEdge( Area_ );
end;
```

ただ、第１条件の 2D-AABB 同士の衝突は、わざわざ射影した２Ｄ上で判定せずとも、元の３Ｄでの 3D-AABB 同士の衝突としてまとめることができるので、最終的な実装としては以下のようになる。

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

なお、２Ｄの衝突判定を３軸方向から行ったとしても、３Ｄでの衝突判定としては不十分であるため、ポリゴンの法線方向に沿った衝突を判定する`CheckPlane`関数が加えられている。
> ![](https://shikihuiku.files.wordpress.com/2012/08/voxel_cross_plane1.png)  
> \* [GPU上でのvoxel構築手法](https://shikihuiku.wordpress.com/2012/08/02/gpu上でのvoxel構築手法/)：[shikihuiku](https://shikihuiku.wordpress.com)

----

## ■ SAT : Separating Axis Theorem
[分離超平面定理](https://ja.wikipedia.org/wiki/分離超平面定理) を利用することで、３次元的にポリゴンとボクセルの衝突判定を行う方法。
> [[YouTube]](https://www.youtube.com)  
> [![Separating Axis Theorem (SAT) Explanation.](http://img.youtube.com/vi/Ap5eBYKlGDo/maxresdefault.jpg)](https://youtu.be/Ap5eBYKlGDo)  
> \* [Separating Axis Theorem (SAT) Explanation.](https://youtu.be/Ap5eBYKlGDo)：[Hilze Vonck](https://www.youtube.com/channel/UC8C7ncaMYnXyu-pRU0S9FLg)

２つの凸体が衝突していなければ、必ず分離面を差し挟むことのできる方向（分離軸：Separating axis）が存在する。つまり、どの方向から見ても隙間が存在しなければ、２つの凸体は衝突している。
> ![Illustration of the hyperplane separation theorem.](https://upload.wikimedia.org/wikipedia/commons/9/9b/Separating_axis_theorem2008.png)  
> \* [Hyperplane separation theorem](https://en.wikipedia.org/wiki/Hyperplane_separation_theorem)：[Wikipedia](https://en.wikipedia.org)

具体的には、指定したベクトル`Vec`の垂直方向へ、三角面`Tria`とボクセル`Area`を射影し、その１Ｄの範囲が重なるかどうかで、分離面の存在が判定できる。

> `Tria.ProjVec( Vec ).Collision( Area.ProjVec( Vec ) )`

さらに、凸体を多面体に限るのであれば、調べるべき方向の数は有限となる。
特にポリゴンとボクセルの場合、以下の **13方向** について調べるだけでよい。

> * 三角面の法線
> * ボクセルの法線
>     * Ｘ軸方向
>     * Ｙ軸方向
>     * Ｚ軸方向
> * ボクセルの法線 × 三角面の辺　※ **×**：外積
>     * Ｘ軸 × Ａ辺
>     * Ｘ軸 × Ｂ辺
>     * Ｘ軸 × Ｃ辺
>     * Ｙ軸 × Ａ辺
>     * Ｙ軸 × Ｂ辺
>     * Ｙ軸 × Ｃ辺
>     * Ｚ軸 × Ａ辺
>     * Ｚ軸 × Ｂ辺
>     * Ｚ軸 × Ｃ辺
> 
> ![](https://www.researchgate.net/profile/Carsten_Preusche/publication/224990152/figure/fig2/AS:302767072661505@1449196703470/Figure-3-Collision-detection-between-triangle-and-voxel-using-the-Separating-Axis.png)  
> \* [Improvements of the Voxmap-PointShell Algorithm - Fast Generation of Haptic Data-Structures](https://www.researchgate.net/publication/224990152_Improvements_of_the_Voxmap-PointShell_Algorithm_-_Fast_Generation_of_Haptic_Data-Structures)：[ResearchGate](https://www.researchgate.net)

具体的な実装は以下のようになる。

```pascal
function TDoubleTria3D.CollisionSAT( const Area_:TDoubleArea3D ) :Boolean;
//······································
     function CheckPlane :Boolean;
     begin
          ～
     end;
     //·································
     function Check( const Vec_:TDouble3D ) :Boolean;
     begin
          Result := ProjVec( Vec_ ).Collision( Area_.ProjVec( Vec_ ) );
     end;
//······································
const
     AX :TDouble3D = ( X:1; Y:0; Z:0 );
     AY :TDouble3D = ( X:0; Y:1; Z:0 );
     AZ :TDouble3D = ( X:0; Y:0; Z:1 );
var
   E1, E2, E3 :TDouble3D;
begin
     E1 := Edge1;
     E2 := Edge2;
     E3 := Edge3;

     Result := AABB.Collision( Area_ )          // Check( AX ) and Check( AY ) and Check( AZ )
           and CheckPlane                       // Check( Norv )
           and Check( CrossProduct( AX, E1 ) )
           and Check( CrossProduct( AX, E2 ) )
           and Check( CrossProduct( AX, E3 ) )
           and Check( CrossProduct( AY, E1 ) )
           and Check( CrossProduct( AY, E2 ) )
           and Check( CrossProduct( AY, E3 ) )
           and Check( CrossProduct( AZ, E1 ) )
           and Check( CrossProduct( AZ, E2 ) )
           and Check( CrossProduct( AZ, E3 ) );
end;
```

ここでＸ/Ｙ/Ｚ軸方向の分離判定は 3D-AABB との衝突判定と等価であり、さらに三角面の法線方向の分離判定は前述の`CheckPlane`関数と等価である。

----

* [The Basics of GPU Voxelization](https://developer.nvidia.com/content/basics-gpu-voxelization)：[NVIDIA Developer](https://developer.nvidia.com)
* [GPU上でのvoxel構築手法](https://shikihuiku.wordpress.com/2012/08/02/gpu上でのvoxel構築手法/)：[shikihuiku](https://shikihuiku.wordpress.com)
* [Improvements of the Voxmap-PointShell Algorithm - Fast Generation of Haptic Data-Structures](https://www.researchgate.net/publication/224990152_Improvements_of_the_Voxmap-PointShell_Algorithm_-_Fast_Generation_of_Haptic_Data-Structures)：[ResearchGate](https://www.researchgate.net)
* [Fast Parallel Surface and Solid Voxelization on GPUs](http://research.michael-schwarz.com/publ/files/vox-siga10.pdf)：[Michael Schwarz](http://research.michael-schwarz.com)
* [VoxelPipe: A Programmable Pipeline for 3D Voxelization](http://research.nvidia.com/publication/voxelpipe-programmable-pipeline-3d-voxelization)：[NVIDIA Research](https://www.nvidia.com/en-us/research/)

[![Delphi Starter](http://img.en25.com/EloquaImages/clients/Embarcadero/%7B063f1eec-64a6-4c19-840f-9b59d407c914%7D_dx-starter-bn159.png)](https://www.embarcadero.com/jp/products/delphi/starter)
