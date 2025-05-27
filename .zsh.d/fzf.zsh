export FZF_DEFAULT_OPTS="\
--bind='ctrl-y:execute-silent(pbcopy <<< {})+abort' \
--info=inline \
--border \
--cycle \
--multi \
--wrap \
--ansi \
--color=border:bright-black \
--color=fg+:blue \
--color=bg:-1,gutter:-1 \
--color=hl+:blue,bg+:-1 \
--color=pointer:blue \
--color=hl:blue \
--color=prompt:blue \
--color=border:8 \
--color=info:240 \
--color=spinner:blue \
--color=marker:green
"

export FZF_DEFAULT_COMMAND="\
rg -uu \
--files \
-H"

export FZF_CTRL_R_OPTS="--nth=2.."
