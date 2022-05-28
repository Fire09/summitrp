SRP.DB = SRP.DB or {}

function SRP.DB.CreateNewPlayer(self, src, callback)
    local hexid = SRP.Util:GetHexId(src)
    callback = callback and callback or function() return end

    local data = {
        hexid = hexid,
        communityid = SRP.Util:HexIdToComId(hexid),
        steamid = SRP.Util:HexIdToSteamId(hexid),
        license = SRP.Util:GetLicense(src),
        name = GetPlayerName(src),
        rank = "user"
    }

    for k,v in pairs(data) do
        if not v or v == "" then
            callback(false, true)
            return
        end
    end

    local q = [[INSERT INTO users (hex_id, steam_id, community_id, license, name, rank)
                VALUES(@hexid, @steamid, @comid, @license, @name, @rank);]]
    local v = {
        ["hexid"] = data.hexid,
        ["steamid"] = data.steamid,
        ["comid"] = data.communityid,
        ["license"] = data.license,
        ["rank"] = data.rank,
        ["name"] = data.name
    }    

    exports.ghmattimysql:execute(q, v, function(rowsChanged)
        if not rowsChanged or not rowsChanged.changedRows then callback(false, true) return end

        local created = rowsChanged and true or false
        callback(created)
    end)
end
function SRP.DB.CreateNewCharacter(self, src, data2, hexid, ph, callback)
    local hexid = hexid
    callback = callback and callback or function() return end

    local data = data2

    for k,v in pairs(data) do
        if not v or v == "" then
            callback(false, true)
            return
        end
    end

    local q = [[INSERT INTO characters (owner, first_name, last_name, dob, gender, phone_number, story)
                VALUES(@owner, @first_name, @last_name, @dob, @gender, @phone_number, @story);]]
    local v = {
        ["owner"] = hexid,
        ["first_name"] = data.firstname,
        ["last_name"] = data.lastname,
        ["dob"] = data.dob,
        ["gender"] = data.gender,
        ["phone_number"] = ph,
        ["story"] = data.story
    }

    exports.ghmattimysql:execute(q, v, function(rowsChanged)

        if not rowsChanged or not rowsChanged.changedRows then callback(false, true) return end

        local created = rowsChanged and true or false

        callback(created)
    end)
end

    
function SRP.DB.PlayerExistsDB(self, src, callback)
    local hexId = SRP.Util:GetHexId(src)
    callback = callback and callback or function() return end
    
    if not hexId or hexId == "" then callback(false, true) return end

    local q = [[SELECT hex_id FROM users WHERE hex_id = @id LIMIT 1;]]
    local v = {["id"] = hexId}

    exports.ghmattimysql:execute(q, v, function(results)
        if not results then callback(false, true) return end

        local exists = (results and results[1]) and true or false

        callback(exists)
    end)
end

function SRP.DB.PhoneNumberExists(self, src, phone_number, callback)
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)

    callback = callback and callback or function() return end

    if not user then callback(false, true) print("error error") return end

    local hexId = user:getVar("hexid")

    if not hexId or hexid == "" then callback(false, true) print('another error') return end

    local q = [[SELECT phone_number FROM characters WHERE owner = @id;]]
    local v = {
        ["id"] = hexid,
        ["phone_number"] = phone_number
    }


    exports.ghmattimysql:execute(q, v, function(results)
        if not results then callback(false, true) print('error error EXORTS') return end


        local exists = (results and results[1]) and true or false
        callback(exists)
    end)
end



function SRP.DB.FetchPlayerData(self, src, callback)
    local hexId = SRP.Util:GetHexId(src)
    callback = callback and callback or function() return end

    if not hexId or hexId == "" then callback(false, true) return end

    local q = [[SELECT id, hex_id, steam_id, community_id, name, rank FROM users WHERE hex_id = @id;]]
    local v = {["id"] = hexId}

    exports.ghmattimysql:execute(q, v, function(results)
        if not results then callback(false, true) return end
        results = results[1] and results or {}

        
        local fetched = (results and results[1]) and results[1] or false

        callback(fetched)
    end)
end

