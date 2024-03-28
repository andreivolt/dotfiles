export FZF_DEFAULT_OPTS="\
--bind='ctrl-y:execute-silent(pbcopy <<< {})+abort' \
--info='inline' \
--border \
--cycle \
--multi \
--ansi \
--color fg+:blue \
--color bg:0 --color gutter:0 \
--color hl+:blue --color bg+:235 \
--color pointer:57 \
--color hl:57 \
--color prompt:blue \
--color border:57 \
--color info:240 \
--color spinner:blue \
--color marker:green \
"

export FZF_DEFAULT_COMMAND="\
rg -uu \
--files \
-H"
