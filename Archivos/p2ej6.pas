program p2ej6; //creo que bien, aunque el procesar se podria haber hecho mas simple, como en p2ej3
const
valoralto = 9999;
cantDetalles = 15;
type
regM = record
  codigo,talle,stockMin,stockDis:integer;
  nombre,descripcion,color:string;
  precio:real;
end;
regD = record
  codigo,cant:integer;
end;
binM = file of regM;
binD = file of regD;
vectorDeDetalles = array [1..cantDetalles] of binD;
vectorDeRegistros = array [1..cantDetalles] of regD;
procedure leer (var archivo:binD; var reg:regD);
  begin
    if (not eof(archivo)) then
      read(archivo,reg)
    else
      reg.codigo:=valoralto;
  end;
procedure minimo (var VD:vectorDeDetalles; var VR:vectorDeRegistros; var min:regD);
  var
    i,iMin:integer;
  begin
    min.codigo:=valoralto;
    for i:= 1 to cantDetalles do begin
      if (VR[i].codigo < min.codigo) then begin
        min.codigo:=VR[i].codigo;
        iMin:=i;
      end;
    end;
    if (min.codigo <> valoralto) then
      leer(VD[iMin],VR[iMin]);
  end;
procedure regATexto (var articulo:regM; var txt:text);
  begin
    write(txt,'Nombre: ');write(txt,articulo.nombre);write(txt,'\n');
    write(txt,'Descripcion: ');write(txt,articulo.descripcion);write(txt,'\n');
    write(txt,'Stockdis: ');write(txt,articulo.stockDis);write(txt,'\n');
    write(txt,'Precio: ');write(txt,articulo.precio);write(txt,'\n');
    write(txt,'\n');   
  end;
procedure procesar (var maestro:binM; var VD:vectorDeDetalles; VR:vectorDeRegistros; var txt:text);
  var
    articulo:regM; min:regD; i,codActual,cantTotal:integer;
  begin
    reset(maestro);
    rewrite(txt);
    for i:= 1 to cantDetalles do begin
      reset(VD[i]);
      leer(VD[i],VR[i]);
    end;
    minimo(VD,VR,min);
    while (min.codigo <> valoralto) do begin
      codActual:=min.codigo;
      cantTotal:=0;
      while (min.codigo <> valoralto) and (codActual = min.codigo) do begin
        cantTotal:=cantTotal+min.cant;
        minimo(VD,VR,min);
      end;
      read(maestro,articulo);
      while (articulo.codigo <> codActual) do
        read(maestro,articulo);
      articulo.stockDis:=articulo.stockDis-cantTotal;
      seek(maestro,filepos(maestro)-1);
      write(maestro,articulo);
      if (articulo.stockDis < articulo.stockMin) then 
        regATexto(articulo,txt);
    end;
    close(maestro);
    close(txt);
    for i:= 1 to cantDetalles do begin
      close(VD[i]);
    end;
  end;
var
  maestro:binM; VD:vectorDeDetalles; VR:vectorDeRegistros i:integer; txt:text; iString:string;
begin
  assign(maestro,'maestrop2ej6.dat');
  assign(txt,'txtp2ej6.txt');
  for i:= 1 to cantDetalles do begin
    str(i,iString);
    assign(VD[i],'detalle' + iString);
  end;
  procesar(maestro,VD,VR,txt);
end.