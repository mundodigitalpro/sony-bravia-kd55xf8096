#!/usr/bin/env bash
# Sony Bravia KD-55XF8096 — limpieza completa via ADB
# Uso: TV_HOST=192.168.x.x bash uninstall.sh
#
# Requiere ADB habilitado en el TV:
#   Ajustes → Información del dispositivo → Opciones para desarrolladores → Depuración ADB

set -euo pipefail
HOST="${TV_HOST:?Falta TV_HOST: TV_HOST=192.168.x.x bash uninstall.sh}"
ADB="adb -s ${HOST}:5555"

echo "Conectando a ${HOST}:5555..."
adb connect "${HOST}:5555"
echo ""

disable() {
  echo "  desactivando $1"
  $ADB shell pm disable-user "$1" 2>/dev/null || echo "  (ya desactivado o no existe: $1)"
}

uninstall() {
  echo "  desinstalando $1"
  $ADB shell pm uninstall --user 0 "$1" 2>/dev/null || echo "  (ya eliminado o no existe: $1)"
}

echo "=== Spyware y ACR ==="
disable tv.samba.ssm
disable com.qterics.da.product

echo ""
echo "=== Sony bloatware y telemetría ==="
disable com.sony.dtv.promos
disable com.sony.dtv.sonybugreportsys
disable com.sony.dtv.demomode
disable com.sony.dtv.demosupport
disable com.sony.dtv.customersupport
disable com.sony.dtv.smarthelp
disable com.sony.dtv.imanual
disable com.sony.dtv.multiscreendemo
disable com.sony.dtv.sonyloglevelsettingsys
disable com.sony.dtv.sonyloglevelsettingvnd
disable com.sony.dtv.youview
disable com.sony.dtv.da.service
disable com.sony.dtv.sonyselect
disable com.sony.dtv.sonyselect.overlay
disable com.sony.dtv.smarthomesettings
disable com.sony.dtv.b2b.hotelmode
disable com.sony.dtv.b2b.rs232csupport
disable com.sony.dtv.b2b.vendorprotocol

echo ""
echo "=== Contenido patrocinado y feeds ==="
disable com.sony.dtv.discovery
disable com.sony.dtv.bivlinfo
disable com.sony.dtv.tvlaunchercustomizer
disable android.autoinstalls.config.sony.bravia

echo ""
echo "=== Google telemetría ==="
disable com.google.android.feedback
disable com.google.android.tvrecommendations
disable com.google.android.backdrop
disable com.google.android.tv.bugreportsender
disable com.google.android.marvin.talkback
disable com.google.android.videos
disable com.google.android.play.games
disable com.android.printspooler

echo ""
echo "=== Apps de streaming (desinstalar) ==="
uninstall com.vodafone.vtv.atv.es
uninstall com.netflix.ninja
uninstall com.amazon.amazonvideo.livingroom
uninstall com.disney.disneyplus
uninstall com.youview.tv.servicehost

echo ""
echo "=== Anuncios del home (desinstalar) ==="
uninstall com.sony.dtv.tvxlauncher.titlelist
uninstall com.sony.dtv.scrums.action
uninstall com.sony.dtv.smartmediaapp

echo ""
echo "Reiniciando launcher..."
$ADB shell am force-stop com.sony.dtv.tvx

echo ""
echo "Listo. RAM disponible:"
$ADB shell cat /proc/meminfo | grep MemAvailable
