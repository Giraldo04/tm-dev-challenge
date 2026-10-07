--[[
  El motor del juego: física, colisiones y estado. **Lua puro**.

  Aquí no se llama a `love.*` a propósito. Todo lo que decide qué pasa vive en
  este fichero, y por eso se puede probar sin abrir una ventana: `love . --test`
  corre los tests contra este módulo en medio segundo.

  Lo que pinta está en `pintar.lua`. Si te ves llamando a love.graphics desde
  aquí, casi seguro que la lógica se está mezclando con el dibujo.
]]

local niveles = require("src.niveles")

local motor = {}
motor.__index = motor

local GRAVEDAD = 1800      -- px/s²
local VELOCIDAD = 260      -- px/s en horizontal
local IMPULSO = 620        -- px/s al saltar

motor.NUM_NIVELES = #niveles

local function clonarPlataformas(nivel)
  local plats = {}
  for i, p in ipairs(nivel.plataformas) do
    plats[i] = { x = p.x, y = p.y, w = p.w, h = p.h }
  end
  return plats
end

--- Un mundo nuevo, con su suelo y sus plataformas, del nivel pedido (1 si no se dice).
function motor.nuevo(ancho, alto, indiceNivel)
  local m = setmetatable({}, motor)
  m.ancho, m.alto = ancho or 960, alto or 540
  m.nivelActual = indiceNivel or 1
  local nivel = niveles[m.nivelActual] or niveles[1]
  m.plataformas = clonarPlataformas(nivel)
  local inicio = nivel.inicio or { x = 80, y = 100 }
  m.jugador = { x = inicio.x, y = inicio.y, vx = 0, vy = 0, w = 28, h = 36, enSuelo = false }
  m.inicio = { x = inicio.x, y = inicio.y }
  return m
end

--- Cambia de nivel sin tocar el resto del mundo (tamaño de ventana, etc).
function motor:cargarNivel(indice)
  local nivel = niveles[indice]
  if not nivel then return false end
  self.nivelActual = indice
  self.plataformas = clonarPlataformas(nivel)
  local inicio = nivel.inicio or { x = 80, y = 100 }
  self.inicio = { x = inicio.x, y = inicio.y }
  self:reiniciar()
  return true
end

local function solapan(a, b)
  return a.x < b.x + b.w and b.x < a.x + a.w and a.y < b.y + b.h and b.y < a.y + a.h
end

--- Un paso de simulación. `entrada` es { izquierda, derecha, saltar }.
function motor:actualizar(dt, entrada)
  local j = self.jugador
  entrada = entrada or {}

  j.vx = 0
  if entrada.izquierda then j.vx = -VELOCIDAD end
  if entrada.derecha then j.vx = VELOCIDAD end

  if entrada.saltar and j.enSuelo then
    j.vy = -IMPULSO
    j.enSuelo = false
  end

  j.vy = j.vy + GRAVEDAD * dt

  -- Se mueve un eje cada vez: así una colisión en X no se come la de Y, que es
  -- de donde salen los bugs de atravesar esquinas.
  j.x = j.x + j.vx * dt
  for _, p in ipairs(self.plataformas) do
    if solapan(j, p) then
      if j.vx > 0 then j.x = p.x - j.w elseif j.vx < 0 then j.x = p.x + p.w end
    end
  end

  j.y = j.y + j.vy * dt
  j.enSuelo = false
  for _, p in ipairs(self.plataformas) do
    if solapan(j, p) then
      if j.vy > 0 then
        j.y = p.y - j.h
        j.vy = 0
        j.enSuelo = true
      elseif j.vy < 0 then
        j.y = p.y + p.h
        j.vy = 0
      end
    end
  end

  -- No se sale por los lados.
  if j.x < 0 then j.x = 0 end
  if j.x + j.w > self.ancho then j.x = self.ancho - j.w end

  -- Si se cae del mundo, vuelve a empezar.
  if j.y > self.alto + 200 then self:reiniciar() end

  return self
end

function motor:reiniciar()
  local j = self.jugador
  j.x, j.y, j.vx, j.vy, j.enSuelo = self.inicio.x, self.inicio.y, 0, 0, false
end

return motor
