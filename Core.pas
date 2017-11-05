unit Core;

interface //#################################################################### ■

uses System.SysUtils, System.UITypes,
     LUX, LUX.D1, LUX.D2, LUX.D3, LUX.M4,
     LUX.GPU.OpenGL,
     LUX.GPU.OpenGL.Scener,
     LUX.GPU.OpenGL.Camera,
     LUX.GPU.OpenGL.Matery,
     LUX.GPU.OpenGL.Shaper,
     LUX.GPU.OpenGL.Shaper.Preset;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingleTria2D

     //  P3              P* :Poin*
     //  │＼            E* :Edge*
     //  │  ＼          N* :Enor*
     //  │    ＼
     //  E2─N2  E1
     //  │    ／  ＼
     //  │  N1  N3  ＼
     //  │      │    ＼
     //  P1───E3───P2

     TSingleTria2D = record
     private
       ///// アクセス
       function GetNorv :Single;
       function GetEdge1 :TSingle2D;
       function GetEdge2 :TSingle2D;
       function GetEdge3 :TSingle2D;
       function GetEnor1 :TSingle2D;
       function GetEnor2 :TSingle2D;
       function GetEnor3 :TSingle2D;
       function GetAABB :TSingleArea2D;
     public
       Poin1 :TSingle2D;
       Poin2 :TSingle2D;
       Poin3 :TSingle2D;
       ///// プロパティ
       property Norv  :Single        read GetNorv ;
       property Edge1 :TSingle2D     read GetEdge1;
       property Edge2 :TSingle2D     read GetEdge2;
       property Edge3 :TSingle2D     read GetEdge3;
       property Enor1 :TSingle2D     read GetEnor1;
       property Enor2 :TSingle2D     read GetEnor2;
       property Enor3 :TSingle2D     read GetEnor3;
       property AABB  :TSingleArea2D read GetAABB ;
       ///// メソッド
       function ColliEdge( const Area_:TSingleArea2D ) :Boolean;
       function Collision( const Area_:TSingleArea2D ) :Boolean;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingleTria3D

     //  P3        P* :Poin*
     //  │＼      E* :Edge*
     //  E2  E1
     //  │    ＼
     //  P1─E3─P2

     TSingleTria3D = record
     private
       ///// アクセス
       function GetNorv :TSingle3D;
       function GetEdge1 :TSingle3D;
       function GetEdge2 :TSingle3D;
       function GetEdge3 :TSingle3D;
       function GetProjXY :TSingleTria2D;
       function GetProjYZ :TSingleTria2D;
       function GetProjZX :TSingleTria2D;
       function GetAABB :TSingleArea3D;
     public
       Poin1 :TSingle3D;
       Poin2 :TSingle3D;
       Poin3 :TSingle3D;
       ///// プロパティ
       property Norv   :TSingle3D     read GetNorv  ;
       property Edge1  :TSingle3D     read GetEdge1 ;
       property Edge2  :TSingle3D     read GetEdge2 ;
       property Edge3  :TSingle3D     read GetEdge3 ;
       property ProjXY :TSingleTria2D read GetProjXY;
       property ProjYZ :TSingleTria2D read GetProjYZ;
       property ProjZX :TSingleTria2D read GetProjZX;
       property AABB   :TSingleArea3D read GetAABB  ;
       ///// メソッド
       function ProjVec( const Vec_:TSingle3D ) :TSingleArea;
       function CollisionPEF( const Area_:TSingleArea3D ) :Boolean;
       function CollisionSAT( const Area_:TSingleArea3D ) :Boolean;
     end;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLTriang

     TGLTriang = class( TGLShaperFace )
     private
     protected
       ///// アクセス
       procedure SetTria( const Tria_:TSingleTria3D );
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// プロパティ
       property Tria :TSingleTria3D write SetTria;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLVoxelsM

     TGLVoxelsM = class( TGLMateryG )
     private
     protected
       ///// アクセス
     public
       constructor Create;
       destructor Destroy; override;
       ///// プロパティ
       ///// メソッド
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLVoxels

     TGLVoxels = class( TGLShaperPoin )
     private
     protected
     public
       type TCollider = reference to function( const Box_:TSingleArea3D ) :Boolean;
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// プロパティ
       ///// メソッド
       function MakeVoxels( const Func_:TCollider ) :Integer;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TAlgo

     TAlgo = class
     private
     protected
     public
       Scener :TGLScener;
       Camera :TGLCameraPers;
       Triang :TGLTriang;
       Voxels :TGLVoxels;
       /////
       constructor Create;
       destructor Destroy; override;
       ///// プロパティ
       ///// メソッド
       procedure SetupCamera( const MouseA_:TSingle2D );
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.Math;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingleTria2D

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function TSingleTria2D.GetNorv :Single;
begin
     Result := CrossProduct( Edge2, Edge3 );
