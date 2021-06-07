# Palabras y términos que hay que usar

## Árboles

Las claves se almacenan en nodos.

El número de nodo es el NRR.

Cuando se inserta una clave y ya hay alguna en ese nodo, hay colisión. Y si se supera el máximo de claves del nodo, hay desborde (overflow).

Cuando hay overflow, la menor de las claves mayores (o la del medio) se promociona al nodo padre.

Si el overflow se propaga al padre, se siguen los mismos pasos.

Cuando hay underflow en una baja, se intenta redistribuir o balancear las cargas con un hermano adyacente. Si no se puede redistribuir, se fusiona (dependiendo de la política).

En árboles B+, las claves válidas están siempre en las hojas. Las demás son señaladores.

## Hashing

Cuando se inserta una clave y ya hay otra en esa cubeta, hay colisión. Y si se supera el máximo de claves de la cubeta, hay desborde (overflow).

Las claves que no se encuentran en su dirección base se denominan intrusas.

En saturación progresiva encadenada, las claves que pertenecen a una misma dirección base conforman la lista de sinónimos.

En dispersión doble, el resultado de la segunda función es un desplazamiento.

En hashing extensible, las direcciones están en una tabla en memoria, y las claves están en cubetas en disco. Hay un valor asociado a la tabla y un valor asociado a cada cubeta. Cuando hay desborde, se duplica la cubeta saturada y se duplican las direcciones.