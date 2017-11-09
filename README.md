# TriVoxel
ポリゴン（三角形）と ボクセル（軸平行直方体）との 衝突/交差/干渉（Collision）を判定する方法。この手法を利用することで、任意のポリゴンモデルをボクセルモデルへ高速に変換することが可能となる。

アルゴリズムとしては、PEF法 と SAT法 の両方を実装。もちろん"接触"に近い衝突の場合、数値誤差によって結果が曖昧になるが、その他の一般的な状態において基本的に同一の結果が得られることを確認した。

![](https://media.githubusercontent.com/media/LUXOPHIA/TriVoxel/master/--------/_SCREENSHOT/TriVoxel.png)

なお、三角形を完全に覆う 26-separating 形式の衝突判定アルゴリズムを対象とする。
> ![](https://shikihuiku.files.wordpress.com/2012/08/voxel_cross_tri_voxelize.png)  
> \* [GPU上でのvoxel構築手法](https://shikihuiku.wordpress.com/2012/08/02/gpu上でのvoxel構築手法/)：[shikihuiku](https://shikihuiku.wordpress.com)

----

## PEF : Projected Edge Function
３次元の三角形を XY, YZ, ZX 平面へ投影した上で、２次元の衝突判定を利用する方法。
> ![](https://developer.nvidia.com/sites/default/files/akamai/gameworks/images/Voxelization/Voxelization_blog_fig_5.png)  
> \* [The Basics of GPU Voxelization](https://developer.nvidia.com/content/basics-gpu-voxelization)：[NVIDIA Developer](https://developer.nvidia.com)

２次元における三角形と長方形の衝突判定には、三角形の辺に垂直な**内向き**のベクトル（辺法線）を用いる。
以下の２つの条件が満たされる場合、三角形と長方形は衝突している。

* 三角形の AABB が、長方形と衝突する。
* 三角形の３辺すべてにおいて、辺法線の方向に沿って 最も前方 の長方形の頂点が辺の内側に入る。

![](https://media.githubusercontent.com/media/LUXOPHIA/TriVoxel/master/--------/_README/Collision2D_TRI-BOX.png)  

もちろん、２次元の衝突判定を３方向から行ったとしても、三角ポリゴンの法線方向の衝突は判定できない。そこで、ポリゴンの法線方向に沿って 最も前方 と 最も後方 のボクセル頂点を求め、その区間内に三角ポリゴンの平面が入るかどうかも判定する。
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

* [The Basics of GPU Voxelization](https://developer.nvidia.com/content/basics-gpu-voxelization)：[NVIDIA Developer](https://developer.nvidia.com)
* [GPU上でのvoxel構築手法](https://shikihuiku.wordpress.com/2012/08/02/gpu上でのvoxel構築手法/)：[shikihuiku](https://shikihuiku.wordpress.com)
* [Improvements of the Voxmap-PointShell Algorithm - Fast Generation of Haptic Data-Structures](https://www.researchgate.net/publication/224990152_Improvements_of_the_Voxmap-PointShell_Algorithm_-_Fast_Generation_of_Haptic_Data-Structures)：[ResearchGate](https://www.researchgate.net)
* [Fast Parallel Surface and Solid Voxelization on GPUs](http://research.michael-schwarz.com/publ/files/vox-siga10.pdf)：[Michael Schwarz](http://research.michael-schwarz.com)
* [VoxelPipe: A Programmable Pipeline for 3D Voxelization](http://research.nvidia.com/publication/voxelpipe-programmable-pipeline-3d-voxelization)：[NVIDIA Research](https://www.nvidia.com/en-us/research/)

[![Delphi Starter](http://img.en25.com/EloquaImages/clients/Embarcadero/%7B063f1eec-64a6-4c19-840f-9b59d407c914%7D_dx-starter-bn159.png)](https://www.embarcadero.com/jp/products/delphi/starter)
