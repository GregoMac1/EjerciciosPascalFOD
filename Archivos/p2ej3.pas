program p2ej3; //bien
const
valoralto = 9999;
cantDetalles = 30;
type
regProducto=record
  codigo,stockMin,stockDis:integer; precio:real;
  nombre,descripcion:string;
end;
regDetalle=record
  codigo,cantVendida:integer;
end;
bin = file of regProducto;
binDetalle = file of regDetalle;
vectorDeDetalles = array [1..cantDetalles] of binDetalle;
vectorDeRegistros = array [1..cantDetalles] of regDetalle;
procedure leer (var detalle:binDetalle; var producto:regDetalle);
  begin
    if (not eof(detalle)) then
      read(detalle,producto)
    else
      producto.codigo:=valoralto;
  end;
procedure minimo (var VD:vectorDeDetalles; var VR:vectorDeRegistros; var min:regDetalle);
  var
    i,iMin:integer;
  begin
    min.codigo:=9999;
    for i:= 1 to cantDetalles do begin
      if (VR[i].codigo <> valoralto) & (VR[i].codigo < min.codigo) then begin
        min:=VR[i];
        iMin:=i;
      end;
    end;
    if (min.codigo <> 9999) then
      leer(VD[iMin],VR[iMin]);
  end;
procedure actualizarMaestro (var maestro:bin; var VD:vectorDeDetalles; var VR:vectorDeRegistros);
  var
    i:integer; regM:regProducto; min:regDetalle;
  begin
    for i:= 1 to cantDetalles do begin
      reset(VD[i]);
      Leer(VD[i],VR[i]);
    end;
    reset(maestro);
    minimo(VD,VR,min);
    while (min.codigo<>valoralto) do begin
      read(maestro,regM);
      while (regM.codigo<>min.codigo) do
        read(maestro,regM);
      while (min.codigo<>valoralto) and (regM.codigo=min.codigo) do begin
        regM.stockDis:=regM.stockDis - min.cantVendida;
        minimo(VD,VR,min);
      end;
      seek(maestro,filepos(maestro)-1);
      write(maestro,regM);
    end;
    for i:= 1 to cantDetalles do begin
      close(VD[i]);
    end;
    close(maestro);
  end;
var
  maestro:bin; VD:vectorDeDetalles; VR:vectorDeRegistros; i:integer;
begin
  for i:=1 to cantDetalles do begin
    Str(i,iString);
    assign(V[i],'detalle' + iString);    
  end;
  assign(maestro,'maestrop2ej3.dat');
  actualizarMaestro(maestro,VD,VR);
end.