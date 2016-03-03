#!/bin/bash

wait=0
waitretry=1
tries=30
url=


while test $# -gt 0
do
    case $1 in
        -w|--wait)
            wait=$2
            shift
            ;;
        -r|--waitretry)
            waitretry=$2
            shift
            ;;

        -t|--tries)
            tries=$2
            shift
            ;;
        -u|--url)
            url=$2
            shift
            ;;
        *)
            echo >&2 "Invalid argument: $1"
            echo >&2 ""
            echo >&2 "Usage: wait-for-server [--waitretry <seconds>] [--tries <tries>] --url <url>"
            echo >&2 "       wait-for-server [-w <seconds>] [-t <tries>] -u <url>"
            echo >&2 ""
            echo >&2 "       seconds: Time in seconds to wait between checks. Defaults to 1 second."
            echo >&2 "       tries:   Number of tries before aborting. Defaults to 30 tries."
            echo >&2 "       url:     The URL to request on each try."
            exit 1
            ;;
    esac
    shift
done

[ -z "$url" ] && ( echo >&2 "No URL specified"; exit 1 )
if [ $wait -gt 0 ]; then sleep $wait; fi

wget --output-document /dev/null --waitretry=$waitretry --tries=$tries --retry-connrefused $url
