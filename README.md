# instant-ide

This is a dockerized instant IDE for developing Netsuite applications and services for BlueBanyanSolutions.

#### Installation

Start by installing docker. There are compatible versions for all OS types. If you are running windows, it's also recommended to install cygwin/x in order to have copy/paste ability to/from the windows host machine to/from the remote docker container. Once you have docker installed, open a shell and enter:

    ./build-image.sh
    
to build the 'intant-ide' docker images for the first time. This will take some time to build for the first time so grab a coffee. Once that's done, run:

    ./run-image.sh
    
This will open a tmux session to the instant-ide. The new shell will open with an instructive banner.

### Features

#### Emacs

#### Cloud 9

#### Pair Programming

#### SDF CLI