function SRP.DB.FetchCharacterData(self, user, callback)
    callback = callback and callback or function() return end

    if not user then callback(false, true) return end

    local hexId = user:getVar("hexid")

    if not hexId or hexid == "" then callback(false, true) return end

    local q = [[SELECT id, owner, first_name, last_name, date_created, cash, bank, phone_number, dob, story, gender, new, deleted, jail_time, stress_level FROM characters WHERE owner = @owner]]
    local v = {["owner"] = hexId}

    exports.ghmattimysql:execute(q,v, function(results)
        if not user then callback(false, true) print('we have error') return end
        results = results[1] and results or {}
        callback(results)
    end)
end

function SRP.DB.DeleteCharacter(self, user, id, callback)
    callback = callback and callback or function() return end

    if not user then callback(false, true) return end

    local hexId = user:getVar("hexid")

    if not hexId or hexId == "" then callback(false, true) return end
    if not id or type(id) ~= "number" then callback(false, true) return end

    local q = [[DELETE FROM characters WHERE owner = @hexid and id = @id;]]
    local v = {
        ["hexid"] = hexId,
        ["id"] = id
    }

    exports.ghmattimysql:execute(q, v, function(rowsChanged)
    if not rowsChanged.changedRows then callback(false, true) return end

    local deleted = rowsChanged and true or false

    callback(deleted)
     end)
end

-- function SRP.DB.DeleteCharacter(self, user, id, callback)
--     callback = callback and callback or function() return end

--     if not user then callback(false, true) return end

--     local hexId = user:getVar("hexid")

--     if not hexId or hexId == "" then callback(false, true) return end
--     if not id or type(id) ~= "number" then callback(false, true) return end

--     local q = [[UPDATE characters SET deleted = 1, deleteion_data = NOW() WHERE owner = @hexid and id = @id;]]
--     local v = {
--         ["hexid"] = hexId,
--         ["id"] = id
--     }

--     exports.ghmattimysql:execute(q, v, function(rowsChanged)
--     if not rowsChanged.changedRows then callback(false, true) return end

--     local deleted = rowsChanged and true or false

--     callback(deleted)
--      end)
-- end

function SRP.DB.UpdateCharacterStressLevel(self, user, characterId, newLevel, callback)
    callback = callback and callback or function() return end
    if not user then callback(false,true) return end
    if not characterId or type(characterId) ~= "number" then callback(false, true) return end

    if not user:ownsCharacter(characterId) then callback(false, true) return end

    local hexId = user:getVar("hexid")
    if not hexId or hexId == "" then callback(false, true) return end

    local q = [[UPDATE characters SET stress_level = @stress_level WHERE owner = @hexid AND id = @characterId;]]
    local v = {
        ["stress_level"] = newLevel,
        ["hexid"] = hexId,
        ["characterId"] = characterId
    }
    exports.ghmattimysql:execute(q, v, function(rowsChanged)
        if not rowsChanged.changedRows then callback(true,false) return end
        local updated = rowsChanged and true or false
        callback(updated)
    end)
end


function SRP.DB.UpdateCharacterDirtyMoney(self, user, characterId, amount, callback)
callback = callback and callback or function() return end
    if not user then callback(false,true) return end
    if not characterId or type(characterId) ~= "number" then callback(false, true) return end

    if not user:ownsCharacter(characterId) then callback(false, true) return end

    local hexId = user:getVar("hexid")
    if not hexId or hexId == "" then callback(false, true) return end

    local q = [[UPDATE characters SET dirty_money = @dirty_money WHERE owner = @hexid AND id = @characterId;]]
    local v = {
        ["dirty_money"] = amount,
        ["hexid"] = hexId,
        ["characterId"] = characterId
    }
    exports.ghmattimysql:execute(q, v, function(rowsChanged)
        if not rowsChanged.changedRows then callback(false, true) return end
        local updated = rowsChanged and true or false
        callback(updated)
    end)
end


