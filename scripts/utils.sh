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
    local args="$@"
    writeln -m "[ ok ]" -c green
    printf "$args\n"
}

write_info() {
    local args="$@"
    writeln -m "[ info ]" -c blue
    printf "$args\n"
}

write_warning() {
    local args="$@"
    writeln -m "[ warning ]" -c yellow
    printf "$args\n"
}

write_error() {
    local args="$@"
    writeln -m "[ error ]" -c red
    printf "$args\n"
}

#region installer file utilities

read_version() {
    # global args: program, default, version
    local msg="enter target version for $program"

    if [ ! -z $default ]; then
        msg+=" (e.g. $default)"
    fi

    write_info $msg
    read -p "version: " version
    [ -z $version ] && version=$default
}

update_system() {
    write_info "updating system"
    apt-get update
}

install_packages() {
    local packages="$@"
    write_info "installing prerequisites"
    apt-get install $packages --yes
}

download_tarball() {
    local url=$1
    local out=$2
    write_info "downloading tarball to $PWD"
    wget $url -O $out
}

clean_up() {
    local artifacts="$@"
    write_info "removing tmp files and build artifacts"
    rm $artifacts --verbose
}

#endregion
