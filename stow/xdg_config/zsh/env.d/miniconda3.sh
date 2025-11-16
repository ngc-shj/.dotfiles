# >>> conda initialize >>>
# Lazy load conda to improve shell startup time
# Conda initialization is deferred until first use of conda command

# Check if conda exists
if [ -f "$HOME/miniconda3/bin/conda" ]; then
    # Add conda to PATH but don't initialize yet
    export PATH="$HOME/miniconda3/bin:$PATH"

    # Create a lazy-loading wrapper function
    conda() {
        unfunction conda

        # Now actually initialize conda
        __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
                . "$HOME/miniconda3/etc/profile.d/conda.sh"
            fi
        fi
        unset __conda_setup

        # Call conda with the original arguments
        conda "$@"
    }
fi
# <<< conda initialize <<<
