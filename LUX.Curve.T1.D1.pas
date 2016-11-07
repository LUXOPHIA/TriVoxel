unit LUX.Curve.T1.D1;

interface //#################################################################### ■

uses LUX,
     LUX.D1,
     LUX.D4;

//type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

function Lerp( const P0_,P1_,T0_,T1_,T_:Single ) :Single; overload;
function Lerp( const P0_,P1_,T0_,T1_,T_:Double ) :Double; overload;
function Lerp( const P0_,P1_,T0_,T1_,T_:TdSingle ) :TdSingle; overload;
function Lerp( const P0_,P1_,T0_,T1_,T_:TdDouble ) :TdDouble; overload;

function Lerp( const P0_,P1_,T_:Single ) :Single; overload;
function Lerp( const P0_,P1_,T_:Double ) :Double; overload;
function Lerp( const P0_,P1_,T_:TdSingle ) :TdSingle; overload;
function Lerp( const P0_,P1_,T_:TdDouble ) :TdDouble; overload;

function CatmullRom( const P0_,P1_,P2_,P3_,T0_,T1_,T2_,T3_,T_:Single ) :Single; overload;
function CatmullRom( const P0_,P1_,P2_,P3_,T0_,T1_,T2_,T3_,T_:Double ) :Double; overload;
function CatmullRom( const P0_,P1_,P2_,P3_,T0_,T1_,T2_,T3_,T_:TdSingle ) :TdSingle; overload;
function CatmullRom( const P0_,P1_,P2_,P3_,T0_,T1_,T2_,T3_,T_:TdDouble ) :TdDouble; overload;

function CatmullRom( const P0_,P1_,P2_,P3_,T_:Single ) :Single; overload;
function CatmullRom( const P0_,P1_,P2_,P3_,T_:Double ) :Double; overload;
function CatmullRom( const P0_,P1_,P2_,P3_,T_:TdSingle ) :TdSingle; overload;
function CatmullRom( const P0_,P1_,P2_,P3_,T_:TdDouble ) :TdDouble; overload;
function CatmullRom( const P0_,P1_,P2_,P3_:Single; const T_:TdSingle ) :TdSingle; overload;
function CatmullRom( const P0_,P1_,P2_,P3_:Double; const T_:TdDouble ) :TdDouble; overload;

function BSpline( const T_:Single; const I0,N1:Integer; const Ts_:array of Single ) :Single; overload;
function BSpline( const T_:Double; const I0,N1:Integer; const Ts_:array of Double ) :Double; overload;
function BSpline( const T_:TdSingle; const I0,N1:Integer; const Ts_:array of TdSingle ) :TdSingle; overload;
function BSpline( const T_:TdDouble; const I0,N1:Integer; const Ts_:array of TdDouble ) :TdDouble; overload;

function BSplin4( const X_:Single ) :Single; overload;
function BSplin4( const X_:Double ) :Double; overload;
function BSplin4( const X_:TdSingle ) :TdSingle; overload;
function BSplin4( const X_:TdDouble ) :TdDouble; overload;

procedure BSplin4( const T_:Single; out Ws_:TSingle4D ); overload;
procedure BSplin4( const T_:Double; out Ws_:TDouble4D ); overload;
procedure BSplin4( const T_:TdSingle; out Ws_:TdSingle4D ); overload;
procedure BSplin4( const T_:TdDouble; out Ws_:TdDouble4D ); overload;

function BSplin4( const Ps_:TSingle4D; const T_:Single ) :Single; overload;
function BSplin4( const Ps_:TDouble4D; const T_:Double ) :Double; overload;
function BSplin4( const Ps_:TdSingle4D; const T_:TdSingle ) :TdSingle; overload;
function BSplin4( const Ps_:TdDouble4D; const T_:TdDouble ) :TdDouble; overload;

function Bezie4( const T_:Single ) :TSingle4D; overload;
function Bezie4( const T_:Double ) :TDouble4D; overload;
function Bezie4( const T_:TdSingle ) :TdSingle4D; overload;
function Bezie4( const T_:TdDouble ) :TdDouble4D; overload;

function Bezie4( const Ps_:TSingle4D; const T_:Single ) :Single; overload;
function Bezie4( const Ps_:TDouble4D; const T_:Double ) :Double; overload;
function Bezie4( const Ps_:TdSingle4D; const T_:TdSingle ) :TdSingle; overload;
function Bezie4( const Ps_:TdDouble4D; const T_:TdDouble ) :TdDouble; overload;

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

