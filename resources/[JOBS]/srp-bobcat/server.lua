
RegisterServerEvent("efe:particleserver")
AddEventHandler("efe:particleserver", function(method)
    TriggerClientEvent("efe:ptfxparticle", -1, method)
end)

RegisterServerEvent("efe:particleserversec")
AddEventHandler("efe:particleserversec", function(method)
    TriggerClientEvent("efe:ptfxparticlesec", -1, method)
end)
