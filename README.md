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

## Configuration

 - `GITIT_CONF` - path to gitit configuration file. If not found then
  it will be created. Can be full path or relative to `GITIT_REPOSITORY`.
  Default is `gitit.conf`
 - `GITIT_REPOSITORY` - path to git repository with gitit wiki. Default `/gitit`
 - `GIT_COMMITTER_NAME` - Committer name for git commits made through the web UI.
  This is only used when creating a new git repository. Default `gitit`
 - `GIT_COMMITTER_EMAIL` - Committer email for git commits made through the web UI.
  This is only used when creating a new git repository. Default `gitit@example.com`
