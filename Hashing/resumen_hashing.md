METODOS DE DISPERSION
---------------------


- Saturacion progresiva
- Saturacion progresiva encadenada
- Saturacion progresiva con area de desborde
- Dispersion doble


# Saturacion progresiva

Las claves intrusas van en la cubeta siguiente que encuentre libre

DE = usados/total * 100

## Bajas

En las bajas se usa marca #### cuando se elimina un dato y en la proxima cubeta hay otra marca u otro dato


# Saturacion progresiva encadenada

Hay una columna que se llama enlace. Comienza en -1

**IMPORTANTE:** Si no hay lugar, busco progresivamente hasta que encuentro un espacion. En la columna enlace, de su direccion base, guarda la direccion donde lo almacene.
Si voy a almacenar una clave, pero en su lugar hay una intrusa, muevo la clave intrusa, actualizo su enlace y guardo la clave original en su direccion base.

*Pregunta:* que pasa cuando tengo que mover una clave intrusa y tengo que pasar a otra intrusa?

*Respuesta:* en la direccion anterior, actualizo el enlace a la direccion mas lejana y en la nueva direccion pongo el enlace anterior. Para poder encontrar la direccion anterior a la intrusa que tengo que mover tengo que aplicarle la funcion e ir recorriendo hasta encontrar a la que en el enlace apuntaba a la intrusa que movi, y actualizar ese enlace. Este procedimiento me va a agregar lecturas extras.

*Busca que la mayor cantidad de claves esten en su direccion base por lo tanto las busquedas son mejores*


## Baja de clave en el medio de la cadena de sinonimos

Busco donde esta la clave a eliminar, la borro y copio su enlace en la direccion anterior

## Baja de clave inicial de la cadena de sinonimos

Copio enlace y registro en la direccion original


# Saturacion progresiva con area de desborde

Cuando hay un desborde se inserta en el area separada y se actualiza el puntero en la tabla principal para hacer referencia.
Si ya hay una clave en esa posicion se busca la siguiente libre en el area de desborde. En el primer elemento de la cadena guardo el enlace a la nueva direccion y en la nueva direccion el enlace del primer elemento.

## Bajas en el area principal

Solo escribo las cubetas sin las claves

## Bajas en el area separada

Actualizo los enlaces. 


# Dispersion doble

Tiene 2 funciones de dispersion. A la 2da funcion siempre se le suma 1 por si el MOD da 0 tiene que existir un desplazamiento.
Si hay desborde, aplico la siguiente funcion de dispersion que es el desplazamiento. Para todos los siguientes desbordes le sumo el desplazamiento.

## Bajas

Se pone una marca de borrado ####

**PREGUNTAR:** siempre se usa la marca de borrado?




# Hashing extensible

Se agregan hasta 2 claves. Si hay desborde

1. Se incrementa en 1 el valor asociado a la cubeta saturada (se duplica la cant de direcciones)
2. Se genera una nueva cubeta con el *mismo valor* asociado a la cubeta saturada

Se dispersan las claves en las cubetas (2) mirando el ultimo bit generado por la funcion. Solo se dispersan y redireccionan las claves de las cubetas involucradas.


















