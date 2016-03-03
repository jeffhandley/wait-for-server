# wait-for-server
Command-line utility that waits for a server to be responsive

Stop hating yourself for hard-coding sleep statements into your server integration test scripts!

wait-for-server is a command-line utility that waits for a server to become responsive and then exits once a page can be requested.

## Usage

```
Invalid argument: $1

Usage: wait-for-server <url> [--wait <seconds>] [--tries <tries>] [--quiet|--verbose] [--output <file>]
       wait-for-server <url> [-w <seconds>] [-t <tries>] [-q|-v] [-o <file>]

       url:     The URL to request on each try.
       seconds: Time in seconds to wait between tries. Defaults to 1 second.
       tries:   Number of tries before aborting. Defaults to 30 tries.
       quiet:   Do not output anything.
       verbose: Use detailed output, showing each try.
       file:    The file to write the URL response to. Defaults to /dev/null.
```

## Notes

wait-for-server is just a wrapper around the following `wget` command:

```
wget --output-document $file --waitretry=$seconds --tries=$tries --retry-connrefused $url
```

wait-for-server will exit with `wget`'s exit status.  You'll also see the output from `wget`, controlled by the `--quiet` and `--verbose` arguments.  The default is `wget`'s `--no-verbose` option.

