unit LUX.Curve.T2.D1;

interface //#################################################################### ■

uses LUX,
     LUX.D1,
     LUX.D2, LUX.D2.V4, LUX.D2.M4,
     LUX.D4,
     LUX.Matrix.L4,
     LUX.Curve.T1.D1;

//type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

procedure BSplin4( const T_:TSingle2D; out Ws_:TSingleM4 ); overload;
procedure BSplin4( const T_:TDouble2D; out Ws_:TDoubleM4 ); overload;
procedure BSplin4( const T_:TdSingle2D; out Ws_:TdSingleM4 ); overload;
procedure BSplin4( const T_:TdDouble2D; out Ws_:TdDoubleM4 ); overload;

function BSplin4( const Ps_:TSingleM4; const T_:TSingle2D ) :Single; overload;
function BSplin4( const Ps_:TDoubleM4; const T_:TDouble2D ) :Double; overload;
function BSplin4( const Ps_:TdSingleM4; const T_:TdSingle2D ) :TdSingle; overload;
function BSplin4( const Ps_:TdDoubleM4; const T_:TdDouble2D ) :TdDouble; overload;

function Bezie4( const T_:TSingle2D ) :TSingleM4; overload;
function Bezie4( const T_:TDouble2D ) :TDoubleM4; overload;
function Bezie4( const T_:TdSingle2D ) :TdSingleM4; overload;
function Bezie4( const T_:TdDouble2D ) :TdDoubleM4; overload;

function Bezie4( const Ps_:TSingleM4; const T_:TSingle2D ) :Single; overload;
function Bezie4( const Ps_:TDoubleM4; const T_:TDouble2D ) :Double; overload;
function Bezie4( const Ps_:TdSingleM4; const T_:TdSingle2D ) :TdSingle; overload;
function Bezie4( const Ps_:TdDoubleM4; const T_:TdDouble2D ) :TdDouble; overload;

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

procedure BSplin4( const T_:TSingle2D; out Ws_:TSingleM4 );
var
   BX, BY :TSingle4D;
begin
     BSplin4( T_.X, BX );
     BSplin4( T_.Y, BY );

     with Ws_ do
     begin
          _11 := BY._1 * BX._1;  _12 := BY._1 * BX._2;  _13 := BY._1 * BX._3;  _14 := BY._1 * BX._4;
          _21 := BY._2 * BX._1;  _22 := BY._2 * BX._2;  _23 := BY._2 * BX._3;  _24 := BY._2 * BX._4;
          _31 := BY._3 * BX._1;  _32 := BY._3 * BX._2;  _33 := BY._3 * BX._3;  _34 := BY._3 * BX._4;
          _41 := BY._4 * BX._1;  _42 := BY._4 * BX._2;  _43 := BY._4 * BX._3;  _44 := BY._4 * BX._4;
     end;
end;

procedure BSplin4( const T_:TDouble2D; out Ws_:TDoubleM4 );
var
   BX, BY :TDouble4D;
begin
     BSplin4( T_.X, BX );
     BSplin4( T_.Y, BY );

     with Ws_ do
     begin
          _11 := BY._1 * BX._1;  _12 := BY._1 * BX._2;  _13 := BY._1 * BX._3;  _14 := BY._1 * BX._4;
          _21 := BY._2 * BX._1;  _22 := BY._2 * BX._2;  _23 := BY._2 * BX._3;  _24 := BY._2 * BX._4;
          _31 := BY._3 * BX._1;  _32 := BY._3 * BX._2;  _33 := BY._3 * BX._3;  _34 := BY._3 * BX._4;
          _41 := BY._4 * BX._1;  _42 := BY._4 * BX._2;  _43 := BY._4 * BX._3;  _44 := BY._4 * BX._4;
     end;
end;

procedure BSplin4( const T_:TdSingle2D; out Ws_:TdSingleM4 );
var
   BX, BY :TdSingle4D;
