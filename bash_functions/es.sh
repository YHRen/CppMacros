#!/usr/bin/env bash

#  shorthand for submiting an exercise using exercism
#  learn more about exercism: exercism.io/

es () {
    # shorthand to exercism submit
    lang_name=$(basename "$(dirname "$(pwd)")") 
    file_name=$(basename "$(pwd)")
    # map language name to suffix
    local -A name_map=( [bash]=sh [python]=py [vimscript]=vim [go]=go )
    if [[ -v "name_map[$lang_name]" ]]; then
        file_name="${file_name}"."${name_map[$lang_name]}"
    else
        echo "${lang_name}" unsupported yet 1>&2
        exit 1
    fi
    # replace hyphen with underscore
    file_name=${file_name//-/_}

    echo "submiting $file_name ..."
    read -p ">Are you sure?[Y/N]" -n 1 -r
    echo 

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        exercism submit "$file_name"
    else
        echo "submission aborted."
    fi
}

es "$@"
