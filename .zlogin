# Execute code only if STDERR is bound to a TTY.
if [[ -o INTERACTIVE && -t 2 ]]; then
    fortune -s | pokemonsay
fi >&2
