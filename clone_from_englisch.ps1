# $TargetZipFileName = "~\Downloads\$(Split-Path -Path $PSScriptRoot -Leaf).zip"
# $compress = @{
#   Path             = "$PSScriptRoot\README.md", "$PSScriptRoot\CHANGELOG.md", "$PSScriptRoot\manifest.json", "$PSScriptRoot\icon.png", "$PSScriptRoot\config", "$PSScriptRoot\plugins"
#   CompressionLevel = "Fastest"
#   DestinationPath  = $TargetZipFileName
# }
# Compress-Archive @compress -Force

$PluginsFolder = "plugins"
$FilePrefixesAndFolders = @{
  "Datys_Professions" = "Krumpac-Datys_Professions";
  "Krumpac_Armors" = "Krumpac-Krumpac_Armors";
  "Krumpac_Building_Pieces" = "Krumpac-Krumpac_Building_Pieces";
  "Krumpac_Dungeon_Meadows" = "Krumpac-Krumpac_Dungeon_Meadows"; 
  "Krumpac_Reforge_Core" = "Krumpac-Krumpac_Reforge_Core"; 
  "Krumpac_Sacrificing_Altars" = "Krumpac-Krumpac_Sacrificing_Altars";
  "Krumpac_Tribe_Ornaments" = "Krumpac-Krumpac_Sacrificing_Altars";
  "Krumpac_Weapon_Arsenal" = "Krumpac-Krumpac_Weapon_Arsenal"
}
$TranslationsSubFolder = "translations"
$SourceLanguage = "English"
$FileSuffix = "yml"

foreach ($kv in $FilePrefixesAndFolders.GetEnumerator()){
  $CurrentFolder = "$PluginsFolder\" + $kv.Value + "\$TranslationsSubFolder"
  $CurrentInputFile = $kv.Name + ".$SourceLanguage.$FileSuffix"
  $CurrentInputFileRelative = "$CurrentFolder\$CurrentInputFile"
  $CurrentInputFileAbsolute = "$PSScriptRoot\$CurrentInputFileRelative"
  Write-Output($CurrentInputFileAbsolute)

  Get-Content $CurrentInputFileAbsolute | Where-Object { ! $_.StartsWith("#") } | Sort-Object | Get-Unique | Out-File "$CurrentInputFileAbsolute-tmp"
}

#Get-Content unsorted.txt | sort | get-unique > sorted.txt
