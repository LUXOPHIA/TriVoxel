unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls,
  LUX, LUX.D2, LUX.D3, LUX.M4,
  LUX.GPU.OpenGL,
  LUX.GPU.OpenGL.Viewer,
  Core;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    GLViewer1: TGLViewer;
    GLViewer2: TGLViewer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure GLViewer1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure GLViewer1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure GLViewer1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  private
    { private 宣言 }
    _MouseS :TShiftState;
    _MouseP :TSingle2D;
    _MouseA :TSingle2D;
  protected
  public
    { public 宣言 }
    _Trias  :array [ 0..3 ] of TSingleTria3D;
    _FrameI :Integer;
    _Tria   :TSingleTria3D;
    _Algo1  :TAlgo;
    _Algo2  :TAlgo;
    ///// メソッド
    procedure InitTrias;
    procedure MakeTria;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

uses System.Math,
     Winapi.Windows;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

procedure TForm1.InitTrias;
begin
     with _Trias[ 0 ] do
     begin
          Poin1 := 8 * TSingle3D.RandG;
          Poin2 := 8 * TSingle3D.RandG;
          Poin3 := 8 * TSingle3D.RandG;
     end;

     with _Trias[ 1 ] do
     begin
          Poin1 := 8 * TSingle3D.RandG;
          Poin2 := 8 * TSingle3D.RandG;
          Poin3 := 8 * TSingle3D.RandG;
     end;

     with _Trias[ 2 ] do
     begin
          Poin1 := 8 * TSingle3D.RandG;
          Poin2 := 8 * TSingle3D.RandG;
          Poin3 := 8 * TSingle3D.RandG;
     end;

     _FrameI := 0;
end;

procedure TForm1.MakeTria;
const
     _FPS :Integer = 10;
var
   I :Integer;
   A :Single;
begin
     I := _FrameI mod _FPS;

     if I = 0 then
     begin
          _Trias[ 0 ] := _Trias[ 1 ];
          _Trias[ 1 ] := _Trias[ 2 ];
          _Trias[ 2 ] := _Trias[ 3 ];

          with _Trias[ 3 ] do
          begin
               Poin1 := 8 * TSingle3D.RandG;
               Poin2 := 8 * TSingle3D.RandG;
               Poin3 := 8 * TSingle3D.RandG;
          end;
     end;

     A := I / _FPS;

     _Tria.Poin1 := ( _Trias[ 2 ].Poin1 - _Trias[ 1 ].Poin1 ) * A + _Trias[ 1 ].Poin1;
     _Tria.Poin2 := ( _Trias[ 2 ].Poin2 - _Trias[ 1 ].Poin2 ) * A + _Trias[ 1 ].Poin2;
     _Tria.Poin3 := ( _Trias[ 2 ].Poin3 - _Trias[ 1 ].Poin3 ) * A + _Trias[ 1 ].Poin3;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
begin
     _Algo1 := TAlgo.Create;
     _Algo2 := TAlgo.Create;

     GLViewer1.Camera := _Algo1.Camera;
     GLViewer2.Camera := _Algo2.Camera;

     _MouseA := TSingle2D.Create( 0, 0 );

     _Algo1.SetupCamera( _MouseA );
     _Algo2.SetupCamera( _MouseA );

     InitTrias;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     _Algo1.DisposeOf;
     _Algo2.DisposeOf;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Timer1Timer(Sender: TObject);
var
   N1, N2 :Integer;
begin
     MakeTria;

     _Algo1.Triang.Tria := _Tria;
     _Algo2.Triang.Tria := _Tria;

     N1 := _Algo1.Voxels.MakeVoxels(
           function( const Box_:TSingleArea3D ) :Boolean
           begin
                Result := _Tria.CollisionPEF( Box_ );
           end );

     N2 := _Algo2.Voxels.MakeVoxels(
           function( const Box_:TSingleArea3D ) :Boolean
           begin
                Result := _Tria.CollisionSAT( Box_ );
           end );

     GLViewer1.Repaint;
     GLViewer2.Repaint;

     Label1.Text := N1.ToString;
     Label2.Text := N2.ToString;

     if N2 < N1 then
     begin
          Label1.FontColor := TAlphaColors.Red;
          Label2.FontColor := TAlphaColors.Blue;

          System.SysUtils.Beep;  Timer1.Enabled := False;
     end
     else
     if N1 < N2 then
     begin
          Label1.FontColor := TAlphaColors.Blue;
          Label2.FontColor := TAlphaColors.Red;

          System.SysUtils.Beep;  Timer1.Enabled := False;
     end
     else
     begin
          Label1.FontColor := TAlphaColors.Black;
          Label2.FontColor := TAlphaColors.Black;
     end;

     Inc( _FrameI );
end;

//------------------------------------------------------------------------------

procedure TForm1.GLViewer1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     _MouseS := Shift;
     _MouseP := TSingle2D.Create( X, Y );
end;

procedure TForm1.GLViewer1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
   P :TSingle2D;
begin
     if ssLeft in _MouseS then
     begin
          P := TSingle2D.Create( X, Y );

          _MouseA := _MouseA + ( P - _MouseP );

          _Algo1.SetupCamera( _MouseA );
          _Algo2.SetupCamera( _MouseA );

          GLViewer1.Repaint;
          GLViewer2.Repaint;

          _MouseP := P;
     end;
end;

procedure TForm1.GLViewer1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     _MouseS := [];
end;

end. //######################################################################### ■
