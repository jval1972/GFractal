//------------------------------------------------------------------------------
//
//  GFractal - A fractal genetator
//
//  Copyright (C) 2001 - 2018 by Jim Valavanis
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, inc., 59 Temple Place - Suite 330, Boston, MA
//  02111-1307, USA.
//
// DESCRIPTION:
//    Main form
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr / jvalavanis@gmail.com
//  Site  : https://sourceforge.net/projects/gfractal/
//------------------------------------------------------------------------------

unit Unit1;

interface

{
  Version 1.1
  Custom julia set.
  Improved user interface.
  Exports various image formats
---------------
  Version 1.0
  First working version
}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, ImgList, ToolWin, ComCtrls, Buttons, ClipBrd,
  ExtDlgs, AppEvnts;

type
  TFractalPainterProc = procedure(ABitmap: TBitmap);

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Fractal1: TMenuItem;
    Mandel1: TMenuItem;
    Bevel1: TBevel;
    Clear1: TMenuItem;
    N1: TMenuItem;
    Fern1: TMenuItem;
    Ameboa1: TMenuItem;
    Bifur1: TMenuItem;
    Carpet1: TMenuItem;
    Castle1: TMenuItem;
    Cloud1: TMenuItem;
    Clouds1: TMenuItem;
    Dendrite1: TMenuItem;
    Dragon1: TMenuItem;
    View1: TMenuItem;
    N640x4801: TMenuItem;
    N800x6001: TMenuItem;
    N1024x7681: TMenuItem;
    N640x6401: TMenuItem;
    N800x8001: TMenuItem;
    N1024x10241: TMenuItem;
    N320x2401: TMenuItem;
    N320x3201: TMenuItem;
    N2: TMenuItem;
    EKG1: TMenuItem;
    Fall1: TMenuItem;
    SnowStar1: TMenuItem;
    Flower1: TMenuItem;
    Forrest1: TMenuItem;
    Tree1: TMenuItem;
    Mandel21: TMenuItem;
    Galaxy1: TMenuItem;
    Rabbit1: TMenuItem;
    Siegel1: TMenuItem;
    Triangle1: TMenuItem;
    JuliaCos1: TMenuItem;
    JuliaSin1: TMenuItem;
    Maze1: TMenuItem;
    MistClouds1: TMenuItem;
    Rock1: TMenuItem;
    ImageList1: TImageList;
    SaveAs1: TMenuItem;
    Edit1: TMenuItem;
    Copy1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    ToolBar1: TToolBar;
    Panel1: TPanel;
    ToolButton1: TToolButton;
    Copy2: TSpeedButton;
    Save2: TSpeedButton;
    ToolButton2: TToolButton;
    Clear2: TSpeedButton;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    SavePictureDialog1: TSavePictureDialog;
    Juliaset1: TMenuItem;
    Mandelset1: TMenuItem;
    CustomJulia1: TMenuItem;
    N4: TMenuItem;
    StatusBar1: TStatusBar;
    ViewToolbar1: TMenuItem;
    ViewStatusbar1: TMenuItem;
    N5: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Mandel1Click(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure Fern1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Ameboa1Click(Sender: TObject);
    procedure Bifur1Click(Sender: TObject);
    procedure Carpet1Click(Sender: TObject);
    procedure Castle1Click(Sender: TObject);
    procedure Cloud1Click(Sender: TObject);
    procedure Clouds1Click(Sender: TObject);
    procedure Dendrite1Click(Sender: TObject);
    procedure Dragon1Click(Sender: TObject);
    procedure N640x4801Click(Sender: TObject);
    procedure N800x6001Click(Sender: TObject);
    procedure N1024x7681Click(Sender: TObject);
    procedure N640x6401Click(Sender: TObject);
    procedure N800x8001Click(Sender: TObject);
    procedure N1024x10241Click(Sender: TObject);
    procedure N320x2401Click(Sender: TObject);
    procedure N320x3201Click(Sender: TObject);
    procedure EKG1Click(Sender: TObject);
    procedure Fall1Click(Sender: TObject);
    procedure SnowStar1Click(Sender: TObject);
    procedure Flower1Click(Sender: TObject);
    procedure Forrest1Click(Sender: TObject);
    procedure Tree1Click(Sender: TObject);
    procedure Mandel21Click(Sender: TObject);
    procedure Galaxy1Click(Sender: TObject);
    procedure Rabbit1Click(Sender: TObject);
    procedure Siegel1Click(Sender: TObject);
    procedure Triangle1Click(Sender: TObject);
    procedure JuliaCos1Click(Sender: TObject);
    procedure JuliaSin1Click(Sender: TObject);
    procedure Maze1Click(Sender: TObject);
    procedure MistClouds1Click(Sender: TObject);
    procedure Rock1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CopyClick(Sender: TObject);
    procedure SaveAsClick(Sender: TObject);
    procedure View1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure File1Click(Sender: TObject);
    procedure CustomJulia1Click(Sender: TObject);
    procedure ViewStatusbar1Click(Sender: TObject);
    procedure ViewToolbar1Click(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
  private
    { Private declarations }
    LastProc: TFractalPainterProc;
    procedure SetDimentions(w, h: integer);
    procedure ClearCanvas(c: TColor);
    procedure ClearPicture;
    procedure PaintFractal(proc: TFractalPainterProc);
  public
    xJulia,
    yJulia: double; // custom julia set
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Math, Complex, CustomJuliaSetFrm, gf_defs, pngimage;

{$R *.DFM}

////////////////////////////////////////////////////////////////////////////////

const
   escape=4.0;               { escape value }
   attract=0.0001;           { attractor sensitivity }

const
   Black        = 0;
   Blue	        = 1;
   Green        = 2;
   Cyan	        = 3;
   Red	        = 4;
   Magenta      = 5;
   Brown        = 6;
   LightGray    = 7;
   DarkGray     = 8;
   LightBlue    = 9;
   LightGreen   =10;
   LightCyan    =11;
   LightRed     =12;
   LightMagenta =13;
   Yellow       =14;
   White        =15;

function GetRGBColor(color:byte):longint;
begin
  case Color of
    black : GetRGBColor := RGB(0,0,0);
    blue  : GetRGBColor := RGB(0,0,128);
    green : GetRGBColor := RGB(0,128,0);
    cyan  : GetRGBColor := RGB(0,255,255);
    red   : GetRGBColor := RGB(128,0,0);
    magenta : GetRGBColor := RGB(128,0,128);
    brown : GetRGBColor := RGB(128,128,0);
    lightgray : GetRGBColor := RGB(192,192,192);
    darkgray : GetRGBColor := RGB(128,128,128);
    lightBlue : GetRGBColor := RGB(0,0,255);
    lightGreen : GetRGBColor := RGB(0,255,0);
    lightcyan : GetRGBColor := RGB(0,255,255);
    lightRed : GetRGBColor := RGB(255,0,0);
    lightmagenta : GetRGBColor := RGB(255,0,255);
    yellow: GetRGBColor := RGB(255,255,0);
    white : GetRGBColor := RGB(255,255,255);
  else
    GetRGBColor := RGB(0,0,255);
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Mandel(ABitmap: TBitmap);
{  Rect     : Actual drawing rect
   Color    : Drawing Color
}
var
   i, j      : integer;      { loop variables}
   MaxY,MaxX : integer;      { Maximum X and Y coordinates }
   xscale,
   yscale    : double;       { scale factor }
   mag       : double;       { square of magnitude of complex number }
   iter      : integer;      { escape iteration counter }
   cx,cy     : double;       { x and y components of c }
   x, y      : double;       { coordinate values in complex plane }
   MaxY2     : integer;
   LeftValue: integer;
   Rect : TRect;
   PlotTimes : byte;         { Max times to plot in one iteration }
   LLimit,
   MLimit,
   RLimit : integer;
   PlotLimit : integer;      { Maximum number to plot a pixel at one iteration }
   ixScale,
   jyScale, zoom: double;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    zoom := 2.0;
    MaxX := right - left;
    MaxY := bottom - top;     { find maximum Y screen coordinate }
    if (MaxX=0) or (MaxY=0) then exit;
    xscale:= 2.0*zoom/MaxX;   { calculate zoom factor}
    yscale:= 2.0*zoom/MaxY;   { calculate zoom factor}
    x :=0;                    { zet z0 = 0 + 0i }
    y :=0;
    MaxY2 := MaxY div 2;
    LLimit := MaxX div 10;        { Starting the disign }
    RLimit := (MaxX * 13) div 20; { Stopping the design }
    MLimit := (MaxX * 11) div 20; { Stopping the limited plotting of pixels }
    PlotLimit := MaxY div 20 + 1;
    ixScale := LLimit*xScale;
    for i := LLimit to MLimit do
    begin
      j := 0;
      jyScale := 0;
      PlotTimes := 0;
      while j<=MaxY2 do
      begin
        x :=0;                   { zet z0 = 0 + 0i }
        y :=0;
        cx:= ixScale-zoom;       { sweep value of c }
        cy:= zoom - jyScale;
        mag :=0;                 { initial loop guards }
        iter := 0;
        begin
          while (iter < 30) and (mag < escape)  do
          begin
            mult(x,y,x,y,x,y);        { square z }
            add(x,y,cx,cy,x,y);       { add c }
            mag := x*x+y*y;           { calculate square of magnitude }
            inc(iter);                { increment counter }
          end;
          if mag < escape then        { output blue for non-escapees}
          begin
            inc(PlotTimes);
            LeftValue := i + left;
            ABitmap.Canvas.Pixels[LeftValue,j+top] := ABitmap.Canvas.Pen.Color;
            ABitmap.Canvas.Pixels[LeftValue,bottom-j] := ABitmap.Canvas.Pen.Color;
          end;
        end;  { while loop}
        if PlotTimes<PlotLimit then
        begin
          inc(j);
          jyScale := jyScale + yScale;
        end
        else
        begin
          ABitmap.Canvas.MoveTo(i+Left,j+top);
          ABitmap.Canvas.LineTo(i+Left,bottom-j);
          j := MaxY2+1;
        end;
      end;  {j loop}
      ixScale := ixScale + xScale;
    end;{ i loop}
    i := MLimit;
    while i<=RLimit do
    begin
      plotTimes := 0;
      jyScale := 0;
      for j := 0 to MaxY2 do
      begin
        x :=0;                   { zet z0 = 0 + 0i }
        y :=0;
        cx:= ixScale-zoom;            { sweep value of c }
        cy:= zoom - jyScale;
        mag :=0;                      { initial loop guards }
        iter := 0;
        begin
          while (iter < 30) and (mag < escape)  do
          begin
            mult(x,y,x,y,x,y);        { square z }
            add(x,y,cx,cy,x,y);       { add c }
            mag := x*x+y*y;           { calculate square of magnitude }
            inc(iter);                 { increment counter }
          end;
          if mag < escape then        { output blue for non-escapees}
          begin
            inc(PlotTimes);
            LeftValue := i + left;

            ABitmap.Canvas.Pixels[LeftValue,j+top] := ABitmap.Canvas.Pen.Color;
            ABitmap.Canvas.Pixels[LeftValue,bottom-j] := ABitmap.Canvas.Pen.Color;
          end;
        end;  { while loop}
        jyScale := jyScale + yScale;
      end;  {j loop}
      if PlotTimes = 0 then { If no plotted pixel }
        i := RLimit + 1
      else
      begin
        inc(i);
        ixScale := ixScale + xScale;
      end;
    end;{ i loop}
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Fern(ABitmap: TBitmap);
var
   x, y      : double;       { pixel coordinates }
   i         : integer;      { loop counter}
   q         : integer;      { random number }
   k         : integer;      { row selector }
   MaxY      : integer;
   xValue,
   yValue    : integer;
   MaxY2,
   MaxY10    : double;      { Maximum Y screen coordinate}
   d         : array[1..4,1..6] of double; { holds data of IFS attractor }
   Rect      : TRect;
   Iterations: integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxY := bottom - top;     { find maximum Y coordinate }
    MaxY2 := MaxY/2;
    maxY10 := MaxY/10;
    { initialize IFS data array }
    d[1,1]:=0;    d[1,2]:=0;    d[1,3]:=0;     d[1,4]:=0.16; d[1,5]:=0; d[1,6]:=0;
    d[2,1]:=0.85; d[2,2]:=0.04; d[2,3]:=-0.04; d[2,4]:=0.85; d[2,5]:=0; d[2,6]:=1.6;
    d[3,1]:=0.2;  d[3,2]:=-0.26; d[3,3]:=0.23; d[3,4]:=0.22; d[3,5]:=0; d[3,6]:=1.6;
    d[4,1]:=-0.15; d[4,2]:=0.28; d[4,3]:=0.26; d[4,4]:=0.24; d[4,5]:=0; d[4,6]:=0.44;

    x := 0;              {set starting coordinates}
    y := 0;

    Iterations := MaxY * 30; { iteration factor }

    for i := 1 to 10 do                    { skip first 10 iterations }
    begin
      q := random(100) + 1;                { pick random number from 1-100}
      if q <= 85 then                      { assign row according to }
        k := 2                             { probability }
      else if q = 86 then
        k := 1
      else if (q > 86) and (q < 94) then
        k := 3
      else
        k := 4;

      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
    end;

    for i := 11 to Iterations do
    begin
      q := random(100) + 1;                { pick random number from 1-100}
      if q <= 85 then                      { assign row according to }
        k := 2                             { probability }
      else if q = 86 then
        k := 1
      else if (q > 86) AND (q < 94) then
        k := 3
      else
        k := 4;

      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
      xValue := round(MaxY2 + MaxY10*x) + Left;
      yValue := round(MaxY10*y) + Top;

      ABitmap.Canvas.Pixels[xValue,yValue] := ABitmap.Canvas.Pen.Color;
    end;                               { scale for screen }
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Ameboa(ABitmap: TBitmap);
var
   i, j      : integer;      { loop variables}
   zoom      : double;
   MaxX,
   MaxY      : integer;      { Maximum Y coordinate}
   MaxY2     : integer;
   scale     : double;         { scale factor }
   mag       : double;         { square of magnitiude of complex number }
   iter      : integer;      { escape iteration counter }
   continue  : boolean;      { continue iteration counter }
   x,y       : double;         { double and complex parts of z }
   MaxColor  : byte;         { maximum number of colors }
   MaxColor2 : byte;
   curColor   : TColorRef;
   Rect: TRect;
   color      : byte;
   ixScale,
   jyScale     : double;
   ColorLimit  : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    zoom := 2.0;
    MaxY := bottom - top;     { find maximum Y coordinate }
    MaxX := right - left;
    if (MaxX=0) or (MaxY=0) then exit;
    MaxX := Max(MaxX,MaxY);
    MaxY := MaxX;
    right := left + MaxX;
    bottom := top + MaxY;
    MaxY2 := MaxY div 2;
    if MaxY<100 then
      MaxColor := 5
    else if MaxY<200 then
      MaxColor := 8
    else
      MaxColor := 15; { Maximum number of colors }
    MaxColor2 := MaxColor*2;
    scale:= 2.0*zoom/MaxY;   { calculate zoom factor}
    ixScale := 0;
    ColorLimit := 0;
    for i := 0 to MaxX do    { MaxY is usually smaller than MaxX }
    begin
      j := 0;
      jyScale := 0;
      while j<= MaxY2 do
      begin
        x := ixScale-zoom;            { set starting value of double(z) }
        y := zoom-jYScale;            { set starting value of imag(z) }
        continue := TRUE;             { assume point does not escape  }
        iter :=0;
        while continue do
        begin
          mult(x,y,x,y,x,y);        { square z }
          add(x,y,0.3,-0.4,x,y);    { add 0.3 -0.4i }
          mag := x*x+y*y;           { calculate square of magnitude }
          if mag < attract then
            continue := false       { point is an attractor }
          else
          begin
            if (mag < 100) and (iter < MaxColor2) then { keep iterating function }
              inc(iter)
            else                     { point escapes, plot it }
            begin
              color := iter div 2;
              if color > colorLimit then
              begin
                if color = MaxColor then
                  CurColor := RGB(255,255,255)
                else
                  CurColor := GetRGBColor(color);

                ABitmap.Canvas.Pixels[i + Left,j+top] := curColor;

                ABitmap.Canvas.Pixels[right-i,bottom-j] := curColor;
              end;
              continue := false;        { get out of loop }
            end;
          end;
        end;  { while loop}
        inc(j);
        jyScale := jYScale + scale;
      end;  {j loop}
      ixScale := ixScale + scale;
    end;{ i loop}
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Bifur(ABitmap: TBitmap);
var
   i, j      : integer;      { loop variables}
   MaxX      : integer;      { Maximum X screen coordinate}
   MaxY      : integer;      { Maximum Y screen coordinate}
   x         : double;       { iterated value }
   c         : double;       { constant of iteration  }
   MaxColor  : byte;         { maximum number of colors on graphics card }
   scale     : double;       { plotting scale factor }
   sf        : integer;      { user input scale factor }
   curColor  : byte;
   MaxY2     : integer;
   Iterate   : double;
   Rect      : TRect;
   jTop : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxX := right - left;
    MaxY := bottom - top;     { find maximum Y coordinate }
    if (MaxX = 0) or (MaxY = 0) then exit;
    MaxY2 := MaxY div 2;
    jTop := MaxY2 + top;
    Iterate := 2.25 / MaxX;
    sf := 5;
    MaxColor := 15;  { Maximum number of colors }

    scale := sf * MaxX / 8;   { calculate overall scale factor }
    c := -2.0;                { set starting point }

    for i := 1 to MaxX do
    begin
      x := 0.0;               { calculate orbit about x=0 }
      c := c + iterate;       { iterate c }
      for j := 1 to 50 do     { skip first 50 iterations }
        x := x * x + c;
      for j := 51 to 200 do   { calculate orbit after 200 iterations}
      begin
        x := x * x + c;
        CurColor := GetRGBColor(j div MaxColor);
        ABitmap.Canvas.Pixels[i + Left,round(x * scale)+jTop] := curColor;
      end;
    end
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Carpet(ABitmap: TBitmap);
{ compute and display Sierpinski carpet
  using Michael Barnsley's IFS algorithm

  12-5-93  Phil Laplante                  }
var
   x, y      : double;         { pixel coordinates }
   i         : integer;      { loop counters}
   k         : integer;      { row selector }
   d         : array[1..8,1..6] of double; { holds data of IFS attractor }
   Rect      : TRect;
   Multiplier : double;
   Iterations : word;
   MaxX,
   MaxY : integer;
   CurColor : TColorRef;
   xValue,
   yValue   : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxX := right - left;
    MaxY := bottom - top;     { find maximum Y coordinate }
    if (MaxX=0) or (MaxY=0) then exit;
    MaxY := Max(MaxX,MaxY);
    bottom := top + MaxY;
    right  := left + MaxY;
{ initialize IFS data array }

    d[1,1]:=0.33; d[1,2]:=0; d[1,3]:=0; d[1,4]:=0.33; d[1,5]:=1;  d[1,6]:=1;
    d[2,1]:=0.33; d[2,2]:=0; d[2,3]:=0; d[2,4]:=0.33; d[2,5]:=MaxY; d[2,6]:=1;
    d[3,1]:=0.33; d[3,2]:=0; d[3,3]:=0; d[3,4]:=0.33; d[3,5]:=1;  d[3,6]:=MaxY;
    d[4,1]:=0.33; d[4,2]:=0; d[4,3]:=0; d[4,4]:=0.33; d[4,5]:=MaxY; d[4,6]:=MaxY;
    d[5,1]:=0.33; d[5,2]:=0; d[5,3]:=0; d[5,4]:=0.33; d[5,5]:=MaxY div 2; d[5,6]:=1;
    d[6,1]:=0.33; d[6,2]:=0; d[6,3]:=0; d[6,4]:=0.33; d[6,5]:=MaxY; d[6,6]:=MaxY div 2;
    d[7,1]:=0.33; d[7,2]:=0; d[7,3]:=0; d[7,4]:=0.33; d[7,5]:=1;  d[7,6]:=MaxY div 2;
    d[8,1]:=0.33; d[8,2]:=0; d[8,3]:=0; d[8,4]:=0.33; d[8,5]:=MaxY div 2; d[8,6]:=MaxY;

    x := 0;              {set starting coordinates}
    y := 0;

    Iterations := MaxY * 50;
    Multiplier := 2/3;

    for i := 1 to 10 do                    { skip first 10 iterations }
    begin
      k := random(8) + 1;                  { pick random row }
      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
    end;

    for i := 11 to Iterations do
    begin
      k := random(8) + 1;                  { pick random row }
      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
      CurColor := GetRGBColor( random(15)+ 1 );
      xValue := round(x*Multiplier)+Left;
      yValue := round(y*Multiplier);
      ABitmap.Canvas.Pixels[xValue,yValue+top] := curColor;
      ABitmap.Canvas.Pixels[xValue,bottom-yValue] := curColor;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Castle(ABitmap: TBitmap);
{ compute and display "castle" fractal
  using Michael Barnsley's IFS algorithm

  12-5-93  Phil Laplante                  }
var
   x, y      : double;       { pixel coordinates }
   i         : integer;      { loop counters}
   k         : integer;      { row selector }
   MaxX,
   MaxY      : integer;      { Maximum Y screen coordinate}
   MaxY2     : double;
   d         : array[1..4,1..6] of double; { holds data of IFS attractor }
   m         : integer;
   Rect      : TRect;
   curColor  : TColorRef;
   Iterations: word;
   xValue,
   yValue    : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxX := right - left;
    MaxY := bottom - top;     { find maximum Y coordinate }
    if (MaxX=0) or (MaxY=0) then exit;
    MaxY := Max(MaxX,MaxY);
    MaxY2 := MaxY/2;
    bottom := top + MaxY;
    right := left + MaxY;
    M:=15; { maxColor }
{ initialize IFS data array }

    d[1,1]:=0.5;  d[1,2]:=0;  d[1,3]:=0;  d[1,4]:=0.5;  d[1,5]:=0; d[1,6]:=0;
    d[2,1]:=0.5;  d[2,2]:=0;  d[2,3]:=0;  d[2,4]:=0.5;  d[2,5]:=2; d[2,6]:=0;
    d[3,1]:=0.4;  d[3,2]:=0;  d[3,3]:=0;  d[3,4]:=0.4;  d[3,5]:=0; d[3,6]:=1;
    d[4,1]:=0.5;  d[4,2]:=0;  d[4,3]:=0;  d[4,4]:=0.5;  d[4,5]:=2; d[4,6]:=1;

    x := 0;              {set starting coordinates}
    y := 0;

    iterations := MaxY * 50;

    for i := 1 to 10 do                    { skip first 10 iterations }
    begin
      k := random(4) + 1;                  { pick random number from 1-4}
      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
    end;

    for i := 11 to Iterations do
    begin
      k := random(4) + 1;                  { pick random number from 1-4}
      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
      CurColor := GetRGBColor( random(m)+ 1 );
      xValue := round(x*MaxY2);
      yValue := round(y*MaxY2);
      ABitmap.Canvas.Pixels[xValue+Left,bottom-yValue] := curColor;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Cloud(ABitmap: TBitmap);
{ compute and display Julia set of function
  f(z) = z^2 -0.194 + 0.6557i

  1-2-92  Phil Laplante                     }
var
   i, j      : integer;      { loop variables}
   scale     : double;         { scale factor }
   mag       : double;         { square of magnitude of complex number }
   iter      : integer;      { escape iteration counter }
   continue  : boolean;      { continue iteration counter }
   x,y       : double;         { double and complex parts of z }
   MaxColor  : integer;      { maximum number of colors on graphics card }
   LightColor,
   DarkColor : TColorRef;
   Rect      : TRect;
   MaxX,
   MaxY      : integer;
   MaxY2     : integer;
   zoom,
   ixScale,
   jyScale    : double;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxX := right - left;
    MaxY := bottom - top;    { find maximum Y coordinate }
    if (MaxX=0) or (MaxY=0) then exit;
    MaxY := Max(MaxX,MaxY);
    bottom := top + MaxY;
    right := left + MaxY;
    MaxColor := 15;           { Maximum number of colors }
    zoom:=1.5;                { create 3 by 3 window }
    scale:= 2.0*zoom/MaxY;    { calculate zoom factor}
    LightColor := ABitmap.Canvas.Pen.Color;
    DarkColor  := RGB(max(GetRValue(ABitmap.Canvas.Pen.Color)-64,0),  {Get dark color }
                      max(GetGValue(ABitmap.Canvas.Pen.Color)-64,0),
                      max(GetBValue(ABitmap.Canvas.Pen.Color)-64,0));
    MaxY2 := MaxY div 2;
    ixScale := 0;
    for i := 0 to MaxY2 do
    begin
      jyScale := 0;
      for j := 0 to MaxY do
      begin
        x := ixScale-zoom;            { set starting value of double(z) }
        y := zoom-jyScale;            { set starting value of imag(z) }
        continue := true;             { assume point does not escape  }
        iter :=0;
        while continue do
        begin
          mult(x,y,x,y,x,y);         { square z }
          add(x,y,-0.194,0.6557,x,y); { add constant }
          mag := x*x+y*y;           { calculate square of magnitude }
          if mag < attract then
            continue := false       { point is an attractor }
          else
            if (mag < 100) AND (iter < MaxColor*2) then { keep iterating function }
              inc(iter)
            else                     { point escapes, plot it }
            begin
              case iter div 2 of
                15 : begin
                       ABitmap.Canvas.Pixels[i+left,j+top] := LightColor;
                       ABitmap.Canvas.Pixels[right-i,bottom-j] := LightColor;
                     end;
                14 : begin
                       ABitmap.Canvas.Pixels[i+left,j+top] := DarkColor;
                       ABitmap.Canvas.Pixels[right-i,bottom-j] := DarkColor;
                     end
              end;
              continue := false        { get out of loop }
            end;
          end;  { while loop}
        jyScale := jyScale + scale;
      end; {j loop}
      ixScale := ixScale + scale;
    end{ i loop}
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Clouds(ABitmap: TBitmap);
{ compute and display clouds
  using Michael Barnsley's IFS algorithm
  12-5-93  Frank D'Erasmo }
var
   x, y      : double;       { pixel coordinates }
   i         : integer;      { loop counters}
   k         : integer;      { row selector }
   MaxX,                     { Maximum X coordinate}
   MaxY      : integer;      { Maximum Y coordinate}
   d         : array[1..4,1..6] of double; { holds data of IFS attractor }
   MaxY2     : double;
   iterations: integer;
   Rect      : TRect;
   xValue,
   yValue    : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxX := right - left;
    MaxY := bottom - top;     { find maximum Y coordinate }
    if (MaxX=0) or (MaxY=0) then exit;
    MaxY := Max(MaxX,MaxY);
    MaxY2 := MaxY/2;
    bottom := top + MaxY;
    right := left + MaxY;

{ initialize IFS data array }

    d[1,1]:=0.5;  d[1,2]:=0;  d[1,3]:=0;  d[1,4]:=0.5;  d[1,5]:=0; d[1,6]:=0;
    d[2,1]:=0.5;  d[2,2]:=0;  d[2,3]:=0;  d[2,4]:=0.5;  d[2,5]:=2; d[2,6]:=0;
    d[3,1]:=-0.4;  d[3,2]:=0;  d[3,3]:=1;  d[3,4]:=0.4;  d[3,5]:=0; d[3,6]:=1;
    d[4,1]:=-0.5;  d[4,2]:=0;  d[4,3]:=0;  d[4,4]:=0.5;  d[4,5]:=2; d[4,6]:=1;

    x := 0;              {set starting coordinates}
    y := 0;

    iterations := MaxY * 50;

    for i := 1 to 10 do                    { skip first 10 iterations }
    begin
      k := random(4) + 1;                  { pick random number from 1-4}
      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
    end;

    for i := 11 to iterations do
    begin
      k := random(4) + 1;                  { pick random number from 1-4}
      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
      xValue := round(x*MaxY2);
      yValue := round(y*MaxY2);
      ABitmap.Canvas.Pixels[xValue+left,bottom-yValue] := ABitmap.Canvas.Pen.Color;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Dendrite(ABitmap: TBitmap);
{ compute and display Julia set of function
  f(z) = z^2 + i

  1-2-92  Phil Laplante                     }
var
   i, j      : integer;      { loop variables}
   MaxX,
   MaxY      : integer;      { Maximum Y screen coordinate}
   MaxY2     : integer;
   scale     : double;         { scale factor }
   mag       : double;         { square of magnitude of complex number }
   iter      : integer;      { escape iteration counter }
   continue  : boolean;      { continue iteration counter }
   x,y       : double;       { double and complex parts of z }
   MaxColor  : byte;         { maximum number of colors on graphics card }
   curColor  : TColorRef;
   Rect      : TRect;
   color     : byte;
   zoom,
   ixScale,
   jyScale   : double;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    zoom := 2.0;
    MaxY := bottom - top;     { find maximum Y coordinate }
    MaxX := right - left;
    if (MaxX=0) or (MaxY=0) then exit;
    MaxX := Max(MaxX,MaxY);
    MaxY := MaxX;
    right := left + MaxX;
    bottom := top + MaxY;
    MaxY2 := MaxY div 2;
    if MaxY<100 then
      MaxColor := 5
    else if MaxY<200 then
      MaxColor := 8
    else
      MaxColor := 15; { Maximum number of colors }
    scale:= 2.0*zoom/MaxY;   { calculate zoom factor}

    zoom := 2.0;
    ixScale := 0;

    for i := 0 to MaxY do    { MaxY is usually smaller than MaxY }
    begin
      jyScale := 0;
      for j := 0 to MaxY2 do
      begin
        x := ixScale-zoom;            { set starting value of double(z) }
        y := zoom-jyScale;            { set starting value of imag(z) }
        continue := true;             { assume point does not escape  }
        iter :=0;
        while continue do
        begin
          mult(x,y,x,y,x,y);        { square z }
          add(x,y,0.0,1.0,x,y);     { add 0 + i }
          mag := x*x+y*y;           { calculate square of magnitude }
          if mag < attract then
            continue := false       { point is an attractor }
          else
            if (mag < 100) AND (iter < MaxColor*2) then { keep iterating function }
              inc(iter)
            else                     { point escapes, plot it }
            begin
              color := iter div 2;
              if color<>0 then
              begin
                if color=MaxColor then
                  CurColor := RGB(255,255,255)
                else
                  CurColor := GetRGBColor(color);
                ABitmap.Canvas.Pixels[i + Left,j+top] := curColor;

                ABitmap.Canvas.Pixels[right-i,bottom-j] := curColor;
              end;
              continue := false        { get out of loop }
            end
        end;  { while loop}
        jyScale := jyScale + scale;
      end;  {j loop}
      ixScale := ixScale + scale;
    end;{ i loop}
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Dragon(Abitmap: TBitmap);
{ compute and display a "dragon" from the Julia set of

    f(z) = z^2 +  0.360284 + 0.100376i

  12-21-92  Phil Laplante                    }
var
   i, j      : integer;      { loop variables}
   MaxX,
   MaxY      : integer;      { Maximum Y screen coordinate}
   MaxY2     : integer;
   scale     : double;         { scale factor }
   mag       : double;         { square of magnitude of complex number }
   iter      : integer;      { escape iteration counter }
   continue  : boolean;      { continue iteration counter }
   x,y       : double;         { double and complex parts of z }
   MaxColor  : byte;         { maximum number of colors on graphics card }
   MaxColor2 : byte;
   curColor  : TColorRef;
   Rect      : TRect;
   color     : byte;
   zoom,
   ixScale,
   jyScale   : double;
   colorLimit : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    zoom := 2.0;
    MaxY := bottom - top;     { find maximum Y coordinate }
    MaxX := right - left;
    if (MaxX=0) or (MaxY=0) then exit;
    MaxX := Max(MaxX,MaxY);
    MaxY := MaxX;
    right := left + MaxX;
    bottom := top + MaxY;
    MaxY2 := MaxY div 2;
    if MaxY<100 then
      MaxColor := 5
    else if MaxY<200 then
      MaxColor := 8
    else
      MaxColor := 15; { Maximum number of colors }
    MaxColor2 := MaxColor*2;
    colorLimit := -1;
    scale:= 2.0*zoom/MaxY;   { calculate zoom factor}

    ixScale := 0;
    for i := 0 to MaxY do    { MaxY is usually smaller than MaxY }
    begin
      jyScale := 0;
      for j := 0 to MaxY2 do
      begin
        x := ixScale-zoom;            { set starting value of double(z) }
        y := zoom-jyScale;            { set starting value of imag(z) }
        continue := true;             { assume point does not escape  }
        iter := 0;
        while continue do
        begin
          mult(x,y,x,y,x,y);        { square z }
          add(x,y,0.360284,0.100376,x,y);{ add 0 + i }
          mag := x*x+y*y;           { calculate square of magnitude }
          if mag < attract then
            continue := false       { point is an attractor }
          else
            if (mag < 100) and (iter < MaxColor2) then { keep iterating function }
              inc(iter)
            else                     { point escapes, plot it }
            begin
              color := iter div 2;
              if color>colorLimit then
              begin
                if color=MaxColor then
                  CurColor := RGB(255,255,255)
                else
                  CurColor := GetRGBColor(color);
                ABitmap.Canvas.Pixels[i + Left,j+top] := curColor;
                ABitmap.Canvas.Pixels[right-i,bottom-j] := curColor;
              end;
              continue := false        { get out of loop }
            end
        end;  { while loop}
        jyScale := jyScale + scale;
      end;  {j loop}
      ixScale := ixScale + scale;
    end;{ i loop}
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure EKG(ABitmap: TBitmap);
{ compute and display a simulated "EKG" from the Julia set of

    f(z) = z^2 + -1.5

  12-21-92  Phil Laplante                    }
var
   i, j      : integer;      { loop variables}
   MaxX,
   MaxY      : integer;      { Maximum Y screen coordinate}
   MaxY2     : integer;
   scale     : double;       { scale factor }
   mag       : double;       { square of magnitude of complex number }
   iter      : integer;      { escape iteration counter }
   continue  : boolean;      { continue iteration counter }
   x,y       : double;       { double and complex parts of z }
   MaxColor  : byte;         { maximum number of colors on graphics card }
   MaxColor2 : byte;
   curColor  : TColorRef;
   Rect      : TRect;
   color     : byte;
   iLeft,
   jTop,
   iRight,
   jBottom: integer;
   zoom,
   ixScale,
   jyScale  : double;
   colorLimit : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    zoom := 2.5;
    MaxY := bottom - top;     { find maximum Y coordinate }
    MaxX := right - left;
    if (MaxX=0) or (MaxY=0) then exit;
    MaxX := Max(MaxX,MaxY);
    MaxY := MaxX;
    right := left + MaxX;
    bottom := top + MaxY;
    MaxY2 := MaxY div 2;
    if MaxY<100 then
      MaxColor := 5
    else if MaxY<200 then
      MaxColor := 8
    else
      MaxColor := 15; { Maximum number of colors }
    MaxColor2 := MaxColor*2;
    colorLimit := -1;
    scale:= 2.0*zoom/MaxY;   { calculate zoom factor}

    ixScale := 0.0;
    for i := 0 to MaxY2 do    { MaxY is usually smaller than MaxY }
    begin
      jyScale := 0.0;
      for j := 0 to MaxY2 do
      begin
        x := ixScale-zoom;            { set starting value of double(z) }
        y := zoom-jyScale;            { set starting value of imag(z) }
        continue := true;             { assume point does not escape  }
        iter :=0;
        while continue do
        begin
          mult(x,y,x,y,x,y);        { square z }
          x := x-1.5;
          mag := x*x+y*y;           { calculate square of magnitude }
          if mag < attract then
             continue := false       { point is an attractor }
          else
            if (mag < 100) and (iter < MaxColor2) then { keep iterating function }
              inc(iter)
            else                     { point escapes, plot it }
            begin
              color := iter div 2;
              if color>colorLimit then
              begin
                if color=MaxColor then
                  CurColor := RGB(255,255,255)
                else
                  CurColor := GetRGBColor(color);

                iLeft := i+ Left;
                iRight := Right - i;
                jTop := j+Top;
                jBottom := Bottom - j;

                ABitmap.Canvas.Pixels[iLeft,jTop] := curColor;

                ABitmap.Canvas.Pixels[iRight,jBottom] := curColor;

                ABitmap.Canvas.Pixels[iRight,jTop] := curColor;

                ABitmap.Canvas.Pixels[iLeft,jBottom] := curColor;

              end;
              continue := false        { get out of loop }
            end
        end;  { while loop}
        jyScale := jyScale + scale;
      end;  {j loop}
      ixScale := ixScale + scale;
    end;{ i loop}
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Fall(ABitmap: TBitmap);
{ compute and display cross fractal
  using Michael Barnsley's IFS algorithm.  Then generate
  snow fall by generating many of them.

  12-5-93  Phil Laplante                  }
var
   x, y      : double;       { pixel coordinates }
   i, j      : integer;      { loop counters}
   k         : integer;      { row selector }
   MaxX,
   MaxY      : integer;      { maximum X screen coordinate}
   d         : array[1..5,1..6] of double; { holds data of IFS attractor }
   scale     : double;       { random scale factor}
   xpos,ypos : integer;      { tree position }
   Rect      : TRect;
   Iterations : integer;
   c   : TColorRef;
   xValue,
   yValue : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxX := right - left;
    MaxY := bottom - top;     { find maximum Y coordinate }
    if (MaxX=0) or (MaxY=0) then exit;
    MaxX := Max(MaxX,MaxY);
    MaxY := MaxX;

{ initialize IFS data array }

    d[1,1]:=0.33; d[1,2]:=0; d[1,3]:=0; d[1,4]:=0.33; d[1,5]:=1;  d[1,6]:=1;
    d[2,1]:=0.33; d[2,2]:=0; d[2,3]:=0; d[2,4]:=0.33; d[2,5]:=MaxX; d[2,6]:=1;
    d[3,1]:=0.33; d[3,2]:=0; d[3,3]:=0; d[3,4]:=0.33; d[3,5]:=1;  d[3,6]:=MaxX;
    d[4,1]:=0.33; d[4,2]:=0; d[4,3]:=0; d[4,4]:=0.33; d[4,5]:=MaxX; d[4,6]:=MaxX;
    d[5,1]:=0.33; d[5,2]:=0; d[5,3]:=0; d[5,4]:=0.33; d[5,5]:=MaxX div 2; d[5,6]:=MaxX div 2;

    x := 0;              {set starting coordinates}
    y := 0;

    iterations := trunc(MaxY * 10);

    for j := 1 to 20 do                     { make 20 snow flakes }
    begin
      xpos := random(MaxX) + Left;                  { pick flake position }
      ypos := random(MaxX) + Top;
      scale := (random(5)+1)/50;            { pick flake scale }

      for i := 1 to 10 do
      begin                                  { skip first 10 iterations }
        k := random(5) + 1;                  { pick random row }
        x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
        y := d[k,3]*x + d[k,4]*y + d[k,6];
      end;

      for i := 11 to iterations do
      begin
        c:= GetRGBColor(random(4)+12);
        k := random(5) + 1;                  { pick random row }
        x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
        y := d[k,3]*x + d[k,4]*y + d[k,6];
        xValue := round(scale*x+xpos);
        yValue := round(scale*y+ypos);
        ABitmap.Canvas.Pixels[xValue,yValue] := C;
      end;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure SnowStar(ABitmap: TBitmap);
{ compute and display cross fractal
  using Michael Barnsley's IFS algorithm.

  12-5-93  Phil Laplante
  31-7-94  Valavanis Jim               }
var
   x, y      : double;       { pixel coordinates }
   i         : integer;      { loop counters}
   k         : integer;      { row selector }
   MaxX,
   MaxY      : integer;      { maximum X screen coordinate}
   d         : array[1..5,1..6] of double; { holds data of IFS attractor }
   scale     : double;       { random scale factor}
   xpos,ypos : integer;      { tree position }
   Rect      : TRect;
   Iterations : integer;
   c   : TColorRef;
   xValue,
   yValue : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxX := right - left;
    MaxY := bottom - top;     { find maximum Y coordinate }
    if (MaxX=0) or (MaxY=0) then exit;
    MaxX := Max(MaxX,MaxY);
    MaxY := MaxX;

{ initialize IFS data array }

    d[1,1]:=0.33; d[1,2]:=0; d[1,3]:=0; d[1,4]:=0.33; d[1,5]:=1;  d[1,6]:=1;
    d[2,1]:=0.33; d[2,2]:=0; d[2,3]:=0; d[2,4]:=0.33; d[2,5]:=MaxX; d[2,6]:=1;
    d[3,1]:=0.33; d[3,2]:=0; d[3,3]:=0; d[3,4]:=0.33; d[3,5]:=1;  d[3,6]:=MaxX;
    d[4,1]:=0.33; d[4,2]:=0; d[4,3]:=0; d[4,4]:=0.33; d[4,5]:=MaxX; d[4,6]:=MaxX;
    d[5,1]:=0.33; d[5,2]:=0; d[5,3]:=0; d[5,4]:=0.33; d[5,5]:=MaxX div 2; d[5,6]:=MaxX div 2;

    x := 0;              {set starting coordinates}
    y := 0;

    iterations := MaxY * 50;

    xpos := Left;
    ypos := Top;
    scale := 0.66;
    for i := 1 to 10 do
    begin                                  { skip first 10 iterations }
      k := random(5) + 1;                  { pick random row }
      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
    end;

    for i := 11 to iterations do
    begin
      c:= GetRGBColor(random(4)+11);
      k := random(5) + 1;                  { pick random row }
      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
      xValue := round(scale*x+xpos);
      yValue := round(scale*y+ypos);
      ABitmap.Canvas.Pixels[xValue,yValue] := C;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Flower(ABitmap: TBitmap);
{ compute and display a "rose" from the Julia set of

value=1 :    f(z) = z^2 + .384

value=2 :    f(z) = z^2 + .2541

  12-21-92  Phil Laplante                    }
var
   i, j      : integer;      { loop variables}
   MaxX,
   MaxY      : integer;      { Maximum Y screen coordinate}
   MaxY2     : integer;
   scale     : double;         { scale factor }
   mag       : double;         { square of magnitude of complex number }
   iter      : integer;      { escape iteration counter }
   continue  : boolean;      { continue iteration counter }
   x,y       : double;         { real and complex parts of z }
   MaxColor  : byte;         { maximum number of colors on graphics card }
   MaxColor2 : byte;
   curColor  : TColorRef;
   Rect      : TRect;
   color     : byte;
   iLeft,
   jTop,
   iRight,
   jBottom: integer;
   plus : double;
   zoom,
   ixScale,
   jyScale : double;
   colorLimit : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    zoom := 2.0;
    MaxY := bottom - top;     { find maximum Y coordinate }
    MaxX := right - left;
    if (MaxX=0) or (MaxY=0) then exit;
{    case value of
      1  : plus := 0.384;
      2  : plus := 0.2451;
    else
      exit
    end;}
    plus := 0.384;
    MaxX := Max(MaxX,MaxY);
    MaxY := MaxX;
    right := left + MaxX;
    bottom := top + MaxY;
    MaxY2 := MaxY div 2;
    if MaxY<100 then
      MaxColor := 5
    else if MaxY<200 then
      MaxColor := 8
    else
      MaxColor := 15; { Maximum number of colors }
    MaxColor2 := MaxColor*2;
{    if hi(StyleLo)=1 then}
      colorLimit := -1;
{    else
      colorLimit := 0; }
    scale:= 2.0*zoom/MaxY;   { calculate zoom factor}

    ixScale := 0.0;
    for i := 0 to MaxY2 do    { MaxY is usually smaller than MaxY }
    begin
      jyScale :=0.0;
      for j := 0 to MaxY2 do
      begin
        x := ixScale-zoom;            { set starting value of real(z) }
        y := zoom-jyScale;            { set starting value of imag(z) }
        continue := TRUE;             { assume point does not escape  }
        iter :=0;
        while continue do
        begin
          mult(x,y,x,y,x,y);        { square z }
          x := x+plus;
          mag := x*x+y*y;           { calculate square of magnitude }
          if mag < attract then
            continue := false       { point is an attractor }
          else
            if (mag < 100) and (iter < MaxColor2) then { keep iterating function }
              inc(iter)
            else                     { point escapes, plot it }
            begin
              color := iter div 2;
              if color>colorLimit then
              begin
                if color=MaxColor then
                  CurColor := RGB(255,255,255)
                else
                  CurColor := GetRGBColor(color);

                iLeft := i+ Left;
                iRight := Right - i;
                jTop := j+Top;
                jBottom := Bottom - j;

                ABitmap.Canvas.Pixels[iLeft,jTop] := curColor;

                ABitmap.Canvas.Pixels[iRight,jBottom] := curColor;

                ABitmap.Canvas.Pixels[iRight,jTop] := curColor;

                ABitmap.Canvas.Pixels[iLeft,jBottom] := curColor;

              end;
              continue := false;       { get out of loop }
            end
        end;  { while loop}
        jyScale := jyScale + scale;
      end; {j loop}
      ixScale := ixScale + scale;
    end;{ i loop}
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Forest(ABitmap: TBitmap);
{ compute and display forest of trees
  using Michael Barnsley's IFS algorithm

  12-5-93  Phil Laplante                  }
var
   x, y      : double;         { pixel coordinates }
   i, j      : integer;      { loop counters}
   q         : integer;      { random number }
   k         : integer;      { row selector }
   MaxX,
   MaxY      : integer;      { Maximum X screen coordinate}
   d         : array[1..4,1..6] of double; { holds data of IFS attractor }
   scale     : double;         { random scale factor}
   xpos,ypos : integer;      { tree position }
   crand     : integer;      { pick random color (green, blue, yellow) }
   color     : integer;      { random color value }
   Rect      : TRect;
   curColor  : TColorRef;
   Iterations: integer;
   xValue,
   yValue    : integer;
   xScale,
   yScale : double;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxX := right - left;
    MaxY := bottom - top;     { find maximum Y coordinate }
    if (MaxX=0) or (MaxY=0) then exit;
    MaxX := Max(MaxX,MaxY);
    MaxY := MaxX;
{ initialize IFS data array }

    d[1,1]:=0;     d[1,2]:=0;     d[1,3]:=0;     d[1,4]:=0.5;  d[1,5]:=0; d[1,6]:=0;
    d[2,1]:=0.42;  d[2,2]:=-0.42; d[2,3]:=0.42;  d[2,4]:=0.42; d[2,5]:=0; d[2,6]:=0.2;
    d[3,1]:=0.42;  d[3,2]:=0.42;  d[3,3]:=-0.42; d[3,4]:=0.42; d[3,5]:=0; d[3,6]:=0.2;
    d[4,1]:=0.1;   d[4,2]:=0;     d[4,3]:=0;     d[4,4]:=0.1;  d[4,5]:=0; d[4,6]:=0.2;

    x := 0;              {set starting coordinates}
    y := 0;

    Iterations := trunc(MaxY/20 * 50);

    for j := 1 to 20 do                       { make 20 trees }
    begin
      xpos := random(MaxX);                    { pick tree position }
      ypos := random(MaxX);
      scale := MaxY/(random(3) + 1);           { pick tree scale }
      crand := random(10) + 1;                 { pick tree color }
      case  crand of
        0,1,2,3,4,5,6,7,8:
             color := GREEN;                  { most trees are green }
        9  : color := YELLOW;                 { some trees are yellow }
        10 : color := BROWN;                  { some trees die }
      else
        color := WHITE;
      end;
      curColor :=  GetRGBColor(color);

      for i := 1 to 10 do                     { skip first 10 iterations }
      begin
        q := random(100) + 1;                { pick random number from 1-100}
        if q <= 40 then                      { assign row according to }
          k := 2                             { probability }
        else if (q> 40) AND (q < 81) then
          k := 3
        else if (q >= 81) AND (q < 95) then
          k := 4
        else
          k := 1;

        x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
        y := d[k,3]*x + d[k,4]*y + d[k,6];
      end;

      for i := 11 to iterations do            { Iterations pixels per tree }
      begin
        q := random(100) + 1;                { pick random number from 1-100}
        if q <= 40 then                      { assign row according to }
          k := 2                             { probability }
        else
          if (q> 40) AND (q < 81) then
            k := 3
          else
          if (q >= 81) AND (q < 95) then
           k := 4
         else
         if (q >= 95 ) then
           k := 1;

         x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
         y := d[k,3]*x + d[k,4]*y + d[k,6];

         xScale := x*scale;
         yScale := y*Scale;
         if (xScale<maxLong) and (yScale<maxLong) then
         begin
           xValue := xpos + round(xScale);
           yValue := ypos - round(yScale);
           ABitmap.Canvas.Pixels[xValue + Left,yValue + top] := curColor;
         end;
       end;
     end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Tree(ABitmap: TBitmap);
{ compute and display a tree
  using Michael Barnsley's IFS algorithm
  12-5-93  Phil Laplante
  31-6-94  Valavanis Jim                  }
var
   x, y      : double;       { pixel coordinates }
   i         : integer;      { loop counters}
   q         : integer;      { random number }
   k         : integer;      { row selector }
   MaxX,
   MaxY      : integer;      { Maximum X screen coordinate}
   d         : array[1..4,1..6] of double; { holds data of IFS attractor }
   scale     : double;       { random scale factor}
   xpos,ypos : integer;      { tree position }
   Rect      : TRect;
   Iterations: integer;
   xValue,
   yValue    : integer;
   xScale,
   yScale : double;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxX := right - left;
    MaxY := bottom - top;     { find maximum Y coordinate }
    if (MaxX=0) or (MaxY=0) then exit;
    MaxX := Min(MaxX,MaxY);
    MaxY := MaxX;
    right := left + MaxX;
    bottom := top + MaxY;
{ initialize IFS data array }

    d[1,1]:=0;     d[1,2]:=0;     d[1,3]:=0;     d[1,4]:=0.5;  d[1,5]:=0; d[1,6]:=0;
    d[2,1]:=0.42;  d[2,2]:=-0.42; d[2,3]:=0.42;  d[2,4]:=0.42; d[2,5]:=0; d[2,6]:=0.2;
    d[3,1]:=0.42;  d[3,2]:=0.42;  d[3,3]:=-0.42; d[3,4]:=0.42; d[3,5]:=0; d[3,6]:=0.2;
    d[4,1]:=0.1;   d[4,2]:=0;     d[4,3]:=0;     d[4,4]:=0.1;  d[4,5]:=0; d[4,6]:=0.2;

    x := 0;              {set starting coordinates}
    y := 0;

    Iterations := MaxX * 50;

    xpos := MaxX div 2;          { pick tree position }
    ypos := MaxY;
    scale := MaxX*3;                    { pick tree scale }

    for i := 1 to 10 do                 { skip first 10 iterations }
    begin
      q := random(100) + 1;             { pick random number from 1-100}
      if q <= 40 then                   { assign row according to }
        k := 2                         { probability }
      else if (q> 40) and (q < 81) then
        k := 3
      else if (q >= 81) and (q < 95) then
        k := 4
      else
        k := 1;

      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
    end;

    for i := 11 to iterations do            { Iterations pixels per tree }
    begin
      q := random(100) + 1;                { pick random number from 1-100}
      if q <= 40 then                      { assign row according to }
        k := 2                             { probability }
      else if (q> 40) and (q < 81) then
        k := 3
      else if (q >= 81) and (q < 95) then
        k := 4
      else
        k := 1;

      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];

      xScale := x*scale;
      yScale := y*scale;
      if (xScale<maxLong) and (yScale<maxLong) then
      begin
        xValue := xpos + round(xScale);
        yValue := ypos - round(yScale);

        ABitmap.Canvas.Pixels[xValue + Left,yValue + top] :=
          RGB(Round(MaxY / 2 + 3 * MaxY * x) and 255, 255, Round(MaxY - 3 * MaxY * y) and 255);
      end;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Mandel2(ABitmap: TBitmap);
var
  tymax, txmax, x, y, count, maxcount: integer;
  xscale, yscale, lleft, ttop, xside, yside, zx, zy, tempx, cx, cy: double;
  tx, ty: double;
  Rect: TRect;
  MaxX,
  MaxY: integer;
  xValue,
  yValue: integer;
  curColor: TColorRef;
  colorLimit: integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxX := right - left;
    MaxY := bottom - top;     { find maximum Y coordinate }
    if (MaxX=0) or (MaxY=0) then exit;
    lleft:=-1.85;
    ttop:=1.25;
    xside:=2.5;
    yside:=-2.5;
    xscale:=xside/MaxX;
    yscale:=yside/MaxY;
    MAXCOUNT:=15;
    y:=0;
    tymax:=(MaxY div 2);
    txmax:=MaxX-2;
    colorLimit := -1;
    repeat
      inc(y);
      x:=0;
      while x<=txmax do
      begin
        inc(x);
        cx:=x*xscale+lleft;
        cy:=y*yscale+ttop;
        zx:=0;
        zy:=0;
        count:=0;
        tx:=0;
        ty:=0;
        repeat
          tempx:=tx-ty+cx;
          zy:=2*zx*zy+cy;
          zx:=tempx;
          tx:=sqr(zx);
          ty:=sqr(zy);
          inc(count);
        until (tx+ty>2.82) or (count=MAXCOUNT);
        if count>colorLimit then
        begin
          curColor := GetRGBColor(count-1);
          xValue := x+Left;
          yValue := y + top;
          ABitmap.Canvas.Pixels[xValue,yValue] := curcolor;
          ABitmap.Canvas.Pixels[xValue,bottom - y] := curcolor;
        end;
      end;
    until y>=tymax;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Galaxy(ABitmap: TBitmap);
{ compute and display view of space using Michael Barnsley's
  IFS algorithm.

  12-5-93  Phil Laplante                  }
var
   x, y      : double;       { pixel coordinates }
   i, j      : integer;      { loop counters}
   k         : integer;      { row selector }
   MaxX,
   MaxY      : integer;      { maximum X and Y coordinates}
   d         : array[1..5,1..6] of double; { holds data of IFS attractor }
   scale     : double;       { random scale factor}
   xpos,ypos : integer;      { tree position }
   Rect      : TRect;
   Iterations: integer;
   xValue,
   yValue    : integer;
   xScale,
   yScale : double;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxX := right - left;
    MaxY := bottom - top;     { find maximum Y coordinate }
    if (MaxX=0) or (MaxY=0) then exit;
    MaxX := Min(MaxX,MaxY);
    MaxY := MaxX;
    right := left + MaxX;
    bottom := top + MaxY;

{ initialize IFS data array }

    d[1,1]:=0.33; d[1,2]:=0; d[1,3]:=0; d[1,4]:=0.33; d[1,5]:=1;  d[1,6]:=1;
    d[2,1]:=0.33; d[2,2]:=0; d[2,3]:=0; d[2,4]:=0.33; d[2,5]:=MaxX; d[2,6]:=1;
    d[3,1]:=0.33; d[3,2]:=0; d[3,3]:=0; d[3,4]:=0.33; d[3,5]:=1;  d[3,6]:=MaxX;
    d[4,1]:=0.33; d[4,2]:=0; d[4,3]:=0; d[4,4]:=0.33; d[4,5]:=MaxX; d[4,6]:=MaxX;
    d[5,1]:=0.33; d[5,2]:=0; d[5,3]:=0; d[5,4]:=0.33; d[5,5]:=MaxX div 2; d[5,6]:=MaxX div 2;

    x := 0;              {set starting coordinates}
    y := 0;

    iterations := trunc(MaxY*5);

    for j := 1 to 20 do                        { make 50 stars }
    begin
      xpos := random(MaxX);                    { pick star position }
      ypos := random(MaxX);
      scale := (random(5)+1)/100;             { pick star scale }

      for i := 1 to 10 do                      { skip first 10 iterations }
      begin
        k := random(5) + 1;                    { pick random row }
        x := d[k,1]*x + d[k,2]*y + d[k,5];     { transform coordinates }
        y := d[k,3]*x + d[k,4]*y + d[k,6];
      end;

      for i := 11 to iterations do
      begin
        k := random(5) + 1;                    { pick random row }
        x := d[k,1]*x + d[k,2]*y + d[k,5];     { transform coordinates }
        y := d[k,3]*x + d[k,4]*y + d[k,6];

        xScale := x*scale;
        yScale := y*scale;
        if (xScale<maxLong) and (yScale<maxLong) then
        begin
          xValue := xpos + round(xScale);
          yValue := ypos + round(yScale);
          ABitmap.Canvas.Pixels[xValue + Left,yValue + top] := ABitmap.Canvas.Pen.Color;
        end;
      end;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Rabbit(ABitmap: TBitmap);
var
   i, j      : integer;      { loop variables}
   MaxX,
   MaxY      : integer;      { Maximum Y coordinate}
   MaxY2     : integer;
   scale     : double;         { scale factor }
   mag       : double;         { square of magnitiude of complex number }
   iter      : integer;      { escape iteration counter }
   continue  : boolean;      { continue iteration counter }
   x,y       : double;         { real and complex parts of z }
   MaxColor  : byte;         { maximum number of colors }
   MaxColor2 : byte;
   curColor   : TColorRef;
   Rect: TRect;
   color      : byte;
   zoom,
   ixScale,
   jyScale    : double;
   colorLimit : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    zoom := 2.0;
    MaxY := bottom - top;     { find maximum Y coordinate }
    MaxX := right - left;
    if (MaxX=0) or (MaxY=0) then exit;
    MaxX := Max(MaxX,MaxY);
    MaxY := MaxX;
    right := left + MaxX;
    bottom := top + MaxY;
    MaxY2 := MaxY div 2;
    MaxColor := 15; { Maximum number of colors }
    MaxColor2 := MaxColor*2;
    scale:= 2.0*zoom/MaxY;   { calculate zoom factor}
//    if hi(StyleLo)=1 then
       colorLimit := -1;
//     else
//       colorLimit := 0;
    ixScale := 0.0;
    for i := 0 to MaxX do    { MaxY is usually smaller than MaxX }
    begin
      jyScale := 0;
      for j := 0 to MaxY2 do
      begin
        x := ixScale-zoom;            { set starting value of real(z) }
        y := zoom-jYScale;            { set starting value of imag(z) }
        continue := true;             { assume point does not escape  }
        iter :=0;
        while continue do
        begin
          mult(x,y,x,y,x,y);        { square z }
          add(x,y,-0.122,0.745,x,y);{ add constant }
          mag := x*x+y*y;           { calculate square of magnitude }
          if mag < attract then
            continue := false       { point is an attractor }
          else
            if (mag < 100) AND (iter < MaxColor2) then { keep iterating function }
              inc(iter)
            else                     { point escapes, plot it }
            begin
              color := iter div 2;
              if color>colorLimit then
              begin
                CurColor := GetRGBColor(color);

                ABitmap.Canvas.Pixels[i + Left,j+top] := curColor;

                ABitmap.Canvas.Pixels[right-i,bottom-j] := curColor;
              end;
            continue := false;        { get out of loop }
          end;
        end;  { while loop}
        jyScale := jyScale + scale;
      end;  {j loop}
      ixScale := ixScale + scale;
    end;{ i loop}
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Siegel(ABitmap: TBitmap);
{ compute and display a Siegel disk -- the Julia set of
 f(z) = z^2 -0.39054 -0.58679i

  1-2-92  Phil Laplante                     }
var
   i, j      : integer;      { loop variables}
   MaxX,
   MaxY      : integer;      { Maximum Y coordinate}
   MaxY2     : integer;
   scale     : double;         { scale factor }
   mag       : double;         { square of magnitiude of complex number }
   iter      : integer;      { escape iteration counter }
   continue  : boolean;      { continue iteration counter }
   x,y       : double;         { real and complex parts of z }
   MaxColor  : byte;         { maximum number of colors }
   MaxColor2 : byte;
   curColor   : TColorRef;
   Rect: TRect;
   color      : byte;
   zoom,
   ixScale,
   jyScale : double;
   colorLimit : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    zoom := 2.0;
    MaxY := bottom - top;     { find maximum Y coordinate }
    MaxX := right - left;
    if (MaxX=0) or (MaxY=0) then exit;
    MaxX := Max(MaxX,MaxY);
    MaxY := MaxX;
    right := left + MaxX;
    bottom := top + MaxY;
    MaxY2 := MaxY div 2;
    MaxColor := 15; { Maximum number of colors }
    MaxColor2 := MaxColor*2;
    scale:= 2.0*zoom/MaxY;   { calculate zoom factor}
//    if hi(StyleLo)=1 then
      colorLimit := -1;
//     else
//       colorLimit := 0;
    ixScale := 0;
    for i := 0 to MaxX do    { MaxY is usually smaller than MaxX }
    begin
      jyScale := 0;
      for j := 0 to MaxY2 do
      begin
        x := ixScale-zoom;            { set starting value of real(z) }
        y := zoom-jyScale;            { set starting value of imag(z) }
        continue := true;             { assume point does not escape  }
        iter :=0;
        while continue do
        begin
          mult(x,y,x,y,x,y);               { square z }
          add(x,y,-0.390540,-0.58679,x,y); { add constant }
          mag := x*x+y*y;                  { calculate square of magnitude }
          if mag < attract then
            continue := false       { point is an attractor }
          else
            if (mag < 100) and (iter < MaxColor2) then { keep iterating function }
              inc(iter)
            else                     { point escapes, plot it }
            begin
              color := iter div 2;
              if color>colorLimit then
              begin
                CurColor := GetRGBColor(color);

                ABitmap.Canvas.Pixels[i + Left,j+top] := curColor;

                ABitmap.Canvas.Pixels[right-i,bottom-j] := curColor;
              end;
              continue := false;        { get out of loop }
            end;
        end;  { while loop}
        jyScale := jyScale + scale;
      end;  {j loop}
      ixScale := ixScale + scale;
    end;{ i loop}
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure FTriangle(ABitmap: TBitmap);
{ compute and display Sierpinski triangle via random orbits
  12-5-93  Phil Laplante                  }
var
   x, y      : integer;      { pixel coordinates }
   triangle  : integer;      { select random traiangle}
   i         : integer;      { loop counters}
   MaxX,
   MaxY      : integer;      { maximum X and Y coordinates}
   Rect      : TRect;
   Iterations: integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxX := right - left;
    MaxY := bottom - top;     { find maximum Y coordinate }
    if (MaxX=0) or (MaxY=0) then exit;
    MaxX := Min(MaxX,MaxY);
    MaxY := MaxX;
    right := left + MaxX;
    bottom := top + MaxY;

    x := random(MaxY);  {select random starting point}
    y := random(MaxY);  {use MaxX=MaxY }

    Iterations := MaxY * 100;

    for i := 1 to  iterations do
    begin
      triangle := random(3)+1;  { select random number between 1 and 3}
      case triangle of         { select which triangle to measure from }
         1:  begin
               x := x div 2;            { find 1/2 way point to  A}
               y := (MaxY + y) div 2
             end;
         2:  begin
               x := (MaxY div 2 + x) div 2; { find 1/2 way point to B }
               y := y div 2
             end;
         3:  begin
               x := (MaxY + x) div 2;       { find 1/2 way point to C}
               y := (MaxY + y) div 2
             end
      end;
      ABitmap.Canvas.Pixels[x+Left,y+Top] := ABitmap.Canvas.Pen.Color;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure JuliaCosZ(ABitmap: TBitmap);
{ compute and display Julia set of cos z
  12-21-93   Phil Laplante                     }
var
   i, j      : integer;      { loop variables}
   MaxX,
   MaxY      : integer;      { Maximum Y coordinate}
   MaxY2     : integer;
   scale     : double;         { scale factor }
   mag       : double;         { square of magnitiude of complex number }
   iter      : integer;      { escape iteration counter }
   continue  : boolean;      { continue iteration counter }
   x,y       : double;         { real and complex parts of z }
   MaxColor  : byte;         { maximum number of colors }
   MaxColor2 : byte;
   curColor   : TColorRef;
   Rect: TRect;
   color      : byte;
   zoom,
   ixScale,
   jyScale : double;
   iLeft,
   iRight,
   jTop,
   jBottom: integer;
   xStop,yStop : integer;
   oldPEN      : TColor;
   colorLimit  : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    zoom := 2.0;
    MaxY := bottom - top;     { find maximum Y coordinate }
    MaxX := right - left;
    if (MaxX=0) or (MaxY=0) then exit;
    MaxX := Max(MaxX,MaxY);
    MaxY := MaxX;
    right := left + MaxX;
    bottom := top + MaxY;
    MaxY2 := MaxY div 2;
    MaxColor := 15; { Maximum number of colors }
    MaxColor2 := MaxColor*2;
//    if hi(StyleLo)=1 then
       colorLimit := -1;
//     else
//       colorLimit := 0;
    scale:= 2.0*zoom/MaxY;   { calculate zoom factor}
    ixScale := 0;

    curColor := GetRGBColor(maxColor);
    oldPEN := ABitmap.Canvas.Pen.Color;
    ABitmap.Canvas.Pen.Color := curColor;

    xStop := trunc(MaxY / 100 * 37) ;
    yStop := MaxY div 5;

    for i := 0 to xStop do
    begin
      jyScale := 0;
      for j := 0 to yStop do
      begin
        x := ixScale-zoom;            { set starting value of real(z) }
        y := zoom-jyScale;            { set starting value of imag(z) }
        continue := true;             { assume point does not escape  }
        iter :=0;
        while continue do
        begin
          ccos(x,y,x,y);                   { calculate complex cosine }
          mag := x*x+y*y;                  { calculate square of magnitude }
          if mag < attract then
            continue := false       { point is an attractor }
          else
            if (mag < 100) and (iter < MaxColor2) then { keep iterating function }
              inc(iter)
            else                     { point escapes, plot it }
            begin
              color := iter div 2;
              if color>colorLimit then
              begin
                CurColor := GetRGBColor(color);
                iLeft := i+ Left;
                iRight := Right - i;
                jTop := j+Top;
                jBottom := Bottom - j;

                ABitmap.Canvas.Pixels[iLeft,jTop] := curColor;
                ABitmap.Canvas.Pixels[iRight,jBottom] := curColor;
                ABitmap.Canvas.Pixels[iRight,jTop] := curColor;
                ABitmap.Canvas.Pixels[iLeft,jBottom] := curColor;
              end;
              continue := false;        { get out of loop }
            end;
        end;  { while loop}
        jyScale := jyScale + scale;
      end;  {j loop}
      iLeft := i+ Left;
      iRight := Right-i;
      jTop := yStop+Top;
      jBottom := Bottom - yStop;

      ABitmap.Canvas.MoveTo(iLeft,jTop);
      ABitmap.Canvas.LineTo(iLeft,jBottom);

      ABitmap.Canvas.MoveTo(iRight,jTop);
      ABitmap.Canvas.LineTo(iRight,jBottom);
      ixScale := ixScale + scale;
    end;{ i loop}
    for i := xStop to maxY2 do
    begin
      ABitmap.Canvas.MoveTo(i+left,top);
      ABitmap.Canvas.LineTo(i+Left,bottom);
      ABitmap.Canvas.MoveTo(right-i,top);
      ABitmap.Canvas.LineTo(right-i,bottom);
    end;

    ABitmap.Canvas.Pen.Color := oldPEN;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure JuliaSinZ(ABitmap: TBitmap);
{ compute and display Julia set of cos z
  12-21-93   Phil Laplante                     }
var
   i, j      : integer;      { loop variables}
   MaxX,
   MaxY      : integer;      { Maximum Y coordinate}
   MaxY2     : integer;
   scale     : double;         { scale factor }
   mag       : double;         { square of magnitiude of complex number }
   iter      : integer;      { escape iteration counter }
   continue  : boolean;      { continue iteration counter }
   x,y       : double;         { real and complex parts of z }
   MaxColor  : byte;         { maximum number of colors }
   MaxColor2 : byte;
   curColor   : TColorRef;
   Rect: TRect;
   color      : byte;
   zoom,
   ixScale,
   jyScale : double;
   iLeft,
   iRight,
   jTop,
   jBottom: integer;
   xStop,yStop : integer;
   oldPEN      : TColor;
   colorLimit  : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    zoom := 2.0;
    MaxY := bottom - top;     { find maximum Y coordinate }
    MaxX := right - left;
    if (MaxX=0) or (MaxY=0) then exit;
    MaxX := Max(MaxX,MaxY);
    MaxY := MaxX;
    right := left + MaxX;
    bottom := top + MaxY;
    MaxY2 := MaxY div 2;
    MaxColor := 15; { Maximum number of colors }
    MaxColor2 := MaxColor*2;
//    if hi(StyleLo)=1 then
       colorLimit := -1;
//     else
//       colorLimit := 0;
    scale:= 2.0*zoom/MaxY;   { calculate zoom factor}
    ixScale := 0;

    curColor := GetRGBColor(maxColor);
    oldPEN := ABitmap.Canvas.Pen.Color;
    ABitmap.Canvas.Pen.Color := curColor;

    xStop := trunc(MaxY / 100 * 37) ;
    yStop := MaxY div 5;

    for i := 0 to xStop do
    begin
      jyScale := 0;
      for j := 0 to yStop do
      begin
        x := ixScale-zoom;            { set starting value of real(z) }
        y := zoom-jyScale;            { set starting value of imag(z) }
        continue := true;             { assume point does not escape  }
        iter :=0;
        while continue do
        begin
          csin(x,y,x,y);                   { calculate complex cosine }
          mag := x*x+y*y;                  { calculate square of magnitude }
          if mag < attract then
            continue := false       { point is an attractor }
          else
            if (mag < 100) and (iter < MaxColor2) then { keep iterating function }
              inc(iter)
            else                     { point escapes, plot it }
            begin
              color := iter div 2;
              if color>colorLimit then
              begin
                CurColor := GetRGBColor(color);
                iLeft := i+ Left;
                iRight := Right - i;
                jTop := j+Top;
                jBottom := Bottom - j;

                ABitmap.Canvas.Pixels[iLeft,jTop] := curColor;
                ABitmap.Canvas.Pixels[iRight,jBottom] := curColor;
                ABitmap.Canvas.Pixels[iRight,jTop] := curColor;
                ABitmap.Canvas.Pixels[iLeft,jBottom] := curColor;
              end;
              continue := false;        { get out of loop }
            end;
        end;  { while loop}
        jyScale := jyScale + scale;
      end;  {j loop}
      iLeft := i+ Left;
      iRight := Right-i;
      jTop := yStop+Top;
      jBottom := Bottom - yStop;

      ABitmap.Canvas.MoveTo(iLeft,jTop);
      ABitmap.Canvas.LineTo(iLeft,jBottom);

      ABitmap.Canvas.MoveTo(iRight,jTop);
      ABitmap.Canvas.LineTo(iRight,jBottom);
      ixScale := ixScale + scale;
    end;{ i loop}
    for i := xStop to maxY2 do
    begin
      ABitmap.Canvas.MoveTo(i+left,top);
      ABitmap.Canvas.LineTo(i+Left,bottom);
      ABitmap.Canvas.MoveTo(right-i,top);
      ABitmap.Canvas.LineTo(right-i,bottom);
    end;

    ABitmap.Canvas.Pen.Color := oldPEN;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Maze(ABitmap: TBitmap);
{ compute and display a "maze"
  using Michael Barnsley's IFS algorithm

  12-5-93  Phil Laplante                  }
var
   x, y      : double;         { pixel coordinates }
   i         : integer;      { loop counters}
   k         : integer;      { row selector }
   d         : array[1..6,1..6] of double; { holds data of IFS attractor }
   Rect      : TRect;
   Multiplier : double;
   Iterations : word;
   MaxX,
   MaxY : integer;
   xValue,
   yValue   : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxX := right - left;
    MaxY := bottom - top;     { find maximum Y coordinate }
    if (MaxX=0) or (MaxY=0) then exit;
    MaxY := Max(MaxX,MaxY);
    bottom := top + MaxY;
    right  := left + MaxY;
{ initialize IFS data array }

    d[1,1]:=0.33; d[1,2]:=0; d[1,3]:=0; d[1,4]:=0.33; d[1,5]:=1;  d[1,6]:=1;
    d[2,1]:=0.33; d[2,2]:=0; d[2,3]:=0; d[2,4]:=0.33; d[2,5]:=MaxY div 2; d[2,6]:=1;
    d[3,1]:=0.33; d[3,2]:=0; d[3,3]:=0; d[3,4]:=0.33; d[3,5]:=1;  d[3,6]:=MaxY div 2;
    d[4,1]:=0.33; d[4,2]:=0; d[4,3]:=0; d[4,4]:=0.33; d[4,5]:=MaxY div 2; d[4,6]:=MaxY;
    d[5,1]:=0.33; d[5,2]:=0; d[5,3]:=0; d[5,4]:=0.33; d[5,5]:=MaxY; d[5,6]:=MaxY;
    d[6,1]:=0.33; d[6,2]:=0; d[6,3]:=0; d[6,4]:=0.33; d[6,5]:=1; d[6,6]:=MaxY;

    x := 0;              {set starting coordinates}
    y := 0;

    Iterations := MaxY * 50;
    Multiplier := 2/3;

    for i := 1 to 10 do                    { skip first 10 iterations }
    begin
      k := random(6) + 1;                  { pick random row }
      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
    end;

    for i := 11 to Iterations do
    begin
      k := random(6) + 1;                  { pick random row }
      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
      xValue := round(x*Multiplier)+Left;
      yValue := round(y*Multiplier);

      ABitmap.Canvas.Pixels[xValue,yValue+top] := ABitmap.Canvas.Pen.Color;
      ABitmap.Canvas.Pixels[xValue,bottom-yValue] := ABitmap.Canvas.Pen.Color;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure MistClouds(ABitmap: TBitmap);     {generates mist/clouds}
var
  x, y      : double;       { pixel coordinates }
  i         : integer;      { loop counters}
  k         : integer;      { row selector }
  MaxX,
  MaxY      : integer;      { Maximum X screen coordinate}
  Rect      : TRect;
  d         : array[1..8,1..6] of double; { holds data of IFS attractor }
  Iterations: integer;
  xValue,
  yValue    : integer;
  multiplier  : double;
  color    : TColorRef;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxX := right - left;
    MaxY := bottom - top;     { find maximum Y coordinate }
    if (MaxX=0) or (MaxY=0) then exit;
    color := GetRGBColor(LightGray);
    Multiplier := 2/3;
{ initialize IFS data array }

    d[1,1]:=0.33; d[1,2]:=1; d[1,3]:=0; d[1,4]:=0.33; d[1,5]:=0;  d[1,6]:=0;
    d[2,1]:=0.33; d[2,2]:=1; d[2,3]:=0; d[2,4]:=0.33; d[2,5]:=MaxY; d[2,6]:=0;
    d[3,1]:=0.33; d[3,2]:=1; d[3,3]:=0; d[3,4]:=0.33; d[3,5]:=1;  d[3,6]:=MaxY;
    d[4,1]:=0.33; d[4,2]:=1; d[4,3]:=0; d[4,4]:=0.33; d[4,5]:=MaxY; d[4,6]:=MaxY;
    d[5,1]:=0.33; d[5,2]:=0; d[5,3]:=0; d[5,4]:=0.33; d[5,5]:=MaxY div 2; d[5,6]:=1;
    d[6,1]:=0.33; d[6,2]:=0; d[6,3]:=0; d[6,4]:=0.33; d[6,5]:=MaxY; d[6,6]:=MaxY div 2;
    d[7,1]:=0.33; d[7,2]:=0; d[7,3]:=0; d[7,4]:=0.33; d[7,5]:=1;  d[7,6]:=MaxY div 2;
    d[8,1]:=0.33; d[8,2]:=0; d[8,3]:=0; d[8,4]:=0.33; d[8,5]:=MaxY div 2; d[8,6]:=MaxY;

    x := 1;              {set starting coordinates}
    y := MaxY div 10;

    Iterations := MaxY * 150;

    for i := 1 to iterations do
    begin
      k := random(8) + 1;                  { pick random column }
      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
      xValue := round(x*multiplier);
      yValue := round(y*multiplier);
      ABitmap.Canvas.Pixels[xValue + Left,yValue + top] := Color;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure Rock(Abitmap: TBitmap);
{ compute and display "Rock" fractal
  using Michael Barnsley's IFS algorithm

  12-5-93  Frank D'Erasmo }
var
   x, y      : double;         { pixel coordinates }
   i         : integer;      { loop counters}
   k         : integer;      { row selector }
   d         : array[1..4,1..6] of double; { holds data of IFS attractor }
   Rect      : TRect;
   Iterations : word;
   MaxX,
   MaxY : integer;
   xValue,
   yValue   : integer;
   MaxY2 : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    MaxX := right - left;
    MaxY := bottom - top;     { find maximum Y coordinate }
    if (MaxX=0) or (MaxY=0) then exit;
    MaxY := Max(MaxX,MaxY);
    bottom := top + MaxY;
    right  := left + MaxY;
    MaxY2 := MaxY div 2;

{ initialize IFS data array }

    d[1,1]:=0.5;  d[1,2]:=0;  d[1,3]:=0;  d[1,4]:=0.5;  d[1,5]:=0; d[1,6]:=0;
    d[2,1]:=0.5;  d[2,2]:=0;  d[2,3]:=0;  d[2,4]:=0.5;  d[2,5]:=2; d[2,6]:=0;
    d[3,1]:=-0.4;  d[3,2]:=0;  d[3,3]:=1;  d[3,4]:=0.4;  d[3,5]:=0; d[3,6]:=1;
    d[4,1]:=-0.5;  d[4,2]:=0;  d[4,3]:=0;  d[4,4]:=0.5;  d[4,5]:=2; d[4,6]:=1;

    x := 0;              {set starting coordinates}
    y := 0;

    Iterations := MaxY * 250;

    for i := 1 to 10 do                    { skip first 10 iterations }
    begin
      k := random(4) + 1;                  { pick random number from 1-4}
      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
    end;

    for i := 11 to Iterations do
    begin
      k := random(4) + 1;                  { pick random number from 1-4}
      x := d[k,1]*x + d[k,2]*y + d[k,5];   { transform coordinates }
      y := d[k,3]*x + d[k,4]*y + d[k,6];
      xValue := round(x*MaxY2)+left;
      yValue := round(y*MaxY2)+top;
      ABitmap.Canvas.Pixels[xValue,yValue] := ABitmap.Canvas.Pen.Color;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

procedure CustomJulia(ABitmap: TBitmap);
{ compute and display a Siegel disk -- the Julia set of
 f(z) = z^2 + xJulia +yJuliai

  1-2-92  Phil Laplante                     }
var
   i, j      : integer;      { loop variables}
   MaxX,
   MaxY      : integer;      { Maximum Y coordinate}
   MaxY2     : integer;
   scale     : double;         { scale factor }
   mag       : double;         { square of magnitiude of complex number }
   iter      : integer;      { escape iteration counter }
   continue  : boolean;      { continue iteration counter }
   x,y       : double;         { real and complex parts of z }
   MaxColor  : byte;         { maximum number of colors }
   MaxColor2 : byte;
   curColor   : TColorRef;
   Rect: TRect;
   color      : byte;
   zoom,
   ixScale,
   jyScale : double;
   colorLimit : integer;
begin
  SetRect(Rect, 0, 0, ABitmap.Width, ABitmap.Height);
  with Rect do
  begin
    zoom := 2.0;
    MaxY := bottom - top;     { find maximum Y coordinate }
    MaxX := right - left;
    if (MaxX=0) or (MaxY=0) then exit;
    MaxX := Max(MaxX,MaxY);
    MaxY := MaxX;
    right := left + MaxX;
    bottom := top + MaxY;
    MaxY2 := MaxY div 2;
    MaxColor := 15; { Maximum number of colors }
    MaxColor2 := MaxColor*2;
    scale:= 2.0*zoom/MaxY;   { calculate zoom factor}
    colorLimit := -1;
    ixScale := 0;
    for i := 0 to MaxX do    { MaxY is usually smaller than MaxX }
    begin
      jyScale := 0;
      for j := 0 to MaxY2 do
      begin
        x := ixScale-zoom;            { set starting value of real(z) }
        y := zoom-jyScale;            { set starting value of imag(z) }
        continue := true;             { assume point does not escape  }
        iter :=0;
        while continue do
        begin
          mult(x,y,x,y,x,y);               { square z }
          add(x,y,Form1.xJulia,Form1.yJulia,x,y); { add constant }
          mag := x*x+y*y;                  { calculate square of magnitude }
          if mag < attract then
            continue := false       { point is an attractor }
          else
            if (mag < 100) and (iter < MaxColor2) then { keep iterating function }
              inc(iter)
            else                     { point escapes, plot it }
            begin
              color := iter div 2;
              if color>colorLimit then
              begin
                CurColor := GetRGBColor(color);

                ABitmap.Canvas.Pixels[i + Left,j+top] := curColor;

                ABitmap.Canvas.Pixels[right-i,bottom-j] := curColor;
              end;
              continue := false;        { get out of loop }
            end;
        end;  { while loop}
        jyScale := jyScale + scale;
      end;  {j loop}
      ixScale := ixScale + scale;
    end;{ i loop}
  end;
end;


procedure TForm1.SetDimentions(w, h: integer);
begin
  Image1.Picture.Bitmap.Width := w;
  Image1.Picture.Bitmap.Height := h;
  Image1.Width := w;
  Image1.Height := h;
  if Assigned(LastProc) then
    PaintFractal(LastProc);
end;

const
  DefFractalWidth = 640;
  DefFractalHeight = 480;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  LastProc := nil;
  opt_width := DefFractalWidth;
  opt_height := DefFractalHeight;
  opt_xjulia := -0.39054;
  opt_yjulia := -0.58679;
  gf_LoadSettingsFromFile(ChangeFileExt(ParamStr(0), '.ini'));

  xJulia := opt_xjulia;
  yJulia := opt_yjulia;
  SetDimentions(opt_width, opt_height);
  ClearPicture;
  StatusBar1.Panels[0].Text := Application.Title + ', Version 1.1';

  Toolbar1.Visible := opt_toolbar;
  StatusBar1.Visible := opt_statusbar;

  Timer1.Enabled := true;
end;

procedure TForm1.ClearPicture;
begin
  ClearCanvas(clBlack);
  Image1.Picture.Bitmap.Canvas.Pen.Color := clWhite;
end;

procedure TForm1.ClearCanvas(c: TColor);
begin
  Image1.Picture.Bitmap.Canvas.Brush.Color := c;
  Image1.Picture.Bitmap.Canvas.FillRect(
    Rect(0, 0, Image1.Picture.Bitmap.Width, Image1.Picture.Bitmap.Height));
end;

procedure TForm1.PaintFractal(proc: TFractalPainterProc);
begin
  Screen.Cursor := crHourglass;
  try
    ClearCanvas(clBlack);
    if Assigned(proc) then proc(Image1.Picture.Bitmap);
    LastProc := proc;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.ClearClick(Sender: TObject);
begin
  ClearPicture;
  LastProc := nil;
end;

procedure TForm1.Mandel1Click(Sender: TObject);
begin
  PaintFractal(Mandel);
end;

procedure TForm1.Fern1Click(Sender: TObject);
begin
  PaintFractal(Fern);
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Ameboa1Click(Sender: TObject);
begin
  PaintFractal(Ameboa);
end;

procedure TForm1.Bifur1Click(Sender: TObject);
begin
  PaintFractal(Bifur);
end;

procedure TForm1.Carpet1Click(Sender: TObject);
begin
  PaintFractal(Carpet);
end;

procedure TForm1.Castle1Click(Sender: TObject);
begin
  PaintFractal(Castle);
end;

procedure TForm1.Cloud1Click(Sender: TObject);
begin
  PaintFractal(Cloud);
end;

procedure TForm1.Clouds1Click(Sender: TObject);
begin
  PaintFractal(Clouds);
end;

procedure TForm1.Dendrite1Click(Sender: TObject);
begin
  PaintFractal(Dendrite);
end;

procedure TForm1.Dragon1Click(Sender: TObject);
begin
  PaintFractal(Dragon);
end;

procedure TForm1.N640x4801Click(Sender: TObject);
begin
  SetDimentions(640, 480);
end;

procedure TForm1.N800x6001Click(Sender: TObject);
begin
  SetDimentions(800, 600);
end;

procedure TForm1.N1024x7681Click(Sender: TObject);
begin
  SetDimentions(1024, 768);
end;

procedure TForm1.N640x6401Click(Sender: TObject);
begin
  SetDimentions(640, 640);
end;

procedure TForm1.N800x8001Click(Sender: TObject);
begin
  SetDimentions(800, 800);
end;

procedure TForm1.N1024x10241Click(Sender: TObject);
begin
  SetDimentions(1024, 1024);
end;

procedure TForm1.N320x2401Click(Sender: TObject);
begin
  SetDimentions(320, 240);
end;

procedure TForm1.N320x3201Click(Sender: TObject);
begin
  SetDimentions(320, 320);
end;

procedure TForm1.EKG1Click(Sender: TObject);
begin
  PaintFractal(EKG);
end;

procedure TForm1.Fall1Click(Sender: TObject);
begin
  PaintFractal(Fall);
end;

procedure TForm1.SnowStar1Click(Sender: TObject);
begin
  PaintFractal(SnowStar);
end;

procedure TForm1.Flower1Click(Sender: TObject);
begin
  PaintFractal(Flower);
end;

procedure TForm1.Forrest1Click(Sender: TObject);
begin
  PaintFractal(Forest);
end;

procedure TForm1.Tree1Click(Sender: TObject);
begin
  PaintFractal(Tree);
end;

procedure TForm1.Mandel21Click(Sender: TObject);
begin
  PaintFractal(Mandel2);
end;

procedure TForm1.Galaxy1Click(Sender: TObject);
begin
  PaintFractal(Galaxy);
end;

procedure TForm1.Rabbit1Click(Sender: TObject);
begin
  PaintFractal(Rabbit);
end;

procedure TForm1.Siegel1Click(Sender: TObject);
begin
  PaintFractal(Siegel);
end;

procedure TForm1.Triangle1Click(Sender: TObject);
begin
  PaintFractal(FTriangle);
end;

procedure TForm1.JuliaCos1Click(Sender: TObject);
begin
  PaintFractal(JuliaCosZ);
end;

procedure TForm1.JuliaSin1Click(Sender: TObject);
begin
  PaintFractal(JuliaSinZ);
end;

procedure TForm1.Maze1Click(Sender: TObject);
begin
  PaintFractal(Maze);
end;

procedure TForm1.MistClouds1Click(Sender: TObject);
begin
  PaintFractal(MistClouds);
end;

procedure TForm1.Rock1Click(Sender: TObject);
begin
  PaintFractal(Rock);
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  MessageBox(
    Handle,
    PChar(
      'GFractal Version 1.1'#13#10#13#10'A Fractal Generator'#13#10'© 2001 - 2018, jvalavanis@gmail.com'
      ),
    PChar(
      'GFractal'
      ),
    MB_OK or MB_ICONINFORMATION or MB_APPLMODAL);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  opt_width := Image1.Width;
  opt_height := Image1.Height;
  opt_xjulia := xJulia;
  opt_yjulia := yJulia;
  opt_toolbar := Toolbar1.Visible;
  opt_statusbar := StatusBar1.Visible;
  gf_SaveSettingsToFile(ChangeFileExt(ParamStr(0), '.ini'));
end;

procedure TForm1.CopyClick(Sender: TObject);
var
  aBitmap: TBitmap;
  r: TRect;
begin
  if not Assigned(LastProc) then
    Exit;

  aBitmap := TBitmap.Create;
  try
    aBitmap.Width := Image1.Picture.Bitmap.Width;
    aBitmap.Height := Image1.Picture.Bitmap.Height;
    if aBitmap.Width * aBitmap.Height <> 0 then
    begin
      SetRect(r, 0, 0, aBitmap.Width, aBitmap.Height);
      aBitmap.Canvas.CopyRect(r, Image1.Picture.Bitmap.Canvas, r);
      Clipboard.Assign(aBitmap);
    end;
  finally
    aBitmap.Free;
  end;
end;

function CreateBackupFile(const FileName: TFileName; const BackExt: string): boolean; overload;
var
  BackFileName: TFileName;
  Ext: string;
  f1, f2: TFileStream;
begin
  result := false;
  if FileExists(FileName) then
  begin
    if length(BackExt) > 0 then
    begin
      Ext := BackExt;
      if Ext[1] <> '.' then
         Ext := '.' + Ext;
    end
    else
      Ext := '.';
    if UpperCase(ExtractFileExt(FileName)) <> UpperCase(Ext) then
    begin
      BackFileName := ChangeFileExt(FileName, Ext);
      f1 := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
      f2 := TFileStream.Create(BackFileName, fmCreate or fmShareDenyWrite);
      try
        f2.CopyFrom(f1, 0);
      finally
        f1.Free;
        f2.Free;
      end;
      result := true;
    end;
  end;
end;

function CreateBackupFile(const FileName: TFileName): boolean; overload;
var
  Ext: string;
begin
  Ext := ExtractFileExt(FileName);
  if Length(Ext) > 1 then
  begin
    if Ext[1] <> '.' then Ext := '.' + Ext;
    Insert('~', Ext, 2);
    result := CreateBackupFile(FileName, Ext);
  end
  else
    result := false;
end;

procedure TForm1.SaveAsClick(Sender: TObject);
var
  aPNG: TPngObject;
begin
  if not Assigned(LastProc) then
    Exit;

  SavePictureDialog1.FileName := '';
  if SavePictureDialog1.Execute then
  begin
    Screen.Cursor := crHourglass;
    try
      aPNG := TPngObject.Create;
      try
        aPNG.Assign(Image1.Picture.Bitmap);
        CreateBackupFile(SavePictureDialog1.Filename);
        aPNG.SaveToFile(SavePictureDialog1.Filename);
      finally
        aPNG.Free;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TForm1.View1Click(Sender: TObject);
var
  w, h: integer;
begin
  w := Image1.Picture.Bitmap.Width;
  h := Image1.Picture.Bitmap.Height;
  N320x2401.Checked := (w = 320) and (h = 240);
  N640x4801.Checked := (w = 640) and (h = 480);
  N800x6001.Checked := (w = 800) and (h = 600);
  N1024x7681.Checked := (w = 1024) and (h = 768);
  N320x3201.Checked := (w = 320) and (h = 320);
  N640x6401.Checked := (w = 640) and (h = 640);
  N800x8001.Checked := (w = 800) and (h = 800);
  N1024x10241.Checked := (w = 1024) and (h = 1024);

  ViewToolbar1.Checked := Toolbar1.Visible;
  ViewStatusBar1.Checked := StatusBar1.Visible;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  SaveAs1.Enabled := Assigned(LastProc);
  Save2.Enabled := Assigned(LastProc);
  Copy1.Enabled := Assigned(LastProc);
  Copy2.Enabled := Assigned(LastProc);
  Clear1.Enabled := Assigned(LastProc);
  Clear2.Enabled := Assigned(LastProc);
end;

procedure TForm1.Edit1Click(Sender: TObject);
begin
  Copy1.Enabled := Assigned(LastProc);
  Clear1.Enabled := Assigned(LastProc);
end;

procedure TForm1.File1Click(Sender: TObject);
begin
  SaveAs1.Enabled := Assigned(LastProc);
end;

procedure TForm1.CustomJulia1Click(Sender: TObject);
begin
  if GetCustomJuliaSet(xJulia, yJulia) then
    PaintFractal(CustomJulia);
end;

procedure TForm1.ViewStatusbar1Click(Sender: TObject);
begin
  StatusBar1.Visible := not StatusBar1.Visible;
end;

procedure TForm1.ViewToolbar1Click(Sender: TObject);
begin
  Toolbar1.Visible := not Toolbar1.Visible;
end;

procedure TForm1.ApplicationEvents1Hint(Sender: TObject);
begin
  if Application.Hint <> '' then
    StatusBar1.Panels[0].Text := ' ' + Application.Hint
  else
    StatusBar1.Panels[0].Text := Application.Title + ', Version 1.1';
end;

end.

