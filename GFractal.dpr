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
//    Project file
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr / jvalavanis@gmail.com
//  Site  : https://sourceforge.net/projects/gfractal/
//------------------------------------------------------------------------------

program GFractal;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  complex in 'complex.pas',
  CustomJuliaSetFrm in 'CustomJuliaSetFrm.pas' {CustomJuliaSetForm},
  pngextra in 'pngextra.pas',
  pngimage in 'pngimage.pas',
  pnglang in 'pnglang.pas',
  gf_defs in 'gf_defs.pas',
  zlibpas in 'zlibpas.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'GFractal';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
