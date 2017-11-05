unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls,
  LUX, LUX.D2, LUX.D3, LUX.M4,
  LUX.Geometry.D3,
  LUX.GPU.OpenGL,
  LUX.GPU.OpenGL.Viewer,
  Core;

type
  TForm1 = class(TForm)
    LabelP: TLabel;
    GLViewerP: TGLViewer;
    LabelPV: TLabel;
    LabelPVU: TLabel;
    LabelS: TLabel;
    GLViewerS: TGLViewer;
    LabelSV: TLabel;
    LabelSVU: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure GLViewerPMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure GLViewerPMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure GLViewerPMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
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
    procedure UpdateGUI;
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
     _Trias[ 0 ] := 12 * TSingleTria3D.RandG;
     _Trias[ 1 ] := 12 * TSingleTria3D.RandG;
     _Trias[ 2 ] := 12 * TSingleTria3D.RandG;

     _FrameI := 0;
end;

procedure TForm1.MakeTria;
const
     N :Integer = 25;
var
   I :Integer;
   T :Single;
begin
     I := _FrameI mod N;

     if I = 0 then
     begin
          _Trias[ 0 ] := _Trias[ 1 ];
          _Trias[ 1 ] := _Trias[ 2 ];
          _Trias[ 2 ] := _Trias[ 3 ];
          _Trias[ 3 ] := 12 * TSingleTria3D.RandG;
     end;

     T := I / N;

     _Tria := BSplin4( _Trias[ 0 ], _Trias[ 1 ], _Trias[ 2 ], _Trias[ 3 ], T );
end;

procedure TForm1.UpdateGUI;
begin

end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
begin
     _Algo1 := TAlgo.Create;
     _Algo2 := TAlgo.Create;

     GLViewerP.Camera := _Algo1.Camera;
     GLViewerS.Camera := _Algo2.Camera;

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
begin
     MakeTria;

     _Algo1.Triang.Setup( _Tria );
     _Algo2.Triang.Setup( _Tria );

     _Algo1.Voxels.MakeVoxels(
      function( const Box_:TSingleArea3D ) :Boolean
      begin
           Result := _Tria.CollisionPEF( Box_ );
      end );

     _Algo2.Voxels.MakeVoxels(
      function( const Box_:TSingleArea3D ) :Boolean
      begin
           Result := _Tria.CollisionSAT( Box_ );
      end );

     with _MouseA do X := X - 0.5;

     _Algo1.SetupCamera( _MouseA );
     _Algo2.SetupCamera( _MouseA );

     GLViewerP.Repaint;
     GLViewerS.Repaint;

     LabelPV.Text := _Algo1.Voxels.Count.ToString;
     LabelSV.Text := _Algo2.Voxels.Count.ToString;

     if _Algo2.Voxels.Count < _Algo1.Voxels.Count then
     begin
          LabelPV.FontColor := TAlphaColors.Red;
          LabelSV.FontColor := TAlphaColors.Blue;

          System.SysUtils.Beep;  Timer1.Enabled := False;
     end
     else
     if _Algo1.Voxels.Count < _Algo2.Voxels.Count then
     begin
          LabelPV.FontColor := TAlphaColors.Blue;
          LabelSV.FontColor := TAlphaColors.Red;

          System.SysUtils.Beep;  Timer1.Enabled := False;
     end
     else
     begin
          LabelPV.FontColor := TAlphaColors.Black;
          LabelSV.FontColor := TAlphaColors.Black;
     end;

     Inc( _FrameI );
end;

//------------------------------------------------------------------------------

procedure TForm1.GLViewerPMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     _MouseS := Shift;
     _MouseP := TSingle2D.Create( X, Y );
end;

procedure TForm1.GLViewerPMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
   P :TSingle2D;
begin
     if ssLeft in _MouseS then
     begin
          P := TSingle2D.Create( X, Y );

          _MouseA := _MouseA + ( P - _MouseP );

          _Algo1.SetupCamera( _MouseA );
          _Algo2.SetupCamera( _MouseA );

          GLViewerP.Repaint;
          GLViewerS.Repaint;

          _MouseP := P;
     end;
end;

procedure TForm1.GLViewerPMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     _MouseS := [];
end;

end. //######################################################################### ■
