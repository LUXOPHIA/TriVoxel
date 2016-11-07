unit LUX.Curve.T1.D2;

interface //#################################################################### ■

uses LUX,
     LUX.D1,
     LUX.D2, LUX.D2.V4,
     LUX.Curve.T1.D1;

//type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

function Bezie4( const Ps_:TSingle2DV4; const T_:Single ) :TSingle2D; overload;
function Bezie4( const Ps_:TDouble2DV4; const T_:Double ) :TDouble2D; overload;
function Bezie4( const Ps_:TdSingle2DV4; const T_:TdSingle ) :TdSingle2D; overload;
function Bezie4( const Ps_:TdDouble2DV4; const T_:TdDouble ) :TdDouble2D; overload;

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

function Bezie4( const Ps_:TSingle2DV4; const T_:Single ) :TSingle2D;
begin
     with Bezie4( T_ ) do Result := _1 * Ps_._1
                                  + _2 * Ps_._2
                                  + _3 * Ps_._3
                                  + _4 * Ps_._4;
end;

function Bezie4( const Ps_:TDouble2DV4; const T_:Double ) :TDouble2D;
begin
     with Bezie4( T_ ) do Result := _1 * Ps_._1
                                  + _2 * Ps_._2
                                  + _3 * Ps_._3
                                  + _4 * Ps_._4;
end;

function Bezie4( const Ps_:TdSingle2DV4; const T_:TdSingle ) :TdSingle2D;
begin
     with Bezie4( T_ ) do Result := _1 * Ps_._1
                                  + _2 * Ps_._2
                                  + _3 * Ps_._3
                                  + _4 * Ps_._4;
end;

function Bezie4( const Ps_:TdDouble2DV4; const T_:TdDouble ) :TdDouble2D;
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
