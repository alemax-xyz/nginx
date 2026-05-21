## Nginx docker image

This image is based on nginx build for Debian and is built on top of [clover/common](https://hub.docker.com/r/clover/common/).

### Exposed ports

| Port | Description
| ---- | -----------
| `80`   | TCP port for _HTTP_ traffic
| `443`  | TCP port _HTTPS_ traffic

### Environment variables

| Environment | Default value | Description
| ----------- | ------------- | -----------
| `PUID` | _not set_ | desired user id of the process owner
| `PGID` | _not set_ | desired group id of the process pwner (primary group of the `PUID` user)
| `PUSER` | _not set_ | desired `PUID` user name
| `PGROUP` | _not set_ | desired `PGID` group name
| `CHOWN` | _not set_ | space-separated list of directories to change ownership to `PUID`/`PGID` during container startup
| `CRON` | _not set_ (`0`) | will start _cron_ inside the container if set to `1`
| `TZ` / `TIMEZONE` | _not set_ (`UTC`) | desired container timezone
| `NGINX_DIRECTIVES` | `error_log /dev/stderr warn;` | any global-scope configuration directives

### Configuration files

| Location | Description
| -------- | -----------
| `/etc/nginx/nginx.conf` | Nginx configuration file
| `/etc/nginx/conf.d/*.conf` | extra Nginx configuration files


### Supported platforms

 * `linux/amd64`;
 * `linux/386`;
 * `linux/arm/v7`;
 * `linux/arm64/v8`;
 * `linux/ppc64le`;
 * `linux/s390x`;
