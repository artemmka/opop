unit doublemenu;

interface

uses Crt;

type
  PtrVertic = ^StackVertic;
  StackVertic = record
    Number: integer;
    Name: string[30];
    Next, Prev: PtrVertic; 
  end;

  PtrHoriz = ^StackHoriz;
  StackHoriz = record
    Number: integer;
    Group: string[10];
    Head: PtrVertic;
    Next, Prev: PtrHoriz; 
  end;

var
  Horiz: PtrHoriz;

procedure MakeMenuVertic(var Vertic: PtrVertic);
procedure MakeMenuHoriz;
procedure PutMenuVertic(Vertic: PtrVertic; n: integer);
procedure ChoiceMenuHoriz;
procedure wait;
procedure LevelMenu;

implementation

procedure MakeMenuVertic(var Vertic: PtrVertic);
var
  Top: PtrVertic;
  Ok: boolean;
  NameValue: string[20];
  k: integer;
begin
  Ok := True;
  Vertic := nil;
  k := 0;
  while Ok do
  begin
    writeln('Введите фамилию');
    readln(NameValue);
    k := k + 1;
    if (NameValue = 'n') or (NameValue = 'т') then
    begin
      Ok := false;
    end
    else
    begin
      New(Top);
      Top^.Next := Vertic;
      Top^.Number := k;
      Top^.Name := NameValue;
      if Vertic <> nil then
      begin
        Vertic^.Prev := Top;
      end;
      Vertic := Top;
    end;
  end;
end;

procedure MakeMenuHoriz;
var
  Vertic: PtrVertic;
  Top: PtrHoriz;
  GroupValue: string[10];
  Ok: boolean;
  k: integer;
begin
  Ok := True;
  Horiz := nil;
  k := 0;
  while Ok do
  begin
    writeln('Введите номер группы');
    readln(GroupValue);
    k := k + 1;
    if (GroupValue = 'n') or (GroupValue = 'т') then
    begin
      Ok := false;
    end
    else
    begin
      New(Top);
      Top^.Next := Horiz;
      Top^.Number := k;
      Top^.Group := GroupValue;
      if Horiz <> nil then
      begin
        Horiz^.Prev := Top;
      end;
      MakeMenuVertic(Vertic);
      Top^.Head := Vertic;
      Horiz := Top;
    end;
  end;
end;


procedure PutMenuVertic(Vertic: PtrVertic; n: integer);
var
  Top, Current: PtrVertic;
  PosX, PosY: integer;
begin
  Top := Vertic;
  while Top^.Next <> nil do
  begin
    Top := Top^.Next;
  end;
  Current := Top;
  PosX := 12 * n + 2;
  PosY := 3;
  while Current <> nil do
  begin
    GotoXY(PosX, PosY);
    write(Current^.Name);
    PosY := PosY + 1;
    Current := Current^.Prev;
  end;
end;

procedure ChoiceMenuHoriz;
var
  Top, Current: PtrHoriz;
  n, k, i: integer;
begin
  Top := Horiz;
  k := 0;
  while Top <> nil do
  begin
    k := k + 1;
    Top := Top^.Next;
  end;
  Current := Horiz;
  n := 0;
  i := k;
  while Current <> nil do
  begin
    n := n + 1;
    GoToXY(12 * i - 7, 1);
    write(i:5, '.', Current^.Group:6);
    i := i - 1;
    Current := Current^.Next;
  end;
  Gotoxy(30, 22);
  writeln('Выберите пункт:');
  Gotoxy(39, 23);
  read(n);
  Top := Horiz;
  while (Top <> nil) and (Top^.Number <> n) do
  begin
    Top := Top^.Next;
  end;
  if Top <> nil then
  begin
    PutMenuVertic(Top^.Head, n);
  end;
end;


procedure wait;
begin
  repeat until KeyPressed;
  while KeyPressed do ReadKey
end;

procedure LevelMenu;
var
  Mode: integer; Ok: boolean;
begin
  Ok := true;
  while Ok do
  begin
    Clrscr;
    writeln('Выберите пункт:');
    writeln('1: Создать меню студентов');
    writeln('2: Просмотр меню');
    writeln('0: Выход');
    readln(Mode);
    Clrscr;
    case Mode of
      1:
        begin
          Clrscr;
          MakeMenuHoriz;
        end;
      
      2:
        begin
          Clrscr;
          ChoiceMenuHoriz;
          Wait;
        end;
      
      0: Ok := false;
    end
  end
end;

end.
