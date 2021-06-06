program p3ej3; //no lo probe pero creo que esta bien
const
valoralto = 9999;
type
regNovela=record
  codigo,duracion:integer; precio:real;
  genero,nombre,director:string;
end;
bin = file of regNovela;
procedure leerNovela (var novela:regNovela);
  begin
    with novela do begin
      writeln('Ingrese:');
      write('Codigo: ');readln(codigo);
      if (codigo<>-1) then begin
        write('Nombre: ');readln(nombre);
        //write('Genero: ');readln(genero);
        //write('Director: ');readln(director);
        //write('Duracion: ');readln(duracion);
        //write('Precio: ');readln(precio);
      end;
    end;writeln();
  end;
procedure crearArchivo (var archivo:bin);
  var
    novela:regNovela;
  begin
    rewrite(archivo);
    novela.codigo:=0; //cabecera
    write(archivo,novela);
    leerNovela(novela);
    while (novela.codigo<>-1) do begin
      write(archivo,novela);
      leerNovela(novela);
    end;
    close(archivo);
  end;
procedure agregarNovela (var archivo:bin); //primera vez que implemento este modulo, yo creo que esta bien
  var
    novela:regNovela; pos,posInicio:integer;
  begin    
    reset(archivo);
    read(archivo,novela);
    if (novela.codigo<=0) then begin
      pos:=novela.codigo*(-1);
      seek(archivo,pos);
      read(archivo,novela);
      posInicio:=novela.codigo;
      leerNovela(novela);
      seek(archivo,filepos(archivo)-1);
      write(archivo,novela);
      seek(archivo,0);
      novela.codigo:=posInicio;
      write(archivo,novela);
    end
    else begin
      seek(archivo,filesize(archivo)-1);
      leerNovela(novela);
      write(archivo,novela);
    end;    
    close(archivo);
  end;
procedure modificarNovela (var archivo:bin);
  var
    novela:regNovela; codigo:integer;
  begin
    write('Ingrese el codigo de la novela a modificar: ');readln(codigo);
    reset(archivo);
    read(archivo,novela);
    while (novela.codigo<>codigo) do 
      read(archivo,novela);
    novela.codigo:=codigo;
    writeln('Ingrese:');
    with novela do begin
      write('Nombre: ');readln(nombre);
      //write('Genero: ');readln(genero);
      //write('Director: ');readln(director);
      //write('Duracion: ');readln(duracion);
      //write('Precio: ');readln(precio);
    end;
    seek(archivo,filepos(archivo)-1);
    write(archivo,novela);
    close(archivo);
  end;
procedure eliminarNovela (var archivo:bin);
  var
    novela:regNovela; codigo,pos,posInicio:integer; //primera vez que implemento este modulo, yo creo que esta bien
  begin
    reset(archivo);
    write('Ingrese el codigo de la novela a eliminar: ');readln(codigo);
    read(archivo,novela);
    posInicio:=novela.codigo;
    while (novela.codigo<>codigo) do
      read(archivo,novela);
    pos:=(filepos(archivo)-1)*(-1);
    novela.codigo:=posInicio;
    seek(archivo,filepos(archivo)-1);
    write(archivo,novela);
    seek(archivo,0);
    novela.codigo:=pos;
    write(archivo,novela);
    close(archivo);
  end;
procedure regATexto (var novela:regNovela; var txt:text); 
  begin
    write(txt,'Codigo de novela: ');write(txt,novela.codigo);write(txt,'\n');
    write(txt,'Nombre: ');write(txt,novela.nombre);write(txt,'\n');
    //write(txt,'Director: ');write(txt,novela.director);write(txt,'\n');
    //write(txt,'Genero: ');write(txt,novela.genero);write(txt,'\n'); 
    //write(txt,'Precio: ');write(txt,novela.precio);write(txt,'\n');   
    //write(txt,'Duracion: ');write(txt,novela.duracion);write(txt,'\n');write(txt,'\n');   
  end;
procedure exportarTxt (var archivo:bin); 
  var
    novela:regNovela; txt:text;
  begin
    assign(txt,'p3ej3.txt');
    rewrite(txt);
    reset(archivo);
    while (not eof(archivo)) do begin
      read(archivo,novela);
      regATexto(novela,txt);
    end;
    close(txt);
    close(archivo);
  end;
procedure desplegarMenu (var archivo:bin);
  var
    opcion:integer;
  begin
    writeln('1. Crear el archivo.');
    writeln('2. Dar de alta una novela.');
    writeln('3. Modificar los datos de una novela.');
    writeln('4. Eliminar una novela.');
    writeln('5. Listar las novelas en .txt.');
    writeln('0. Salir.');writeln();
    write('Opcion: ');readln(opcion);writeln();
    if (opcion<>0) then begin
      case opcion of
        1: crearArchivo(archivo);
        2: agregarNovela(archivo);
        3: modificarNovela(archivo);
        4: eliminarNovela(archivo);
        5: exportarTxt(archivo);
        else
          writeln('Opcion incorrecta.');writeln();
      end;
      desplegarMenu(archivo);
    end;  
  end;
var
  archivo:bin;
begin
  assign(archivo,'p3ej3.dat');  
  desplegarMenu(archivo);
end.