-- Manifest
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- General
client_scripts {
  'main_client.lua',
  'functions_client.lua',
  'gui.lua',
  'menu.lua',
  'garage_menus.lua',
  'armoury_menu.lua',
  'mission_client.lua',
  'customisation.lua',
  'spawnstuff.lua',
  'teleporter_client.lua',
}

server_scripts {
  'main_server.lua',
  'functions_server.lua',
  'mission_server.lua',
  'teleporter_server.lua',
}

export 'getIsInService'
export 'getIsCuffed'
export 'getParamedicRank'