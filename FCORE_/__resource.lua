resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
dependency 'FCORE'

--Anticheat
client_script 'anticheat/client.lua'
server_script 'anticheat/server.lua'
--Clothing
client_script 'clothing/client.lua'
client_script 'clothing/config.lua'
server_script 'clothing/server.lua'
--Garages
client_script 'garages/client.lua'
server_script 'garages/server.lua'
--Inventory
client_script 'inventory/client.lua'
client_script 'inventory/locksystem.lua'
server_script 'inventory/server.lua'
--Item stores
client_script 'item_stores/client.lua'
server_script 'item_stores/server.lua'
--Jail system
client_script 'jail_system/client.lua'
server_script 'jail_system/server.lua'
--Jobs
client_script 'jobs/towing/client.lua'
server_script 'jobs/towing/server.lua'
--Los Santos Customs
client_script 'lscustoms/client.lua'
server_script 'lscustoms/server.lua'
--Vehicle rentals
client_script 'vehicle_rentals/client.lua'
server_script 'vehicle_rentals/server.lua'
--Vehicle stores
client_script 'vehicle_stores/client.lua'
server_script 'vehicle_stores/server.lua'
--Weapon system
client_script 'weapon_system/licenses/client.lua'
server_script 'weapon_system/licenses/server.lua'

client_script 'weapon_system/stores/client.lua'
server_script 'weapon_system/stores/server.lua'
--Utilities
client_script 'utilities/fuel/client.lua'
server_script 'utilities/fuel/server.lua'

client_script 'utilities/gui.lua'
client_script 'utilities/utils.lua'

client_script 'utilities/hunger/client.lua'

client_script 'utilities/ipls/client.lua'
server_script 'utilities/ipls/server.lua'

client_script 'utilities/weapon_remover/client.lua'
server_script 'utilities/weapon_remover/server.lua'

client_script 'utilities/alerts/client.lua'
server_script 'utilities/alerts/server.lua'
--Exports

--Inventory
export 'GetItemQuantity'
export 'isFull'
--Hunger bars
export 'getBars'
-- Jobs/Towing
export 'GetActiveTows'