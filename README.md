# HiCT
Combines all HiCT-related repositories as submodules
---

## How to properly clone this repository

All HiCT-related repositories are added as git submodules, so in order to properly initialize them, you need to add `--recurse-submodules` option to your command like: `git clone --recurse-submodules https://github.com/ctlab/HiCT.git` (via HTTPS) or `git clone --recurse-submodules git@github.com:ctlab/HiCT.git` (via SSH).

If you have already cloned repository without submodules, run `git submodule update --init --recursive` at the root of this cloned repository.

---

## How to test-drive HiCT

Assuming you have properly cloned this repository (following guidelines in the previous section) and have Docker installed with `docker compose` or `docker-compose` available, create a directory `~/HiCT/HiCT_Server/data` where you'll put your source cooler's `.mcool` or `.cool` files along fith the FASTA and AGP (and where converted `.hict.hdf5` will be stored) and then run `docker compose up -f ./docker/docker-compose.yml`.
This will download images with server and webui and run them in Docker containers.
After that, navigate to the `http://localhost:8080` and HiCT WebUI should be accessible through your web browser.
