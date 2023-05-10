local M = {
  countDownSeconds = 5,
  currentCount = nil
}

function CountDown()
  M.currentCount = M.currentCount - 1

  local reset = false

  if (M.currentCount <= 0) then
      MP.SendChatMessage(-1, 'GO!')
      reset = true
  else
      MP.SendChatMessage(-1, M.currentCount .. '...')
  end

  MP.TriggerClientEvent(-1, 'clientCountdown', tostring(M.currentCount))

  if reset then
    MP.CancelEventTimer('serverCountdown')
    M.currentCount = M.countDownSeconds
  end
end

function HandleChatMessage(pid, name, message)
  print(pid, name, message)
  -- Switch to console input if there is no "message" variable
  if not message then
      message = pid
      pid = -2
  end

  print('Command', '"' .. message:sub(1, 3) .. '"')

  if message:sub(1, 3) == '/cd' then
    -- If command is "/cd <number>" we parse the seconds and use that
    local delim = message:find(' ')
    if delim then
      local seconds = tonumber(message:sub(delim + 1))
      if type(seconds) ~= 'number' then
        MP.SendChatMessage(pid, 'Invalid seconds value, it has to be a number')
        return 1
      end
      if seconds < 1 then
        MP.SendChatMessage(pid, 'Seconds have to be a positive number')
        return 1
      end

      M.countDownSeconds = tonumber(seconds)
    end

    M.currentCount = M.countDownSeconds

    MP.SendChatMessage(-1, 'Counting down from ' .. M.countDownSeconds)
    MP.TriggerClientEvent(-1, 'freezeVehicle', '')
    MP.CreateEventTimer('serverCountdown', 1000)
    return 1
  end

  return 0
end

MP.RegisterEvent('onConsoleInput', 'HandleChatMessage')
MP.RegisterEvent('onChatMessage', 'HandleChatMessage')
MP.RegisterEvent('serverCountdown', 'CountDown')

return M
