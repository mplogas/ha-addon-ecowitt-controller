# Ecowitt Controller Add-on for Home Assistant

Home Assistant OS add-on that bridges Ecowitt weather stations and IoT subdevices to MQTT with auto-discovery.

This is a thin wrapper around the [Ecowitt Controller](https://github.com/mplogas/ecowitt-controller) Docker image. It translates the HA add-on configuration into the application's config format and handles Mosquitto add-on service discovery.

## Installation

1. In Home Assistant, go to **Settings > Add-ons > Add-on Store**
2. Click the three-dot menu and select **Repositories**
3. Add this repository URL: `https://github.com/mplogas/ha-addon-ecowitt-controller`
4. Find **Ecowitt Controller** in the store and install it

## Configuration

If you're running the Mosquitto add-on, MQTT credentials are auto-discovered. Otherwise, configure the MQTT connection manually in the add-on options.

You must configure at least one gateway under **Gateways** and point your Ecowitt gateway's custom upload to the HA host IP on port 8080, path `/data/report`, using the Ecowitt protocol.

For detailed configuration options, see the [main project documentation](https://github.com/mplogas/ecowitt-controller).

## Supported Architectures

- amd64
- aarch64 (ARM64, e.g. Raspberry Pi 4/5)
