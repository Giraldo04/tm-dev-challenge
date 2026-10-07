--[[
  R-13: los niveles salen de aquí, no de motor.lua.

  Cada nivel es datos puros — su punto de partida y sus plataformas — pensados
  para la resolución de referencia 960x540, igual que estaban antes a mano
  dentro de motor.lua. motor.lua solo los carga por índice.
]]
return {
  {
    inicio = { x = 80, y = 100 },
    plataformas = {
      { x = 0,   y = 500, w = 960, h = 40 },  -- el suelo
      { x = 220, y = 410, w = 180, h = 18 },
      { x = 480, y = 320, w = 200, h = 18 },
    },
  },
  {
    inicio = { x = 40, y = 80 },
    plataformas = {
      { x = 0,   y = 500, w = 960, h = 40 },
      { x = 120, y = 430, w = 140, h = 18 },
      { x = 340, y = 360, w = 140, h = 18 },
      { x = 560, y = 290, w = 140, h = 18 },
      { x = 760, y = 220, w = 160, h = 18 },
    },
  },
  {
    inicio = { x = 80, y = 100 },
    plataformas = {
      { x = 0,   y = 500, w = 300, h = 40 },  -- suelo partido: hay un hueco
      { x = 420, y = 500, w = 540, h = 40 },
      { x = 200, y = 400, w = 120, h = 18 },
      { x = 650, y = 350, w = 160, h = 18 },
    },
  },
}