end;

//------------------------------------------------------------------------------

function TSingleTria2D.GetEdge1 :TSingle2D;
begin
     Result := Poin2.VectorTo( Poin3 );
end;

function TSingleTria2D.GetEdge2 :TSingle2D;
begin
     Result := Poin3.VectorTo( Poin1 );
end;

function TSingleTria2D.GetEdge3 :TSingle2D;
begin
     Result := Poin1.VectorTo( Poin2 );
end;

//------------------------------------------------------------------------------

function TSingleTria2D.GetEnor1 :TSingle2D;
begin
     Result := Norv * Edge1.RotL90;
end;

function TSingleTria2D.GetEnor2 :TSingle2D;
begin
     Result := Norv * Edge2.RotL90;
end;

function TSingleTria2D.GetEnor3 :TSingle2D;
begin
     Result := Norv * Edge3.RotL90;
end;

//------------------------------------------------------------------------------

function TSingleTria2D.GetAABB :TSingleArea2D;
begin
     with Result do
     begin
          ProjX := TSingleArea.Create( Poin1.X, Poin2.X, Poin3.X );
          ProjY := TSingleArea.Create( Poin1.Y, Poin2.Y, Poin3.Y );
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

function TSingleTria2D.ColliEdge( const Area_:TSingleArea2D ) :Boolean;
//······································
     function CheckEdge( const N,P:TSingle2D ) :Boolean;
     var
        B, V :TSingle2D;
     begin
          B := Area_.Poin[ N.Orthant ];

          V := P.VectorTo( B );

          Result := DotProduct( N, V ) > 0;
     end;
//······································
begin
     //  P3
     //  │＼
     //  │  ＼
     //  │    ＼
     //  E2─N2  E1
     //  │    ／  ＼
     //  │  N1  N3  ＼
     //  │      │    ＼
     //  P1───E3───P2

     Result := CheckEdge( Enor1, Poin2 )
           and CheckEdge( Enor2, Poin3 )
           and CheckEdge( Enor3, Poin1 );
end;

function TSingleTria2D.Collision( const Area_:TSingleArea2D ) :Boolean;
begin
     Result := AABB.Collision( Area_ ) and ColliEdge( Area_ );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingleTria3D

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function TSingleTria3D.GetNorv :TSingle3D;
begin
     Result := CrossProduct( Edge2, Edge3 );
end;

//------------------------------------------------------------------------------

function TSingleTria3D.GetEdge1 :TSingle3D;
begin
     Result := Poin2.VectorTo( Poin3 );
end;

function TSingleTria3D.GetEdge2 :TSingle3D;
begin
     Result := Poin3.VectorTo( Poin1 );
end;

function TSingleTria3D.GetEdge3 :TSingle3D;
begin
     Result := Poin1.VectorTo( Poin2 );
end;

//------------------------------------------------------------------------------

function TSingleTria3D.GetProjXY :TSingleTria2D;
begin
     with Poin1 do Result.Poin1 := TSingle2D.Create( X, Y );
     with Poin2 do Result.Poin2 := TSingle2D.Create( X, Y );
     with Poin3 do Result.Poin3 := TSingle2D.Create( X, Y );
end;

function TSingleTria3D.GetProjYZ :TSingleTria2D;
begin
     with Poin1 do Result.Poin1 := TSingle2D.Create( Y, Z );
     with Poin2 do Result.Poin2 := TSingle2D.Create( Y, Z );
     with Poin3 do Result.Poin3 := TSingle2D.Create( Y, Z );