function Lerp( const P0_,P1_,T0_,T1_,T_:Single ) :Single;
begin
     Result := ( ( T1_ - T_ ) * P0_ + ( T_ - T0_ ) * P1_ ) / ( T1_ - T0_ );
end;

function Lerp( const P0_,P1_,T0_,T1_,T_:Double ) :Double;
begin
     Result := ( ( T1_ - T_ ) * P0_ + ( T_ - T0_ ) * P1_ ) / ( T1_ - T0_ );
end;

function Lerp( const P0_,P1_,T0_,T1_,T_:TdSingle ) :TdSingle;
begin
     Result := ( ( T1_ - T_ ) * P0_ + ( T_ - T0_ ) * P1_ ) / ( T1_ - T0_ );
end;

function Lerp( const P0_,P1_,T0_,T1_,T_:TdDouble ) :TdDouble;
begin
     Result := ( ( T1_ - T_ ) * P0_ + ( T_ - T0_ ) * P1_ ) / ( T1_ - T0_ );
end;

//------------------------------------------------------------------------------

function Lerp( const P0_,P1_,T_:Single ) :Single;
begin
     Result := ( P1_ - P0_ ) * T_ + P0_;
end;

function Lerp( const P0_,P1_,T_:Double ) :Double;
begin
     Result := ( P1_ - P0_ ) * T_ + P0_;
end;

function Lerp( const P0_,P1_,T_:TdSingle ) :TdSingle;
begin
     Result := ( P1_ - P0_ ) * T_ + P0_;
end;

function Lerp( const P0_,P1_,T_:TdDouble ) :TdDouble;
begin
     Result := ( P1_ - P0_ ) * T_ + P0_;
end;

//------------------------------------------------------------------------------

function CatmullRom( const P0_,P1_,P2_,P3_,T0_,T1_,T2_,T3_,T_:Single ) :Single;
var
   A01, A12, A23, B02, B13 :Single;
begin
     A01 := Lerp( P0_, P1_, T0_, T1_, T_ );
     A12 := Lerp( P1_, P2_, T1_, T2_, T_ );
     A23 := Lerp( P2_, P3_, T2_, T3_, T_ );

     B02 := Lerp( A01, A12, T0_, T2_, T_ );
     B13 := Lerp( A12, A23, T1_, T3_, T_ );

     Result := Lerp( B02, B13, T1_, T2_, T_ );
end;

function CatmullRom( const P0_,P1_,P2_,P3_,T0_,T1_,T2_,T3_,T_:Double ) :Double;
var
   A01, A12, A23, B02, B13 :Double;
begin
     A01 := Lerp( P0_, P1_, T0_, T1_, T_ );
     A12 := Lerp( P1_, P2_, T1_, T2_, T_ );
     A23 := Lerp( P2_, P3_, T2_, T3_, T_ );

     B02 := Lerp( A01, A12, T0_, T2_, T_ );
     B13 := Lerp( A12, A23, T1_, T3_, T_ );

     Result := Lerp( B02, B13, T1_, T2_, T_ );
end;

function CatmullRom( const P0_,P1_,P2_,P3_,T0_,T1_,T2_,T3_,T_:TdSingle ) :TdSingle;
var
   A01, A12, A23, B02, B13 :TdSingle;
begin
     A01 := Lerp( P0_, P1_, T0_, T1_, T_ );
     A12 := Lerp( P1_, P2_, T1_, T2_, T_ );
     A23 := Lerp( P2_, P3_, T2_, T3_, T_ );

     B02 := Lerp( A01, A12, T0_, T2_, T_ );
     B13 := Lerp( A12, A23, T1_, T3_, T_ );

     Result := Lerp( B02, B13, T1_, T2_, T_ );
end;

function CatmullRom( const P0_,P1_,P2_,P3_,T0_,T1_,T2_,T3_,T_:TdDouble ) :TdDouble;
var
   A01, A12, A23, B02, B13 :TdDouble;
begin
     A01 := Lerp( P0_, P1_, T0_, T1_, T_ );
     A12 := Lerp( P1_, P2_, T1_, T2_, T_ );
     A23 := Lerp( P2_, P3_, T2_, T3_, T_ );

     B02 := Lerp( A01, A12, T0_, T2_, T_ );
     B13 := Lerp( A12, A23, T1_, T3_, T_ );

     Result := Lerp( B02, B13, T1_, T2_, T_ );
