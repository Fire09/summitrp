let DroppedInventories = [];
let InUseInventories = [];
let DataEntries = 0;
let hasBrought = [];
let CheckedDeginv = [];
const DROPPED_ITEM_KEEP_ALIVE = 1000 * 60 * 15;

function clean() {
    for (let Row in DroppedInventories) {
        if (new Date(DroppedInventories[Row].lastUpdated + DROPPED_ITEM_KEEP_ALIVE).getTime() < Date.now() && DroppedInventories[Row].used && !InUseInventories[DroppedInventories[Row].name]) {
            emitNet("Inventory-Dropped-Remove", -1, [DroppedInventories[Row].name])
            delete DroppedInventories[Row];
        }
    }
}

setInterval(clean, 20000)


function db(string) {
    exports["mysql-async"].mysql_execute(string, {}, function(result) {});
}


RegisterServerEvent("server-remove-item")
onNet("server-remove-item", async (player, itemidsent, amount, openedInv) => {
    functionRemoveAny(player, itemidsent, amount, openedInv)
});

RegisterServerEvent("server-update-item")
onNet("server-update-item", async (player, itemidsent, slot, data) => {
    let src = source
    let playerinvname = 'ply-' + player
    let string = `UPDATE user_inventory2 SET information='${data}' WHERE item_id='${itemidsent}' and name='${playerinvname}' and slot='${slot}'`

    exports["mysql-async"].mysql_execute(string, {}, function() {
        emit("server-request-update-src", player, src)

    });
});

function functionRemoveAny(player, itemidsent, amount, openedInv) {
    let src = source
    let playerinvname = 'ply-' + player
    let string = `DELETE FROM user_inventory2 WHERE name='${playerinvname}' and item_id='${itemidsent}' LIMIT ${amount}`

    exports["mysql-async"].mysql_execute(string, {}, function() {
        emit("server-request-update-src", player, src)
    });

}

RegisterServerEvent("request-dropped-items")
onNet("request-dropped-items", async (player) => {
    let src = source;
    emitNet("requested-dropped-items", src, JSON.stringify(Object.assign({}, DroppedInventories)));
});

RegisterServerEvent("server-request-update")
onNet("server-request-update", async (player) => {
    let src = source
    let playerinvname = 'ply-' + player
    let string = `SELECT count(item_id) as amount, id, item_id, name, information, slot, dropped FROM user_inventory2 WHERE name = 'ply-${player}' group by item_id`;
    exports["mysql-async"].mysql_fetch_all(string, {}, function(inventory) {
        emitNet("inventory-update-player", src, [inventory, 0, playerinvname]);

    });
});

RegisterServerEvent("inventory-degItem")
onNet("inventory-degItem", async (itemID) => {
    let amount = 4000000
    exports["mysql-async"].mysql_execute(`UPDATE user_inventory2 set creationDate = ${amount} WHERE id = ${itemID}`, {}, function() {});
});


RegisterServerEvent("server-request-update-src")
onNet("server-request-update-src", async (player, src) => {

    let playerinvname = 'ply-' + player
    let string = `SELECT count(item_id) as amount, item_id, id, name, information, slot, dropped, creationDate, MIN(creationDate) as creationDate, quality FROM user_inventory2 WHERE name = '${playerinvname}' group by item_id`; // slot
    exports["mysql-async"].mysql_fetch_all(string, {}, function(inventory) {
        emitNet("inventory-update-player", src, [inventory, 0, playerinvname]);
    });
});

