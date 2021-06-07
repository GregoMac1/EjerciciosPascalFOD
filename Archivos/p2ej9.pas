program p2ej9;
const
valoralto = 9999;
type
reg = record
  codProv,codLoc,mesa,cantVotos:integer;
end;
bin = file of reg;
procedure leer (var archivo:bin; var mesa:reg);
  begin
    if not eof(archivo); then
      read(archivo,mesa)
    else
      mesa.codProv:=valoralto;
  end;
procedure procesar (var archivo:bin);
  var
    mesa,actual:reg; total,totalProv,totalLoc:integer;
  begin
    total:=0;
    leer(archivo,mesa);
    while mesa.codProv <> valoralto do begin
      actual.codProv:=mesa.codProv;
      writeln('Codigo de provincia: ',actual.codProv);
      totalProv:=0;
      while mesa.codProv <> valoralto & actual.codProv = mesa.codProv do begin
        actual.codLoc:=mesa.codLoc;
        writeln('Codigo de localidad: ',actual.codLoc);
        totalLoc:=0;
        while mesa.codProv <> valoralto & actual.codProv = mesa.codProv & actual.codLoc = mesa.codLoc do begin
          totalLoc:=totalLoc+mesa.cantVotos;
          leer(archivo,mesa);
        end;
        totalProv:=totalProv+totalLoc;
      end;
      writeln('Total votos: ',totalProv);
      total:=total+totalProv;
    end;
  end;
var
  archivo:bin;
begin
  assign(archivo,'p2ej9.dat');
  reset(archivo);
  procesar(archivo);
  close(archivo);
end.