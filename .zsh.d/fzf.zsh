export FZF_DEFAULT_OPTS="\
--bind='ctrl-y:execute-silent(pbcopy <<< {})+abort' \
--info='inline' \
--border \
--cycle \
--multi \
--ansi \
--color fg+:15 \
--color bg:0 --color gutter:0 \
--color hl+:magenta --color bg+:235 \
--color pointer:magenta \
--color hl:magenta \
--color prompt:blue \
--color border:magenta \
--color info:240 \
--color spinner:blue \
--color marker:magenta \
"

export FZF_DEFAULT_COMMAND="\
rg -uu \
--files \
-H"
