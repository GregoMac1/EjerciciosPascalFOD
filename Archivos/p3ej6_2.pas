program p3ej6_2; //creo que bien aunque el enunciado pedia pasar todo a otro archivo directamente
const
valoralto = 9999;
type
regPrenda = record
  codigo,stock:integer; precio:real;
  descripcion,colores,tipoPrenda:string;
end;
bin = file of regPrenda;
binDetalle = file of integer;
procedure leer (var archivo:binDetalle; var codigo:integer);
  begin
    if (not eof(archivo)) then
      read(archivo,codigo)
    else
      codigo:=valoralto;
  end;
procedure bajasLogicas (var maestro:bin; var detalle:binDetalle);
  var
    prenda:regPrenda; codigoD:integer;
  begin
    reset(maestro);
    reset(detalle);
    leer(detalle,codigoD);
    while (codigoD <> valoralto) do begin
      seek(maestro,0);
      read(maestro,prenda);
      while (prenda.codigo <> codigoD) do //se asume que existe en el maestro
        read(maestro,prenda);
      prenda.stock:=-1;
      seek(maestro,filepos(maestro)-1);
      write(maestro,prenda);
      seek(maestro,0);
      leer(detalle,codigoD);
    end;
    close(maestro);
    close(detalle);
  end;
procedure compactar (var maestro:bin);
  var
    prenda,aux:regPrenda; posActual:integer; //aux no es necesaria. se podria hacer todo con 'prenda'
  begin
    reset(maestro);
    leer(maestro,prenda);
    while (prenda.codigo <> valoralto) do begin
      if (prenda.stock < 0) then begin
        posActual:=filepos(maestro)-1;
        seek(maestro,filesize(maestro));
        read(maestro,aux);
        seek(maestro,filesize(maestro)-1);
        truncate(maestro);
        seek(maestro,posActual);
        write(maestro,aux);
      end;
      leer(maestro,prenda);
    end;
    close(maestro);
  end;
var
  maestro:bin; detalle:binDetalle;
begin
  assign(maestro,'maestrop3ej2_2.dat');
  assign(detalle,'detallep3ej2_2.dat');
  bajasLogicas(maestro,detalle);
  compactar(maestro);
end.