ARG BUILD_VERSION
ARG BASE_IMAGE_VERSION=2.0.3
FROM mplogas/ecowitt-controller:${BASE_IMAGE_VERSION}

RUN apt-get update && apt-get install -y --no-install-recommends jq curl && rm -rf /var/lib/apt/lists/*

COPY rootfs /
RUN chmod +x /run.sh

LABEL io.hass.type="addon" \
      io.hass.name="Ecowitt Controller" \
      io.hass.description="Bridge Ecowitt weather stations and IoT subdevices to MQTT"

ENTRYPOINT ["/run.sh"]
