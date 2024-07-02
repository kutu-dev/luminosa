# Deployment Guide

## External configurations
The server machine should have the following ports forwarded:
- `80` and `443`: Use by the `traefik` reverse proxy to access all the web based services.
- `25565`: Used for the Minecraft servers network.
- `12590`: Generic port used for SSH Tunneling by personal machines.

There should be two A record entries for the domain (in this case `dobon.dev`), both the certificate generator and record updated is tailored to work only with the [Porkbun domain name registrar](https://porkbun.com/):
- `*.dobon.dev`: Points to the public IP of the machine, updated by `porkbun-ddns` as needed.
- `*.v.dobon.dev`: Points to the IP address inside the VPN that connected the server with all the trusted clients (in this case [Tailscale](https://tailscale.com/)).

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
