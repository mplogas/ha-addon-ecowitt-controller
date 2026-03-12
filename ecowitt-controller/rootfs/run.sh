#!/bin/sh
set -e

OPTIONS="/data/options.json"

echo "Generating appsettings.json from add-on configuration..."

# Read options
MQTT_HOST=$(jq -r '.mqtt_host // empty' "$OPTIONS")
MQTT_PORT=$(jq -r '.mqtt_port // 1883' "$OPTIONS")
MQTT_USER=$(jq -r '.mqtt_user // empty' "$OPTIONS")
MQTT_PASSWORD=$(jq -r '.mqtt_password // empty' "$OPTIONS")
BASE_TOPIC=$(jq -r '.mqtt_base_topic // "ecowitt"' "$OPTIONS")
CLIENT_ID=$(jq -r '.mqtt_client_id // "ecowitt-controller"' "$OPTIONS")
USE_311=$(jq '.mqtt_use_311 // false' "$OPTIONS")
POLLING=$(jq '.polling_interval // 30' "$OPTIONS")
UNIT=$(jq -r '.unit // "metric"' "$OPTIONS")
PRECISION=$(jq '.precision // 2' "$OPTIONS")
LOG_LEVEL=$(jq -r '.log_level // "Warning"' "$OPTIONS")
GATEWAYS=$(jq -c '.gateways // []' "$OPTIONS")

# Check for Mosquitto service discovery via Supervisor API
if [ -z "$MQTT_HOST" ]; then
    if [ -n "$SUPERVISOR_TOKEN" ]; then
        MQTT_INFO=$(curl -s -H "Authorization: Bearer ${SUPERVISOR_TOKEN}" http://supervisor/services/mqtt 2>/dev/null || true)
        if echo "$MQTT_INFO" | jq -e '.data.host' > /dev/null 2>&1; then
            echo "Mosquitto add-on detected, using auto-discovered credentials"
            MQTT_HOST=$(echo "$MQTT_INFO" | jq -r '.data.host')
            MQTT_PORT=$(echo "$MQTT_INFO" | jq -r '.data.port')
            MQTT_USER=$(echo "$MQTT_INFO" | jq -r '.data.username')
            MQTT_PASSWORD=$(echo "$MQTT_INFO" | jq -r '.data.password')
        fi
    fi
fi

if [ -z "$MQTT_HOST" ]; then
    echo "ERROR: No MQTT host configured and no Mosquitto add-on found"
    exit 1
fi

mkdir -p /config

cat > /config/appsettings.json <<EOF
{
  "Serilog": {
    "MinimumLevel": "${LOG_LEVEL}"
  },
  "mqtt": {
    "host": "${MQTT_HOST}",
    "user": "${MQTT_USER}",
    "password": "${MQTT_PASSWORD}",
    "port": ${MQTT_PORT},
    "basetopic": "${BASE_TOPIC}",
    "clientId": "${CLIENT_ID}",
    "reconnect": true,
    "reconnectAttempts": 5,
    "useMqtt311": ${USE_311}
  },
  "ecowitt": {
    "pollingInterval": ${POLLING},
    "calculateValues": true,
    "gateways": ${GATEWAYS}
  },
  "controller": {
    "precision": ${PRECISION},
    "unit": "${UNIT}",
    "homeassistantdiscovery": true
  }
}
EOF

echo "Starting Ecowitt Controller..."
cd /app
exec dotnet Ecowitt.Controller.dll
