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
//    Configure Julia Set Form
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr / jvalavanis@gmail.com
//  Site  : https://sourceforge.net/projects/gfractal/
//------------------------------------------------------------------------------

unit CustomJuliaSetFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TCustomJuliaSetForm = class(TForm)
    Bevel1: TBevel;
    Panel1: TPanel;
    Panel2: TPanel;
    OKBtn: TButton;
    Panel3: TPanel;
    Memo1: TMemo;
    Button1: TButton;
    Panel4: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetCustomJuliaSet(var xJulia, yJulia: double): boolean;

implementation

uses
  Unit1;

{$R *.DFM}

function GetCustomJuliaSet(var xJulia, yJulia: double): boolean;
var
  oldx, oldy: double;
begin
  Result := False;
  with TCustomJuliaSetForm.Create(nil) do
  try
    oldx := xJulia;
    oldy := yJulia;
    Edit1.Text := Format('%2.7f', [xJulia]);
    Edit2.Text := Format('%2.7f', [yJulia]);
    ShowModal;
    if ModalResult = mrOK then
    begin
      xJulia := StrToFloatDef(Edit1.Text, oldx);
      yJulia := StrToFloatDef(Edit2.Text, oldy);
      Result := True;
    end;
  finally
    Free;
  end;
end;

end.
