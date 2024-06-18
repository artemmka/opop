uses Crt, Compl, CompMatr, VectR, VectC, Stack, QueueLib, doublemenu, SubTrees,MakeFiles,MakeTree,BTrees;
var Mode: integer;
    Ok: boolean;
    begin
      Ok:= true;
      while Ok do
        begin
          ClrScr;
          GoToXY(1, 1);writeln('Выбери пункт');
          GoToXY(1, 3);writeln('1: Комплексные числа');
          GoToXY(1, 5);writeln('2: Комплексные матрицы');
          GoToXY(1, 7);writeln('3: Вектора');
          GoToXY(1, 9);writeln('4: Комплексные вектора');
          GoToXY(1, 11);writeln('5: Стэки');
          GoToXY(1, 13);writeln('6: Очереди');
          GoToXY(1, 15);writeln('7: двойноеМеню');
          GoToXY(1, 17);writeln('8: Файлы');
          GoToXY(1, 19);writeln('9: Деревья');
          GoToXY(1, 21);writeln('10: Бинарные деревья');
          GoToXY(1, 24);writeln('0 Выход');
          GoToXY(2, 28); readln(Mode);
          ClrScr;
            Case Mode of
              1: MenuComplex;
              2: MenuComplexMatrix;
              3: MenuVectR;
              4: MenuVectC;
              5: MenuStack;
              6: MenuQueue;
              7: LevelMenu;
              8: StudentsMenu;
              9: MenuTree;
              10: BinTreesMenu;
              0: Ok:= false
              else
                begin
                  GoToXY(30, 24);
                  writeln('Ошибка! Повторите ввод!');
                  delay(1000);
                end;
            end;
        end;
    end.