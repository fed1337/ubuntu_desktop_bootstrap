#!/usr/bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.8/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install "$1"
which node >/dev/null && sudo ln -sf "$(which node)" /usr/local/bin/node
which npm >/dev/null && sudo ln -sf "$(which npm)" /usr/local/bin/npm
which npx >/dev/null && sudo ln -sf "$(which npx)" /usr/local/bin/npx

wget -qO- https://get.pnpm.io/install.sh | sh -
which pnpm >/dev/null && sudo ln -sf "$(which pnpm)" /usr/local/bin/pnpm