end;

function TSingleTria3D.GetProjZX :TSingleTria2D;
begin
     with Poin1 do Result.Poin1 := TSingle2D.Create( Z, X );
     with Poin2 do Result.Poin2 := TSingle2D.Create( Z, X );
     with Poin3 do Result.Poin3 := TSingle2D.Create( Z, X );
end;

//------------------------------------------------------------------------------

function TSingleTria3D.GetAABB :TSingleArea3D;
begin
     with Result do
     begin
          ProjX := TSingleArea.Create( Poin1.X, Poin2.X, Poin3.X );
          ProjY := TSingleArea.Create( Poin1.Y, Poin2.Y, Poin3.Y );
          ProjZ := TSingleArea.Create( Poin1.Z, Poin2.Z, Poin3.Z );
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

function TSingleTria3D.ProjVec( const Vec_:TSingle3D ) :TSingleArea;
var
   C1, C2, C3 :Single;
begin
     C1 := DotProduct( Vec_, Poin1 );
     C2 := DotProduct( Vec_, Poin2 );
     C3 := DotProduct( Vec_, Poin3 );

     Result := TSingleArea.Create( C1, C2, C3 );
end;

function TSingleTria3D.CollisionPEF( const Area_:TSingleArea3D ) :Boolean;
//······································
     function CheckPlane :Boolean;
     var
        N, B0, B1, V0, V1 :TSingle3D;
        I0, I1 :Byte;
        C0, C1 :Single;
     begin
          N := Norv;

          I1 := N.Orthant;
          I0 := I1 xor 7;

          B0 := Area_.Poin[ I0 ];
          B1 := Area_.Poin[ I1 ];

          V0 := Poin1.VectorTo( B0 );
          V1 := Poin1.VectorTo( B1 );

          C0 := DotProduct( N, V0 );
          C1 := DotProduct( N, V1 );

          Result := ( C0 * C1 ) < 0;
     end;
//······································
begin
     Result := AABB.Collision( Area_ )
           and CheckPlane
           and ProjXY.ColliEdge( Area_.ProjXY )
           and ProjYZ.ColliEdge( Area_.ProjYZ )
           and ProjZX.ColliEdge( Area_.ProjZX );
end;

function TSingleTria3D.CollisionSAT( const Area_:TSingleArea3D ) :Boolean;
//······································
     function CheckPlane :Boolean;
     var
        N, B0, B1, V0, V1 :TSingle3D;
        I0, I1 :Byte;
        C0, C1 :Single;
     begin
          N := Norv;

          I1 := N.Orthant;
          I0 := I1 xor 7;

          B0 := Area_.Poin[ I0 ];
          B1 := Area_.Poin[ I1 ];

          V0 := Poin1.VectorTo( B0 );
          V1 := Poin1.VectorTo( B1 );

          C0 := DotProduct( N, V0 );
          C1 := DotProduct( N, V1 );

          Result := ( C0 * C1 ) < 0;
     end;
     //·································
     function Check( const Vec_:TSingle3D ) :Boolean;
     begin
          Result := ProjVec( Vec_ ).Collision( Area_.ProjVec( Vec_ ) );
     end;
//······································
const
     AX :TSingle3D = ( X:1; Y:0; Z:0 );
     AY :TSingle3D = ( X:0; Y:1; Z:0 );
     AZ :TSingle3D = ( X:0; Y:0; Z:1 );
var
   E1, E2, E3 :TSingle3D;
begin
     E1 := Edge1;
     E2 := Edge2;
     E3 := Edge3;

     Result := Check( Norv )
           and Check( AX )
           and Check( AY )
           and Check( AZ )
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

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLTriang

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

procedure TGLTriang.SetTria( const Tria_:TSingleTria3D );
begin
     PosBuf[ 0 ] := Tria_.Poin1;
     PosBuf[ 1 ] := Tria_.Poin2;
     PosBuf[ 2 ] := Tria_.Poin3;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLTriang.Create;
