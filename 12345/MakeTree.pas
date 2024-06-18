unit MakeTree;

interface

uses Crt;

const
  g = 11;

type
  Node = record
    ch: char;
    left, right: byte;
  end;

procedure MenuTree;
procedure Wait;
procedure CreateTree(var Tree: array of Node; var Root: byte; var n: byte);
procedure WayUpDown(Next: byte);
procedure WayDownUp(Next: byte);
procedure WayHoriz(Next, Level: byte);

implementation

var
  Tree: array of Node;
  Root, n: byte;

procedure Wait;
begin
  repeat until KeyPressed;
  while KeyPressed do ReadKey;
end;

procedure CreateTree(var Tree: array of Node; var Root: byte; var n: byte);
var
  i: byte;
  ch: char;
  left, right: byte;
begin
  writeln('Введите количество узлов в дереве: ');
  readln(n);
  setlength(Tree, n + 1);
  for i := 1 to n do
  begin
    writeln('Введите символ для узла ', i, ': ');
    readln(ch);
    Tree[i].ch := ch;
    writeln('Введите индексы левого и правого потомков для узла ', i, ' (0 если потомок отсутствует): ');
    readln(left, right);
    Tree[i].left := left;
    Tree[i].right := right;
  end;
  writeln('Введите индекс корневого узла: ');
  readln(Root);
end;


procedure WayUpDown(Next: byte);
begin
  if Next <> 0 then
    with Tree[Next] do
    begin
      write(ch, ' ');
      WayUpDown(left);
      WayUpDown(right);
    end;
end;

procedure WayDownUp(Next: byte);
begin
  if Next <> 0 then
    with Tree[Next] do
    begin
      WayDownUp(left);
      WayDownUp(right);
      write(ch, ' ');
    end;
end;

procedure WayHoriz(Next, Level: byte);
begin
  if Next <> 0 then
    with Tree[Next] do
      if Level = 1 then write(ch, ' ')
      else
      begin
        WayHoriz(left, Level - 1);
        WayHoriz(right, Level - 1);
      end;
end;

procedure MenuTree;
var
  Level: byte;
  choice: Integer;
  Ok := True;
begin
  while Ok do
  begin
    ClrScr;
    writeln('Выберите пункт меню:');
    writeln('1. Создать дерево');
    writeln('2. Обход сверху вниз');
    writeln('3. Обход снизу вверх');
    writeln('4. Вывод горизонтали');
    writeln('0. Выйти');
    GoToXY(40, 23); readln(choice);
    ClrScr;
    case choice of
      1:
        begin
          CreateTree(Tree, Root, n);
          Wait;
          ClrScr;
        end;
      2:
        begin
          WayUpDown(Root);
          Wait;
          ClrScr;
        end;
      3:
        begin
          WayDownUp(Root);
          Wait;
          ClrScr;
        end;
      4:
        begin
          writeln('Введите уровень:');
          readln(Level);
          WayHoriz(Root, Level);
          Wait;
          ClrScr;
        end;
      0: Ok := False
    else
      begin
        GoToXY(30, 23); writeln('Ошибка!');
        Wait
      end
    end
  end
end;
end.