# qli-client-installer
# qli-Client installation script

This script installs the qli client (version 3.3.3) on Linux systems, configures the `appsettings.json` and starts the client in a screen session.

## Usage

```bash
wget https://raw.githubusercontent.com/<your-username>/qli-client-installer/main/install.sh
chmod +x install.sh
./install.sh <alias> <cpuThreads> “<accessToken>”
