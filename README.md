## Psibase-contributor

This tool is primarily for the developers on the Fractally team, or other developers who:

1. Are building Psibase system or user services / applets (Contributing directly to the `fractally/psibase` monorepo)
2. Are using VSCode as their IDE
3. Want to build psibase/psidk/psinode from source, rather than use the precompiled binaries

## Prerequisites

1. VSCode installed on your development PC
2. git installed & configured on your development PC
3. Microsoft's [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) VSCode extension has been installed

## How to use

1. Clone this psibase-contributor repo to your development PC.
2. Open this repo in vscode
    1. If you are running on an arm device like Apple M1, switch branches in the repo from `main` to `arm-image`
3. Execute the VSCode command to relaunch this repository inside a Docker container <br/> ![Reopen in Container](/img/build-command.png)
4. Run a full build by clicking the corresponding button in the status bar at the bottom of the window in VSCode <br/> ![Execute Build](/img/full-build.png)

## Note on HTTPS

Running psinode using a database with the name "psinode_db" within the container will use a psinode config file located in your dev environment at `$PSINODE_PATH/psinode_db/config`. This is configured to automatically run psinode locally over https. Http is exposed within the container at port 8079, but the 8080 exposed outside the container is https.

Make sure to install the root cert located in this repo at `local-certs/rootCA.pem` (`local-certs/rootCA.pem.crt` for Windows users) as a *Trusted Root Certificate Authority* to ensure your browser doesn't complain when accessing psinode over https. The certificate is generated after the container is built for the first time.

## Workflow loop

In general, your workflow will be to open this psibase contributor repo, relaunch it inside a container, do all develoment activities, commit/push from within the VSCode-integrated bash terminal, close VSCode when finished (this closes the container. All work is saved unless you delete the corresponding docker volume).

## Data and build artifact access

All source code and build files are stored within a named docker volume and are only accessible from within the container. A bind-mount has been added to allow all bundled UIs and compiled wasms (Release version) for system and user services to be accessible from outside the container. These artifacts can be found on your host machine in this repo in the `./artifacts` directory.

## Updating

Occasionally, updates are made to the Psibase build environment (new external tool/library, etc.) that could cause your Psibase builds to start failing. In order to load the environment changes into your container here, close your connection to the remote development container, and run: `docker pull ghcr.io/gofractally/psibase-contributor:latest` to pull in the latest changes. Then run the command `Rebuild Without Cache and Reopen in Container`:
![Rebuild Without Cache](/img/rebuild-without-cache.png)

And of course, if there is an update to this tool itself, you may run a standard `git pull` to update the tool, followed by another `Rebuild Without Cache and Reopen in Container`.

## Features

The environment in the container set up for you by this tool has many helpful features that simplify the development of Psibase services & applets. Regardless of what VSCode extensions you have locally installed, this development environment is opinionated and will install several VSCode extensions into the container for you. These extensions are for:

1. C++ auto-formatting, refactoring tools, and intellisense (C-mantic, C/C++, Clang-format)
2. CMake file language support (Cmake)
3. Showing custom build buttons in the status bar (Command Variable, and Tasks)
4. Checking git history, blames, diffs, commit IDs, branch diagrams, etc. (GitLens, Open in Github)
5. Previewing markdown files, with Mermaid diagram support (Markdown Preview Mermaid Support)

## Windows troubleshooting

If you're on Windows, using Docker Desktop with WSL2, it is likely that the WSL2 process will chew up an enormous amount of memory on your PC. This is [a known issue](https://github.com/microsoft/WSL/issues/8725) with Docker Desktop with WSL2 on Windows.

The solution is simply to:
1. Shut down docker desktop
2. Run `wsl --shutdown` from a command prompt
3. Create a `.wslconfig` file in `%userprofile%` if it doesn't exist
4. Add the following config to the `.wslconfig` file
```
[wsl2]
memory=8GB
```
5. That's it. Save the file and restart Docker Desktop, and now WSL2 is limited to only consume a maximum of 8GB. If you encounter any hang-ups or freezes when building, try bumping the memory limit higher.
