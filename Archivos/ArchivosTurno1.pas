program turno1;
const
valoralto = 9999;
cantDetalles = 10;
type
regM = record
  codLoc,codCepa,activos,nuevos,recup,falle:integer;
  nombreLoc,nombreCepa:string;
end;
regD = record
  codLoc,codCepa,activos,nuevos,recup,falle:integer;
end;
binM = file of regM;
binD = file of regD;
vectorDeDetalles = array [1..cantDetalles] of binD;
vectorDeRegistros = array [1..cantDetalles] of regD;
procedure leer (var archivo:binD; var reg:regD);
  begin
    if not eof(archivo) then
      read(archivo,reg)
    else
      reg.codLoc:=valoralto;
  end;
procedure minimo (var VD:vectorDeDetalles; var VR:vectorDeRegistros; var min:regD);
  var
    i,iMin:integer;
  begin
    min.codLoc:=valoralto;
    min.codCepa:=valoralto;
    for i:= 1 to cantDetalles do begin
      if VR[i].codLoc < min.codLoc & VR[i].codCepa < min.codCepa then begin
        min:=VR[i];
        iMin:=i;
      end;
    end;
    leer(VD[i],V[i]);
  end;
procedure procesar (var maestro:binM; var VD:vectorDeDetalles; VR:vectorDeRegistros);
  var
    regM:regM; min:regD; total:integer;
  begin
    total:=0;
    minimo(VD,VR,min);
    read(maestro,regM);
    while not eof(maestro) do begin
      if regM.codLoc = min.codLoc then begin
        while min.codLoc <> valoralto & regM.codLoc = min.codLoc do begin
          while min.codLoc <> valoralto & regM.codLoc = min.codLoc & regM.codCepa = min.codCepa do begin
            regM.falle:=regM.falle+min.falle;
            regM.recup:=regM.recup+min.recup;
            regM.activos:=min.activos;
            regM.nuevos:=min.nuevos;
            minimo(VD,VR,min);
          end;          
        end;
        seek(maestro,filepos(maestro)-1);
        write(maestro,regM);
      end;
      if regM.activos > 50 then
        total:=total+;
      read(maestro,regM);
    end;
    writeln('Localidades con mas de 50 activos: ',total);
  end;
var
  maestro:binM; VD:vectorDeDetalles; VR:vectorDeRegistros; i:integer;
begin
  assign(maestro,'maestro');
  reset(maestro);
  for i:= 1 to cantDetalles do begin
    assign(VD[i],'detalle' + IntToStr(i));
    reset(VD[i]);
    leer(VD[i],VR[i]);
  end;
  procesar(maestro,VD,VR);
  close(maestro);
  for i:= 1 to cantDetalles do
    close(VD[i]);
end.