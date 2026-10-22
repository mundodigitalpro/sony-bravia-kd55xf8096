# Sony Bravia KD-55XF8096 — Debloat & Optimización

Guía completa para eliminar bloatware, spyware y anuncios de un **Sony Bravia KD-55XF8096** (2018, Android 8, firmware 5.4.0) mediante ADB desde Termux.

**Resultado:** +50–70 MB de RAM disponible en frío, sin anuncios en el home, sin telemetría.

Compatible con [cleanyourtv](https://github.com/Gathin23/cleanyourtv).

---

## Requisitos

| Herramienta | Cómo instalar |
|---|---|
| Termux (Android) | F-Droid o Play Store |
| ADB en Termux | `pkg install android-tools` |
| TV en la misma red WiFi | Configuración de red del TV |

**Activar ADB en el TV:**
1. `Ajustes` → `Información del dispositivo`
2. Pulsar varias veces sobre `Número de compilación` hasta activar opciones de desarrollador
3. `Opciones para desarrolladores` → activar **Depuración ADB**

---

## Opción A — Script automático

```bash
TV_HOST=192.168.x.x bash uninstall.sh
```

La primera vez el TV mostrará un diálogo de autorización — aceptar en pantalla.

## Opción B — Con cleanyourtv

```bash
git clone https://github.com/Gathin23/cleanyourtv
cd cleanyourtv
python3 -m venv tools/venv && tools/venv/bin/pip install -r tools/requirements.txt
TV_HOST=192.168.x.x tools/disable.sh /ruta/a/debloat.txt
```

## Opción C — Manual

```bash
adb connect 192.168.x.x:5555
adb -s 192.168.x.x:5555 shell
pm disable-user <paquete>   # reversible
pm uninstall --user 0 <paquete>   # no reversible sin reset de fábrica
```

---

## Qué se elimina

### Desactivado (reversible con `pm enable <paquete>`)

| Paquete | Descripción |
|---|---|
| `tv.samba.ssm` | Samba TV — ACR, identifica lo que ves en pantalla |
| `com.qterics.da.product` | Qterics device agent / analytics |
| `com.sony.dtv.promos` | My BRAVIA promos |
| `com.sony.dtv.da.service` | Sony device agent / soporte remoto |
| `com.sony.dtv.sonybugreportsys` | Subida de informes de error |
| `com.sony.dtv.demomode` | Modo demo de tienda |
| `com.sony.dtv.demosupport` | Soporte modo demo |
| `com.sony.dtv.customersupport` | Tile de soporte al cliente |
| `com.sony.dtv.smarthelp` | Ayuda interactiva |
| `com.sony.dtv.imanual` | Manual interactivo |
| `com.sony.dtv.multiscreendemo` | Demo multiscreen |
| `com.sony.dtv.sonyloglevelsettingsys` | Configuración nivel de log (sistema) |
| `com.sony.dtv.sonyloglevelsettingvnd` | Configuración nivel de log (vendor) |
| `com.sony.dtv.youview` | YouView (TV Reino Unido, inútil en España) |
| `com.sony.dtv.sonyselect` | Sony Select (tienda/promos) |
| `com.sony.dtv.smarthomesettings` | Configuración Alexa — arranca en cada inicio |
| `com.sony.dtv.b2b.hotelmode` | Modo hotel |
| `com.sony.dtv.b2b.rs232csupport` | Control RS-232C |
| `com.sony.dtv.b2b.vendorprotocol` | Broadcaster SDDP para domótica |
| `com.sony.dtv.discovery` | Barra Discover de Sony |
| `com.sony.dtv.bivlinfo` | Feeds que alimentan el Discover |
| `com.sony.dtv.tvlaunchercustomizer` | Customizaciones Sony en filas del home |
| `android.autoinstalls.config.sony.bravia` | Auto-instala apps de socios desde Play Store |
| `com.google.android.feedback` | Informes de feedback a Google |
| `com.google.android.tvrecommendations` | Filas de recomendaciones del launcher |
| `com.google.android.backdrop` | Salvapantallas ambient |
| `com.google.android.tv.bugreportsender` | Envío de informes de error a Google |
| `com.google.android.marvin.talkback` | Lector de pantalla (accesibilidad) |
| `com.google.android.videos` | Play Películas — servicio cerrado, consumía 108 MB |
| `com.google.android.play.games` | Play Games |
| `com.android.printspooler` | Impresora |

### Desinstalado (no reversible sin reset de fábrica)

| Paquete | Descripción |
|---|---|
| `com.vodafone.vtv.atv.es` | Lowi/Vodafone |
| `com.netflix.ninja` | Netflix preinstalado |
| `com.amazon.amazonvideo.livingroom` | Amazon Prime Video preinstalado |
| `com.disney.disneyplus` | Disney+ preinstalado |
| `com.youview.tv.servicehost` | Servicio YouView (Reino Unido) |
| `com.sony.dtv.tvxlauncher.titlelist` | Fila de contenido patrocinado en el home |
| `com.sony.dtv.scrums.action` | Sistema SCRUMS de recomendaciones/promociones Sony |
| `com.sony.dtv.smartmediaapp` | Contenido patrocinado en el launcher ⚠️ también es el reproductor USB |

---

## Qué se conserva

| Paquete | Motivo |
|---|---|
| `com.sony.huey.dlna.module` | DLNA — reproducir contenido desde móvil o PC |
| `com.uei.quicksetsdk.sony` | Control remoto universal IR |
| `com.vewd.core.integration.dia` | HbbTV — botón rojo TDT interactiva |
| `com.mediatek.agent` | Capa hardware del mando a distancia |
| `mtktvapi.agent` | API de bajo nivel del chipset MediaTek |
| `com.mediatek.dmagent` | Agente del chipset — no tocar |

---

## Cómo revertir

```bash
adb -s 192.168.x.x:5555 shell pm enable <paquete>
```

Los paquetes desinstalados con `pm uninstall --user 0` solo se recuperan con un reset de fábrica.

---

## Resultados

| Estado | RAM libre | RAM disponible |
|---|---|---|
| Antes | ~102 MB | ~484 MB |
| Después (frío) | ~169 MB | ~534 MB |
| **Ganancia** | **+67 MB** | **+50 MB** |

---

## Referencias

- [cleanyourtv](https://github.com/Gathin23/cleanyourtv) — herramienta genérica para debloat de Android TV
- Lista más cercana: [sony-kd-55xe8596](https://github.com/Gathin23/cleanyourtv/tree/main/examples/sony-kd-55xe8596)