function SRP.DB.UpdateCharacterMoney(self, user, characterId, amount, callback)
    callback = callback and callback or function() return end
        if not user then callback(false,true) return end
        if not characterId or type(characterId) ~= "number" then callback(false, true) return end
    
        if not user:ownsCharacter(characterId) then callback(false, true) return end
    
        local hexId = user:getVar("hexid")
        if not hexId or hexId == "" then callback(false, true) return end
    
        local q = [[UPDATE characters SET cash = @cash WHERE owner = @hexid AND id = @characterId;]]
        local v = {
            ["cash"] = amount,
            ["hexid"] = hexId,
            ["characterId"] = characterId
        }
        exports.ghmattimysql:execute(q, v, function(rowsChanged)
            if not rowsChanged.changedRows then callback(false, true) return end
            local updated = rowsChanged and true or false
            callback(updated)
        end)
end

function SRP.DB.UpdateCharacterBank(self, user, characterId, amount, callback)
    callback = callback and callback or function() return end
        if not user then callback(false,true) return end
        if not characterId or type(characterId) ~= "number" then callback(false, true) return end
    
        if not user:ownsCharacter(characterId) then callback(false, true) return end
    
        local hexId = user:getVar("hexid")
        if not hexId or hexId == "" then callback(false, true) return end
    
        local q = [[UPDATE characters SET bank = @bank WHERE owner = @hexid AND id = @characterId;]]
        local v = {
            ["bank"] = amount,
            ["hexid"] = hexId,
            ["characterId"] = characterId
        }
        exports.ghmattimysql:execute(q, v, function(rowsChanged)
            if not rowsChanged.changedRows then callback(false, true) return end
            local updated = rowsChanged and true or false
            callback(updated)
        end)
end

function SRP.DB.UpdateControls(self, src, controlsTable, callback)
    callback = callback and callback or function() return end
        local user = exports["srp-base"]:getModule("Player"):GetUser(src)
        if not user then callback(false,true) return end
    
        local hexId = user:getVar("hexid")
        if not hexId or hexId == "" then callback(false, true) return end
    
        local q = [[UPDATE users SET controls = @controls WHERE hex_id = @hexid;]]
        local v = {
            ["controls"] = json.encode(controlsTable),
            ["hexid"] = hexId
        }
        exports.ghmattimysql:execute(q, v, function(rowsChanged)
            if not rowsChanged.changedRows then callback(false, true) return end
            local updated = rowsChanged and true or false
            callback(updated)
        end)
end


function SRP.DB.GetControls(self, src, callback)
    callback = callback and callback or function() return end
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
        Citizen.Wait(3000)
        if not user then callback(false, true) return end

        local hexId = user:getVar("hexid")

        if not hexId or hexid == "" then callback(false, true) return end

        local q = [[SELECT controls FROM users WHERE hex_id = @hex_id;]]
        local v = {["hex_id"] = hexid}

        exports.ghmattimysql:execute(q,v, function(results)
            if not user then callback(false, true) return end
            results = results[1] and results or {}
            callback(results)
        end)
end

    
function SRP.DB.UpdateSettings(self, src, settingsTable, callback)
    callback = callback and callback or function() return end
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
        if not user then callback(false,true) return end
    
        local hexId = user:getVar("hexid")
        if not hexId or hexId == "" then callback(false, true) return end
    
        local q = [[UPDATE users SET settings = @settings WHERE hex_id = @hexid;]]
        local v = {
            ["settings"] = json.encode(settingsTable),
            ["hexid"] = hexId
        }
        exports.ghmattimysql:execute(q, v, function(rowsChanged)
            if not rowsChanged.changedRows then callback(false, true) return end
            local updated = rowsChanged and true or false
            callback(updated)
        end)
end


function SRP.DB.GetSettings(self, src, callback)
    callback = callback and callback or function() return end
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    if not user then callback(false, true) return end

    local hexId = user:getVar("hexid")

    if not hexId or hexid == "" then callback(false, true) return end

    local q = [[SELECT settings FROM users WHERE hex_id =@id;]]
    local v = {["id"] = hexid}

    exports.ghmattimysql:execute(q,v, function(results)
        if not user then callback(false, true) return end
        results = results[1] and results or {}
        callback(results)
    end)
end
