# Caddy Docker image with plungins

## Usage

Set docker build arg `XCADDY_ARGUMENTS`, in format of `PLUGIN1,PLUGIN2,PLUNIN3` to add plugins.

```
docker build -t my_caddy \
    --build-arg XCADDY_ARGUMENTS=github.com/caddy-dns/cloudflare,github.com/mholt/caddy-webdav \
    .
```

## Customization

You can fork this repo and edit [.github/workflows/docker.yml](.github/workflows/docker.yml) to satisfy your requirements (plugins, platforms, etc.)