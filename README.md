# Python Development

This repository provides a Python development environment inside a container.

## Get started
1. Add this repo as a git submodule inside your development repo
```bash
cd <your repo>
git submodule add git@github.com:lehela/.devcontainer.git .devcontainer
git submodule update --init --recursive
```

2. Open VSCode, and choose "Rebuild and Reopen in Container"
   - The `Remote Development` extension pack must be installed (ms-vscode-remote.vscode-remote-extensionpack)
   - This command will build a docker container, which might take a couple of minutes the first time around

3. Copy the workspace file `.devcontainer/project.code-workspace` into your repo
4. Open the copied workspace folder


## How to add additional Python modules
Inside the `project.code-workspace`, add required modules to the task `pip install`
- Note that this will reinstall all modules whenever the container is destroyed

## Unit Tests
To run unit tests of your cloned repo
- ensure `__init__.py` exist in every level of your repo


- edit your workspace json file to point to your repo:
```json
{
    "settings": {
        "python.testing.unittestEnabled": false,
        "python.testing.pytestEnabled": true,
        "python.testing.cwd": "/opt/python-dev/repos/<myrepo>",
        "python.testing.autoTestDiscoverOnSaveEnabled": true,
        "python.testing.pytestArgs": ["."]
    }
} 
```