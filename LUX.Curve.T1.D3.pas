unit LUX.Curve.T1.D3;

interface //#################################################################### ■

uses LUX,
     LUX.D1,
     LUX.D2, LUX.D2.V4,
     LUX.D3, LUX.D3.V4,
     LUX.Curve.T1.D1, LUX.Curve.T1.D2;

//type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

function Bezie4( const Ps_:TSingle3DV4; const T_:Single ) :TSingle3D; overload;
function Bezie4( const Ps_:TDouble3DV4; const T_:Double ) :TDouble3D; overload;
function Bezie4( const Ps_:TdSingle3DV4; const T_:TdSingle ) :TdSingle3D; overload;
function Bezie4( const Ps_:TdDouble3DV4; const T_:TdDouble ) :TdDouble3D; overload;

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

function Bezie4( const Ps_:TSingle3DV4; const T_:Single ) :TSingle3D;
begin
     with Bezie4( T_ ) do Result := _1 * Ps_._1
                                  + _2 * Ps_._2
                                  + _3 * Ps_._3
                                  + _4 * Ps_._4;
end;

function Bezie4( const Ps_:TDouble3DV4; const T_:Double ) :TDouble3D;
begin
     with Bezie4( T_ ) do Result := _1 * Ps_._1
                                  + _2 * Ps_._2
                                  + _3 * Ps_._3
                                  + _4 * Ps_._4;
end;

function Bezie4( const Ps_:TdSingle3DV4; const T_:TdSingle ) :TdSingle3D;
begin
     with Bezie4( T_ ) do Result := _1 * Ps_._1
                                  + _2 * Ps_._2
                                  + _3 * Ps_._3
                                  + _4 * Ps_._4;
end;

function Bezie4( const Ps_:TdDouble3DV4; const T_:TdDouble ) :TdDouble3D;
begin
     with Bezie4( T_ ) do Result := _1 * Ps_._1
                                  + _2 * Ps_._2
                                  + _3 * Ps_._3
                                  + _4 * Ps_._4;
end;

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