begin
     BSplin4( T_.X, BX );
     BSplin4( T_.Y, BY );

     with Ws_ do
     begin
          _11 := BY._1 * BX._1;  _12 := BY._1 * BX._2;  _13 := BY._1 * BX._3;  _14 := BY._1 * BX._4;
          _21 := BY._2 * BX._1;  _22 := BY._2 * BX._2;  _23 := BY._2 * BX._3;  _24 := BY._2 * BX._4;
          _31 := BY._3 * BX._1;  _32 := BY._3 * BX._2;  _33 := BY._3 * BX._3;  _34 := BY._3 * BX._4;
          _41 := BY._4 * BX._1;  _42 := BY._4 * BX._2;  _43 := BY._4 * BX._3;  _44 := BY._4 * BX._4;
     end;
end;

procedure BSplin4( const T_:TdDouble2D; out Ws_:TdDoubleM4 );
var
   BX, BY :TdDouble4D;
begin
     BSplin4( T_.X, BX );
     BSplin4( T_.Y, BY );

     with Ws_ do
     begin
          _11 := BY._1 * BX._1;  _12 := BY._1 * BX._2;  _13 := BY._1 * BX._3;  _14 := BY._1 * BX._4;
          _21 := BY._2 * BX._1;  _22 := BY._2 * BX._2;  _23 := BY._2 * BX._3;  _24 := BY._2 * BX._4;
          _31 := BY._3 * BX._1;  _32 := BY._3 * BX._2;  _33 := BY._3 * BX._3;  _34 := BY._3 * BX._4;
          _41 := BY._4 * BX._1;  _42 := BY._4 * BX._2;  _43 := BY._4 * BX._3;  _44 := BY._4 * BX._4;
     end;
end;

//------------------------------------------------------------------------------

function BSplin4( const Ps_:TSingleM4; const T_:TSingle2D ) :Single;
var
   WX, WY :TSingle4D;
   P1, P2, P3, P4 :Single;
begin
     BSplin4( T_.X, WX );
     BSplin4( T_.Y, WY );

     with WX do
     begin
          P1 := _1 * Ps_._11 + _2 * Ps_._12 + _3 * Ps_._13 + _4 * Ps_._14;
          P2 := _1 * Ps_._21 + _2 * Ps_._22 + _3 * Ps_._23 + _4 * Ps_._24;
          P3 := _1 * Ps_._31 + _2 * Ps_._32 + _3 * Ps_._33 + _4 * Ps_._34;
          P4 := _1 * Ps_._41 + _2 * Ps_._42 + _3 * Ps_._43 + _4 * Ps_._44;
     end;

     with WY do
     begin
          Result := _1 * P1 + _2 * P2 + _3 * P3 + _4 * P4;
     end;
end;

function BSplin4( const Ps_:TDoubleM4; const T_:TDouble2D ) :Double;
var
   WX, WY :TDouble4D;
   P1, P2, P3, P4 :Double;
begin
     BSplin4( T_.X, WX );
     BSplin4( T_.Y, WY );

     with WX do
     begin
          P1 := _1 * Ps_._11 + _2 * Ps_._12 + _3 * Ps_._13 + _4 * Ps_._14;
          P2 := _1 * Ps_._21 + _2 * Ps_._22 + _3 * Ps_._23 + _4 * Ps_._24;
          P3 := _1 * Ps_._31 + _2 * Ps_._32 + _3 * Ps_._33 + _4 * Ps_._34;
          P4 := _1 * Ps_._41 + _2 * Ps_._42 + _3 * Ps_._43 + _4 * Ps_._44;
     end;

     with WY do
     begin
          Result := _1 * P1 + _2 * P2 + _3 * P3 + _4 * P4;
     end;
end;

function BSplin4( const Ps_:TdSingleM4; const T_:TdSingle2D ) :TdSingle;
var
   WX, WY :TdSingle4D;
   P1, P2, P3, P4 :TdSingle;
begin
     BSplin4( T_.X, WX );
     BSplin4( T_.Y, WY );

     with WX do
     begin
          P1 := _1 * Ps_._11 + _2 * Ps_._12 + _3 * Ps_._13 + _4 * Ps_._14;
          P2 := _1 * Ps_._21 + _2 * Ps_._22 + _3 * Ps_._23 + _4 * Ps_._24;
          P3 := _1 * Ps_._31 + _2 * Ps_._32 + _3 * Ps_._33 + _4 * Ps_._34;
          P4 := _1 * Ps_._41 + _2 * Ps_._42 + _3 * Ps_._43 + _4 * Ps_._44;
     end;

     with WY do
     begin
          Result := _1 * P1 + _2 * P2 + _3 * P3 + _4 * P4;
     end;
