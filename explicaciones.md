# Formas de explicar las distintas operaciones

## Árboles

### Altas

*Intento insertar la clave X en el nodo N y, como el nodo no está lleno con el mnáximo de claves que puede tener, no se produce un overflow e inserto la clave sin problemas.*

*Intento insertar la clave X en el nodo N pero este ya contiene el número máximo de claves, por lo que se produce un desborde u overflow. Para resolverlo, divido las cargas del nodo N más la clave a insertar a la mitad. Luego creo un nuevo nodo y le inserto la mitad mayor de las claves, y promociono la menor de las claves mayores (o una copia, en B+) al nodo padre. Si se propaga el overflow al nodo padre, sigo los mismos pasos.*

### Bajas

*Como la clave X no está en una hoja, primero debo intercambiarla con la menor clave de su subárbol derecho. Una vez hecho eso ya la puedo eliminar.*

*Intento eliminar la clave X del nodo N, pero como el nodo queda con menos claves de las mínimas que puede tener, se produce un underflow. Como la política es izquierda o derecha, primero intento redistribuir con el hermano adyacente izquierdo, luego con el derecho, y como no es posible porque ambos están con el mínimo número de claves, debo fusionar con el hermano izquierdo (Adaptar según el caso).*

## Hashing

### Altas

*(Saturación progresiva) Intento insertar la clave X en la cubeta N, pero como está llena, leo progresivamente las siguientes cubetas hasta encontrar una que tenga espacio disponible e inserto la clave (que queda como intrusa).*

*(S. progresiva encadenada) Intento insertar la clave X en la cubeta N, pero como está llena, copio el enlace que contenga y leo progresivamente las siguientes cubetas hasta encontrar una que tenga espacio disponible. Inserto la clave (que queda como intrusa) con el enlace que copié de la dirección base, y luego vuelvo a la dirección base y le escribo la posición de la cubeta en la que inserté la clave X en el campo de enlace.*

*(S. progresiva encadenada) Intento insertar la clave X en la cubeta N, pero ya está llena y contiene una clave intrusa, por lo que muevo la clave intrusa (con su enlace) a la próxima posición libre. Luego recorro la lista de sinónimos para encontrar el elemento anterior a la clave que moví, y le actualizo el enlace a la nueva posición. Por último, inserto la clave X en la cubeta N.*

*(Hashing extensible) Como el valor asociado a la tabla de direcciones es i, intento insertar la clave X en la cubeta que corresponda según los i últimos bits de la clave. Si la cubeta ya está llena, le aumento el valor asociado y la duplico. Reacomodo las claves que ya tenían más la clave nueva, y por último compruebo si el valor asociado a la cubeta es mayor al valor asociado a la tabla de direcciones. Si es mayor, duplico las direcciones de memoria, aumento el valor asociado a la tabla, y reacomodo los enlaces a las cubetas.*

### Bajas

*(Saturación progresiva) Si la cubeta donde está la clave X no está llena, la elimino sin problemas. Si la cubeta está llena, leo la próxima cubeta y, si esta contiene algún dato o alguna marca, elimino la clave y dejo una marca de borrado.*

*(S. progresiva encadenada) Si la clave a eliminar es la primera clave de su lista de sinónimos, avanzo a la próxima cubeta de la lista de sinónimos y la copio en la cubeta de la que voy a eliminar. Si no es la primera de la lista, copio el enlace que tenga la cubeta, borro la clave y, a partir de la dirección base, recorro los sinónimos hasta encontrar el anterior. Cuando lo encuentro, le actualizo el enlace.*