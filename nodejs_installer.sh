#!/usr/bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
source "/.nvm/nvm.sh"
nvm install 24
corepack enable pnpm
which node >/dev/null && sudo ln -sf "$(which node)" /usr/local/bin/node
which npx >/dev/null && sudo ln -sf "$(which npx)" /usr/local/bin/npx
which pnpm >/dev/null && sudo ln -sf "$(which pnpm)" /usr/local/bin/pnpm