end;

function BSplin4( const Ps_:TdDoubleM4; const T_:TdDouble2D ) :TdDouble;
var
   WX, WY :TdDouble4D;
   P1, P2, P3, P4 :TdDouble;
begin
     BSplin4( T_.X, WX );
     BSplin4( T_.Y, WY );

     with WX do
     begin
          P1 := _1 * Ps_._11 + _2 * Ps_._12 + _3 * Ps_._13 + _4 * Ps_._14;
          P2 := _1 * Ps_._21 + _2 * Ps_._22 + _3 * Ps_._23 + _4 * Ps_._24;
          P3 := _1 * Ps_._31 + _2 * Ps_._32 + _3 * Ps_._33 + _4 * Ps_._34;
          P4 := _1 * Ps_._41 + _2 * Ps_._42 + _3 * Ps_._43 + _4 * Ps_._44;
     end;

     with WY do
     begin
          Result := _1 * P1 + _2 * P2 + _3 * P3 + _4 * P4;
     end;
end;

//------------------------------------------------------------------------------

function Bezie4( const T_:TSingle2D ) :TSingleM4;
var
   BX, BY :TSingle4D;
begin
     BX := Bezie4( T_.X );
     BY := Bezie4( T_.Y );

     with Result do
     begin
          _11 := BY._1 * BX._1;  _12 := BY._1 * BX._2;  _13 := BY._1 * BX._3;  _14 := BY._1 * BX._4;
          _21 := BY._2 * BX._1;  _22 := BY._2 * BX._2;  _23 := BY._2 * BX._3;  _24 := BY._2 * BX._4;
          _31 := BY._3 * BX._1;  _32 := BY._3 * BX._2;  _33 := BY._3 * BX._3;  _34 := BY._3 * BX._4;
          _41 := BY._4 * BX._1;  _42 := BY._4 * BX._2;  _43 := BY._4 * BX._3;  _44 := BY._4 * BX._4;
     end;
end;

function Bezie4( const T_:TDouble2D ) :TDoubleM4;
var
   BX, BY :TDouble4D;
begin
     BX := Bezie4( T_.X );
     BY := Bezie4( T_.Y );

     with Result do
     begin
          _11 := BY._1 * BX._1;  _12 := BY._1 * BX._2;  _13 := BY._1 * BX._3;  _14 := BY._1 * BX._4;
          _21 := BY._2 * BX._1;  _22 := BY._2 * BX._2;  _23 := BY._2 * BX._3;  _24 := BY._2 * BX._4;
          _31 := BY._3 * BX._1;  _32 := BY._3 * BX._2;  _33 := BY._3 * BX._3;  _34 := BY._3 * BX._4;
          _41 := BY._4 * BX._1;  _42 := BY._4 * BX._2;  _43 := BY._4 * BX._3;  _44 := BY._4 * BX._4;
     end;
end;

function Bezie4( const T_:TdSingle2D ) :TdSingleM4;
var
   BX, BY :TdSingle4D;
begin
     BX := Bezie4( T_.X );
     BY := Bezie4( T_.Y );

     with Result do
     begin
          _11 := BY._1 * BX._1;  _12 := BY._1 * BX._2;  _13 := BY._1 * BX._3;  _14 := BY._1 * BX._4;
          _21 := BY._2 * BX._1;  _22 := BY._2 * BX._2;  _23 := BY._2 * BX._3;  _24 := BY._2 * BX._4;
          _31 := BY._3 * BX._1;  _32 := BY._3 * BX._2;  _33 := BY._3 * BX._3;  _34 := BY._3 * BX._4;
          _41 := BY._4 * BX._1;  _42 := BY._4 * BX._2;  _43 := BY._4 * BX._3;  _44 := BY._4 * BX._4;
     end;
end;

function Bezie4( const T_:TdDouble2D ) :TdDoubleM4;
var
   BX, BY :TdDouble4D;
