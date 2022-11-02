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
Each of the Python-based projects (Library, Server and Utils) has a `requirements.txt` file with all the required staff. All of them are required for proper development. Our workflow here is to create a virtual environment and install all required packages there. This virtual environment could be shared between all of these projects. In linux, you can do this by entering HiCT directory that we've created on the previous step and simply running:
```
python -m venv hict_venv
source hict_venv/bin/activate
pip install -r HiCT_Library/requirements.txt
pip install -r HiCT_Server/requirements.txt
pip install -r HiCT_Utils/requirements.txt
```

On a Windows (native, not WSL/WSL2) the workflow is different, though. Firstly, the venv activation script is located in `hict_venv/Scripts/Activate.ps1` (for Powershell) or `hict_venv/Scripts/activate.bat` (for Command Prompt).
