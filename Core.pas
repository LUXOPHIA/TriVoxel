unit Core;

interface //#################################################################### ■

uses System.SysUtils, System.UITypes,
     LUX, LUX.D1, LUX.D2, LUX.D3, LUX.M4,
     LUX.Geometry.D3,
     LUX.GPU.OpenGL,
     LUX.GPU.OpenGL.Scener,
     LUX.GPU.OpenGL.Camera,
     LUX.GPU.OpenGL.Matery,
     LUX.GPU.OpenGL.Shaper,
     LUX.GPU.OpenGL.Shaper.Preset;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLShaperTriang

     TGLShaperTriang = class( TGLShaperFace )
     private
     protected
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// メソッド
       procedure Setup( const Tria_:TSingleTria3D );
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLMateryVoxels

     TGLMateryVoxels = class( TGLMateryG )
     private
     protected
       ///// アクセス
     public
       constructor Create;
       destructor Destroy; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLShaperVoxels

     TGLShaperVoxels = class( TGLShaperPoin )
     private
     protected
       ///// アクセス
       function GetCount :Integer;
     public
       type TCollider = reference to function( const Area_:TSingleArea3D ) :Boolean;
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// プロパティ
       property Count :Integer read GetCount;
       ///// メソッド
       procedure MakeVoxels( const Collider_:TCollider );
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TAlgo

     TAlgo = class
     private
     protected
       _Scener :TGLScener;
       _Camera :TGLCameraPers;
       _Triang :TGLShaperTriang;
       _Voxels :TGLShaperVoxels;
     public
       constructor Create;
       destructor Destroy; override;
       ///// プロパティ
       property Camera :TGLCameraPers read _Camera;
       property Triang :TGLShaperTriang     read _Triang;
       property Voxels :TGLShaperVoxels     read _Voxels;
       ///// メソッド
       procedure SetupCamera( const MouseA_:TSingle2D );
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.Math,
     Winapi.OpenGL, Winapi.OpenGLext,
     LUX.D4, LUX.Curve.T1.D1,
     LUX.GPU.OpenGL.Matery.Preset;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLShaperTriang

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLShaperTriang.Create;
begin
     inherited;

     Matery := TGLMateryG.Create;

     PosBuf.Count := 3;
     EleBuf.Count := 2;

     with EleBuf.Map( GL_WRITE_ONLY ) do
     begin
          Items[ 0 ] := TCardinal3D.Create( 0, 1, 2 );
          Items[ 1 ] := TCardinal3D.Create( 2, 1, 0 );

          DisposeOf;
     end;
end;

destructor TGLShaperTriang.Destroy;
begin

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TGLShaperTriang.Setup( const Tria_:TSingleTria3D );
begin
     with PosBuf.Map( GL_WRITE_ONLY ) do
     begin
          Items[ 0 ] := Tria_.Poin1;
          Items[ 1 ] := Tria_.Poin2;
          Items[ 2 ] := Tria_.Poin3;

          DisposeOf;
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLMateryVoxels

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLMateryVoxels.Create;
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

destructor TGLMateryVoxels.Destroy;
begin

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLShaperVoxels

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

function TGLShaperVoxels.GetCount :Integer;
begin
     Result := PosBuf.Count;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLShaperVoxels.Create;
begin
     inherited;

     _Matery := TGLMateryVoxels.Create;

     with TGLShaperLineCube.Create( Self ) do
     begin
          SizeX := 32;
          SizeY := 32;
          SizeZ := 32;
     end;
end;

destructor TGLShaperVoxels.Destroy;
begin

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TGLShaperVoxels.MakeVoxels( const Collider_:TCollider );
var
   Cs :TArray<TSingle3D>;
   X, Y, Z :Integer;
   C :TSingle3D;
   B :TSingleArea3D;
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

                    if Collider_( B ) then Cs := Cs + [ C ];
               end;
          end;
     end;

     PosBuf.Import( Cs );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TAlgo

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TAlgo.Create;
begin
     inherited;

     _Scener := TGLScener      .Create          ;
     _Camera := TGLCameraPers  .Create( _Scener );
     _Triang := TGLShaperTriang.Create( _Scener );
     _Voxels := TGLShaperVoxels.Create( _Scener );
end;

destructor TAlgo.Destroy;
begin
     _Scener.DisposeOf;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TAlgo.SetupCamera( const MouseA_:TSingle2D );
begin
     _Camera.Pose := TSingleM4.RotateY( DegToRad( -MouseA_.X ) )
                   * TSingleM4.RotateX( DegToRad( -MouseA_.Y ) )
                   * TSingleM4.Translate( 0, 0, 16+Roo2(3)*16 );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■