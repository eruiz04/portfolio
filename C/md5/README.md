ITESO
Diplomado en verificación Pre-Silicio
Programación en C 
Tarea 04
Alumnos:
•Ruiz Mejía Eugenio Alejandro
•Zetina Martínez Enrique 

Introducción
El algoritmo MD5 es u algoritmo para resumen de mensajes, en el cual se toma como entrada un mensaje de longitud arbitraria y produce como salida una "huella" de 128 bits o "resumen del mensaje" de entrada. Se conjetura que es computacionalmente inviable encontrar dos mensajes que tengan el mismo resumen, u obtener un mensaje que tenga un resumen de mensaje en concreto, establecido previamente como objetivo. (Francos, 2003)
Explicación del algoritmo
1.Teniendo un mensaje de entrada de b-bits 
m_0 m_1 ... m_{b-1}

2.Se amplia el mensaje de entrada para que su longitud en bits sea equivalente a 448 bits, es decir, 512 – 64 bits. Este proceso se realiza agregando un “1” al mensaje y después se añaden “0” s. El fin es que la longitud sea de 448, modulo 512. 

3.A la representación a 64bits del mensaje de entrada b se le añade el resultado del paso previo y esto será dividido entre 2 palabras de 32 bits. La longitud del mensaje será un múltiplo exacto de 512.

4.Se inician cuatro palabras de 32 bits cada y se inicializan con los siguientes valores hexadecimales
palabra A: 01 23 45 67
palabra B: 89 ab cd ef
palabra C: fe dc ba 98
palabra D: 76 54 32 10

5.Se definen 4 variables auxiliares que toman por entrada las entradas definidas en el paso anterior

F(X,Y,Z) = XY v not(X) Z
G(X,Y,Z) = XZ v Y not(Z)
H(X,Y,Z) = X xor Y xor Z
I(X,Y,Z) = Y xor (X v not(Z))
De las cuales, se pueden interpretar de la siguiente forma:
F(x, y, z) = ((x AND y) OR (NOT(x) and z))
G(x, y, z) = ((x AND z) OR (y NOT(z))
H(x, y, z) = (x XOR y XOR z)
I(x, y, z) = (y XOR (x OR NOT(z))
6.La función de las funciones previamente mencionadas es actuar como condicional para la posición de cada bit buscando que cada uno de los bits salida de las funciones sea independiente entre sí.
7.Posteriormente se utiliza una tabla de 64 elementos, construida a partir de la función seno. Supongamos que T[i] es el elemento i-ésimo de la tabla, que es igual a la parte entera del resultado de multiplicar 4294967296 veces abs(sin(i)), estando i expresado en radianes (Francos, 2003). 
8.Después de ciclos iterativos, se guardan las siguientes variables 
AA = A
BB = B
CC = C
DD = D
9.	Se realizan 4 vueltas descritas de la siguiente manera:

     /* Vuelta 1. */
     /* Suponiendo que [abcd k s i] representa la operación
          a = b + ((a + F(b,c,d) + X[k] + T[i]) <<< s). */
     /* Realizamos las 16 operaciones siguientes. */
     [ABCD  0  7  1]  [DABC  1 12  2]  [CDAB  2 17  3]  [BCDA  3 22  4]
     [ABCD  4  7  5]  [DABC  5 12  6]  [CDAB  6 17  7]  [BCDA  7 22  8]
     [ABCD  8  7  9]  [DABC  9 12 10]  [CDAB 10 17 11]  [BCDA 11 22 12]
     [ABCD 12  7 13]  [DABC 13 12 14]  [CDAB 14 17 15]  [BCDA 15 22 16]

     /* Vuelta 2 */
     /* Suponiendo que [abcd k s i] representa la operación
          a = b + ((a + G(b,c,d) + X[k] + T[i]) <<< s). */
     /* Realizamos las 16 operaciones siguientes. */

     [ABCD  1  5 17]  [DABC  6  9 18]  [CDAB 11 14 19]  [BCDA  0 20 20]
     [ABCD  5  5 21]  [DABC 10  9 22]  [CDAB 15 14 23]  [BCDA  4 20 24]
     [ABCD  9  5 25]  [DABC 14  9 26]  [CDAB  3 14 27]  [BCDA  8 20 28]
     [ABCD 13  5 29]  [DABC  2  9 30]  [CDAB  7 14 31]  [BCDA 12 20 32]

     /* Vuelta 3. */
     /* Supongamos que [abcd k s t] representa la operación
          a = b + ((a + H(b,c,d) + X[k] + T[i]) <<< s). */
     /* Realizamos las 16 operaciones siguientes. */
     [ABCD  5  4 33]  [DABC  8 11 34]  [CDAB 11 16 35]  [BCDA 14 23 36]
     [ABCD  1  4 37]  [DABC  4 11 38]  [CDAB  7 16 39]  [BCDA 10 23 40]
     [ABCD 13  4 41]  [DABC  0 11 42]  [CDAB  3 16 43]  [BCDA  6 23 44]
     [ABCD  9  4 45]  [DABC 12 11 46]  [CDAB 15 16 47]  [BCDA  2 23 48]

     /* Vuelta 4. */
     /* Supongamos que [abcd k s t] representa la operación
          a = b + ((a + I(b,c,d) + X[k] + T[i]) <<< s). */
     /* Realizamos las 16 operaciones siguientes. */
     [ABCD  0  6 49]  [DABC  7 10 50]  [CDAB 14 15 51]  [BCDA  5 21 52]
     [ABCD 12  6 53]  [DABC  3 10 54]  [CDAB 10 15 55]  [BCDA  1 21 56]
     [ABCD  8  6 57]  [DABC 15 10 58]  [CDAB  6 15 59]  [BCDA 13 21 60]
     [ABCD  4  6 61]  [DABC 11 10 62]  [CDAB  2 15 63]  [BCDA  9 21 64]

10.Se realiza la siguiente operación con los 4 registros:
A = A + AA
B = B + BB
C = C + CC
D = D + DD

11.El resumen de mensaje resultante está en A, B, C, D, empezando por el byte de menor orden de A, y terminando con el byte de mayor orden de D.
