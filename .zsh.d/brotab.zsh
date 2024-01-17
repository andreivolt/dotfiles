_bt_list_colorize() {
    while IFS=$'\t' read -r col1 col2 col3; do
        printf "${fg[magenta]}%s\t${fg[white]}%s\t${fg[blue]}%s${reset_color}\n" "$col1" "$col2" "$col3"
    done
}
