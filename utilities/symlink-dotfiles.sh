#!/bin/bash

update () {
    file="$@"
    base_file=~/.$file

    if [ -h "$base_file" ]; then
        if [[ $(readlink "$base_file" 2>/dev/null) == "$file" ]]; then
            # file already symlinked
            return
        fi
    else
        if [ -f "$base_file" ]; then
            # file exists, rename
            mv "$base_file" "${base_file}-$(date +%s)"
        fi

        # symlink to correct file
        ln -s "$file" "$base_file"
        return
    fi

    echo "Skipping $file (unknown type)"
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