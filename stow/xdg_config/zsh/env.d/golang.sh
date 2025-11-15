# Golang
if [ -d "$XDG_DATA_HOME"/go ]; then
    export GOPATH="$XDG_DATA_HOME"/go
    export PATH="$GOPATH/bin:$PATH"
fi