begin
     inherited;

     Matery := TGLMateryG.Create;

     PosBuf.Count := 3;
     EleBuf.Count := 2;

     EleBuf[ 0 ] := TCardinal3D.Create( 0, 1, 2 );
     EleBuf[ 1 ] := TCardinal3D.Create( 2, 1, 0 );
end;

destructor TGLTriang.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLVoxelsM

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLVoxelsM.Create;
begin
     inherited;

     with _ShaderV do
     begin
          with Source do
          begin
               BeginUpdate;
                 Clear;

                 Add( '#version 430' );

                 Add( 'layout( std140 ) uniform TViewerScal{ layout( row_major ) mat4 _ViewerScal; };' );
                 Add( 'layout( std140 ) uniform TCameraProj{ layout( row_major ) mat4 _CameraProj; };' );
                 Add( 'layout( std140 ) uniform TCameraPose{ layout( row_major ) mat4 _CameraPose; };' );
                 Add( 'layout( std140 ) uniform TShaperPose{ layout( row_major ) mat4 _ShaperPose; };' );

                 Add( 'in vec4 _SenderPos;' );

                 Add( 'out TSenderVG' );
                 Add( '{' );
                 Add( '  vec4 Pos;' );
                 Add( '}' );
                 Add( '_Result;' );

                 Add( 'void main()' );
                 Add( '{' );
                 Add( '  _Result.Pos = _ShaperPose * _SenderPos;' );
                 Add( '}' );

               EndUpdate;
          end;

          Assert( Status, Errors.Text );
     end;

     with _ShaderG do
     begin
          with Source do
          begin
               BeginUpdate;
                 Clear;

                 Add( '#version 430' );

                 Add( 'layout( std140 ) uniform TViewerScal{ layout( row_major ) mat4 _ViewerScal; };' );
                 Add( 'layout( std140 ) uniform TCameraProj{ layout( row_major ) mat4 _CameraProj; };' );
                 Add( 'layout( std140 ) uniform TCameraPose{ layout( row_major ) mat4 _CameraPose; };' );
                 Add( 'layout( std140 ) uniform TShaperPose{ layout( row_major ) mat4 _ShaperPose; };' );

                 Add( 'layout( points ) in;' );
                 Add( 'in TSenderVG' );
                 Add( '{' );
                 Add( '  vec4 Pos;' );
                 Add( '}' );
                 Add( '_Sender[ 1 ];' );

                 Add( 'layout( line_strip, max_vertices = 24 ) out;' );
                 Add( 'out TSenderGF' );
                 Add( '{' );
                 Add( '  vec4 Pos;' );
                 Add( '}' );
                 Add( '_Result;' );

                 Add( 'void AddPoin( vec4 Poin_ )' );
                 Add( '{' );
                 Add( '  _Result.Pos = Poin_;' );
                 Add( '  gl_Position = _ViewerScal * _CameraProj * inverse( _CameraPose ) * _Result.Pos;' );
                 Add( '  EmitVertex();' );
                 Add( '}' );

                 Add( 'void AddLine( vec4 Pos1_, vec4 Pos2_ )' );
                 Add( '{' );
                 Add( '  AddPoin( Pos1_ );' );
                 Add( '  AddPoin( Pos2_ );' );
                 Add( '  EndPrimitive();' );
                 Add( '}' );

                 Add( 'void main()' );
                 Add( '{' );
                 Add( '  vec4 C = _Sender[ 0 ].Pos;' );
                 Add( '  float S = 0.5;' );

                 Add( '  vec4 P000 = C + S * vec4( -1, -1, -1, 0 );' );
                 Add( '  vec4 P001 = C + S * vec4( +1, -1, -1, 0 );' );
                 Add( '  vec4 P010 = C + S * vec4( -1, +1, -1, 0 );' );
                 Add( '  vec4 P011 = C + S * vec4( +1, +1, -1, 0 );' );
                 Add( '  vec4 P100 = C + S * vec4( -1, -1, +1, 0 );' );
                 Add( '  vec4 P101 = C + S * vec4( +1, -1, +1, 0 );' );
                 Add( '  vec4 P110 = C + S * vec4( -1, +1, +1, 0 );' );
                 Add( '  vec4 P111 = C + S * vec4( +1, +1, +1, 0 );' );

                 Add( '  AddLine( P000, P001 );' );
                 Add( '  AddLine( P010, P011 );' );
                 Add( '  AddLine( P100, P101 );' );
                 Add( '  AddLine( P110, P111 );' );

                 Add( '  AddLine( P000, P010 );' );
                 Add( '  AddLine( P100, P110 );' );
                 Add( '  AddLine( P001, P011 );' );
                 Add( '  AddLine( P101, P111 );' );

                 Add( '  AddLine( P000, P100 );' );
                 Add( '  AddLine( P001, P101 );' );
                 Add( '  AddLine( P010, P110 );' );
                 Add( '  AddLine( P011, P111 );' );

                 Add( '}' );

               EndUpdate;
          end;

          Assert( Status, Errors.Text );
     end;

     with _ShaderF do
     begin
          with Source do
          begin
               BeginUpdate;
                 Clear;

                 Add( '#version 430' );

                 Add( 'layout( std140 ) uniform TViewerScal{ layout( row_major ) mat4 _ViewerScal; };' );
                 Add( 'layout( std140 ) uniform TCameraProj{ layout( row_major ) mat4 _CameraProj; };' );
                 Add( 'layout( std140 ) uniform TCameraPose{ layout( row_major ) mat4 _CameraPose; };' );
                 Add( 'layout( std140 ) uniform TShaperPose{ layout( row_major ) mat4 _ShaperPose; };' );

                 Add( 'in TSenderGF' );
                 Add( '{' );
                 Add( '  vec4 Pos;' );
                 Add( '}' );
                 Add( '_Sender;' );

                 Add( 'out vec4 _ResultCol;' );

                 Add( 'void main()' );
                 Add( '{' );
                 Add( '  _ResultCol = vec4( 1, 1, 1, 1 );' );
                 Add( '}' );

               EndUpdate;
          end;

          Assert( Status, Errors.Text );
     end;

     with _Engine do
     begin
          Assert( Status, Errors.Text );
     end;