begin
     BX := Bezie4( T_.X );
     BY := Bezie4( T_.Y );

     with Result do
     begin
          _11 := BY._1 * BX._1;  _12 := BY._1 * BX._2;  _13 := BY._1 * BX._3;  _14 := BY._1 * BX._4;
          _21 := BY._2 * BX._1;  _22 := BY._2 * BX._2;  _23 := BY._2 * BX._3;  _24 := BY._2 * BX._4;
          _31 := BY._3 * BX._1;  _32 := BY._3 * BX._2;  _33 := BY._3 * BX._3;  _34 := BY._3 * BX._4;
          _41 := BY._4 * BX._1;  _42 := BY._4 * BX._2;  _43 := BY._4 * BX._3;  _44 := BY._4 * BX._4;
     end;
end;

//------------------------------------------------------------------------------

function Bezie4( const Ps_:TSingleM4; const T_:TSingle2D ) :Single;
var
   P1, P2, P3, P4 :Single;
begin
     with Bezie4( T_.X ) do
     begin
          P1 := _1 * Ps_._11 + _2 * Ps_._12 + _3 * Ps_._13 + _4 * Ps_._14;
          P2 := _1 * Ps_._21 + _2 * Ps_._22 + _3 * Ps_._23 + _4 * Ps_._24;
          P3 := _1 * Ps_._31 + _2 * Ps_._32 + _3 * Ps_._33 + _4 * Ps_._34;
          P4 := _1 * Ps_._41 + _2 * Ps_._42 + _3 * Ps_._43 + _4 * Ps_._44;
     end;

     with Bezie4( T_.Y ) do
     begin
          Result := _1 * P1 + _2 * P2 + _3 * P3 + _4 * P4;
     end;
end;

function Bezie4( const Ps_:TDoubleM4; const T_:TDouble2D ) :Double;
var
   P1, P2, P3, P4 :Double;
begin
     with Bezie4( T_.X ) do
     begin
          P1 := _1 * Ps_._11 + _2 * Ps_._12 + _3 * Ps_._13 + _4 * Ps_._14;
          P2 := _1 * Ps_._21 + _2 * Ps_._22 + _3 * Ps_._23 + _4 * Ps_._24;
          P3 := _1 * Ps_._31 + _2 * Ps_._32 + _3 * Ps_._33 + _4 * Ps_._34;
          P4 := _1 * Ps_._41 + _2 * Ps_._42 + _3 * Ps_._43 + _4 * Ps_._44;
     end;

     with Bezie4( T_.Y ) do
     begin
          Result := _1 * P1 + _2 * P2 + _3 * P3 + _4 * P4;
     end;
end;

function Bezie4( const Ps_:TdSingleM4; const T_:TdSingle2D ) :TdSingle;
var
   P1, P2, P3, P4 :TdSingle;
begin
     with Bezie4( T_.X ) do
     begin
          P1 := _1 * Ps_._11 + _2 * Ps_._12 + _3 * Ps_._13 + _4 * Ps_._14;
          P2 := _1 * Ps_._21 + _2 * Ps_._22 + _3 * Ps_._23 + _4 * Ps_._24;
          P3 := _1 * Ps_._31 + _2 * Ps_._32 + _3 * Ps_._33 + _4 * Ps_._34;
          P4 := _1 * Ps_._41 + _2 * Ps_._42 + _3 * Ps_._43 + _4 * Ps_._44;
     end;

     with Bezie4( T_.Y ) do
     begin
          Result := _1 * P1 + _2 * P2 + _3 * P3 + _4 * P4;
     end;
end;

function Bezie4( const Ps_:TdDoubleM4; const T_:TdDouble2D ) :TdDouble;
var
   P1, P2, P3, P4 :TdDouble;
begin
     with Bezie4( T_.X ) do
     begin
          P1 := _1 * Ps_._11 + _2 * Ps_._12 + _3 * Ps_._13 + _4 * Ps_._14;
          P2 := _1 * Ps_._21 + _2 * Ps_._22 + _3 * Ps_._23 + _4 * Ps_._24;
          P3 := _1 * Ps_._31 + _2 * Ps_._32 + _3 * Ps_._33 + _4 * Ps_._34;
          P4 := _1 * Ps_._41 + _2 * Ps_._42 + _3 * Ps_._43 + _4 * Ps_._44;
     end;

     with Bezie4( T_.Y ) do
     begin
          Result := _1 * P1 + _2 * P2 + _3 * P3 + _4 * P4;
     end;
end;

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