function makeid(length) {
    var result = '';
    var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghikjlmnopqrstuvwxyz'; //abcdef
    var charactersLength = characters.length;
    for (var i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

function GenerateInformation(src, player, itemid, itemdata) {
    let data = Object.assign({}, itemdata);
    let returnInfo = "{}"
    return new Promise((resolve, reject) => {
        if (itemid == "") return resolve(returninfo);
        let timeout = 0;
        if (!isNaN(itemid)) {
            var identifier = Math.floor((Math.random() * 99999) + 1)
            if (itemdata && itemdata.fakeWeaponData) {
                identifier = Math.floor((Math.random() * 99999) + 1)
                identifier = identifier.toString()
            }

            // should I remove that?
            let cartridgeCreated = makeid(3) + "-" + Math.floor((Math.random() * 999) + 1);
            returnInfo = JSON.stringify({
                cartridge: cartridgeCreated,
                serial: identifier
            })
            timeout = 1;
            clearTimeout(timeout)
            emit("serials:insert", src, cartridgeCreated)
            return resolve(returnInfo);
        } else if (Object.prototype.toString.call(itemid) === '[object String]') {
            switch (itemid.toLowerCase()) {
                case "idcard":
                    if (itemdata == itemdata.fake) {
                        returnInfo = JSON.stringify({
                            identifier: itemdata,
                            charID,
                            Name: itemdata.first.replace(/[^\w\s]/gi, ''),
                            Surname: itemdata.last.replace(/[^\w\s]/gi, ''),
                            Sex: itemdata.sex,
                            DOB: itemdata.dob
                        })
                        timeout = 1
                        clearTimeout(timeout)
                        return resolve(returnInfo);
                    } else {
                        let string = `SELECT first_name,last_name,gender,dob FROM characters WHERE id = '${player}'`;
                        exports.ghmattimysql.execute(string, {}, function(result) {
                            returnInfo = JSON.stringify({
                                identifier: player.toString(),
                                Name: result[0].first_name.replace(/[^\w\s]/gi, ''),
                                Surname: result[0].last_name.replace(/[^\w\s]/gi, ''),
                                Sex: result[0].gender,
                                DOB: result[0].dob
                            })
                            timeout = 1
                            clearTimeout(timeout)
                            return resolve(returnInfo);
                        });
                    }
                    break;
                case "casing":
                    returnInfo = JSON.stringify({
                        Identifier: itemdata.identifier,
                        type: itemdata.eType,
                        other: itemdata.other
                    })
                    timeout = 1
                    clearTimeout(timeout)
                    return resolve(returnInfo);
                case "evidence":
                    returnInfo = JSON.stringify({
                        Identifier: itemdata.identifier,
                        type: itemdata.eType,
                        other: itemdata.other
                    })
                    timeout = 1;
                    clearTimeout(timeout)
                    return resolve(returnInfo);
                case "ownerreceipt":
                    returnInfo = JSON.stringify({
                        Price: itemdata.Price,
                        Creator: itemdata.Creator,
                        Comment: itemdata.Comment
                    })
                    timeout = 1;
                    clearTimeout(timeout)
                    return resolve(returnInfo);
                case "receipt":
                    returnInfo = JSON.stringify({
                        Price: itemdata.Price,
                        Creator: itemdata.Creator,
                        Comment: itemdata.Comment
                    })
                    timeout = 1;
                    clearTimeout(timeout)
                    return resolve(returnInfo);
                }
        } else {
            return resolve(returnInfo);q
        }

        setTimeout(() => {
            if (timeout == 0) {
                return resolve(returnInfo);
            }
        }, 500)
    });
}

RegisterServerEvent("server-inventory-give")
onNet("server-inventory-give", async (player, itemid, slot, amount, generateInformation, itemdata, openedInv) => {

    let src = source
    let playerinvname = 'ply-' + player
    let information = "{}"
    let creationDate = Date.now()

    if (itemid == "idcard") {
        information = await GenerateInformation(src, player, itemid, itemdata)
    }

    if (itemid == "evidence") {
        information = await GenerateInformation(src, player, itemid, itemdata)
    }

    if (itemid == "ownerreceipt") {
        information = await GenerateInformation(src, player, itemid, itemdata)
    }
    
    if (itemid == "receipt") {
        information = await GenerateInformation(src, player, itemid, itemdata)
    }

    let values = `('${playerinvname}','${itemid}','${information}','${slot}','${creationDate}')`
    if (amount > 1) {
        for (let i = 2; i <= amount; i++) {
            values = values + `,('${playerinvname}','${itemid}','${information}','${slot}','${creationDate}')`

        }
    }

    let query = `INSERT INTO user_inventory2 (name,item_id,information,slot,creationDate) VALUES ${values};`
    exports["mysql-async"].mysql_execute(query, {}, function() {
        emit("server-request-update-src", player, src)
    });

});


RegisterServerEvent("server-inventory-refresh")
onNet("server-inventory-refresh", async (player, sauce) => {
    let src = source
    if (!src) {
        src = sauce
    }

    let string = `SELECT count(item_id) as amount, id, name, item_id, information, slot, dropped,quality, creationDate FROM user_inventory2 where name= 'ply-${player}' group by slot`;
    exports["mysql-async"].mysql_fetch_all(string, {}, function(inventory) {
        if (!inventory) {} else {
            var invArray = inventory;
            var arrayCount = 0;
            var playerinvname = player
            emitNet("inventory-update-player", src, [invArray, arrayCount, playerinvname]);
            emitNet('current-items', src, invArray)
        }
    })
})

RegisterServerEvent("server-inventory-open")
onNet("server-inventory-open", async (coords, player, secondInventory, targetName, itemToDropArray, sauce) => {

    let src = source

    if (!src) {
        src = sauce
    }

    let playerinvname = 'ply-' + player

    if (InUseInventories[targetName] || InUseInventories[playerinvname]) {

        if (InUseInventories[playerinvname]) {
            if ((InUseInventories[playerinvname] != player)) {
                return
            } else {

            }
        }
        if (InUseInventories[targetName]) {
            if (InUseInventories[targetName] == player) {

            } else {
                secondInventory = "69"
            }
        }
    }
    let string = `SELECT count(item_id) as amount, id, name, item_id, information, slot, dropped,  quality, creationDate FROM user_inventory2 where name= 'ply-${player}'  group by slot`;

    exports["mysql-async"].mysql_fetch_all(string, {}, function(inventory) {

        var invArray = inventory;
        var i;
        var arrayCount = 0;

        InUseInventories[playerinvname] = player;

    //    emitNet('current-items', src, invArray)

        if (secondInventory == "1") {

            var targetinvname = targetName

            let string = `SELECT count(item_id) as amount, id, name, item_id, information, slot, dropped, creationDate FROM user_inventory2 WHERE name = '${targetinvname}' group by slot`;
            exports["mysql-async"].mysql_fetch_all(string, {}, function(inventory2) {
                emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, inventory2, 0, targetinvname, 500, true]);

                InUseInventories[targetinvname] = player
            });
        } else if (secondInventory == "3") {

            let Key = "" + DataEntries + "";
            let NewDroppedName = 'Drop-' + Key;

            DataEntries = DataEntries + 1
            var invArrayTarget = [];
            DroppedInventories[NewDroppedName] = {
                position: {
                    x: coords[0],
                    y: coords[1],
                    z: coords[2]
                },
                name: NewDroppedName,
                used: false,
                lastUpdated: Date.now()
            }


            InUseInventories[NewDroppedName] = player;

            invArrayTarget = JSON.stringify(invArrayTarget)
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, invArrayTarget, 0, NewDroppedName, 500, false]);

        } else if (secondInventory == "13") {

            let Key = "" + DataEntries + "";
            let NewDroppedName = 'Drop-' + Key;
            DataEntries = DataEntries + 1
            for (let Key in itemToDropArray) {
                for (let i = 0; i < itemToDropArray[Key].length; i++) {
                    let objectToDrop = itemToDropArray[Key][i];
                    db(`UPDATE user_inventory2 SET slot='${i+1}', name='${NewDroppedName}', dropped='1' WHERE name='${Key}' and slot='${objectToDrop.faultySlot}' and item_id='${objectToDrop.faultyItem}' `);
                }
            }

            DroppedInventories[NewDroppedName] = {
                position: {
                    x: coords[0],
                    y: coords[1],
                    z: coords[2]
                },
                name: NewDroppedName,
                used: false,
                lastUpdated: Date.now()
            }
            emitNet("Inventory-Dropped-Addition", -1, DroppedInventories[NewDroppedName])

        } else if (secondInventory == "2") {

            var targetinvname = targetName;
            var shopArray = ConvenienceStore();
            var shopAmount = 14;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);

        } else if (secondInventory == "4") {
            var targetinvname = targetName;
            var shopArray = HardwareStore();
            var shopAmount = 12;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "5") {
            var targetinvname = targetName;
            var shopArray = GunStore();
            var shopAmount = 5;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "6") {
            var targetinvname = targetName;
            var shopArray = GunStore2();
            var shopAmount = 5;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "10") {
            var targetinvname = targetName;
            var shopArray = PoliceArmory();
            var shopAmount = 16;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "15") {
            var targetinvname = targetName;
            var shopArray = EMT();
            var shopAmount = 13;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "14") {
            var targetinvname = targetName;
            var shopArray = courthouse();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "18") {
            var targetinvname = targetName;
            var shopArray = TacoTruck();
            var shopAmount = 14;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "22") {
            var targetinvname = targetName;
            var shopArray = JailFood();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "25") {
            var targetinvname = targetName;
            var shopArray = JailMeth();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "12") {
            var targetinvname = targetName;
            var shopArray = burgiestore();
            var shopAmount = 8;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "897") {
            var targetinvname = targetName;
            var shopArray = burgershot();
            var shopAmount = 5;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "654") {
            var targetinvname = targetName;
            var shopArray = burgershotorder();
            var shopAmount = 6;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "600") {
            var targetinvname = targetName;
            var shopArray = policeveding();
            var shopAmount = 9;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "27") {
            var targetinvname = targetName;
            var shopArray = Mechanic();
            var shopAmount = 6;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "103") {
            var targetinvname = targetName;
            var shopArray = recycle();
            var shopAmount = 9;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "31") {
            var targetinvname = targetName;
            var shopArray = Blackmarket();
            var shopAmount = 5;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "998") {
            var targetinvname = targetName;
            var shopArray = slushy();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "921") {
            var targetinvname = targetName;
            var shopArray = asslockpick();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "26") {
            var targetinvname = targetName;
            var shopArray = assphone();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "28") {
            var targetinvname = targetName;
            var shopArray = Tuner();
            var shopAmount = 4;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "548") {
            var targetinvname = targetName;
            var shopArray = sodavend();
            var shopAmount = 2;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "549") {
            var targetinvname = targetName;
            var shopArray = coffeevend();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "550") {
            var targetinvname = targetName;
            var shopArray = foodvend();
            var shopAmount = 4;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "551") {
            var targetinvname = targetName;
            var shopArray = watervend();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "714") {
            var targetinvname = targetName;
            var shopArray = smelter();
            var shopAmount = 1;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "699") {
            var targetinvname = targetName;
            var shopArray = weapons();
            var shopAmount = 6;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "421") {
            var targetinvname = targetName;
            var shopArray = warehousecraft();
            var shopAmount = 5;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "422") {
            var targetinvname = targetName;
            var shopArray = gundealershop();
            var shopAmount = 3;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "997") {
            var targetinvname = targetName;
            var shopArray = prison();
            var shopAmount = 7;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "99") {
            var targetinvname = targetName;
            var shopArray = bestbuds();
            var shopAmount = 5;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "1311") {
            var targetinvname = targetName;
            var shopArray = BeanMachineOrder();
            var shopAmount = 6;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "1312") {
            var targetinvname = targetName;
            var shopArray = BeanMachineCraft();
            var shopAmount = 5;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "420") {
            var targetinvname = targetName;
            var shopArray = gangstore();
            var shopAmount = 3;
            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else if (secondInventory == "7") {
            var targetinvname = targetName;
            var shopArray = DroppedItem(itemToDropArray);

            itemToDropArray = JSON.parse(itemToDropArray)
            var shopAmount = itemToDropArray.length;

            emitNet("inventory-open-target", src, [invArray, arrayCount, playerinvname, shopArray, shopAmount, targetinvname, 500, false]);
        } else {
            emitNet("inventory-update-player", src, [invArray, arrayCount, playerinvname]);
        }
    });
});



