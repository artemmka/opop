Unit Stack;

  Interface
uses crt;
Type Ptr=^Stac;
  Stac = record 
    Inf: integer;
    Next: Ptr;
  end;
var top, Kon2, Top1, Top2, kon: Ptr;
    value: integer;
    
procedure MakeStack(var top: Ptr);
procedure ViewStack(var top:Ptr);
procedure AddStack(var top:Ptr);
procedure DeleteStack(var top:Ptr);
procedure DeleteFirstElement(var top:Ptr);
procedure ReverseStack(var top:Ptr);
procedure SumStack(var Top1, Top2: Ptr);
procedure wait;
procedure MenuStack;

  Implementation

procedure MakeStack(var top: Ptr);
  var ok: boolean;
  begin
    ok:= True;
    top:= Nil;
    while ok do
    begin
      writeln('Введите число: '); 
      readln(value);
      if value = 999 then ok:= False
      else
      begin
        New(kon);
        kon^.Next:= top;
        kon^.Inf:= Value;
        top:= kon;
      end;
    end;
  end;
  
procedure ViewStack(var top: Ptr);
  begin
    kon:= top;
    while kon <> Nil do
    begin
      GoToXY(40, 40);
      writeln(kon^.Inf: 4);
      kon:= kon^.Next
    end;
  end;
  
procedure AddStack(var top: Ptr);
  Var Ok: boolean;
  begin
    Ok:= True;
    while Ok do
    begin
      writeln('Добавьте число: ');
      readln(Value);
      if Value = 999 then Ok:= False
      else
      begin
        New(kon);
        kon^.Next:= top;
        kon^.Inf:= Value;
        top:= Kon;
      end;
    end;
  end;
  
procedure DeleteStack(var top: Ptr);
  var temp: Ptr;
  begin
    while top <> nil do
    begin
      temp := top;
      top := top^.Next;
      Dispose(temp);
    end;
  end;
  
procedure DeleteFirstElement(var top: Ptr);
  var сurrent, prev: Ptr;
  begin
    сurrent := top;
    prev := nil;
    while сurrent^.Next <> nil do
    begin
      prev := сurrent;
      сurrent := сurrent^.Next;
    end;
  // если стек состоит только из одного элемента
    if prev = nil then
      top := nil
    else
      prev^.Next := nil;
    Dispose(сurrent);
  end;
  
procedure ReverseStack(var top: Ptr);
  var reversedSctack, temp: Ptr;
  begin
    reversedSctack := nil;
    while top <> nil do
    begin
      temp := top;
      top := top^.Next;
      temp^.Next := reversedSctack;
      reversedSctack := temp;
    end;
    top := reversedSctack;
  end;
  
procedure SumStack(var Top1, Top2: Ptr);
begin
  Kon2 := Top2;
  while Kon2^.Next <> nil do
    Kon2 := Kon2^.Next;
  Kon2^.Next := Top1;
  Top1 := Top2;
end;
  
procedure wait;
  begin
    repeat until KeyPressed;
    while KeyPressed do ReadKey;
  end;

procedure MenuStack;
   var Ok: boolean; 
       Mode: integer;
   begin
     Ok:= true; 
     while Ok = true do
       begin
        ClrScr;
        writeln('Выберите пункт:');
        writeln('1: Создание стэка');
        writeln('2: Просмотр стэка');
        writeln('3: Добавление чисел в стэк');
        writeln('4: Удаление стэка');
        writeln('5: Удаление первого элемента стэка');
        writeln('6: Перевернуть стэк');
        writeln('7: Сложение двух стэков');
        writeln('999: Прервать действие');
        writeln('0: Назад.');
          
         GoToXY(40, 23); read(Mode);
         GoToXY(40, 23); ClearLine;
         
         case Mode of
     1: begin
          ClrScr;
          writeln('Создание стэка');
          MakeStack(Top1);
        end;
     2: begin
          ClrScr;
          writeln('Ваш стэк: ');
          ViewStack(Top1);
          wait;
        end;
     3: begin
          ClrScr;
          writeln('Добавить еще число: ');
          AddStack(Top1);
        end;
     4: begin
          ClrScr;
          writeln('Стэк удалён!');
          DeleteStack(Top1);
          wait;
        end;
     5: begin
          ClrScr;
          writeln('Первый элемент стэка удалён!');
          DeleteFirstElement(Top1);
          wait; 
        end;
     6: begin
          ClrScr;
          writeln('Стэк был перевернут!');
          ReverseStack(Top1);
          wait; 
        end;
     7: begin
          ClrScr;
          writeln('Введите второй стэк');
          MakeStack(Top2); 
          SumStack(Top1,Top2);
          DeleteStack(Top2);
          ClrScr;
          writeln('Стэки были сложены!');
          wait;
        end;
     0: begin
        ClrScr;
        ok:= False;
        end;
        
        else   
        begin
          GoToXY(30, 24);
          writeln('Ошибка! Повторите ввод:');
        end;
      end;
    end;
  end;
end.
