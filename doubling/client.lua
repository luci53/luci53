local isInInventory = false

function CheckInventory()
    if not isInInventory then
        isInInventory = true
        TriggerServerEvent('inventoryDuplicationDetection:CheckInventory')
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 289) then -- F2 key
            CheckInventory()
        end
    end
end)