end;

//------------------------------------------------------------------------------

function CatmullRom( const P0_,P1_,P2_,P3_,T_:Single ) :Single;
begin
     Result := ( ( ( -0.5 * P0_ + 1.5 * P1_ - 1.5 * P2_ + 0.5 * P3_ ) * T_
                   +        P0_ - 2.5 * P1_ + 2.0 * P2_ - 0.5 * P3_ ) * T_
                   -  0.5 * P0_             + 0.5 * P2_             ) * T_
                                +       P1_;
end;

function CatmullRom( const P0_,P1_,P2_,P3_,T_:Double ) :Double;
begin
     Result := ( ( ( -0.5 * P0_ + 1.5 * P1_ - 1.5 * P2_ + 0.5 * P3_ ) * T_
                   +        P0_ - 2.5 * P1_ + 2.0 * P2_ - 0.5 * P3_ ) * T_
                   -  0.5 * P0_             + 0.5 * P2_             ) * T_
                                +       P1_;
end;

function CatmullRom( const P0_,P1_,P2_,P3_,T_:TdSingle ) :TdSingle;
begin
     Result := ( ( ( -0.5 * P0_ + 1.5 * P1_ - 1.5 * P2_ + 0.5 * P3_ ) * T_
                   +        P0_ - 2.5 * P1_ + 2.0 * P2_ - 0.5 * P3_ ) * T_
                   -  0.5 * P0_             + 0.5 * P2_             ) * T_
                                +       P1_;
end;

function CatmullRom( const P0_,P1_,P2_,P3_,T_:TdDouble ) :TdDouble;
begin
     Result := ( ( ( -0.5 * P0_ + 1.5 * P1_ - 1.5 * P2_ + 0.5 * P3_ ) * T_
                   +        P0_ - 2.5 * P1_ + 2.0 * P2_ - 0.5 * P3_ ) * T_
                   -  0.5 * P0_             + 0.5 * P2_             ) * T_
                                +       P1_;
end;

function CatmullRom( const P0_,P1_,P2_,P3_:Single; const T_:TdSingle ) :TdSingle;
begin
     Result.o := CatmullRom( P0_, P1_, P2_, P3_, T_.o );

     Result.d := ( ( ( -1.5 * P0_ + 4.5 * P1_ - 4.5 * P2_ + 1.5 * P3_ ) * T_.o
                     +  2.0 * P0_ - 5.0 * P1_ + 4.0 * P2_ -       P3_ ) * T_.o
                     -  0.5 * P0_             + 0.5 * P2_             ) * T_.d;
end;

function CatmullRom( const P0_,P1_,P2_,P3_:Double; const T_:TdDouble ) :TdDouble;
begin
     Result.o := CatmullRom( P0_, P1_, P2_, P3_, T_.o );

     Result.d := ( ( ( -1.5 * P0_ + 4.5 * P1_ - 4.5 * P2_ + 1.5 * P3_ ) * T_.o
                     +  2.0 * P0_ - 5.0 * P1_ + 4.0 * P2_ -       P3_ ) * T_.o
                     -  0.5 * P0_             + 0.5 * P2_             ) * T_.d;
end;

//------------------------------------------------------------------------------

function BSpline( const T_:Single; const I0,N1:Integer; const Ts_:array of Single ) :Single;
var
   I1, N0 :Integer;
   T0, T1, T2, T3 :Single;
begin
     I1 := I0 + 1;

     T0 := Ts_[ I0      ];
     T2 := Ts_[ I0 + N1 ];
     T1 := Ts_[ I1      ];
     T3 := Ts_[ I1 + N1 ];

     if N1 = 1 then
     begin
          {    I0      I1
             ━╋━━━╋━━━╋━
               T0      T2
               ├─N1─┤
                       T1      T3
                       ├─N1─┤    }

          if ( T_ < T0 ) or ( T3 < T_ ) then Result := 0
          else
          begin
               if T_ < T2 then Result := ( T_ - T0 ) / ( T2 - T0 )
                          else
               if T_ > T1 then Result := ( T3 - T_ ) / ( T3 - T1 )
                          else Result := 1;
          end;
     end
     else
     begin
          {    I0      I1
             ━╋━━━╋━━━╋━━━╋━━━╋━
               T0                      T2
               ├─────N1─────┤
                       T1                      T3
                       ├─────N1─────┤    }

          N0 := N1 - 1;

          Result := 0;

          if T2 > T0 then Result := Result + ( T_ - T0 ) / ( T2 - T0 ) * BSpline( T_, I0, N0, Ts_ );
          if T3 > T1 then Result := Result + ( T3 - T_ ) / ( T3 - T1 ) * BSpline( T_, I1, N0, Ts_ );
     end;
