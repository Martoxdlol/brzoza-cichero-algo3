# Preguntas para después de hacer el ejercicio

## Sobre implementar funcionalidad

Cuando implementamos las primeras pruebas primero hicimos que cumpla los requisitos mínimos para que pase las pruebas. Es decir, en el test01 hicimos para que cumpla que el mensaje `cantidadDeHuevosDeAvispas` devolviera 0, y con eso pasa la prueba 01. Luego para la prueba dos ahí tuvimos que implementar el método `intentarReproducirse` de `laAvispaOriana`. Para el cual tuvimos que implementar `hacerQueElHabitatTengaLosRecursosSuficientes` también. Luego de esto la prueba 1 ya no pasaba y tuvimos que implementar `retrocederElHabitatAlInicioDeLosTiempos`. Con estos pasos hechos ahora pasaban las 3 pruebas. En resumen, si, se puede y es como lo hicimos que pase primero la prueba 01 después la 02 y la 03 y después las tres. Lo bueno de implementarlo de esta manera es que no nos adelantamos a los requerimientos del ejercicio y vamos creando los métodos y mensajes necesarios conforme hagan falta para pasar las pruebas.

## Sobre código repetido

Si, por ejemplo tenemos muchos métodos que agregan o eliminan recursos o huevos que hacen lo mismo pero con otro recurso.
El hábitat `HabitatDeAvispas` es responsable de responder a la cantidad de huevos y recursos disponibles. Para ver si se puede reproducir o no las avispas le preguntan al hábitat si están los recursos necesarios y decide si reproducir o no.
La información de las orugas y polillas la tiene el hábitat mientas que los responsables de decidir si sirve o no para reproducirse es cada avispa. A nosotros nos parece que es una buena implementación.

## Sobre código repetido 2

Nosotros utilizamos colaboradores internos para almacenar la información de huevos y de recursos. No utilizamos ni colecciones ni diccionarios. Nos pareció la manera más sencilla de implementar todo. Es posible que hubiese menor cantidad de código repetido con diccionarios, pero creemos que nuestra implementación es más sencilla y fácil de entender.
