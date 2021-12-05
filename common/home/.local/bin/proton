#!/bin/sh

# Execute Windows programs with Proton from Steams installation folder, without
# starting Steam client.
#
# 1. Create a directory for Proton environment to run in.  As an example make a
#    folder "proton" in your home directory.  This folder must exist in order
#    to make Proton work.
#
# 2. Point the variable "env_dir" in this script to that folder or...
#
# 3. ... alternatively set the environmenal variable "$PROTONPREFIX" to this
#    folder before running the script.  It works similar to the "$WINEPREFIX"
#    from WINE and will have higher priority over "env_dir".
#
# 4. Look in your Steam installation folder at "steamapps/common/" folder for
#    available Proton versions.  Pick one and point the script variable
#    "proton_version" to this that folder name, in example "Proton 3.16".
#    Note: You have to download a Proton version from Steam first, if none is
#    there yet.
#
# 5. Or alternatively set the environmental variable "$PROTONVERSION" to that
#    folder name of Proton version before running the script.  It has higher
#    priority over script variable "proton_version".
#
# 6. Optionally install/copy this script in a directory that is in your $PATH,
#    so you can run it easily from any place.  Or set the default interpreter
#    for .exe files to this script.
#
# Usage:
#   proton program.exe
#
# or:
#   export PROTONPREFIX="$HOME/proton_316"
#   export PROTONVERSION="Proton 3.16"
#   proton program.exe

# Folder name of the Proton version found under "steamapps/common/".
# proton_version="Proton - Experimental"
# proton_version="Proton 3.16"
proton_version="Proton - Experimental"

# Path to installation directory of Steam.
# Alternate path: "$HOME/.steam/steam"
client_dir="$HOME/.local/share/Steam"

# Default data folder for Proton/WINE environment.  Folder must exist.
# If the environmental variable PROTONPREFIX is set, it will overwrite env_dir.
env_dir=$HOME/proton

# Proton modes to run
#   run = start target app
#   waitforexitandrun = wait for wineserver to shut down
#   getcompatpath = linux -> windows path
#   getnativepath = windows -> linux path
mode=run

# ENVIRONMENTAL VARIABLES
if [ -n "${PROTONPREFIX+1}" ]
then
    env_dir=$PROTONPREFIX
fi

if [ -n "${PROTONVERSION+1}" ]
then
    proton_version=$PROTONVERSION
fi

# EXECUTE
export STEAM_COMPAT_CLIENT_INSTALL_PATH=$client_dir
export STEAM_COMPAT_DATA_PATH=$env_dir
"$client_dir/steamapps/common/$proton_version/proton" $mode $*
