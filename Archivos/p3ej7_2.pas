program p3ej7_2;
const
valoralto = 9999;
type
regEspecie = record
  codigo:integer;
  nombre,familia,descripcion,zona:string;
end;
bin = file of regEspecie;
procedure bajaLogica (var archivo:bin; codigo:integer);
  var
    especie:regEspecie;
  begin
    read(archivo,especie);
    while (especie.codigo <> codigo) do
      read(archivo,especie);
    especie.nombre:='***';
    seek(archivo,filepos(archivo)-1);
    write(archivo,especie);
  end;
procedure leer (var archivo:bin; var especie:regEspecie);
  begin
    if (not eof(archivo)) then
      read(archivo,especie)
    else
      especie.codigo:=valoralto;
  end;
procedure compactar (var archivo:bin);
  var
    especie:regEspecie; posActual,cantPosiciones:integer;
  begin
    leer(archivo,especie);
    while (especie.codigo <> valoralto) do begin
      if (especie.nombre = '***') then begin
        posActual:=filepos(archivo)-1;
        cantPosiciones:=1;
        seek(archivo,filesize(archivo)-cantPosiciones);
        read(archivo,especie);
        while (especie.nombre = '***') do begin
          cantPosiciones:=cantPosiciones+1;
          seek(archivo,filesize(archivo)-cantPosiciones);
          read(archivo,especie);
        end;
        truncate(filesize(archivo)-cantPosiciones);
        seek(archivo,posActual);
        write(archivo,especie);
      end;
      leer(archivo,especie);
    end;
  end;
var
  archivo:bin; codigo:integer;
begin
  assign(archivo,'maestrop3ej7_2.dat');
  reset(archivo);
  write('Ingrese el codigo: ');readln(codigo);
  while (codigo <> 500000) do begin
    bajaLogica();
    write('Ingrese el codigo: ');readln(codigo);
  end;
  compactar();
  close(archivo);
end.