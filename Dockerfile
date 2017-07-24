  FROM ubuntu:xenial
  MAINTAINER firemound #Brendan Boyd

  ENV DEBIAN_FRONTEND noninteractive

  RUN apt-get update
  RUN apt-get upgrade -q -y
  RUN apt-get dist-upgrade -q -y

  RUN apt-get install -y apt-utils
  RUN apt-get install -y sudo
  RUN apt-get install -y figlet
  RUN apt-get install -y strace
  RUN apt-get install -y curl
  RUN apt-get install -y vim
  RUN apt-get install -y git
  RUN apt-get install -y tig
  RUN apt-get install -y zsh
  RUN apt-get install -y htop
  RUN apt-get install -y xclip

  RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
  RUN apt-get install -y nodejs
  RUN apt-get install -y python
  RUN apt-get install -y python-pip
  RUN apt-get install -y python-dev
  RUN apt-get install -y libssl-dev
  RUN apt-get install -y rake

  # Install tmux to gain split screen management and screen sharing capabilities
  RUN apt-get install -y tmux

  # Pimp VIM with Nerd Tree and other goodies using the Braintree setup
  WORKDIR /root
  #RUN git clone https://github.com/braintreeps/vim_dotfiles.git
  #WORKDIR /root/vim_dotfiles
  #RUN sh /root/vim_dotfiles/activate.sh

  # Make sure we are using 
  RUN echo 'set encoding=utf-8' >> /root/.vimrc

  # Add an SSH server for social hacking i.e. pair/multi programming and configure run on port 2222
  RUN apt-get install -y openssh-server
  RUN sed -i '/Port 22/c\Port 2222' /etc/ssh/sshd_config
  RUN sed -i '/LogLevel INFO/c\LogLevel VERBOSE' /etc/ssh/sshd_config
  RUN sed -i '/PasswordAuthentication yes/c\PasswordAuthentication no' /etc/ssh/sshd_config 
  RUN mkdir /var/run/sshd
  RUN mkdir /root/.ssh

  # Create an instructive welcome message
  RUN echo 'figlet Instant Blue Banyan IDE' >> /root/.bashrc
  RUN echo 'echo "\n\
  Build 2017.1\n\
  \n\
  *** GET STARTED ***\n\
  tmux is used to maintain concurrent windows.\n\
  Note you can create a new window using ctrl-b c, and you can\n\
  navigate to an existing window using ctrl-b <window>.\n\
  \n\
  SAMPLE BUILD PROCESS...\n\
  $ mkdir new-proj         # create a new project folder\n\
  $ cd new-proj            # make project folder current directory\n\
  $ generator-sdf          # make a new Account Customization project\n\
  $ npm build              # lint your javascript and validate the project with sdf\n\
  $ npm deploy             # deploy to the default account\n\
  \n\
  TIPS\n\
  -- An SSH server makes it possible to share tmux session\n\
  ---- Pair programmers join tmux sessions using $ tmux a -t pair\n\
  \n\
  Enjoy! Ping me with feature requests via https://twitter.com/firemound\n\
  "' >> /root/.bashrc

  # Get dotfiles
  # WORKINGDIR /home
  # RUN git clone https://github.com/BlueBanyanSolutions/dotfiles.git ~/.dotfiles

  # Pimp Emacs with Spacemacs and plugins
  # RUN sh ~/.dotfiles/scripts/install/pkg_emacs.sh
  # RUN git clone --recursive https://github.com/joaotavora/yasnippet ~/.emacs.d/plugins/yasnippet
  # RUN git clone https://github.com/firemound/ns-snippets.git ~/.emacs.d/private/snippets/js2-mode

  # Install the SDF CLI
  # RUN sh ~/.dotfiles/scripts/install/pkg_sdfcli.sh

  # Clean up APT when done.
  RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

  # On entry, start sshd, copy pair programming keys into authorized keys, and run bash
  ENTRYPOINT service ssh start && cp /root/.import/authorized_keys /root/.ssh/ && tmux new -n editor -s bluebanyan-ide 'emacs -nw' \; split-window -d

  # Start user in their source code directory...
  WORKDIR /src