RegisterServerEvent("server-inventory-close")
onNet("server-inventory-close", async (player, targetInventoryName) => {
    let src = source

    //line 647
    if (targetInventoryName.startsWith("Trunk"))
        emitNet("toggle-animation", src, false);
    InUseInventories = InUseInventories.filter(item => item != player);
    if (targetInventoryName.indexOf("Drop") > -1 && DroppedInventories[targetInventoryName]) {
        if (DroppedInventories[targetInventoryName].used === false) {
            delete DroppedInventories[targetInventoryName];
        } else {
            let string = `SELECT count(item_id) as amount, item_id, name, information, slot, dropped FROM user_inventory2 WHERE name='${targetInventoryName}' group by item_id `;
            exports["mysql-async"].mysql_fetch_all(string, {}, function(result) {
                if (result.length == 0 && DroppedInventories[targetInventoryName]) {
                    delete DroppedInventories[targetInventoryName];
                    emitNet("Inventory-Dropped-Remove", -1, [targetInventoryName])
                }
            });
        }
    }
    emit("server-request-update-src", player, source)
});


RegisterServerEvent("server-inventory-remove")
onNet("server-inventory-remove-slot", async (player, itemidsent, amount, slot) => {
    var playerinvname = 'ply-' + player
    db(`DELETE FROM user_inventory2 WHERE name='${playerinvname}' and item_id='${itemidsent}' and slot='${slot}' LIMIT ${amount}`);
});