end;

function BSpline( const T_:Double; const I0,N1:Integer; const Ts_:array of Double ) :Double;
var
   I1, N0 :Integer;
   T0, T1, T2, T3 :Double;
begin
     I1 := I0 + 1;

     T0 := Ts_[ I0      ];
     T2 := Ts_[ I0 + N1 ];
     T1 := Ts_[ I1      ];
     T3 := Ts_[ I1 + N1 ];

     if N1 = 1 then
     begin
          {    I0      I1
             ━╋━━━╋━━━╋━
               T0      T2
               ├─N1─┤
                       T1      T3
                       ├─N1─┤    }

          if ( T_ < T0 ) or ( T3 < T_ ) then Result := 0
          else
          begin
               if T_ < T2 then Result := ( T_ - T0 ) / ( T2 - T0 )
                          else
               if T_ > T1 then Result := ( T3 - T_ ) / ( T3 - T1 )
                          else Result := 1;
          end;
     end
     else
     begin
          {    I0      I1
             ━╋━━━╋━━━╋━━━╋━━━╋━
               T0                      T2
               ├─────N1─────┤
                       T1                      T3
                       ├─────N1─────┤    }

          N0 := N1 - 1;

          Result := 0;

          if T2 > T0 then Result := Result + ( T_ - T0 ) / ( T2 - T0 ) * BSpline( T_, I0, N0, Ts_ );
          if T3 > T1 then Result := Result + ( T3 - T_ ) / ( T3 - T1 ) * BSpline( T_, I1, N0, Ts_ );
     end;
end;

function BSpline( const T_:TdSingle; const I0,N1:Integer; const Ts_:array of TdSingle ) :TdSingle;
var
   I1, N0 :Integer;
   T0, T1, T2, T3 :TdSingle;
begin
     I1 := I0 + 1;

     T0 := Ts_[ I0      ];
     T2 := Ts_[ I0 + N1 ];
     T1 := Ts_[ I1      ];
     T3 := Ts_[ I1 + N1 ];

     if N1 = 1 then
     begin
          {    I0      I1
             ━╋━━━╋━━━╋━
               T0      T2
               ├─N1─┤
                       T1      T3
                       ├─N1─┤    }

          if ( T_ < T0 ) or ( T3 < T_ ) then Result := 0
          else
          begin
               if T_ < T2 then Result := ( T_ - T0 ) / ( T2 - T0 )
                          else
               if T_ > T1 then Result := ( T3 - T_ ) / ( T3 - T1 )
                          else Result := 1;
          end;
     end
     else
     begin
          {    I0      I1
             ━╋━━━╋━━━╋━━━╋━━━╋━
               T0                      T2
               ├─────N1─────┤
                       T1                      T3
                       ├─────N1─────┤    }

          N0 := N1 - 1;

          Result := 0;

          if T2 > T0 then Result := Result + ( T_ - T0 ) / ( T2 - T0 ) * BSpline( T_, I0, N0, Ts_ );
          if T3 > T1 then Result := Result + ( T3 - T_ ) / ( T3 - T1 ) * BSpline( T_, I1, N0, Ts_ );
     end;
end;

function BSpline( const T_:TdDouble; const I0,N1:Integer; const Ts_:array of TdDouble ) :TdDouble;
var
   I1, N0 :Integer;
   T0, T1, T2, T3 :TdDouble;
