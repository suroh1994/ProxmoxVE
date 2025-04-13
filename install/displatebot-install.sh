#!/usr/bin/env bash

# Copyright (c) 2021-2025 community-scripts ORG
# Author: suroh
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE
# Source: https://www.filestash.app/

source /dev/stdin <<<"$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apk add newt \
	curl \
	openssh \
	tzdata \
	nano \
	mc
msg_ok "Installed Dependencies"

msg_info "Installing Docker"
$STD apk add docker
$STD rc-service docker start
$STD rc-update add docker default
msg_ok "Installed Docker"

read -r -p "Please enter your telegram bot token: " token
export BOT_TOKEN=$token

msg_info "Launching DisplateBot Container"
$STD docker run -e TELEGRAM_BOT_TOKEN="$BOT_TOKEN" -d suroh/displatebot:v1.4
msg_ok "Launched DisplateBot Container"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
