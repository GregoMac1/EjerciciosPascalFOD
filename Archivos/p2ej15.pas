program p2ej15; //en el minimo, no alcanza con solo comparar el dni
const
valoralto = 9999;
cantDetalles = 10; //la consigna no aclara
type
regAlumno = record
  dni,codCarrera:integer; montoTotalPagado:real;
end;
regPago = record
  dni,codCarrera:integer; montoCuota:real;
end;
binM = file of regAlumno;
binD = file of regPago;
vectorDeDetalles = array [1..cantDetalles] of binD;
vectorDeRegistros = array [1..cantDetalles] of regPago;
procedure leer (var archivo:binD; var pago:regPago);
  begin
    if (not eof(archivo)) then
      read(archivo,pago)
    else
      pago.dni:=valoralto;
  end;
procedure minimo (var V:vectorDeDetalles; VR:vectorDeRegistros; var min:regPago);
  var
    i,iMin:integer;
  begin
    min.dni:=valoralto;
    for i:= 1 to cantDetalles do begin
      if (VR[i].dni < min.dni) then begin
        min.dni:=VR[i].dni;
        iMin:=i;
      end;
    end;
    leer(V[iMin],VR[iMin]);
  end;
procedure incisoA (var maestro:binM; var V:vectorDeDetalles; VR:vectorDeRegistros);
  var
    alumno,actual:regAlumno; min:regPago; i:integer;
  begin
    reset(maestro);
    for i:= 1 to cantDetalles do begin
      reset(V[i]);
    end;
    minimo(V,VR,min);
    while (min.dni <> valoralto) do begin
      actual.dni:=min.dni;
      while (min.dni <> valoralto) and (actual.dni = min.dni) do begin
        actual.codCarrera:=min.codCarrera;
        read(maestro,alumno);
        while (alumno.dni <> min.dni) and (alumno.codCarrera <> min.codCarrera) do
          read(maestro,alumno);
        while (min.dni <> valoralto) and (actual.dni = min.dni) and (actual.codCarrera = min.codCarrera) do begin
          alumno.montoTotalPagado:=alumno.montoTotalPagado + min.montoCuota;
          minimo(V,VR,min);
        end;
        seek(maestro,filepos(maestro)-1);
        write(maestro,alumno);
      end;
    end;
    close(maestro);
    for i:= 1 to cantDetalles do begin
      close(V[i]);
    end;
  end;
procedure regATexto (var alumno:regAlumno; var txt:text);
  begin
    write(txt,'Dni: ');write(txt,alumno.DNI);write(txt,'. ');
    write(txt,'Codcarrera: ');write(txt,alumno.codCarrera);write(txt,'. ');
    write(txt,'Alumno moroso.');write(txt,'\n');
  end;
procedure incisoB (var maestro:binM; var txt:text);
  var
    alumno:regAlumno; i:integer;
  begin
    reset(maestro);
    rewrite(txt);
    read(maestro,alumno);
    while (not eof(maestro)) do begin
      if (alumno.montoTotalPagado = 0) then
        regATexto(alumno,txt);
      read(maestro,alumno);
    end;
    close(maestro);
    close(txt);
  end;
var
  maestro:binM; V:vectorDeDetalles; VR:vectorDeRegistros; txt:text; i:integer; iString:string;
begin
  assign(maestro,'maestrop2ej15.dat');
  assign(txt,'txtp2ej25.txt');
  for i:= 1 to cantDetalles do begin
    Str(i,iString);
    assign(V[i],'detalle' + iString);
    leer(V[i],VR[i]);
  end;
  incisoA(maestro,V,VR);
  incisoB(maestro,txt);
end.