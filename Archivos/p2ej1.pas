program p2ej1; //falta probarlo pero creo que bien
const
valoralto = 9999;
type
regIngreso=record
  codigo:integer; nombre:string; monto:real;
end;
bin = file of regIngreso;
procedure leer (var ingreso:regIngreso);
  begin
    with ingreso do begin
      write('Ingrese el codigo de empleado: ');readln(codigo);
      if (codigo<>000) then begin
        write('Ingrese el nombre: ');readln(nombre);
        write('Ingrese el monto: ');readln(monto);
      end;
    end;writeln();
  end;
procedure cargarArchivo (var archivo:bin);
  var
    ingreso:regIngreso;
  begin
    reset(archivo);
    leer(ingreso);
    while (ingreso.codigo <> 000) do begin
      write(archivo,ingreso);
      leer(ingreso);
    end;
    close(archivo);
  end;
procedure compactarIngresos (var archivo,archivoNuevo:bin);
  var
    cantPos:integer; ingreso,ingresoNuevo:regIngreso;
  begin
    reset(archivo);
    rewrite(archivoNuevo);
    leer(archivo,ingreso);
    while (ingreso.codigo <> valoralto) do begin
      ingresoNuevo.nombre:=ingreso.nombre;
      ingresoNuevo.monto:=0;
      while (ingreso.codigo <> valoralto) and (ingreso.codigo = ingresoSig.codigo) do begin
        ingresoNuevo.monto:=ingresoNuevo.monto+ingreso.monto;
        leer(archivo,ingreso);
      end;
      write(archivoNuevo,ingreso);
    end;
    close(archivo);
    close(archivoNuevo);
  end;
procedure imprimir (var archivo:bin);
  var
    ingreso:regIngreso;
  begin
    reset(archivo);
    while not eof(archivo) do begin
      read(archivo,ingreso);
      writeln('Codigo de empleado: ',ingreso.codigo);
      writeln('Nombre: ',ingreso.nombre);
      writeln('Monto: ',ingreso.monto);writeln();
    end;
    close(archivo);
  end;
var
  archivo,archivoNuevo:bin; nombre:string;
begin
  write('Ingrese el nombre del archivo: ');readln(nombre);
  assign(archivo,nombre);
  cargarArchivo(archivo);
  imprimir(archivo);
  write('Ingrese el nombre del archivo compactado: ');readln(nombre);
  assign(archivoNuevo,nombre);
  compactarIngresos(archivo,archivoNuevo);
  imprimir(archivoNuevo);
end.