# -*- mode: ruby -*-
# vi: set ft=ruby :
# For a complete Vagrant configuration reference, please see the online
# documentation at https://docs.vagrantup.com.

Vagrant.configure("2") do |config|
  config.vm.box = "Feneric/bodhi"
  config.vm.define "nimwasm"
  config.vm.network "private_network", type: "dhcp"
  config.vm.provision "shell", name: "ppas", keep_color: true, inline: <<-SHELL
    # Temporarily turn off automatic updates to avoid interference.
    #systemctl disable apt-daily.service
    systemctl disable apt-daily.timer
    pkill -9 apt-get
    # Add the PPA for the latest Nim release.
    add-apt-repository -y ppa:jonathonf/nimlang
    sleep 30
    echo "***** REPOSITORY ADDED. *****"
  SHELL
  $wasmscript = <<-SHELL
    bash -c 'echo "
# WebAssembly additions
@if emscripten:
  cc = clang
  clang.exe = \"emcc\"
  clang.linkerexe = \"emcc\"
  clang.options.linker = \"\"
  cpu = \"i386\"
  passC = \"-s WASM=1 -s \'BINARYEN_METHOD=\\\"native-wasm\\\"\' -Iemscripten\"
  passL = \"-s WASM=1 -Lemscripten -s TOTAL_MEMORY=335544320\"
@end
" >> /tmp/nim.cfg'
  SHELL
  config.vm.provision "shell", name: "root", upload_path: "/tmp/wasm-shell", inline: $wasmscript
  $rootscript = <<-SHELL
    aptitude -y update
    echo "***** UPDATE FINISHED. *****"
    # ideally we'd like to do the full upgrade here, but it's unreliable.
    aptitude --allow-untrusted -y dist-upgrade
    #aptitude -y safe-upgrade fish
    echo "***** DIST-UPGRADE FINISHED. *****"
    # Install dependencies.
    aptitude -y install nim exuberant-ctags libsdl2-2.0-0 libsdl2-image-2.0-0 libsdl2-gfx-1.0-0 libsdl2-ttf-2.0-0 libsdl2-net-2.0-0 default-jre-headless nginx
    echo "***** INSTALLATION FINISHED. *****"
    # Install Nim libs.
    yes | nimble install opengl png sdl2
    chown -R vagrant:vagrant /home/vagrant/.config
    chsh -s /usr/bin/fish vagrant
    # Turn the automatic updates back on.
    systemctl enable apt-daily.timer
    #systemctl enable apt-daily.service
    # This funny little dance gets around gnarly quoting issues.
    sed -e '1d;12d' /tmp/wasm-shell > /tmp/nim.cfg
    cat /tmp/nim.cfg >> /etc/nim.cfg
    # Set up Nginx to serve samples.
    ln -s /vagrant/Samples /var/www/html
    sed -i -e 's/sendfile on;/sendfile on;\\n\\tdisable_symlinks off;\\n\\tautoindex on;/' /etc/nginx/nginx.conf
    service nginx restart
  SHELL
  config.vm.provision "shell", name: "root", inline: $rootscript
  config.vm.provision "shell", name: "repositories", keep_color: true, inline: <<-SHELL
    cd /opt
    git clone https://github.com/edc/bass.git
    git clone https://github.com/juj/emsdk.git
    git clone https://bitbucket.org/nimcontrib/ntags.git
    cd ntags
    nimble install
    cp -p ntags /usr/local/bin
    cd ../emsdk
    ./emsdk install latest
    mkdir -p /home/vagrant/.vim/bundle
    cd /home/vagrant/.vim/bundle
    git clone git://github.com/zah/nim.vim.git
    git clone https://github.com/scrooloose/syntastic.git
    cd /opt
    chown -R vagrant:vagrant bass emsdk ntags /home/vagrant/.vim
  SHELL
  $script = <<-SHELL
    cd /home/vagrant
    echo "execute pathogen#infect()" >> .vimrc
    mkdir .vim/autoload
    curl -so .vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
    mkdir -p .config/fish
    cd /opt/bass
    make install
    cd ../emsdk
    ./emsdk activate latest
    echo "bass source /opt/emsdk/emsdk_env.sh --build=Release" >> /home/vagrant/.config/fish/config.fish
  SHELL
  config.vm.provision "shell", inline: $script, privileged: false, name: "user"
end
