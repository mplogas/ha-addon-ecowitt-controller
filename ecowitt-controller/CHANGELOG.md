# Changelog

## 2.0.6 

- Exposes the Ecowitt subdevice "run for a duration / volume" capability as first-class Home Assistant entities
- multiple fixes

## 2.0.3-7

- Fix Mosquitto auto-discovery (enable Supervisor API access, add curl)
- Fix run.sh permission denied on startup
- Decouple add-on version from base image version
- Always enable Home Assistant discovery (no opt-out in add-on context)

## 2.0.3

- Initial add-on release based on Ecowitt Controller v2.0.3
- Mosquitto add-on auto-discovery
- Multi-arch support (amd64, aarch64)
