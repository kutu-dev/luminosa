# Deployment Guide
[](.md)
## External configurations
The server machine should have the following ports forwarded:
- `80` and `443`: Use by the `traefik` reverse proxy to access all the web based services.
- `25565`: Used for the Minecraft servers network.
- `12590`: Generic port used for SSH Tunneling by personal machines.

There should be two A record entries for the domain (in this case `dobon.dev`), both the certificate generator and record updated is tailored to work only with the [Porkbun domain name registrar](https://porkbun.com/):
- `*.dobon.dev`: Points to the public IP of the machine, updated by `porkbun-ddns` as needed.
- `*.v.dobon.dev`: Points to the IP address inside the VPN that connected the server with all the trusted clients (in this case [Tailscale](https://tailscale.com/)).

An external `STUN` and `TURN` server is needed for the `pairdrop` service. Currently [Open Relay (Metered Global STUN TURN Servers Free Tier)](https://www.metered.ca/tools/openrelay/) is being used.

When setting up the secrets check any file or directory that ends with `.example` and make a copy without it, then edit the files followinng the notes inside the angle brackets of each one. _Note:_ You will need two separate Porkbun API keys, that can be get [here](https://porkbun.com/account/api). 

## Imperative configurations

It's expected to have the following environment variables set `LUMINOSA_UID` and `LUMINOSA_GID`, they will define the user and group that will be used inside the containers, **this user MUST NOT be part of the `docker` group or have any kind of access to the Docker socket**.

Create a shared external Docker network like this:
```sh
sudo docker network create shared
```

### `lldap` configurations
Before be able to use the SSO provided by Authelia the following steps need to be followed inside the `lldap` Web UI, to access it withouta working Authelia setup its middleware should be remove temporally, you can do that by commenting out its corresponding label beforehand in its Docker Compose file located at [`services/lldap/compose.yaml`](./services/lldap/compose.yaml):

> [!CAUTION]
> Remember to add the middleware again to the `lldap` service after following this steps.

- Login with user `admin` and the password set at the secret located at `services/lldap/secrets/lldap_ldap_user_pass.txt`.
- Create a user `authelia` and set its password with the text inside the secret located at `services/authelia/secrets/authelia_authentication_backend_ldap_password.txt`.
- Add the user `authelia` to the builtin group `lldap_password_manager`.
- Create the group `vpn`.
- Create the desired users...
- Add any user that should have access to the services located at the private domain (`*.v.dobon.dev`) to the group `vpn`.

### `baïkal` configurations
Just follow the configuration wizard, then create a personal user with calendars and address books as needed.

### `Uptime Kuma` configurations
[Unfortunately it doesn't seems that it's going to be implemented a declarative based system to define the monitors in the near future](https://github.com/louislam/uptime-kuma/issues/1354) so the settings needs to be set manually, including but not limited to:
- Monitors
- Tags
- Status pages
- Notifications by `ntfy`

And **remember to disable authentication** as it should relay on the Authelia middleware.

### `ntfy` configurations
Users can't be define declarative so manual steps are needed:
- Enter the container shell with `docker compose -f /srv/services/ntfy/compose.yaml exec bash`
- Create a new admin user that can read to all topics: `ntfy user add --role=admin Kutu`
- Block global access to the topics thought ACL: `ntfy access * * deny`

At the clients (mobile and desktop) the following topics should be set:
- `uptime-kuma`: For Uptime Kuma service down alerts.
- `watchtower`: To notify when a container is updated.

### `syncthing` configurations
- Refuse ` Allow Anonymous Usage Reporting`.
- Set the device name to `[luminosa](luminosa.md)`.
- Remove the `Default Folder` folder.
- Add your desired devices and shared directories (they should be located at `/var/syncthing/sync/<folder-name>`).
- Run `rm -rf /srv/sync/syncthing/Sync`.
