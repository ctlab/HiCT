# Development Guide
This document describes how to clone all HiCT-related repositories and prepare the environment to launch HiCT in development mode and easily change sources with hot-reload support (no need to rebuild it each time).


## Repositories
If you plan to make contributions to the HiCT or change a subset of its repositories, it is generally more preferrable to clone them as a separate repositories in one parent directory. The solution with submodules in this repository is mainly to ease the future deployment of stable versions.

It could be done in a few steps:
* First, create an empty folder for storing all the repositories. Let's name it `HiCT` and enter there.
* Then, you need to clone all the HiCT-related repositories:
  ```
  git clone https://github.com/ctlab/HiCT_Library.git
  git clone https://github.com/ctlab/HiCT_Server.git
  git clone https://github.com/ctlab/HiCT_Utils.git
  git clone https://github.com/ctlab/HiCT_WebUI.git
  ```
* Now, enter each repository and checkout the desired branch, i.e. 
  ```
  cd HiCT_Library
  git checkout dev-0.1.3
  cd ..
  ```
## Dependencies

### Python projects
We use [Python 3.9.7 or newer](https://www.python.org/downloads/) for our Python projects, `pip` as a package manager and `venv` module for the virtual environment.
Each of the Python-based projects (Library, Server and Utils) has a `requirements.txt` file with all the required staff. All of them are required for proper development. Our workflow here is to create a virtual environment and install all required packages there. This virtual environment could be shared between all of these projects. In linux, you can do this by entering HiCT directory that we've created on the previous step and simply running:
```
python -m venv hict_venv
source hict_venv/bin/activate
pip install -r HiCT_Library/requirements.txt
pip install -r HiCT_Server/requirements.txt
pip install -r HiCT_Utils/requirements.txt
```

If it fails due to unresolved

On a Windows (native, not WSL/WSL2) the workflow is different, though. Firstly, the venv activation script is located in `hict_venv/Scripts/Activate.ps1` (for Powershell) or `hict_venv/Scripts/activate.bat` (for Command Prompt). Secondly, you will probably encounter a problem during installation of `cooler`, because it uses `pypairix` which is not available on Windows. However, the [solution from cooler's issue](https://github.com/open2c/cooler/issues/224#issuecomment-700403146) should work fine:
```
pip install --no-deps cooler
pip install simplejson pyfaidx multiprocessing
```
This should resolve failed dependencies.

### Node.js project
Our project uses Node.js 16, however both older Node.js 14 and newer versions such as Node.js 18 should also work fine. As a package manager we use `npm` it should be from branch 8.x or newer (now we use npm 8.19.2). For Windows you can simply [download and install Node.js from their official site](https://nodejs.org/en/download/). On a linux system, though, your distro's repositories may contain older versions or node without the npm, we recomend you to use script from nodesource: (https://deb.nodesource.com/setup_18.x), where 18.x corresponds to the Node.js version. This script will add the repositories so you can remove your older version like `sudo apt-get purge nodejs npm` and then install it like `sudo apt-get install build-essential nodejs npm` (these commands should work for Ubuntu/Debian; you should know yourself how to install particular versions of Node.js and npm if you have another distro).
All dependencies are specified in the `package.json` file. For the initial setup and after each modification of `package.json` you should run `npm install` in the directory where `package.json` is located.
WebUI is based on Vue+Vite+TypeScript template and represents an `npm` package. It has lots of dependencies (and tons of transitive dependencies), but that is how Node's ecosystem works. It is a good idea to place HiCT_WebUI on a SSD, because `node_modules` directory which contains all the dependencies, has lots and lots of very small files.

## Common workflows

Here we present some typical workflows that are used during the development stage.

### Convert a file from `.mcool` to `.hict.hdf5` format
During active development phase the code of `hict` is changed frquently so instead of (re)building and (re)installing it after each change, we can just add library's sources to `PYTHONPATH`. Usually the data is stored in the same directory where server will search for it, and by default it is `HiCT/HiCT_Server/data/`. So, if you put file `cool.mcool` to that folder, you can then convert it to the HiCT format by running this command from the `HiCT_Utils` directory:
`PYTHONPATH=../HiCT_Library python -m hict_utils convert ../HiCT_Server/data/cool.mcool` (for linux bash)
or
```
$env:PYTHONPATH = "../HiCT_Library"
python -m hict_utils convert ../HiCT_Server/data/cool.mcool
```
(for Windows Powershell)

After conversion the result should be located in the `HiCT/HiCT_Server/data/cool.mcool.hict.hdf5` file (and should be picked up then by the HiCT Server).

### Start server in development mode
Again, during development it is common to change both the code of library and the code of server, so we can use the same tactic to start the hict_server module. Flask is distributed with the nice development server which supports hot-reload (both when changing server's sources and libraries' sources) and serves all our needs.
This is done more often than file convertion, so we have two dedicated scripts for starting the server: `loadfromsource.sh` (for linux bash) and `loadfromsource.ps1` (for Windows Powershell). You can simply navigate to the `HiCT/HiCT_Server` and start server like `./loadfromsource.sh` or `& .\loadfromsource.ps1`.

### Start the WebUI to work in browser
Just execute `npm run dev` from the `HiCT/HiCT_WebUI` directory, it should transpile TypeScript to JavaScript and print the address like `localhost:8080` that you shold then open in your browser. Remember to run `npm install` each time you've changed anything in `package.json` and try to use Private Browsing Mode, because otherwise your browser might cache some version of modules and you might encounter strange behaviour when code is changed but browser executes the old version.
All the transpilation is done by Vite development server which also supports hot-module-reload (hmr) so if you change the `.vue`, `.ts` or `.js` files in `HiCT/HiCT_WebUI/src` directory, after saving the changes in editor, these changes will immediately appear in your browser. 

### Build a standalone version using Electron
You can also package the WebUI into the Electron app, for that you can run `npm run app:build`.
If you want to use Electron version instead of your browser and still benefit from hot-module-reload, there is also an option to run `npm run app:preview`.


