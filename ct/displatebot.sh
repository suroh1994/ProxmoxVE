#!/usr/bin/env bash
source <(curl -fsSL https://raw.githubusercontent.com/suroh1994/ProxmoxVE/main/misc/build.func)
# Copyright (c) 2021-2025 community-scripts ORG
# Author: suroh
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE
# Source: https://github.com/suroh1994/displateBot

APP="DisplateBot"
var_tags="crawler"
var_cpu="1"
var_ram="128"
var_disk="0.5"
var_os="alpine"
var_version="3.21"
var_unprivileged="1"
var_apikey=""

header_info "$APP"
variables
color
catch_errors

function update_script() {
    header_info
    check_container_storage
    check_container_resources
    if [[ ! -f /etc/containers/registries.conf ]]; then # TODO: add check for filestash
        msg_error "No ${APP} Installation Found!"
        exit
    fi
    msg_info "Updating ${APP} LXC"
    $STD apt-get update
    $STD apt-get -y upgrade
    msg_ok "Updated Successfully"
    exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${CREATING}${GN}${APP} setup has been successfully initialized!${CL}"