begin
     I1 := I0 + 1;

     T0 := Ts_[ I0      ];
     T2 := Ts_[ I0 + N1 ];
     T1 := Ts_[ I1      ];
     T3 := Ts_[ I1 + N1 ];

     if N1 = 1 then
     begin
          {    I0      I1
             ━╋━━━╋━━━╋━
               T0      T2
               ├─N1─┤
                       T1      T3
                       ├─N1─┤    }

          if ( T_ < T0 ) or ( T3 < T_ ) then Result := 0
          else
          begin
               if T_ < T2 then Result := ( T_ - T0 ) / ( T2 - T0 )
                          else
               if T_ > T1 then Result := ( T3 - T_ ) / ( T3 - T1 )
                          else Result := 1;
          end;
     end
     else
     begin
          {    I0      I1
             ━╋━━━╋━━━╋━━━╋━━━╋━
               T0                      T2
               ├─────N1─────┤
                       T1                      T3
                       ├─────N1─────┤    }

          N0 := N1 - 1;

          Result := 0;

          if T2 > T0 then Result := Result + ( T_ - T0 ) / ( T2 - T0 ) * BSpline( T_, I0, N0, Ts_ );
          if T3 > T1 then Result := Result + ( T3 - T_ ) / ( T3 - T1 ) * BSpline( T_, I1, N0, Ts_ );
     end;
end;

//------------------------------------------------------------------------------

function BSplin4( const X_:Single ) :Single;
const
     A :Single = 1/6;
     B :Single = 4/3;
     C :Single = 2/3;
var
   X :Single;
begin
     X := Abs( X_ );

     if X < 1 then Result := ( 0.5 * X - 1 ) * X * X + C
              else
     if X < 2 then Result := ( ( 1 - A * X ) * X - 2 ) * X + B
              else Result := 0;
end;

function BSplin4( const X_:Double ) :Double;
const
     A :Double = 1/6;
     B :Double = 4/3;
     C :Double = 2/3;
var
   X :Double;
begin
     X := Abs( X_ );

     if X < 1 then Result := ( 0.5 * X - 1 ) * X * X + C
              else
     if X < 2 then Result := ( ( 1 - A * X ) * X - 2 ) * X + B
              else Result := 0;
end;

function BSplin4( const X_:TdSingle ) :TdSingle;
const
     A :TdSingle = ( o:1/6; d:0 );
     B :TdSingle = ( o:4/3; d:0 );
     C :TdSingle = ( o:2/3; d:0 );
var
   X :TdSingle;
begin
     X := Abso( X_ );

     if X < 1 then Result := ( X / 2 - 1 ) * X * X + C
              else
     if X < 2 then Result := ( ( 1 - A * X ) * X - 2 ) * X + B
              else Result := 0;
end;

function BSplin4( const X_:TdDouble ) :TdDouble;
const
     A :TdDouble = ( o:1/6; d:0 );
     B :TdDouble = ( o:4/3; d:0 );
     C :TdDouble = ( o:2/3; d:0 );
var
   X :TdDouble;
begin
     X := Abso( X_ );

     if X < 1 then Result := ( X / 2 - 1 ) * X * X + C
              else
     if X < 2 then Result := ( ( 1 - A * X ) * X - 2 ) * X + B
              else Result := 0;
end;

//------------------------------------------------------------------------------

procedure BSplin4( const T_:Single; out Ws_:TSingle4D );
begin
     with Ws_ do
     begin
          _1 := BSplin4( T_ + 1 );
          _2 := BSplin4( T_     );
          _3 := BSplin4( T_ - 1 );
          _4 := BSplin4( T_ - 2 );
     end;
end;

procedure BSplin4( const T_:Double; out Ws_:TDouble4D );
begin
     with Ws_ do
     begin
          _1 := BSplin4( T_ + 1 );
          _2 := BSplin4( T_     );
          _3 := BSplin4( T_ - 1 );
          _4 := BSplin4( T_ - 2 );
     end;
end;

procedure BSplin4( const T_:TdSingle; out Ws_:TdSingle4D );
begin
     with Ws_ do
     begin
          _1 := BSplin4( T_ + 1 );
          _2 := BSplin4( T_     );
          _3 := BSplin4( T_ - 1 );
          _4 := BSplin4( T_ - 2 );
     end;
end;

procedure BSplin4( const T_:TdDouble; out Ws_:TdDouble4D );
begin
     with Ws_ do
     begin
          _1 := BSplin4( T_ + 1 );
          _2 := BSplin4( T_     );
          _3 := BSplin4( T_ - 1 );
          _4 := BSplin4( T_ - 2 );
     end;
end;

//------------------------------------------------------------------------------

function BSplin4( const Ps_:TSingle4D; const T_:Single ) :Single;
var
   Ws :TSingle4D;
