# Psibase-contributor

This tool is primarily for developers who:

1. Are working on core psibase services or system (Contributing directly to the `psibase` monorepo)
2. Are using VSCode (or Cursor, Windsurf, or another fork) as their IDE
3. Want to build psibase/psidk/psinode from source, rather than use the precompiled binaries

# Features

The environment in the container set up for you by this tool has many helpful features that simplify the development of Psibase services. Regardless of what VSCode extensions you have locally installed, this development environment is opinionated and will install several VSCode extensions into the container for you. These extensions are for:

* Language support, auto-formatting, intellisense, refactoring tools (C++, Rust, Javascript, Typescript, Markdown)
* Showing custom build buttons in the VSCode status bar
* Version control tools: checking git history, blames, diffs, commit IDs, branch diagrams, etc.

# Prerequisites

1. VSCode installed on your development PC
2. git installed & configured on your development PC
3. Microsoft's [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) VSCode extension has been installed

# How to use

1. Clone this psibase-contributor repo to your development PC.
2. Open this repo in vscode
3. Execute the VSCode command to relaunch this repository inside a Docker container <br/> ![Reopen in Container](/img/build-command.png)
4. Open a terminal in vscode, and run `git pull` and `git submodule update --init --recursive` to ensure psibase is up-to-date.
5. Run a full build by clicking the corresponding button in the status bar at the bottom of the window in VSCode <br/> ![Build](/img/full-build.png)

## Note on HTTPS

To run locally using https, you must specify the appropriate TLS-related options. The psibase-contributor tool generates tls keys for you to use, and a sample config file using them can be found in the container at `/root/example-psinode-configs/https.config`.

Make sure to install the root cert located in this repo at `local-certs/rootCA.pem` (`local-certs/rootCA.pem.crt` for Windows users) as a *Trusted Root Certificate Authority* to ensure your browser doesn't complain about invalid certs when accessing psinode over https. The certificate is generated after the container is built for the first time.

The certificates are generated for `sslip.io` subdomains. You must ensure you specify the corresponding host (e.g. `https://psibase.127.0.0.1.sslip.io:8080`) when you launch psinode rather than the default (e.g. `http://psibase.localhost:8080`).

## Development workflow

In general, your workflow will be to open this psibase contributor repo, relaunch it inside a container, do all develoment activities, commit/push from within the VSCode-integrated bash terminal, close VSCode when finished (this closes the container. All work is saved unless you delete the corresponding docker volume).

## Building & Launching a Local Network

Within the container, you should have some items in the toolbar to help you build and launch the chain. These toolbar buttons are defined in `.vscode/tasks.json` and they reference bash scripts found in `.vscode/scripts/`. 

The first time you use psibase contributor (or after any time your docker volume gets deleted), you will have to configure 

# Development data location

All source code and build files are stored within a named docker volume. This data is accessible from within the container or alternatively through Docker Desktop.

# Updating

Occasionally, you should use `git pull` in your `psibase-contributor` directory on your host machine in order to pull the latest changes to the build environment or external tooling. After updating `psibase-contributor`, you should run `Rebuild Without Cache and Reopen in Container` when relaunching your container in order to load the changes into your development environment.

# Troubleshooting

## Windows memory/CPU consumption

If you're on Windows, using Docker Desktop with WSL2, it is likely that the WSL2 process will chew up an enormous amount of memory on your PC. This is [a known issue](https://github.com/microsoft/WSL/issues/8725) with Docker Desktop with WSL2 on Windows. Another related issue is the overconsumption of CPU during builds, especially if you are using multiple psibase-contributors or parallel builds.

The solution is simply to:
1. Shut down docker desktop
2. Run `wsl --shutdown` from a command prompt
3. Create a `.wslconfig` file in `%userprofile%` if it doesn't exist
4. Add the following config to the `.wslconfig` file (Change the numbers to suitable limits depending on your host machine specs)
```
[wsl2]
memory=12GB
processors=8
```
5. That's it. Save the file and restart Docker Desktop, and now WSL2 is limited to only consume a maximum of 12GB memory and may only use 8 CPU cores. If you encounter any hang-ups or freezes when building, try bumping the memory limit higher.

### Mac disk space issue

There are max volume size limits in Docker Desktop for Mac configurable in the `Settings > Resources` tab. Building psibase from source requires a large amount of disk space for all the various artifacts that are produced, so if you have disk space problems, this is where you can go to bump up the volume size limits.