RegisterServerEvent("server-ragdoll-items")
onNet("server-ragdoll-items", async (player) => {
    let currInventoryName = `ply-${player}`
    let newInventoryName = `wait-${player}`
    db(`UPDATE user_inventory2 SET name='${newInventoryName}', WHERE name='${currInventoryName}' and dropped=0 and item_id="mobilephone" `);
    db(`UPDATE user_inventory2 SET name='${newInventoryName}', WHERE name='${currInventoryName}' and dropped=0 and item_id="idcard" `);
    await db(`DELETE FROM user_inventory2 WHERE name='${currInventoryName}'`);
    db(`UPDATE user_inventory2 SET name='${currInventoryName}', WHERE name='${newInventoryName}' and dropped=0`);
});

RegisterServerEvent('server-jail-item')
onNet("server-jail-item", async (player, isSentToJail) => {
    let currInventoryName = `${player}`
    let newInventoryName = `${player}`

    if (isSentToJail) {
        currInventoryName = `jail-${player}`
        newInventoryName = `${player}`
    } else {
        currInventoryName = `${player}`
        newInventoryName = `jail-${player}`
    }

    db(`UPDATE user_inventory2 SET name='${currInventoryName}' WHERE name='${newInventoryName}' and dropped=0`);
});

function removecash(pSrc, amount) {
    emit('cash:remove', pSrc, amount)
}


