# Tarea 1: Programación con Ensamblador ARM

Este repositorio tiene las soluciones de la Tarea #1 del curso de Arquitectura de Computadores 1, **CE4301**. Los detalles de la tarea se pueden obtener mediante el siguiente documento [Arqui1_Tarea1_v3.pdf](https://github.com/CURSOS-TEC/ARMTarea1/blob/master/Arqui1_Tarea1_v3.pdf "Arqui1_Tarea1_v3.pdf")

# Diagrama de proceso
> Este diagrma debe de ser abierto en un navegador web debido a que es en formato HTML.

Los pseudocódigos fueron diagramados utilizado el editor Draw.io en donde se exporta un archivo HTML. ([Tarea1Arqui1.html](https://github.com/CURSOS-TEC/ARMTarea1/blob/master/Tarea1Arqui1.html "Tarea1Arqui1.html"))

> Se debe de considerar que este archivo HTML tiene un panel de navegación con los dos diagramas  en donde  la primera página se encuentra los respectivos diagramas para el ejercicio 1 y en la siguiente página los correspondientes para el ejercicio 2. 

# Ejercicio 1

Con el fin de revisar el paso a paso del proceso de cifrar y decoficar una frase encriptada se recomienda el uso de BreakPoints y revisar el mapa de memoria el cual inicia en la dirección **0x300**.

 1. Abrir el archivo [encrypt.s](https://github.com/CURSOS-TEC/ARMTarea1/blob/master/encrypt.s "encrypt.s")
 2. Revisar que el texto se escribe sin cifrar: **Breakpoint en la línea 66**
 3. Texto cifrado : **Breakpoint en la línea  98**
 4. Texto decodificado:  **Continuar con la ejecución**

# Ejercicio 2

Abrir el archivo [test.s](https://github.com/CURSOS-TEC/ARMTarea1/blob/master/test.s "test.s") , y abrir la herramienta del mapa de memoria.

La generación de la tabla de números primos contenidos en el intervalo de  [0, 255], son guardados a partir de la dirección de memoria **0x300**. Aquellos números que sean primos se dejaron con el fin de hacer la revisión más efectiva y aquellos números que no son primos fueron establecidos con el valor indicado en la tarea, **0x1**.

Los números que fueron generados por el algoritmo *LSFR* son validados mediante la búsqueda de la dirección de memoria asociada a la tabla de Erasthontenes en donde se compara si el valor es diferente de  **0x1h**. 
Todo número que sea validado como primo será almacenado a partir de la dirección de memoria  **0x700**.
