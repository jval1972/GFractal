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
//    Save/Load configuration file
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr / jvalavanis@gmail.com
//  Site  : https://sourceforge.net/projects/gfractal/
//------------------------------------------------------------------------------

unit gf_defs;

interface

uses
  Graphics;

function gf_LoadSettingsFromFile(const fn: string): boolean;

procedure gf_SaveSettingsToFile(const fn: string);

var
  opt_width: integer = 640;
  opt_height: integer = 480;
  opt_xjulia: double = -0.39054;
  opt_yjulia: double = -0.58679;
  opt_toolbar: boolean = True;
  opt_statusbar: boolean = True;

implementation

uses
  SysUtils, Classes;

const
  NUMSETTINGS = 8;

type
  TSettingsType = (tstDevider, tstInteger, tstFloat, tstColor, tstBoolean, tstString);

  TSettingItem = record
    desc: string;
    typeof: TSettingsType;
    location: pointer;
  end;

var
  Settings: array[0..NUMSETTINGS - 1] of TSettingItem = (
    (
      desc: '[GFRACTAL]';
      typeof: tstDevider;
      location: nil;
    ),
    (
      desc: 'WIDTH';
      typeof: tstInteger;
      location: @opt_width;
    ),
    (
      desc: 'HEIGHT';
      typeof: tstInteger;
      location: @opt_height;
    ),
    (
      desc: 'XJULIA';
      typeof: tstFloat;
      location: @opt_xjulia;
    ),
    (
      desc: 'YJULIA';
      typeof: tstFloat;
      location: @opt_yjulia;
    ),
    (
      desc: '[VIEW]';
      typeof: tstDevider;
      location: nil;
    ),
    (
      desc: 'TOOLBAR';
      typeof: tstBoolean;
      location: @opt_toolbar;
    ),
    (
      desc: 'STATUSBAR';
      typeof: tstBoolean;
      location: @opt_statusbar;
    )
  );


procedure splitstring(const inp: string; var out1, out2: string; const splitter: string = ' ');
var
  p: integer;
begin
  p := Pos(splitter, inp);
  if p = 0 then
  begin
    out1 := inp;
    out2 := '';
  end
  else
  begin
    out1 := Trim(Copy(inp, 1, p - 1));
    out2 := Trim(Copy(inp, p + 1, Length(inp) - p));
  end;
end;

function IntToBool(const x: integer): boolean;
begin
  Result := x <> 0;
end;

function BoolToInt(const b: boolean): integer;
begin
  if b then
    Result := 1
  else
    Result := 0;
end;

procedure gf_SaveSettingsToFile(const fn: string);
var
  s: TStringList;
  i: integer;
begin
  s := TStringList.Create;
  try
    for i := 0 to NUMSETTINGS - 1 do
    begin
      if Settings[i].typeof = tstInteger then
        s.Add(Format('%s=%d', [Settings[i].desc, PInteger(Settings[i].location)^]))
      else if Settings[i].typeof = tstFloat then
        s.Add(Format('%s=%2.7f', [Settings[i].desc, PDouble(Settings[i].location)^]))
      else if Settings[i].typeof = tstColor then
        s.Add(Format('%s=%d', [Settings[i].desc, PLongWord(Settings[i].location)^]))
      else if Settings[i].typeof = tstBoolean then
        s.Add(Format('%s=%d', [Settings[i].desc, BoolToInt(PBoolean(Settings[i].location)^)]))
      else if Settings[i].typeof = tstString then
        s.Add(Format('%s=%s', [Settings[i].desc, PString(Settings[i].location)^]))
      else if Settings[i].typeof = tstDevider then
      begin
        if s.Count > 0 then
          s.Add('');
        s.Add(Settings[i].desc);
      end;
    end;
    s.SaveToFile(fn);
  finally
    s.Free;
  end;
end;

function gf_LoadSettingsFromFile(const fn: string): boolean;
var
  s: TStringList;
  i, j: integer;
  s1, s2: string;
  itmp: integer;
  dtmp: double;
  itmp64: int64;
begin
  if not FileExists(fn) then
  begin
    result := false;
    exit;
  end;
  result := true;

  s := TStringList.Create;
  try
    s.LoadFromFile(fn);
    begin
      for i := 0 to s.Count - 1 do
      begin
        splitstring(s.Strings[i], s1, s2, '=');
        if s2 <> '' then
        begin
          s1 := UpperCase(s1);
          for j := 0 to NUMSETTINGS - 1 do
            if UpperCase(Settings[j].desc) = s1 then
            begin
              if Settings[j].typeof = tstInteger then
              begin
                itmp := StrToIntDef(s2, PInteger(Settings[j].location)^);
                PInteger(Settings[j].location)^ := itmp;
              end
              else if Settings[j].typeof = tstFloat then
              begin
                dtmp := StrToFloatDef(s2, PDouble(Settings[j].location)^);
                PDouble(Settings[j].location)^ := dtmp;
              end
              else if Settings[j].typeof = tstColor then
              begin
                itmp64 := StrToInt64Def(s2, PLongWord(Settings[j].location)^);
                PLongWord(Settings[j].location)^ := itmp64;
              end
              else if Settings[j].typeof = tstBoolean then
              begin
                itmp := StrToIntDef(s2, BoolToInt(PBoolean(Settings[j].location)^));
                PBoolean(Settings[j].location)^ := IntToBool(itmp);
              end
              else if Settings[j].typeof = tstString then
              begin
                PString(Settings[j].location)^ := s2;
              end;
            end;
        end;
      end;
    end;
  finally
    s.Free;
  end;

end;

end.