setTimeout(CleanDroppedInventory, 5)



function DroppedItem(itemArray) {
    itemArray = JSON.parse(itemArray)
    var shopItems = [];

    shopItems[0] = {
        item_id: itemArray[0].itemid,
        id: 0,
        name: "shop",
        information: "{}",
        slot: 1,
        amount: itemArray[0].amount
    };

    return JSON.stringify(shopItems);
}

function BuildInventory(Inventory) {
    let buildInv = Inventory
    let invArray = {};
    itemCount = 0;
    for (let i = 0; i < buildInv.length; i++) {
        invArray[itemCount] = {
            item_id: buildInv[i].item_id,
            id: buildInv[i].id,
            name: buildInv[i].name,
            information: buildInv[i],
            slot: buildInv[i].slot
        };
        itemCount = itemCount + 1
    }
    return [JSON.stringify(invArray), itemCount]
}

function mathrandom(min, max) {
    return Math.floor(Math.random() * (max + 1 - min)) + min;
}


const DEGREDATION_INVENTORY_CHECK = 1000 * 60 * 60;
const DEGREDATION_TIME_BROKEN = 1000 * 60 * 40320;
const DEGREDATION_TIME_WORN = 1000 * 60 * 201000;



RegisterServerEvent("server-inventory-move")
onNet("server-inventory-move", async (player, data, coords) => {
    let src = source
    let targetslot = data[0]
    let startslot = data[1]
    let targetName = data[2].replace(/"/g, "");
    let startname = data[3].replace(/"/g, "");
    let purchase = data[4]
    let itemCosts = data[5]
    let itemidsent = data[6]
    let amount = data[7]
    let crafting = data[8]
    let isWeapon = data[9]
    let PlayerStore = data[10]
    let creationDate = Date.now()

    if ((targetName.indexOf("Drop") > -1 || targetName.indexOf("hidden") > -1) && DroppedInventories[targetName]) {

        if (DroppedInventories[targetName].used === false) {

            DroppedInventories[targetName] = {
                position: {
                    x: coords[0],
                    y: coords[1],
                    z: coords[2]
                },
                name: targetName,
                used: true,
                lastUpdated: Date.now()
            }
            emitNet("Inventory-Dropped-Addition", -1, DroppedInventories[targetName])
        }
    }

    let info = "{}"

    if (purchase) {
        if (isWeapon) {


        }
        info = await GenerateInformation(src, player, itemidsent)
        removecash(src, itemCosts)

        if (!PlayerStore) {
            for (let i = 0; i < parseInt(amount); i++) {

                db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetName}','${info}','${targetslot}','${creationDate}' );`);
            }
        } else if (crafting) {

            info - await GenerateInformation(src, player, itemidsent)
            for (let i = 0; i < parseInt(amount); i++) {
                db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetName}','${info}','${targetslot}','${creationDate}' );`);
            }
        } else {
            if (targetName.indexOf("Drop") > -1 || targetName.indexOf("hidden") > -1) {

                db(`INSERT INTO user_inventory2 SET slot='${targetslot}', name='${targetName}', dropped='1' WHERE slot='${startslot}' AND name='${startname}'`);

            } else {
                db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetName}', dropped='0' WHERE slot='${startslot}' and name='${startname}'`);

            }
        }
    } else {

        if (crafting == true) {
            info - await GenerateInformation(src, player, itemidsent)
            for (let i = 0; i < parseInt(amount); i++) {
                db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetName}','${info}','${targetslot}','${creationDate}' );`);
            }
        }

        db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetName}', dropped='0' WHERE slot='${startslot}' and name='${startname}'`);

    }
});


