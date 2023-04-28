RegisterServerEvent('checkInventory')
AddEventHandler('checkInventory', function()
  local src = source
  local duplicates = {}

  -- Function to check for duplicate items
  local function checkDuplicates(inv)
      duplicates = {}
      for i=1, #inv do
          local item = inv[i]
          local count = 0
          for j=1, #inv do
              if inv[j].name == item.name and inv[j].serial ~= item.serial then
                  count = count + 1
              end
          end
          if count > 0 then
              duplicates[item.name] = duplicates[item.name] or {}
              duplicates[item.name][item.serial] = true
          end
      end
  end
  
  -- Function to alert when duplicate item is found
  local function alertDuplicates(source, inv)
      checkDuplicates(inv)
      for itemName, serials in pairs(duplicates) do
          local message = "**Possible duplicate items found!**\n\nItem Name: " .. itemName .. "\nSerial Numbers:\n"
          for serialNumber, _ in pairs(serials) do
              message = message .. serialNumber .. "\n"
          end
          sendToDiscord(message)
      end
  end
  
  -- Function to send alert to Discord webhook
  local function sendToDiscord(message)
      if webhookUrl ~= nil and webhookUrl ~= "https://discord.com/api/webhooks/1101170048921514034/r3qO-d_RU_hYbhL9CDjJfBMBurr6WyM26FQIYAA1QY9TF2lLLFQXzbiFwhdxFHhgPLDr" then
          PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
      end
  end
  
  -- Function to get player's inventory
  local function getPlayerInventory(source)
      local player = QBCore.Functions.GetPlayer(source)
      local inv = {}
      for k,v in pairs(player.PlayerData.items) do
          if v.slot ~= nil then
              local item = QBCore.Shared.Items[v.name:lower()]
              if item ~= nil then
                  table.insert(inv, {
                      name = item.label,
                      count = v.count,
                      serial = v.info.serial
                  })
              end
          end
      end
      return inv
  end
  
  local inv = getPlayerInventory(src)
  alertDuplicates(src, inv)
end)
