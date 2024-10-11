fx_version "cerulean"
use_fxv2_oal "yes"
lua54 "yes"
game "gta5"
version "1.0.0"
description "A simple carmenu system"
name 'krs_carmenu'
author "karos7804"

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script {
    'client/*.lua'
}

server_script {
    'server/*.lua'
}

files {
    'locales/*.json'
}

dependencies {
    'ox_lib'
}
