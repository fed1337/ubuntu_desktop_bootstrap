#!/usr/bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install 24
npm install -g pnpm
which node >/dev/null && sudo ln -sf "$(which node)" /usr/local/bin/node
which npx >/dev/null && sudo ln -sf "$(which npx)" /usr/local/bin/npx
which pnpm >/dev/null && sudo ln -sf "$(which pnpm)" /usr/local/bin/pnpm
