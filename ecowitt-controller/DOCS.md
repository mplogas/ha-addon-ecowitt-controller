# Ecowitt Controller

Bridges Ecowitt weather stations and IoT subdevices (AC1100, WFC01, WFC02) to MQTT with Home Assistant auto-discovery.

## Setup

### 1. Configure your weather station

Open your gateway's WebUI or the WS View Plus app, go to weather services, enable the **Customized** upload with:

- **Protocol:** Ecowitt
- **Server IP:** Your Home Assistant IP
- **Path:** `/data/report`
- **Port:** 8080

### 2. MQTT

If you're running the **Mosquitto** add-on, MQTT is configured automatically. Otherwise, fill in the MQTT host, port, username, and password in the add-on options.

### 3. Gateways

Add your gateway(s) under **Gateways** with a name and IP address. Enable **Subdevices** if you have IoT devices (AC1100, WFC01, WFC02) connected to a GW1200, GW2000, or GW3000.

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `mqtt_host` | auto | MQTT broker address (auto-discovered from Mosquitto) |
| `mqtt_port` | `1883` | MQTT broker port |
| `mqtt_user` | auto | MQTT username |
| `mqtt_password` | auto | MQTT password |
| `mqtt_base_topic` | `ecowitt` | Root MQTT topic prefix |
| `mqtt_client_id` | `ecowitt-controller` | MQTT client identifier |
| `mqtt_use_311` | `false` | Fall back to MQTT 3.1.1 protocol |
| `polling_interval` | `30` | Subdevice polling interval in seconds |
| `unit` | `metric` | Unit system (`metric` or `imperial`) |
| `precision` | `2` | Decimal places for sensor values |
| `log_level` | `Warning` | Log verbosity |

## Support

For issues and feature requests, visit the [GitHub repository](https://github.com/mplogas/ecowitt-controller/issues).