end;

destructor TGLVoxelsM.Destroy;
begin

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLVoxels

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLVoxels.Create;
begin
     inherited;

     _Matery := TGLVoxelsM.Create;

     with TGLShaperLineCube.Create( Self ) do
     begin
          SizeX := 32;
          SizeY := 32;
          SizeZ := 32;
     end;
end;

destructor TGLVoxels.Destroy;
begin

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TGLVoxels.MakeVoxels( const Func_:TCollider ) :Integer;
var
   X, Y, Z :Integer;
   C :TSingle3D;
   B :TSingleArea3D;
   Cs :TArray<TSingle3D>;
begin
     Cs := [];

     for Z := 0 to 32-1 do
     begin
          C.Z := ( Z + 0.5 ) - 16;

          B.Min.Z := C.Z - 0.5;
          B.Max.Z := C.Z + 0.5;

          for Y := 0 to 32-1 do
          begin
               C.Y := ( Y + 0.5 ) - 16;

               B.Min.Y := C.Y - 0.5;
               B.Max.Y := C.Y + 0.5;

               for X := 0 to 32-1 do
               begin
                    C.X := ( X + 0.5 ) - 16;

                    B.Min.X := C.X - 0.5;
                    B.Max.X := C.X + 0.5;

                    if Func_( B ) then Cs := Cs + [ C ];
               end;
          end;
     end;

     PosBuf.Import( Cs );

     Result := Length( Cs );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TAlgo

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TAlgo.Create;
begin
     inherited;

     Scener := TGLScener    .Create          ;
     Camera := TGLCameraPers.Create( Scener );
     Triang := TGLTriang    .Create( Scener );
     Voxels := TGLVoxels    .Create( Scener );
end;

destructor TAlgo.Destroy;
begin
     Scener.DisposeOf;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TAlgo.SetupCamera( const MouseA_:TSingle2D );
begin
     Camera.Pose := TSingleM4.RotateY( DegToRad( -MouseA_.X ) )
                  * TSingleM4.RotateX( DegToRad( -MouseA_.Y ) )
                  * TSingleM4.Translate( 0, 0, 16+Roo2(3)*16 );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■