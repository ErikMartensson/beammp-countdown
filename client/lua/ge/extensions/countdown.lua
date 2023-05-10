local M = {}

AddEventHandler('clientCountdown', function(count)
  print(count)
  if count == '0' then
    Engine.Audio.playOnce('AudioGui', 'event:UI_CountdownGo')
    core_vehicleBridge.executeAction(be:getPlayerVehicle(0), 'setFreeze', false)
  else
    Engine.Audio.playOnce('AudioGui', 'event:UI_Countdown1')
  end
end)

AddEventHandler('freezeVehicle', function()
  core_vehicleBridge.executeAction(be:getPlayerVehicle(0), 'setFreeze', true)
end)

return M
