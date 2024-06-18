Unit SubTrees;
Interface
Uses Crt;

Type NodePtr = ^Node;
     Node = record
     Name: char;
     Key: byte;
     Left, Right: NodePtr;
 end;
 
procedure MakeSubTrees(Leaf:NodePtr);
Procedure Wait;
Procedure MakeTree(var Top: NodePtr);
Procedure WayUpDown(Top: NodePtr);
Procedure WayDownUp(Top: NodePtr);
Procedure WayHoriz(Top: NodePtr; Level: byte);
Function High(Top: NodePtr): byte;
Procedure ViewTree(Top: NodePtr);
Procedure SearchNode(Top: NodePtr; var Leaf: NodePtr);
Procedure AddSubTree(Top: NodePtr);
procedure MenuTtree;

Implementation

var 
  Key,Symbol:char;
  Flag:boolean;
  Top,Leaf:NodePtr;
  Level,Mode:byte;
  
procedure MakeSubTrees(Leaf:NodePtr);
var
  top:NodePtr;
begin
  GoToXY(30, 18); 
  writeln('Введите текущий узел:');
  GoToXY(40, 19); 
  readln(Leaf^.Name);
  GoToXY(30, 18); 
  writeln(' ');
  GoToXY(40, 19); 
  writeln(' ');
  GoToXY(25, 20); 
  writeln(Leaf^.Name, ' имеет левое поддерево?:у/т');
  GoToXY(40, 21); 
  readln(Key);
  GoToXY(25, 20); 
  writeln(' ');
  GoToXY(40, 21); 
  writeln(' ');
  if Key in ['y', 'Y', 'н', 'Н'] then
  begin
    new(Top); 
    Leaf^.Left := Top; 
    MakeSubTrees(Top)
  end
  else 
    Leaf^.Left := nil;
  GoToXY(25, 20); 
  writeln(Leaf^.Name, ' имеет правое поддерево?:у/т');
  GoToXY(40, 21); 
  readln(Key);
  GoToXY(25, 20); 
  writeln(' ');
  GoToXY(40, 21); 
  writeln(' ');
  if Key in ['y', 'Y', 'н', 'Н'] then
  begin
    new(Top); 
    Leaf^.Right := Top; 
    MakeSubTrees(Top)
  end
else Leaf^.Right := nil;
end;
 
Procedure Wait;
begin
  repeat until KeyPressed;
  while KeyPressed do ReadKey;
end;

Procedure MakeTree(var Top: NodePtr);
begin
  new(Top);
  MakeSubTrees(Top)
end;

Procedure WayUpDown(Top: NodePtr);
begin
  if Top <> nil then
  begin
    write(Top^.Name, ' ');
    WayUpDown(Top^.Left);
    WayUpDown(Top^.Right)
  end
end;

Procedure WayDownUp(Top: NodePtr);
begin
  if Top <> nil then
  begin
    WayDownUp(Top^.Left);
    WayDownUp(Top^.Right);
    write(Top^.Name, ' ')
  end;
end;

Procedure WayHoriz(Top: NodePtr; Level: byte);
begin
  if Top <> nil then
  if Level = 1 then write(Top^.Name, ' ')
  else
  begin
    WayHoriz(Top^.Left, Level - 1);
    WayHoriz(Top^.Right, Level - 1)
  end
end;

Function High(Top: NodePtr): byte;
var HighLeft, HighRight: byte;
begin
  if Top = nil then High := 0
  else
  begin
    HighLeft := High(Top^.Left);
    HighRight := High(Top^.Right);
    if HighLeft > HighRight then 
      High := HighLeft + 1
  else High := HighRight + 1
  end
end;

Procedure ViewTree(Top: NodePtr);
var i, HighTree: byte;
begin
  HighTree := High(Top);
  for i := 1 to HighTree do
  begin
    writeln; 
    WayHoriz(Top, i)
  end
end;

Procedure SearchNode(Top: NodePtr; var Leaf: NodePtr);
begin
  if (Top <> nil) and (Flag = True) then
  begin
    if Symbol = Top^.Name then
    begin
      Flag := False; 
      Leaf := Top
    end
    else
    begin
      SearchNode(Top^.Left, Leaf);
      SearchNode(Top^.Right, Leaf)
    end
  end
end;

//Procedure adds a subtree
Procedure AddSubTree(Top: NodePtr);
begin
  GoToXY(30, 18); 
  writeln('Введите узел для поиска');
  GoToXY(40, 19); 
  readln(Symbol);
  Flag := True; 
  SearchNode(Top, Leaf); 
  ClrScr;
  if Flag = True then
  begin
    write('Узел ', Symbol, ' не найден'); 
    Wait
  end
  else
  begin
    GoToXY(25, 20);
    writeln('Вы хотите добавить узел к ', Leaf^.Name, ' ? y/n');
    GoToXY(40, 21); 
    readln(Key);
    GoToXY(23, 20);
    writeln(' ');
    GoToXY(40, 21); 
    writeln(' ');
    if Key in ['y', 'Y', 'н', 'Н'] then
    begin
      MakeTree(Top); 
      if Leaf^.Left = nil then
        Leaf^.Left := Top
      else if Leaf^.Right = nil then
        Leaf^.Right := Top
      else
        writeln('Узел ', Leaf^.Name, ' уже имеет правое и левое поддерево');
    end;
  end;
end;


procedure MenuTtree;
var ok:boolean;
    Mode, Level:byte;
    Top: NodePtr;
begin
  Ok := True;
  while Ok do
  begin
    ClrScr;
    writeln('Выберите пункт меню:');
    writeln('1. Создать дерево');
    writeln('2. Сверху вниз');
    writeln('3. Снизу вверх');
    writeln('4. Горизонталь ');
    writeln('5. Высота');
    writeln('6. Посмотреть');
    writeln('7. Добавить поддерево');
    writeln('0. Выход');
    GoToXY(40, 23); readln(Mode);
    ClrScr;
    case Mode of
      1: 
         MakeTree(Top);
      2: begin 
           WayUpDown(Top); 
           Wait 
         end;
      3: begin 
           WayDownUp(Top); 
           Wait 
         end;
      4: begin
           GoToXY(30, 18); 
           writeln('Введите уровень');
           GoToXY(40, 19); 
           readln(Level); 
           ClrScr;
           WayHoriz(Top, Level); 
           Wait
         end;
      5: begin 
          writeln(High(Top):3); 
          Wait 
         end;
      6: begin 
          ViewTree(Top); 
          Wait 
         end;
      7: AddSubTree(Top);
      0: Ok := False
    else
    begin
      GoToXY(30, 23); writeln('Ошибка!');
      Wait
    end
    end
  end;
end;
end.