begin
     BSplin4( T_, Ws );

     Result := Ws._1 * Ps_._1
             + Ws._2 * Ps_._2
             + Ws._3 * Ps_._3
             + Ws._4 * Ps_._4;
end;

function BSplin4( const Ps_:TDouble4D; const T_:Double ) :Double;
var
   Ws :TDouble4D;
begin
     BSplin4( T_, Ws );

     Result := Ws._1 * Ps_._1
             + Ws._2 * Ps_._2
             + Ws._3 * Ps_._3
             + Ws._4 * Ps_._4;
end;

function BSplin4( const Ps_:TdSingle4D; const T_:TdSingle ) :TdSingle;
var
   Ws :TdSingle4D;
begin
     BSplin4( T_, Ws );

     Result := Ws._1 * Ps_._1
             + Ws._2 * Ps_._2
             + Ws._3 * Ps_._3
             + Ws._4 * Ps_._4;
end;

function BSplin4( const Ps_:TdDouble4D; const T_:TdDouble ) :TdDouble;
var
   Ws :TdDouble4D;
begin
     BSplin4( T_, Ws );

     Result := Ws._1 * Ps_._1
             + Ws._2 * Ps_._2
             + Ws._3 * Ps_._3
             + Ws._4 * Ps_._4;
end;

//------------------------------------------------------------------------------

function Bezie4( const T_:Single ) :TSingle4D;
var
   T1, T2, T3,
   S1, S2, S3 :Single;
begin
     T1 :=      T_;  S1 := 1  - T_;
     T2 := T1 * T1;  S2 := S1 * S1;
     T3 := T1 * T2;  S3 := S1 * S2;

     with Result do
     begin
          _1 :=          S3;
          _2 := 3 * T1 * S2;
          _3 := 3 * T2 * S1;
          _4 :=     T3     ;
     end;
end;

function Bezie4( const T_:Double ) :TDouble4D;
var
   T1, T2, T3,
   S1, S2, S3 :Double;
begin
     T1 :=      T_;  S1 := 1  - T_;
     T2 := T1 * T1;  S2 := S1 * S1;
     T3 := T1 * T2;  S3 := S1 * S2;

     with Result do
     begin
          _1 :=          S3;
          _2 := 3 * T1 * S2;
          _3 := 3 * T2 * S1;
          _4 :=     T3     ;
     end;
end;

function Bezie4( const T_:TdSingle ) :TdSingle4D;
var
   T1, T2, T3,
   S1, S2, S3 :TdSingle;
begin
     T1 :=      T_;  S1 := 1  - T_;
     T2 := T1 * T1;  S2 := S1 * S1;
     T3 := T1 * T2;  S3 := S1 * S2;

     with Result do
     begin
          _1 :=          S3;
          _2 := 3 * T1 * S2;
          _3 := 3 * T2 * S1;
          _4 :=     T3     ;
     end;
end;

function Bezie4( const T_:TdDouble ) :TdDouble4D;
var
   T1, T2, T3,
   S1, S2, S3 :TdDouble;
begin
     T1 :=      T_;  S1 := 1  - T_;
     T2 := T1 * T1;  S2 := S1 * S1;
     T3 := T1 * T2;  S3 := S1 * S2;

     with Result do
     begin
          _1 :=          S3;
          _2 := 3 * T1 * S2;
          _3 := 3 * T2 * S1;
          _4 :=     T3     ;
     end;
end;

//------------------------------------------------------------------------------

function Bezie4( const Ps_:TSingle4D; const T_:Single ) :Single;
begin
     with Bezie4( T_ ) do Result := _1 * Ps_._1
                                  + _2 * Ps_._2
                                  + _3 * Ps_._3
                                  + _4 * Ps_._4;
end;

function Bezie4( const Ps_:TDouble4D; const T_:Double ) :Double;
begin
     with Bezie4( T_ ) do Result := _1 * Ps_._1
                                  + _2 * Ps_._2
                                  + _3 * Ps_._3
                                  + _4 * Ps_._4;
end;

function Bezie4( const Ps_:TdSingle4D; const T_:TdSingle ) :TdSingle;
begin
     with Bezie4( T_ ) do Result := _1 * Ps_._1
                                  + _2 * Ps_._2
                                  + _3 * Ps_._3
                                  + _4 * Ps_._4;
end;

function Bezie4( const Ps_:TdDouble4D; const T_:TdDouble ) :TdDouble;
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