function CleanDroppedInventory() {
    onNet("server-ragdoll-items", async (player) => {
        let currInventoryName = `ply-${player}`
        let newInventoryName = player
        db(`UPDATE user_inventory2 SET name='${newInventoryName}', WHERE name='${currInventoryName}' and dropped=0 and item_id="mobilephone" `);
        db(`UPDATE user_inventory2 SET name='${newInventoryName}', WHERE name='${currInventoryName}' and dropped=0 and item_id="idcard" `);
        db(`UPDATE user_inventory2 SET name='${currInventoryName}', WHERE name='${newInventoryName}' and dropped=0`);
    })
};

RegisterServerEvent("server-inventory-stack")
onNet("server-inventory-stack", async (player, data, coords) => {
    let targetslot = data[0]
    let moveAmount = data[1]
    let targetName = data[2].replace(/"/g, "");
    let src = source
    let originSlot = data[3]
    let originInventory = data[4].replace(/"/g, "");
    let purchase = data[5]
    let itemCosts = data[6]
    let itemidsent = data[7]
    let amount = data[8]
    let crafting = data[9]
    let isWeapon = data[10]
    let PlayerStore = data[11]
    let amountRemaining = data[12]
    let creationDate = Date.now()
    if ((targetName.indexOf("Drop") > -1 || targetName.indexOf("hidden") > -1) && DroppedInventories[targetName]) {

        if (DroppedInventories[targetName].used === false) {
            DroppedInventories[targetName] = {
                position: {
                    x: coords[0],
                    y: coords[1],
                    z: coords[2]
                },
                name: targetName,
                used: true,
                lastUpdated: Date.now()
            }
            emitNet("Inventory-Dropped-Addition", -1, DroppedInventories[targetName])
        }
    }

    let info = "{}"

    if (purchase) {

        if (isWeapon) {
            db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetName}','${info}','${targetslot}','${creationDate}' );`);

        }
        info = await GenerateInformation(src, player, itemidsent)
        removecash(src, itemCosts)

        if (!PlayerStore) {
            for (let i = 0; i < parseInt(amount); i++) {

                db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetName}','${info}','${targetslot}','${creationDate}' );`);


            }
        }

        if (PlayerStore) {

            db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetname}', dropped = '0' WHERE slot='${startslot}' AND name='${startname}'`);
        }


    } else if (crafting) {
        info = await GenerateInformation(src, player, itemidsent)
        for (let i = 0; i < parseInt(amount); i++) {

            db(`INSERT INTO user_inventory2 (item_id, name, information, slot, creationDate) VALUES ('${itemidsent}','${targetName}','${info}','${targetslot}','${creationDate}' );`);
        }
    } else {
        let string = `SELECT item_id, id FROM user_inventory2 WHERE slot='${originSlot}' and name='${originInventory}' LIMIT ${moveAmount}`;

        exports["mysql-async"].mysql_fetch_all(string, {}, function(result) {

            var itemids = "0"
            for (let i = 0; i < result.length; i++) {
                itemids = itemids + "," + result[i].id
            }

            if (targetName.indexOf("Drop") > -1 || targetName.indexOf("hidden") > -1) {
                db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetName}', dropped='1' WHERE id IN (${itemids})`);

            } else {
                db(`UPDATE user_inventory2 SET slot='${targetslot}', name='${targetName}', dropped='0' WHERE id IN (${itemids})`);
            }
        });
    }
});

