local isHostage = false
local hostagePed = nil

local function findNearbyPed(radius)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local handle, ped = FindFirstPed()
    local success
    repeat
        local pedCoords = GetEntityCoords(ped)
        if DoesEntityExist(ped) and not IsPedAPlayer(ped) then
            if #(pedCoords - playerCoords) <= radius then
                EndFindPed(handle)
                return ped
            end
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return nil
end

RegisterNetEvent('hostagescript:takeHostage', function()
    if isHostage then return end
    local ped = findNearbyPed(3.0)
    if ped then
        hostagePed = ped
        isHostage = true
        SetEntityAsMissionEntity(hostagePed, true, true)
        ClearPedTasks(hostagePed)
        TaskPlayAnim(hostagePed, "missprologueig_2", "idle_crew_monologue", 8.0, -8.0, -1, 1, 0, false, false, false)
        SetBlockingOfNonTemporaryEvents(hostagePed, true)
        SetEntityInvincible(hostagePed, true)
        TriggerEvent("chat:addMessage", { args = { "NPC taken hostage." } })
    else
        TriggerEvent("chat:addMessage", { args = { "No nearby NPC found." } })
    end
end)

RegisterNetEvent('hostagescript:releaseHostage', function()
    if isHostage and hostagePed ~= nil then
        ClearPedTasksImmediately(hostagePed)
        SetEntityInvincible(hostagePed, false)
        SetBlockingOfNonTemporaryEvents(hostagePed, false)
        SetPedAsNoLongerNeeded(hostagePed)
        TriggerEvent("chat:addMessage", { args = { "Hostage released." } })
        isHostage = false
        hostagePed = nil
    end
end)

CreateThread(function()
    exports['qb-target']:AddTargetModel({'a_m_m_business_01', 'a_m_m_tramp_01'}, {
        options = {
            {
                type = 'client',
                event = 'hostagescript:takeHostage',
                icon = 'fas fa-user-lock',
                label = 'Take Hostage'
            },
            {
                type = 'client',
                event = 'hostagescript:releaseHostage',
                icon = 'fas fa-user-unlock',
                label = 'Release Hostage'
            }
        },
        distance = 2.5
    })
end)

