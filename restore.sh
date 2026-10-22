#!/usr/bin/env bash
# Sony Bravia KD-55XF8096 — reactivar paquetes desactivados con uninstall.sh
# Uso: TV_HOST=192.168.x.x bash restore.sh
#
# NOTA: Solo reactiva los paquetes desactivados con pm disable-user.
# Los desinstalados con pm uninstall --user 0 NO son recuperables sin reset de fábrica:
#   com.vodafone.vtv.atv.es, com.netflix.ninja, com.amazon.amazonvideo.livingroom,
#   com.disney.disneyplus, com.youview.tv.servicehost, com.sony.dtv.tvxlauncher.titlelist,
#   com.sony.dtv.scrums.action, com.sony.dtv.smartmediaapp

set -euo pipefail
HOST="${TV_HOST:?Falta TV_HOST: TV_HOST=192.168.x.x bash restore.sh}"
ADB="adb -s ${HOST}:5555"

echo "Conectando a ${HOST}:5555..."
adb connect "${HOST}:5555"
echo ""

enable() {
  echo "  reactivando $1"
  $ADB shell pm enable "$1" 2>/dev/null || echo "  (no encontrado o ya activo: $1)"
}

echo "=== Spyware y ACR ==="
enable tv.samba.ssm
enable com.qterics.da.product

echo ""
echo "=== Sony bloatware y telemetría ==="
enable com.sony.dtv.promos
enable com.sony.dtv.sonybugreportsys
enable com.sony.dtv.demomode
enable com.sony.dtv.demosupport
enable com.sony.dtv.customersupport
enable com.sony.dtv.smarthelp
enable com.sony.dtv.imanual
enable com.sony.dtv.multiscreendemo
enable com.sony.dtv.sonyloglevelsettingsys
enable com.sony.dtv.sonyloglevelsettingvnd
enable com.sony.dtv.youview
enable com.sony.dtv.da.service
enable com.sony.dtv.sonyselect
enable com.sony.dtv.sonyselect.overlay
enable com.sony.dtv.smarthomesettings
enable com.sony.dtv.b2b.hotelmode
enable com.sony.dtv.b2b.rs232csupport
enable com.sony.dtv.b2b.vendorprotocol

echo ""
echo "=== Contenido patrocinado y feeds ==="
enable com.sony.dtv.discovery
enable com.sony.dtv.bivlinfo
enable com.sony.dtv.tvlaunchercustomizer
enable android.autoinstalls.config.sony.bravia

echo ""
echo "=== Google telemetría ==="
enable com.google.android.feedback
enable com.google.android.tvrecommendations
enable com.google.android.backdrop
enable com.google.android.tv.bugreportsender
enable com.google.android.marvin.talkback
enable com.google.android.videos
enable com.google.android.play.games
enable com.android.printspooler

echo ""
echo "Reiniciando launcher..."
$ADB shell am force-stop com.sony.dtv.tvx

echo ""
echo "Restauración completa (paquetes disable-user). Los 8 desinstalados con uninstall --user 0"
echo "solo se recuperan con un reset de fábrica del TV."
