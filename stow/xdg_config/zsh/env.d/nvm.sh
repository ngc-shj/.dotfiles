# nvm
if [ -d "$XDG_DATA_HOME"/nvm ]; then
    export NVM_DIR="$XDG_DATA_HOME"/nvm
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
fi
