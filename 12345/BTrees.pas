unit BTrees;

interface

Uses Crt;

type
  NodePtr = ^Node;
  Node = record
    Key: byte;
    Left, Right: NodePtr;
  end;

var
  Top, Root: NodePtr; Level: byte;

procedure MakeNode(NewKey: byte; var Top: NodePtr);
procedure MakeBinTree(var Top: NodePtr);
procedure BinUpDown(Top: NodePtr);
procedure BinDownUp(Top: NodePtr);
function High(Top: NodePtr): byte;
procedure BinHoriz(Top: NodePtr; level: byte); 
procedure ViewBinTree(Top: NodePtr);
function SearchNode(Top: NodePtr; SearchKey: byte): NodePtr;
procedure DeleteSubTree(Top: NodePtr);
procedure BinTreesMenu;

implementation

procedure Wait;
begin
  repeat until Keypressed;
  while Keypressed do readKey;
end;


procedure MakeNode(NewKey: byte; var Top: NodePtr);
  begin
    if Top = nil then 
      begin
        New(Top); Top^.Key := NewKey;
        Top^.Left := nil; Top^.Right := nil;
      end
    else
      if NewKey < Top^.Key then
        MakeNode(NewKey, Top^.Left)
      else
        MakeNode(NewKey, Top^.Right);
  end;

procedure MakeBinTree(var Top: NodePtr);
  var
      i, n, InputKey: byte;
      Key: char;
  begin
    
      GoToXY(1, 2); write('Количество ветвей:'); readln(n); ClrScr; Top := nil;
      for i := 1 to n do
        begin
          GoToXY(1, 2); write('Значение (', i, '/', n, ') ветки: '); readln(InputKey); ClrScr;
          MakeNode(InputKey, Top);
        end
end;

procedure BinUpDown(Top: NodePtr);
  begin
    if Top <> nil then 
      begin
        write(Top^.Key:4);
        BinUpDown(Top^.Right);
        BinUpDown(Top^.Left);
      end
  end;

procedure BinDownUp(Top: NodePtr);
  begin
    if Top <> nil then 
      begin
        BinDownUp(Top^.Right);
        BinDownUp(Top^.Left);
        write(Top^.Key:4);
      end
  end;

function High(Top: NodePtr): byte;
var
  HighLeft, HighRight: byte;
  begin
    if Top = Nil then High := 0
    else 
      begin
        HighLeft := High(Top^.left);
        HighRight := High(Top^.Right);
        if HighLeft > HighRight then
          High := HighLeft + 1
        else
          High := HighRight + 1;
      end
  end;

procedure BinHoriz(Top: NodePtr; Level: byte);
  begin
    if Top <> Nil then
      if Level = 1 then write(Top^.Key)
      else 
        begin
          BinHoriz(Top^.Left, Level - 1);
          BinHoriz(Top^.Right, Level - 1);
        end
end;


procedure ViewBinTree(Top: NodePtr);
var i, HighTree: byte;
  begin
    HighTree := High(Top);
    for i := 1 to HighTree do
      begin
        writeln;
        BinHoriz(Top, i);
      end
end;

function SearchNode(Top: NodePtr; SearchKey: byte): NodePtr;
  begin
    if Top = Nil then 
      SearchNode := Nil
    else if Top^.Key = SearchKey then SearchNode := Top
    else if SearchKey < Top^.Key then
      SearchNode := SearchNode(Top^.Left, SearchKey)
    else SearchNode := SearchNode(Top^.Right, SearchKey);
end;

procedure DeleteSubTree(Top: NodePtr);
var Tmp: NodePtr; DeleteKey: byte;
  begin
    GoToXY(1, 2); write('Удаляемая ветка: '); readln(DeleteKey); ClrScr;
    Tmp := SearchNode(Top, DeleteKey);
    if Tmp <> nil then 
      begin
        Tmp^.Left := nil;
        Tmp^.Right := nil;
      end;
  end;
  
  

procedure BinTreesMenu;
  var
    Ok: boolean;
    Mode: integer;
begin
  Ok := True;
  while Ok do
  begin
    Clrscr;
    GoToXY(1, 2);writeln('Выберите пункт: ');
    GoToXY(1, 3);writeln('1: Создание дерева');
    GoToXY(1, 4);writeln('2: Просмотр дерева');
    GoToXY(1, 5);writeln('3: Обход сверху вниз');
    GoToXY(1, 6);writeln('4: Обход снизу вверх');
    GoToXY(1, 7);writeln('5: Просмотр вершин одного этажа');
    GoToXY(1, 8);writeln('6: Удаление поддерева');
    GoToXY(1, 9);writeln('0: Выход');
    GoToXY(1, 10); write('Выбор: ');readln(Mode);
    ClrScr;
    case Mode of
      1:begin
          Clrscr; 
          MakeBinTree(Top); 
          Wait
        end;
      2:begin
          Clrscr; 
          ViewBinTree(Top);
          Wait
        end;
      3:begin
          Clrscr;
          BinUpDown(Top);
          Wait
        end;
      4:begin
          Clrscr;
          BinDownUp(Top);
          Wait
        end;
      5:begin
          Clrscr; 
          GoToXY(1, 5);
          write('Введите этаж:');
          readln(Level);
          BinHoriz(Top, level);
          Wait
        end;
      6:begin
          Clrscr; 
          DeleteSubTree(Top); 
          Wait
        end;
      0: ok := False;
    else
      begin
        GoToXY(1, 21);
        writeln('Ошибка!Повторите Ввод');
        Wait
      end
    end
  end
end;

 
End.