#!/usr/bin/env bash
set -e

ZMKCONFIG="$HOME/Documents/dev/keyboard/piantor-bt"
ZMKHOME="$HOME/Documents/dev/keyboard/zmk"
OUTPUT="${ZMKCONFIG}/output"
ZMKHOMECACHE=zmk-home-cache

mkdir -p "$OUTPUT"

cache() {
  podman volume exists "$ZMKHOMECACHE" || podman volume create "$ZMKHOMECACHE"
}

clean_cache() {
  podman volume rm "$ZMKHOMECACHE"
}

init() {
  echo "=== Initialize configuration $artifact ==="
  podman run --rm \
    -v "${ZMKCONFIG}:/zmk-config" \
    -v "${ZMKHOME}:/zmk-home" \
    -v "${OUTPUT}:/output" \
    -v "${ZMKHOMECACHE}":/root \
    -e ZEPHYR_BASE=/zmk-home/zephyr \
    zmkfirmware/zmk-build-arm:stable \
    bash -c "
      rm -rf /zmk-home/.west /zmk-home/config
      west init --manifest-file /zmk-config/config/west.yml /zmk-home && \
      cd /zmk-home && \
      west update && \
      west zephyr-export
    "
}

build() {
  local board=$1
  local shield=$2
  local snippet=$3
  local cmake_args=$4
  local artifact=$5

  echo "=== Building $artifact ==="
  podman run --rm \
    -v "${ZMKCONFIG}:/zmk-config" \
    -v "${ZMKHOME}:/zmk-home" \
    -v "${OUTPUT}:/output" \
    -v zmk-home-cache:/root \
    -e ZEPHYR_BASE=/zmk-home/zephyr \
    zmkfirmware/zmk-build-arm:stable \
    bash -c "
      # rm -rf /zmk-home/.west /zmk-home/config
      # west init --manifest-file /zmk-config/config/west.yml /zmk-home && \
      # cd /zmk-home && \
      # west update && \
      # west zephyr-export && \
      # build
      cd /zmk-home/zmk/app && \
      west build -p -d /tmp/build \
        -b $board \
        ${snippet:+-S ${snippet}} \
        -- \
        ${shield:+-DSHIELD=${shield}} \
        -DZMK_CONFIG=/zmk-config/config \
        -DZMK_EXTRA_MODULES=/zmk-config \
        ${cmake_args} && \
      cp /tmp/build/zephyr/zmk.uf2 /output/${artifact}.uf2
    "
}

# --- init ---
# cache
# init
# --- Entries from build.yaml ---

build "piantor_pro_bt_left" "nice_view" "studio-rpc-usb-uart" "-DCONFIG_ZMK_STUDIO=y" "left_nice_view"
build "piantor_pro_bt_right" "nice_view" "studio-rpc-usb-uart" "" "right_nice_view"
build "piantor_pro_bt_left" "settings_reset" "studio-rpc-usb-uart" "" "left_settings_reset"
build "piantor_pro_bt_right" "settings_reset" "studio-rpc-usb-uart" "" "right_settings_reset"

echo "=== Done! UF2 files are in ~/zmk-workspace/output/ ==="
