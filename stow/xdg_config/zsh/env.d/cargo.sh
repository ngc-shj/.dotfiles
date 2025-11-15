# cargo
if [ -d "$XDG_DATA_HOME"/cargo ]; then
    export CARGO_HOME="$XDG_DATA_HOME"/cargo
    source $CARGO_HOME/env
fi
