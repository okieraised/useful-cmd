#!/bin/sh

# Determine the operating system that is running the script
# - mainly care whether Cygwin
checkOperatingSystem()
{
    operatingSystem="unknown"
    os=`uname | tr [a-z] [A-Z]`
    case "${os}" in
        CYGWIN*)
            operatingSystem="cygwin"
            ;;
        LINUX*)
            operatingSystem="linux"
            ;;
        MINGW*)
            operatingSystem="mingw"
            ;;
    esac
    echo "operatingSystem=$operatingSystem (used to check for Cygwin and filemode compatibility)"
}
