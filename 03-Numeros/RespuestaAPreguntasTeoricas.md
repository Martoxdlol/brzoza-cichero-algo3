# Aporte de los mensajes de DD

## En un double dispatch (DD), ¿qué información aporta cada uno de los dos llamados?


En un DD, cada llamado nos ayuda a entender de que clase son los objetos en cuestión, sin preguntarlo de forma directa. Esto pasa porque ambas clases tendrían el mismo llamado con diferentes implementaciones, y entonces, depende de la clase del objeto, como va a comportarse ante el llamado.

# Lógica de instanciado

## Con lo que vieron y saben hasta ahora, ¿donde les parece mejor tener la lógica de cómo instanciar un objeto? ¿por qué? ¿Y si se crea ese objeto desde diferentes lugares y de diferentes formas? ¿cómo lo resuelven?

Cada clase tiene puede tener uno o varios inicializadores. Estos se pueden tener como metodo de instancia que se llaman despues del new. Otra forma que podemos hacer es inicializar instancias desde métodos de clase. Esto nos permitiria tener una lógica de inicializacion especifica como queramos y evitando usar new. Esto nos permite tambien inicializar otro tipo de objeto o sub clase con el mismo inicilizador o desde la misma clase. Ej: `Number with:` o `Number with:over:`. Estos métodos nos permiten desde número inicializar un Entero o una Fraccion.

# Nombres de las categorías de métodos

## Con lo que vieron y trabajaron hasta ahora, ¿qué criterio están usando para categorizar métodos?

A la hora de categorizar métodos, nos enfocamos en que tipo de acciones hacen (si operaciones aritmeticas, si inicializan, si son de imprimir, etc). Si algunos de estos métodos llama a un mensaje "privado" (o sea, no se espera que el usuario llame a ese mensaje), este mensaje lo clasificamos según su procedencia, más la aclarción de que es privado. Por ejemplo en este ejercicio, _beAddedToAnEntero_ esta en la categoría _"arithmetic operations - private"_, ya que es un mensaje privado que va a ser llamado desde algún mensaje de _"arithmetic operations"_.



# Subclass Responsibility

## Si todas las subclases saben responder un mismo mensaje, ¿por qué ponemos ese mensaje sólo con un “self subclassResponsibility” en la superclase? ¿para qué sirve?

Ese mensaje va en la superclase, por el simple hecho de que sepamos que cosas sabe responder la clase, aunque según que subclase sea lo hara de forma diferente. Si desistieramos de poner ese mensaje, y el día de mañana alguien quisiera implementar una nueva subclase (por ejemplo, en la superclase número, agregar complejo) no sabríamos que mensajes tendría que responder. De esta forma, podemos ver en la superclase, que cosas debe saber responder mi nueva subclase, por el hecho de ser "subclassResponsability"



# No rompas

## ¿Por qué está mal/qué problemas trae romper encapsulamiento?

Está mal porque rompemos con las buenas prácticas del paradigma. Puede traer problemas que si por ejemplo cambiamos la implmentacion de una clase y hay algo que depende de eso (rompiendo la encapsulacion) podria romper el programa. Además de que el código se vuelve mucho mas dificil de mantener y debugear. Estamos agregando complejidad accidental innecesaria.