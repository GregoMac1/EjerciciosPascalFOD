# Formas de explicar las distintas operaciones

## Árboles

### Overflow

*Intento insertar la clave X en el nodo N pero este ya contiene el número máximo de claves, por lo que se produce un desborde u overflow. Para resolverlo, divido las cargas del nodo N más la clave a insertar a la mitad. Luego creo un nuevo nodo y le inserto la mitad mayor de las claves, y promociono la menor de las claves mayores (o una copia, en B+) al nodo padre. Si en el nodo padre se propaga el overflow, sigo los mismos pasos.*

## Hashing