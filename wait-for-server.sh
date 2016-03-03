#!/bin/bash

seconds=1
tries=30
quietVerbose=--no-verbose
file=/dev/null
url=$1;shift

while test $# -gt 0
do
    case $1 in
        -w|--wait)
            seconds=$2
            shift
            ;;

        -t|--tries)
            tries=$2
            shift
            ;;
        -q|--quiet)
            quietVerbose=$1
            ;;
        -v|--verbose)
            quietVerbose=$1
            ;;
        -o|--output)
            file=$2
            shift
            ;;
        *)
            echo >&2 "Invalid argument: $1"
            echo >&2 ""
            echo >&2 "Usage: wait-for-server <url> [--wait <seconds>] [--tries <tries>] [--quiet|--verbose] [--output <file>]"
            echo >&2 "       wait-for-server <url> [-w <seconds>] [-t <tries>] [-q|-v] [-o <file>]"
            echo >&2 ""
            echo >&2 "       url:     The URL to request on each try."
            echo >&2 "       seconds: Time in seconds to wait between tries. Defaults to 1 second."
            echo >&2 "       tries:   Number of tries before aborting. Defaults to 30 tries."
            echo >&2 "       quiet:   Do not output anything."
            echo >&2 "       verbose: Use detailed output, showing each try."
            echo >&2 "       file:    The file to write the URL response to. Defaults to /dev/null."
            exit 1
            ;;
    esac
    shift
done

if [ -z "$url" ]
then
    echo >&2 "No URL specified"
    exit 1
else
    wget $quietVerbose --output-document $file --waitretry=$seconds --tries=$tries --retry-connrefused $url
fi
