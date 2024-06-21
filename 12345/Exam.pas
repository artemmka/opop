Unit Exam;

Interface

Uses Crt, Compl;
const eps=0.001;n=10;
procedure Task1;
procedure Task2;
procedure Wait;
procedure ExamMenu;

Implementation
procedure Task1;
  var z,z2,v,w,sum,l,s,p:Complex;
   eps:real;
   k: integer;
  begin
    Input(z);
    ClrScr;
    if Modul(z) < (1/2) then
    begin
     repeat
      writeln('Модуль Z меньше 1/2, введите повторно!');
      Input(z);
      ClrScr
     until Modul(z) > (1/2);
    end;
    k:=2;
    Inv(z,z2);
    Zero(s);
    One(p);
    One(w);
    Zero(v);
    Prod(3, z, p);
    Prod(3, z, s);
    Prod((1/2), z2, w);
    Prod((1/2), z2, v);
    Add(p, w, l);
      
      while Modul(l) > eps
        do begin
          Prod(3/(k-1), p, p); 
          Prod(k/(2*(k-1)), w, w); 
          Mult(p, z, p);
          Mult(w, z2, w); 
          Add(p, w, l); 
          Add(p, s, s); 
          Add(w, v, v);
          k:= k + 1;
        end;
    Add(s,v, sum); 
    Output(sum);
    writeln();
  end;

procedure Task2;
  var i,j: integer;
      a: array[1..n,1..n] of integer;
  begin
    for i:= 1 to n do begin
        for j:= 1 to n do begin
            a[i,j]:= 0;
        end;
    end;
    for i:= 1 to n do begin
        for j:= 1 to n do begin
          if((i mod 2) <> 0) then begin
              a[i,j]:= j;
              GoToXY(10+4*j, 3+i*2); write(a[i,j]);
            end
          else begin
              a[i,j]:= i;
              GoToXY(10+4*j, 3+i*2); write(a[i,j]);
            end;
        end;
    end;
 end;
 
procedure Task3;
var z,z2,v,w,s,p:Complex;
   eps:real;
   k: integer;
  begin
    Input(z);
    ClrScr;
    if Modul(z) < (1/2) then
    begin
     repeat
      writeln('Модуль Z меньше 1/2, введите повторно!');
      Input(z);
      ClrScr
     until Modul(z) > (1/2);
    end;
    k:=2;
    Inv(z,z2);
    Zero(s);
    One(p);
    One(w);
    Zero(v);
    Prod(3, z, p);
    Prod(3, z, s);
    Prod((1/2), z2, w);
    Prod((1/2), z2, v);
      while Modul(p) > eps
        do begin
          Prod(3/(k-1), p, p);  
          Mult(p, z, p);
          Add(p, s, s); 
          k:= k + 1;
        end;
     k:=2;
     while Modul(w) > eps
     do begin
          Prod(k/(2*(k-1)), w, w);
          Mult(w, z2, w);
          Add(w,v,v);
          k:=k+1;
     end;
    GoToXY(45, 3);Output(s);
    GoToXY(45, 5);Output(v);
    writeln();
  end;

procedure Wait;
  begin
    repeat until KeyPressed;
      while KeyPressed do ReadKey
  end;
  
procedure ExamMenu;
var Mode: integer;
    Ok: boolean;
    begin
      Ok:= true;
      while Ok do
        begin
          ClrScr;
          GoToXY(45, 3);writeln('1: Cумма');
          GoToXY(45, 5);writeln('2: Матрица');
          GoToXY(45, 7);writeln('3: Суммы');
          GoToXY(45, 25);writeln('0 Выход');
          GoToXY(40, 27); readln(Mode);
          ClrScr;
            Case Mode of
              1: 
                begin
                  GoToXY(40, 1);writeln('Задача 1');
                  Task1;
                  Wait;
                end;
              2: 
                begin
                  GoToXY(40, 1); writeln('Задача 2');
                  Task2;
                  Wait;
                end;
              3:
                begin
                  GoToXY(40, 1); writeln('Задача 1.2');
                  Task3;
                  Wait;
                end;
              0: Ok:= false
              else
                begin
                  GoToXY(30, 24);
                  writeln('Ошибка! Повторите ввод!');
                  delay(1000);
                end;
            end;
        end;
    end;
end.