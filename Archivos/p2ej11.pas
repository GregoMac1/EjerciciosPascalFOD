program p2ej11;
const
valoralto = 'ZZZZ';
type
regM = record
  nombre:string; personas,encuestados:integer;
end;
regD = record
  nombre:string; codLoc,personas,encuestados:integer;
end;
binM = file of regM;
binD = file of regD;
vectorDeDetalles = array [1..2] of binD;
vectorDeRegistros = array [1..2] of regD;
procedure leer (var archivo:binD; var reg:regD);
  begin
    if not eof(archivo) then
      read(archivo,reg)
    else
      reg.nombre:=valoralto;
  end;
procedure minimo (var VD:vectorDeDetalles; var VR:vectorDeRegistros; var min:regD);
  var
    i,iMin:integer;
  begin
    min.nombre:=valoralto;
    for i:= 1 to 2 do begin
      if VR[i].nombre < min.nombre then begin
        min.nombre:=VR[i].nombre;
        iMin:=i;
      end;
    end;
    if min.nombre <> valoralto then
      leer(VD[iMin],VR[iMin]);
  end;
procedure procesar (var maestro:binM; var VD:vectorDeDetalles; VR:vectorDeRegistros);
  var
    regMaestro:regM; min:regD; provActual:string;
  begin
    minimo(VD,VR,min);
    while min.nombre <> valoralto do begin
      provActual:=min.nombre;
      read(maestro,regMaestro);
      while regMaestro.nombre <> provActual do
        read(maestro,regMaestro);
      while min.nombre <> valoralto & provActual = min.nombre do begin
        regMaestro.personas:=regMaestro.personas+min.personas;
        regMaestro.encuestados:=regMaestro.encuestados+min.encuestados;
        minimo(VD,VR,min);
      end;
      seek(maestro,filepos(maestro)-1);
      write(maestro,regMaestro);
    end;
  end;
var
  maestro:binM; VD:vectorDeDetalles; VR:vectorDeRegistros; i:integer; iString:string;
begin
  assign(maestro,'maestrop2ej11.dat');
  reset(maestro);
  for i:= 1 to 2 do begin
    Str(i,iString);
    assign(VD[i],'detalle' + iString);
    leer(VD[i],VR[i]);
  end;
  procesar(maestro,VD,VR);
  close(maestro);
  for i:= 1 to 2 do
    close(VD[i]);
end.