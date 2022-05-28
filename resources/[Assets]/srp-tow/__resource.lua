resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

files {
    'carvariations.meta',
    'carcols.meta'
}

data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'

client_script {
    'towlivery_names.lua'
}