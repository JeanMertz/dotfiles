#!/bin/bash

update () {
    file="$@"
    base_file=~/.$file

    if [ -h "$base_file" ]; then
        if [[ $(readlink "$base_file" 2>/dev/null) == "$(pwd)/$file" ]]; then
            # file already symlinked
            log "$(pwd)/$file already symlinked to $base_file, skipped"
            return
        fi
    else
        if [ -e "$base_file" ]; then
            # file exists, rename
            new_name = "${base_file}-$(date +%s)"
            mv "$base_file" "$new_name"
            log "$base_file already exists, renamed to $new_name"
        fi

        # symlink to correct file
        ln -s "$(pwd)/$file" "$base_file"
        log "$(pwd)/$file symlinked to $base_file"
        return
    fi

    echo "Skipping $(pwd)/$file (unknown type)"
}


dirupdate () {
    for file in ${@}*; do
	case $file in
	    gitup)
		continue
		;;
	esac

	update "$file"
    done
}

dirupdate
