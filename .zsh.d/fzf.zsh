export FZF_DEFAULT_OPTS="\
--ansi \
--bind='ctrl-y:execute-silent(pbcopy <<< {})+abort' \
--border \
--cycle \
--highlight-line \
--info=inline \
--preview-window=wrap \
--wrap \
--tiebreak=index \
"

export FZF_DEFAULT_COMMAND="\
rg -uu \
--files \
-H"

export FZF_CTRL_R_OPTS="--nth=2.."

