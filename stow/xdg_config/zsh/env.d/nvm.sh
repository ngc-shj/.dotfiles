# nvm
# Sourcing nvm.sh costs ~130ms per shell, nearly all of it `nvm use default`.
# Every zsh pays env.d, so resolve the default alias by hand and put that
# version's bin on PATH; nvm itself loads on first use (.zshrc). An alias
# that resolves to nothing installed leaves PATH alone, as nvm would.
if [ -d "$XDG_DATA_HOME"/nvm ]; then
    export NVM_DIR="$XDG_DATA_HOME"/nvm

    nvm_default_bin() {
        local alias_name=default target hops versions
        # Aliases chain (default -> lts/* -> lts/krypton -> v24.14.0)
        for hops in 1 2 3 4 5; do
            [[ -r "$NVM_DIR/alias/$alias_name" ]] || break
            alias_name=$(<"$NVM_DIR/alias/$alias_name")
        done
        target=${alias_name#v}
        case $target in
            node|stable) target='' ;;
            *[!0-9.]*|'') return 1 ;;
        esac
        # Newest first; nvm matches whole version components, so "2" is 2.x
        # and never 22.x
        if [[ -n $target ]]; then
            versions=("$NVM_DIR"/versions/node/(v$target|v$target.*)(N/nOn))
        else
            versions=("$NVM_DIR"/versions/node/v*(N/nOn))
        fi
        (( $#versions )) || return 1
        print -r -- "$versions[1]/bin"
    }
    nvm_bin=$(nvm_default_bin) && path_prepend "$nvm_bin"
    unset nvm_bin
    unfunction nvm_default_bin
fi
