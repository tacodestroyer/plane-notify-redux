﻿# PowerShell script to generate .ini files for multiple ICAO codes
# Set the output directory (modify as needed)
$OutputDir = "./configs"

# Ensure the directory exists
if (!(Test-Path -Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir
}

# Prompt for ICAO codes (comma-separated)
$ICAOList = Read-Host "Enter ICAO codes (comma-separated)"

# Convert input to an array
$ICAOs = $ICAOList -split "," | ForEach-Object { $_.Trim() }

# Default INI template (modify as needed)
$iniTemplate = @"
[DATA]
#Plane to track, based off ICAO or ICAO24 which is the unique transponder address of a plane.
ICAO = {ICAO}


#Optional Per Plane Overrides
; OVERRIDE_REG= 
; OVERRIDE_ICAO_TYPE= 
; OVERRIDE_TYPELONG = 
; OVERRIDE_OWNER = 
; DATA_LOSS_MINS = 20
; CONCEAL_AC_ID = True
; CONCEAL_PIA = False

[MAP]
#Optional, map selection moved to mainconf, this is for map overlays per plane
#Tar1090 overlays option, should be seperated by comma no space, remove option all together to disable any
OVERLAYS = nexrad

[AIRPORT]
#Requires a list of airport types, this plane could land/takeoff at
#Choices: small_airport, medium_airport, large_airport, heliport, seaplane_base
TYPES = [small_airport, medium_airport, large_airport]

#TITLE for Twitter, PB and Discord are Just text added to the front of each message/tweet sent
[TWITTER]
ENABLE = FALSE
TITLE =
ACCESS_TOKEN = athere
ACCESS_TOKEN_SECRET = atshere

[DISCORD]
ENABLE = TRUE
#WEBHOOK URL https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks
URL = #Discord Webhook URL
#Role to tag optional, the role ID
ROLE_ID = 
Title = # Title of post from bot
USERNAME = # Discord username the bot will use when posting
THREAD_ID =  # Thread ID of thread you want to post in

[META]
ENABLE = False
FB_PAGE_ID =
IG_USER_ID =
ACCESS_TOKEN =


[TELEGRAM]
ENABLE = FALSE
TITLE = Title Of Telegram message
ROOM_ID = -100xxxxxxxxxx
BOT_TOKEN = xxxxxxxxxx:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

[MASTODON]
ENABLE = FALSE
ACCESS_TOKEN = mastodonaccesstoken
APP_URL = mastodonappurl
"@

# Loop through each ICAO and create an INI file
foreach ($ICAO in $ICAOs) {
    $iniFilePath = "$OutputDir/$ICAO.ini"

    if (Test-Path -Path $iniFilePath) {
        Write-Host "⚠️ Skipping $ICAO.ini (already exists)" -ForegroundColor Yellow
    } else {
        # Replace placeholder with ICAO code
        $iniContent = $iniTemplate -replace "{ICAO}", $ICAO

        # Ensure UTF-8 encoding WITHOUT BOM
        $UTF8NoBOM = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllLines($iniFilePath, $iniContent, $UTF8NoBOM)

        Write-Host "✅ Created: $ICAO.ini" -ForegroundColor Green
    }
}

Write-Host "🎉 INI file generation complete!"