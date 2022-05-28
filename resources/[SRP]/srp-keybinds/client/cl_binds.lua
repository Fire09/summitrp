local shouldExecuteBind = true
AddEventHandler("srp-binds:should-execute", function(shouldExecute)
  shouldExecuteBind = shouldExecute
end)

exports('registerKeyMapping', function(name, category, description, onKeyDownCommand, onKeyUpCommand, default, event, type)
    if not default then default = "" end
    if not type then type = "keyboard" end
    if not category then
        print("no category provided for keymap, cancelling")
        return
    end
    if not description then
        print("no description provided for keymap, cancelling")
        return
    end
    if not name and event then
      print("no name provided for keymap when key is event, cancelling")
      return
    end
    local desc = "(" .. category .. ")" .. " " .. description

    cmdStringDown = "+cmd_wrapper__" .. onKeyDownCommand
    cmdStringUp = "-cmd_wrapper__" .. onKeyDownCommand
    RegisterCommand(cmdStringDown, function()
      if not shouldExecuteBind then return end
      if event then TriggerEvent("srp-binds:keyEvent", name, true) end
      ExecuteCommand(onKeyDownCommand)
    end, false)
    RegisterCommand(cmdStringUp, function()
      if not shouldExecuteBind then return end
      if event then TriggerEvent("srp-binds:keyEvent", name, false) end
      ExecuteCommand(onKeyUpCommand)
    end, false)
    RegisterKeyMapping(cmdStringDown, desc, type, default)
end)



