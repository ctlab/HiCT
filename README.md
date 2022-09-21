# HiCT
Combines all HiCT-related repositories as submodules


## How to properly clone this repository

All HiCT-related repositories are added as git submodules, so in order to properly initialize them, you need to add `--recurse-submodules` option to your command like: `git clone --recurse-submodules https://github.com/ctlab/HiCT` (via HTTPS) or `git clone --recurse-submodules git@github.com:ctlab/HiCT` (via SSH).

If you have already cloned repository without submodules, run `git submodule update --init --recursive` at the root of this cloned repository.
