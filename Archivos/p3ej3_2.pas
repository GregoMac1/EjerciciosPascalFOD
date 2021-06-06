//solo la parte de bajas
program p3ej3_2; //creo que esta bien. esta mejor que la primera version de p3ej3
const
valoralto = 9999;
type
regNovela = record
  codigo:integer;
  genero,nombre,director:string;
  duracion,precio:real;
end;
bin = file of regNovela;
procedure realizarBaja (var archivo:bin; codigo:integer);
  var
    novela,cabecera:regNovela;
  begin
    read(archivo,novela);
    cabecera:=novela;
    while (not eof(archivo)) and (novela.codigo <> codigo) do
      read(archivo,novela);
    if (novela.codigo = codigo) then begin
      novela:=cabecera;
      seek(archivo,filepos(archivo)-1);
      write(archivo,novela);
      cabecera.codigo:=filepos(archivo) * -1;
      seek(archivo,0);
      write(archivo,cabecera);
    end;
  end;
procedure agregar (var archivo:bin; novela:regNovela);
  var
    cabecera,actual:regNovela;
  begin
    read(archivo,cabecera);
    if (cabecera.codigo = 0) then begin //no hay espacio libre
      seek(archivo,filesize(archivo)-1);
      write(archivo,novela);
    end
    else begin
      seek(archivo,cabecera.codigo * -1); //voy a la posicion libre
      read(archivo,actual);
      cabecera:=actual; //me guardo el siguiente enlace
      seek(archivo,filepos(archivo)-1);
      write(archivo,novela); //escribo el registro nuevo
      seek(archivo,0);
      write(archivo,cabecera); //actualizo la cabecera
    end;
  end;
var
  codigo:integer; archivo:bin; novela:regNovela;
begin
  assign(archivo,'p3ej2_2.dat');
  rewrite(archivo);
  write('Ingrese el codigo: ');readln(codigo);
  realizarBaja(archivo,codigo)
  leerNovela(novela); //se dispone
  agregar(archivo,novela);
  close(archivo);
end.