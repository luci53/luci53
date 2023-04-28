fx_version 'cerulean'
game 'gta5'

description 'Inventory Duplication Detection Script'
version '1.0'

client_script 'client.lua'

server_scripts {
    'server.lua',
    '@mysql-async/lib/MySQL.lua' -- Replace with your MySQL library if needed
}

dependencies {
    'qb-core' -- Replace with your core framework if needed
}
