# trasher

## INSTALLATION
Clone the trasher repo


``git clone https://github.com/SethTheDev0/trasher-bash.git``

``cd ~/trasher-bash``


Deploy the trasher scripts


``mkdir -p ~/.local/bin/trasher``

``cp trasher-view trasher-remove trasher-recover ~/.local/bin/trasher/``

``chmod +x ~/.local/bin/trasher/*``


Apply the trasher aliases to ".bashrc"


``alias trasher-view="$HOME/.local/bin/trasher/trasher-view"``

``alias trasher-remove="$HOME/.local/bin/trasher/trasher-remove"``

``alias trasher-recover="$HOME/.local/bin/trasher/trasher-recover"``


Reload bash by source, and done!


``source ~/.bashrc``
