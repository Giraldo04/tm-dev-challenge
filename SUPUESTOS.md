# Supuestos y recortes

Este archivo es parte de la entrega, no un anexo. Escríbelo mientras trabajas,
no al final: al final no te va a dar tiempo.

## Lo que asumí

Una línea por decisión que tuviste que tomar porque el requisito no la definía.
Formato libre; el contenido importa más que la forma.

- (ejemplo) *R-30 pide respetar el "modo silencioso" y eso no existe en ninguna
  parte. Asumo que se refiere a no reproducir sonidos, lo implemento así y lo
  dejo dicho aquí.*
- *R-93 pide que las teclas 1-9 carguen el nivel directamente. Esas teclas ya
  copiaban el requisito N al portapapeles (el modo de pasarle los requisitos al
  agente). Se lo señalé a quien dirige y decidió priorizar el cambio rápido de
  nivel: ahora 1-9 cargan nivel y ese atajo de copiado individual desaparece.
  `C` sigue copiando todos los requisitos de golpe, como red.*

## Lo que dejé fuera, y por qué

Lo mismo, para lo que no hiciste. Dejar algo fuera con el motivo escrito puntúa
más que entregarlo a medias.

- (ejemplo) *R-70, multijugador a pantalla partida: no cabe en el tiempo que
  queda y tocaría el bucle entero. Prefiero entregar lo demás funcionando.*
- *R-20 (doble salto) y su ajuste R-23: se implementaron, probados y en verde,
  pero se retiraron después. Se probó en beta y no dio resultado — no fue bien
  recibido por el usuario final. Se quitó la lógica de `src/motor.lua` y sus
  tests de `tests/motor_spec.lua`; el resto (niveles, R-93) sigue en pie.*

## Lo que me dio la IA y no verifiqué

Si algo salió del modelo y no lo comprobaste, dilo aquí. **No resta.** Lo que no
sobrevive es entregarlo como propio sin haberlo mirado.
