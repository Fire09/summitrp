this_is_a_map 'yes'

files {
	'gabztimecyclemods.xml',
	'shellprops.ytyp',
    'gabz_timecycle_mods_1.xml',
    'nutt_timecycle_mods_1.xml',
    'stream/irp-pillbox/interiorproxies.meta',
    'stream/burgershot/interiorproxies.meta',
    "gabz_mrpd_timecycle.xml",
    "iv_int_1_timecycle_mods_1.xml",
    'audio/ivbsoverride_game.dat151.rel',
    "peds.meta",
    "gardoor_game.dat151.rel",
}

data_file 'DLC_ITYP_REQUEST' 'shellprops.ytyp'
data_file 'TIMECYCLEMOD_FILE' 'gabztimecyclemods.xml'
data_file 'TIMECYCLEMOD_FILE' 'iv_int_1_timecycle_mods_1.xml'
data_file 'TIMECYCLEMOD_FILE' 'gabz_timecycle_mods_1.xml'
data_file 'TIMECYCLEMOD_FILE' 'nutt_timecycle_mods_1.xml'
data_file "INTERIOR_PROXY_ORDER_FILE" "interiorproxies.meta"
data_file 'INTERIOR_PROXY_ORDER_FILE' 'irp-pillbox/interiorproxies.meta'
data_file 'INTERIOR_PROXY_ORDER_FILE' 'burgershot/interiorproxies.meta'
data_file 'DLC_ITYP_REQUEST' 'stream/misc/shell-mansion/v_int_44.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/slbBuildings/def_props.ytyp'
data_file 'TIMECYCLEMOD_FILE' 'gabz_mrpd_timecycle.xml'
data_file 'AUDIO_GAMEDATA' 'audio/ivbsoverride_game.dat'
data_file "AUDIO_GAMEDATA" "gardoor_game.dat"
data_file "PED_METADATA_FILE" "peds.meta"


client_scripts {
    "client.lua",
}

fx_version 'adamant'
games { 'gta5' }