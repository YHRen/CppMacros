#!/usr/bin/env bash

#  shorthand for submiting an exercise using exercism
#  learn more about exercism: exercism.io/

es () {
    # shorthand to exercism submit
    lang_name=$(basename "$(dirname "$(pwd)")") 
    file_name=$(basename "$(pwd)")
    # map language name to suffix
    local -A name_map=( [bash]=sh [python]=py [vimscript]=vim [go]=go [rust]=rs )
    if [[ -v "name_map[$lang_name]" ]]; then
        if [[ "$lang_name" != "rust" ]]; then
            file_name="${file_name}"."${name_map[$lang_name]}"
        else
            file_name="src/lib.rs"
        fi
    else
        echo "${lang_name}" unsupported yet 1>&2
        exit 1
    fi
    # replace hyphen with underscore
    file_name=${file_name//-/_}

    echo "submiting $file_name ..."
    read -p ">Are you sure?[Y/N]" -n 1 -r
    echo 
    
    if [[ ! -f "$file_name" ]]; then
        echo "Could  not find file $file_name" >&2
        return 1
    fi

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        exercism submit "$file_name"
    else
        echo "submission aborted."
    fi
}

es "$@"
