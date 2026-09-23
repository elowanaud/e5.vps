export DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=a APT_LISTCHANGES_FRONTEND=none
APT_OPTIONS=(-y -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold)

# Updates
apt-get "${APT_OPTIONS[@]}" update
apt-get "${APT_OPTIONS[@]}" upgrade

# Fail2Ban
apt-get "${APT_OPTIONS[@]}" install fail2ban curl
curl -fsSL https://raw.githubusercontent.com/elowanaud/e5.vps/main/configs/fail2ban -o /etc/fail2ban/jail.local
systemctl restart fail2ban

# UFW (Uncomplicated Firewall)
ufw default allow outgoing
ufw default deny incoming
ufw allow ssh/tcp
ufw --force enable

# Docker
apt-get "${APT_OPTIONS[@]}" install ca-certificates
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
apt-get "${APT_OPTIONS[@]}" update
apt-get "${APT_OPTIONS[@]}" install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Dokploy
curl -sSL https://dokploy.com/install.sh | bash