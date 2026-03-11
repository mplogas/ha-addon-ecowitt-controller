ARG BUILD_VERSION=2.0.3
FROM mplogas/ecowitt-controller:${BUILD_VERSION}

RUN apt-get update && apt-get install -y --no-install-recommends jq && rm -rf /var/lib/apt/lists/*

COPY rootfs /

LABEL io.hass.type="addon" \
      io.hass.name="Ecowitt Controller" \
      io.hass.description="Bridge Ecowitt weather stations and IoT subdevices to MQTT"

ENTRYPOINT ["/run.sh"]
