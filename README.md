# Gitit in docker

A Dockerfile to build image with [Gitit Wiki](https://github.com/jgm/gitit).

Additional packages are installed:
*   `ghc` for haskell plugin support
*   `graphviz` package for dot file support
*   `texlive` for PDF export capabilities

## Quickstart

```
docker run --rm --name gitit -p 80:5001 tomzo/gitit
```

## Usage

In real-world use you would mount existing git repository from docker host to the container.
Often the directory is owned by non-root user on host. This image can work with
cases like that. Gitit server runs as `gitit` user which has uid and gid
set to match with host-mounted directory.

Assuming `~/gitit.wiki` has existing git repository. You can start server with
```
docker run --rm --name gitit -p 80:5001 -v ~/gitit.wiki:/gitit tomzo/gitit
```

Image can be used this way to host an always running server or
to preview wiki that you have locally.

## Configuration

Normally you do not need to set any of these values. You may need to ensure
that `GITIT_CONF` is set to your configuration path.

 - `GITIT_CONF` - path to gitit configuration file. If not found then
  it will be created. Can be full path or relative to `GITIT_REPOSITORY`.
  Default is `gitit.conf`
 - `GITIT_REPOSITORY` - path to git repository with gitit wiki. Default `/gitit`
 - `GIT_COMMITTER_NAME` - Committer name for git commits made through the web UI.
  This is only used when creating a new git repository. Default `gitit`
 - `GIT_COMMITTER_EMAIL` - Committer email for git commits made through the web UI.
  This is only used when creating a new git repository. Default `gitit@example.com`

## License

MIT
