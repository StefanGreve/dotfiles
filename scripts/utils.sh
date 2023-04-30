#!/bin/bash

writeln() {
    local color=yellow
    local OPTIND verbose=1

    while getopts ":b:m:c:" opt; do
        case $opt in
            b) lf=true ;;
            m) msg=$OPTARG ;;
            c) color=$OPTARG ;;
            *|h) echo "USAGE: writeln -m <message> [-c <color> | -b true ]" && exit 0 ;;
        esac
    done

    case $color in
        red)
            color_code=160 ;;
        blue)
            color_code=25 ;;
        green)
            color_code=40 ;;
        yellow)
            color_code=184 ;;
    esac

    printf "$(tput setaf $color_code)%s$(tput sgr 0) " $msg

    if [ "$lf" == "true" ]; then
        printf "\n"
        lf=false
    fi
}

write_success() {
    writeln -m "[ ok ]" -c green
    printf "$1\n"
}

write_info() {
    writeln -m "[ info ]" -c blue
    printf "$1\n"
}

write_warning() {
    writeln -m "[ warning ]" -c yellow
    printf "$1\n"
}

write_error() {
    writeln -m "[ error ]" -c red
    printf "$1\n"
}
