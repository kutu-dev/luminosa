# Luminosa Deployment and Configuration Files
> Powered by a cheap laptop and lots of dreams.

Network: `shared`.
puertos abiertos...

Two API keys for Porkbun

Cada entrada DNS.

lldap admin pass in secret.
create user `kutu`.

create user `authelia` with password located at `./services/authelia/secrets/authelia_authentication_backend_ldap_password.txt`.
Add user `authelia` to group `lldap_strict_readonly`.

## Services
- [x] porkbun-ddns
- [x] traefik
- [x] lldap
- [x] authelia

- [ ] baikal
- [ ] caddy
- [ ] cdn
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
