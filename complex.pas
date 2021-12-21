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
//    Complex numbers math
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr / jvalavanis@gmail.com
//  Site  : https://sourceforge.net/projects/gfractal/
//------------------------------------------------------------------------------

unit complex;

interface

procedure add(x1, y1, x2, y2: double; var x3, y3: double); // complex addition

procedure sub(x1, y1, x2, y2: double; var x3, y3: double); // complex subtraction

procedure mult(x1, y1, x2, y2: double; var x3, y3: double); // complex multiplication

procedure cdiv(x1, y1, x2, y2: double; var x3, y3: double); // complex division

function cosh(x: double): double; // hyperbolic cosine

function sinh(x: double): double; // hyperbolic sine

procedure csin(x, y: double; var x1, y1: double); // complex sine

procedure ccos(x, y: double; var x1, y1: double); // complex cosine

procedure cexp(x, y: double; var x1, y1: double); // complex exponentiation

implementation

procedure add(x1, y1, x2, y2: double; var x3, y3: double);
{ calculates z3 = z1 + z2 where:
  z1 = x1 + iy1;
  z2 = x2 + iy2;
  z3 = x3 + iy3;
}
begin
  x3 := x1 + x2;
  y3 := y1 + y2;
end;

procedure sub(x1, y1, x2, y2: double; var x3, y3: double);
{ calculates z3 = z1 - z2 where:
  z1 = x1 + iy1
  z2 = x2 + iy2
  z3 = x3 + iy3
}
begin
  x3 := x1 - x2;
  y3 := y1 - y2;
end;


procedure mult(x1, y1, x2, y2: double; var x3, y3: double);
{ calculates z3 = z1 * z2 where:
  z1 = x1 + iy1
  z2 = x2 + iy2
  z3 = x3 + iy3
}
begin
  x3 := x1 * x2 - y1 * y2;
  y3 := y1 * x2 + x1 * y2;
end;

procedure cdiv(x1, y1, x2, y2: double; var x3, y3: double);
{ calculates z3 = z1 / z2 where:
  z1 = x1 + iy1
  z2 = x2 + iy2
  z3 = x3 + iy3
}
var
  denom: double;                   { denominator }
begin
  denom := x2 * x2 + y2 * y2;
  x3 := (x1 * x2 + y1 * y2) / denom;   { double part }
  y3 := (x2 * y1 - x1 * y2) / denom;   { imaginary part }
end;


function cosh(x: double): double;     { calculates cosh(x) }
begin
  cosh := (exp(x) + exp(-x)) / 2.0;
end;

function sinh(x: double): double;     { calculates sinh(x) }
begin
  sinh := (exp(x) - exp(-x)) / 2.0;
end;

procedure ccos(x, y: double; var x1, y1: double);
{ calculates z = cos(x + iy) where:
  x1 is double part of z
  y1 is imaginary part of z }
var
  expy,
  expyp: double;
begin
  expy := exp(y);
  expyp := 1 / expy;
  x1 := cos(x) * (expy + expyp) / 2.0;
  y1 := -sin(x)*(expy - expyp) / 2.0;
end;

procedure csin(x, y: double; var x1, y1: double);
{ calculates z = sin(x + iy) where:
  x1 is double part of z
  y1 is imaginary part of z }
var
  expy,
  expyp: double;
begin
  expy := exp(y);
  expyp := 1 / expy;
  x1 := sin(x) * (expy + expyp) / 2.0;
  y1 := cos(x) * (expy - expyp) / 2.0;
end;

procedure cexp(x, y : double; var x1, y1 : double);
{ calculates z = e^(x + iy) where
  x1 is double part of z
  y1 is imaginary part of z
}
var
  expx: double;
begin
  expx := exp(x);
  x1 := expx * cos(y);
  y1 := expx * sin(y)
end;

end.
