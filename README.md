# Luminosa Deployment and Configuration Files
> [Powered](powered.md) by a cheap laptop and lots of dreams.

VPN with Tailscale.

Network: `shared`.
puertos abiertos...

Two API keys for Porkbun

Cada entrada DNS.

lldap admin pass in secret.
create user `kutu`.
create group `vpn`.
Add user `kutu` to group `vpn`.

create user `authelia` with password located at `./services/authelia/secrets/authelia_authentication_backend_ldap_password.txt`.
Add user `authelia` to group `lldap_strict_readonly`.

`static.dobon.dev/healthcheck` path.

## Services
- [x] porkbun-ddns
- [x] traefik
- [x] lldap
- [x] authelia
- [x] static

- [ ] baikal
- [ ] caddy
- [ ] cobalt
- [ ] grafana
- [ ] homer
- [ ] navidrome
- [ ] ntfy
- [ ] rei-network
- [ ] snapdrop
- [ ] syncthing
- [ ] uptime-kuma
- [ ] vaultwarden
- [ ] watchtower
- [ ] wg-easy

## Acknowledgements
- Created with :heart: by [Jorge "Kutu" Dobón Blanco](https://dobon.dev).