RegisterServerEvent("server-inventory-swap")
onNet("server-inventory-swap", (player, data, coords) => {
    let targetslot = data[0]
    let targetname = data[1].replace(/"/g, "");
    let startslot = data[2]
    let startname = data[3].replace(/"/g, "");

    let string = `SELECT id FROM user_inventory2 WHERE slot='${targetslot}' AND name='${targetname}'`;

    exports["mysql-async"].mysql_fetch_all(string, {}, function(startid) {
        var itemids = "0"
        for (let i = 0; i < startid.length; i++) {
            itemids = itemids + "," + startid[i].id

        }

        let string = false;
        if (targetname.indexOf("Drop") > -1 || targetname.indexOf("hidden") > -1) {
            string = `UPDATE user_inventory2 SET slot='${targetslot}', name ='${targetname}', dropped='1' WHERE slot='${startslot}' AND name='${startname}'`;
        } else {
            string = `UPDATE user_inventory2 SET slot='${targetslot}', name ='${targetname}', dropped='0' WHERE slot='${startslot}' AND name='${startname}'`;
        }

        exports["mysql-async"].mysql_execute(string, {}, function(inventory) {
            if (startname.indexOf("Drop") > -1 || startname.indexOf("hidden") > -1) {
                db(`UPDATE user_inventory2 SET slot='${startslot}', name='${startname}', dropped='1' WHERE id IN (${itemids})`);
            } else {
                db(`UPDATE user_inventory2 SET slot='${startslot}', name='${startname}', dropped='0' WHERE id IN (${itemids})`);
            }
        });
    });
});



function deleteHidden() {
    db(`DELETE FROM user_inventory2 WHERE name like '%Hidden%' OR name like '%trash%'`)
}

function deleteHiddenHandler() {
    setTimeout(250000, deleteHidden())
}


RegisterServerEvent("inv:playerSpawned")
onNet("inv:playerSpawned", () => {
    db(`DELETE FROM user_inventory2 WHERE name like '%Drop%' OR name like '%Hidden%' OR name like '%trash-1%'`)
    db(`DELETE FROM user_inventory2 WHERE quality like '0'`)
    console.log("[srp-inventory] Drops & broken items were deleted.")
});