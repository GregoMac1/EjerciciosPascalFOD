program parcial2018; //creo que bien
const
valoralto = 9999;
type
regAcceso = record
  anio,mes,dia,id,tiempo:integer;
end;
bin = file of regAcceso;
procedure leer (var archivo:bin; var acceso:regAcceso);
  begin
    if (not eof(archivo)) then
      read(archivo,acceso)
    else
      acceso.anio:=valoralto;
  end;
procedure procesar (var archivo:bin; anio:integer);
  var
    acceso,actual:regAcceso; tiempoAnio,tiempoMes,tiempoDia:integer;
  begin
    tiempoAnio:=0;
    leer(archivo,acceso);
    while (acceso.anio <> valoralto) and (acceso.anio <> anio) do
      leer(archivo,acceso); //posiciono el puntero en el anio que necesito
    if (acceso.anio = anio) then begin
      seek(archivo,filepos(archivo)-1); //vuelvo una posicion para empezar ese año desde cero
      writeln('Anio: ',anio);
      while (acceso.anio <> valoralto) and (acceso.anio = anio) do begin
        actual.mes:=acceso.mes;
        tiempoMes:=0;
        writeln('Mes: ',actual.mes);
        while (acceso.anio <> valoralto) and (acceso.anio = anio) and (actual.mes = acceso.mes) do begin
          actual.dia:=acceso.dia;
          tiempoDia:=0;
          writeln('Dia: ',actual.dia);
          while (acceso.anio <> valoralto) and (acceso.anio = anio) and (actual.mes = acceso.mes) and (actual.dia = acceso.dia) do begin
            writeln('ID usuario: ',acceso.id,'. Tiempo: ',acceso.tiempo);
            tiempoDia:=tiempoDia+acceso.tiempo;
            leer(archivo,acceso);
          end;
          writeln('Tiempo total dia: ',tiempoDia;
          tiempoMes:=tiempoMes+tiempoDia;
        end;
        writeln('Tiempo total mes: ',tiempoMes);
        tiempoAnio:=tiempoAnio+tiempoMes;
      end;
      writeln('Tiempo total anio: ',tiempoAnio);
    end
    else
      writeln('Anio no encontrado.');
  end;
var
  archivo:bin; anio:integer;
begin
  assign(archivo,'parcial2018.dat');
  reset(archivo);
  write('Ingrese el anio: '); readln(anio);
  procesar(archivo,anio);
  close(archivo);
end.