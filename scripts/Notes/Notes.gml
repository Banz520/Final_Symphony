/*

ALL DRAW GUI TEXT POSITION SHOULD BE MULTIPLIED BY 2 DUE TO THE GUI SRUFACE BEING THE DOUBLE OF THE ROOM SIZE

 TO DO
implementar pelear con multiples enemigos donde usando las flechas aumente o disminuye el valor 
en un arreglo que contiene los enemigos y asi elegir a cual atacar y a su vez dependiendo del 
enemigo cambiar la posicion del outline para distinguir cual seleccione para atacar graficamente
mediante un objeto/ sprite de una sombra en el suelo o cualqueir color para distinguir y que este ajuste su posicion a ser 
la del enemigo en el arreglo que tengo seleccionado

!DONE
Com hago la barra de vida? 
(debe de estar sobre cada personaje, prodia hacer un objeto que con el battle manager al inicio de la pelea
genere cada objeto de vida por entidad en el cuarto , tanto enemigo como aliado y este objeto cambia segun l vida del 
personaje al que este vinculado y, se destruira si la instancia del objeto al que esta asigndo se detruye)

!DONE
añadir el flash par cuando golpean 


añadir que los personajes se acerquen al objetivo al golpear

hacer tutorial


 TO FIX
 
no se porque el enemigo no golpea en su turno..

 IDEAS

ya que el gameplay se separa en el mundo y el combate habra dos objetos del jugador, uno del combate y otro de aventura
que el jugador pueda mover y la camara seguir, por lo que quiero checar al inicio de cada cuarto con mi camara
si hay una instancia del jugador de aventura para que lo siga, de lo contrario que sea fija al combate 


se me ocurre que para entrar a los combates haya como un objeto de transicion como los de cambio de cuarto, pero
este te enviara al cuarto de la pelea y tendra como variables que cuarto te envia y la cantidad y/o tipos de enemigos


11/mar/23
hacer mas modular el menu de selector de niveles, de modo que solo pase una matriz con el nivel al que te redigira cada boton, 
un enum del sprite y la cadena de texto que tenga 

y moverse por el menu con las flechas o w s y hacer grande el boton si es el seleccionado y cambiar el fondo segun el boton sobre el que estas

y hacer un fade de transicion al nivel 

y por ultimo añadir audio al juego y ya estaria terminado la funcionalidad

12/mar/23
listo el menu y las transiciones


13/mar/23
añadir los sprites de ataque de cada quien



character will be split into 3 for their stats, these can be atack dmg high, low or med and also for health, these will be an enum that will be multiplied by the difficulty
no chara can have two high stats or two low stats to make balanced , with some exceptions, now that i see using an denum woudlnt hel´p  i need to use a map o just the numbers



Poner numeros a las barras de vida
explicar el sistema de defensa
cambiar el simbolo para los puntos de caos, que se vea mas visual y mas contraste en el numero
quiza una dinamita que se acorte la mecha




















*/


