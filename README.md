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
3. Execute the VSCode command to relaunch this repository inside a Docker container <br/> ![Reopen in Container](/img/build-command.png)
4. Run a full build by clicking the corresponding button in the blue status bar at the bottom of the window in VSCode <br/> ![Execute Build](/img/full-build.png)

## Note on HTTPS

Running psinode using a database with the name "psinode_db" within the container will use the default psinode config file located at `psinode/configs/dev.config`. This is configured to automatically run psinode locally over https. Http is exposed within the container at port 8079, but the 8080 exposed outside the container is https.

Make sure to install the root cert located in this repo at `local-certs/rootCA.pem` (`local-certs/rootCA.pem.crt` for Windows users) to ensure your browser doesn't complain when accessing psinode over https.

## Workflow loop

In general, your workflow will be to open this psibase contributor repo, relaunch it inside a container, do all develoment activities, commit/push from within the VSCode-integrated bash terminal, close VSCode when finished (this closes the container. All work is saved unless you delete the docker volume).

## Data and build artifact access

All source code and build files are stored within a named docker volume and are only accessible from within the container, with one exception: A bind-mount has been added to allow all bundled UIs and compiled wasms (Release version) for system and user services to be accessible from outside the container. These artifacts can be found here on the host machine in the `./artifacts` directory.

## Updating

Occasionally, updates are made to Psibase that require a change to the environment (New external tool/library, etc.). When this happens, the simplest update procedure is simply to open this repo locally (not in a container), and run the command `Rebuild Without Cache and Reopen in Container`:
![Rebuild Without Cache](/img/rebuild-without-cache.png)

And of course, if there is an update to this tool itself, you may run a standard git pull to update the tool.

## Features

The environment in the container set up for you by this tool has many helpful features that simplify the development of Psibase services & applets. Regardless of what VSCode extensions you have locally installed, this development environment is opinionated and will install several VSCode extensions into the container for you. These extensions are for:

1. C++ auto-formatting, refactoring tools, and intellisense (C-mantic, C/C++, Clang-format)
2. CMake file language support (Cmake)
3. Showing custom build buttons in the status bar (Command Variable, and Tasks)
4. Checking git history, blames, diffs, commit IDs, branch diagrams, etc. (GitLens, Open in Github)
5. Creating real-time collaboration sessions with others on code within your container (Live Share Extension Pack)
6. Previewing markdown files, with Mermaid diagram support (Markdown Preview Mermaid Support)
