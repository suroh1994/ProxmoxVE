#!/usr/bin/env bash
source <(curl -fsSL https://raw.githubusercontent.com/suroh1994/ProxmoxVE/main/misc/build.func)
# Copyright (c) 2021-2025 tteck
# Author: tteck (tteckster)
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE
# Source: https://www.cloudflare.com/

APP="Cloudflared"
var_tags="network;cloudflare"
var_cpu="1"
var_ram="512"
var_disk="2"
var_os="debian"
var_version="12"
var_unprivileged="1"

header_info "$APP"
variables
color
catch_errors

function update_script() {
   header_info
   check_container_storage
   check_container_resources
   if [[ ! -d /var ]]; then
      msg_error "No ${APP} Installation Found!"
      exit
   fi
   msg_info "Updating $APP LXC"
   $STD apt-get update
   $STD apt-get -y upgrade
   msg_ok "Updated $APP LXC"
   exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${CREATING}${GN}${APP} setup has been successfully initialized!${CL}"
