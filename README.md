# Intro

By default the script reads a file called `websites`, it performs a curl against each website, records the time
and formats/prints the results to stdout. 

Overrides
- You can override the file name by passing the name/path as `$1` the default is `websites`
- You can override the check interval by passing an int as `$2` the default is 5 seconds

## Websites file Example
```bash
$ ls -l  websites
-rw-r--r-- 1 owen owen 71 Mar 31 12:29 websites
$ cat websites
google.com
bbc.co.uk
```

## Example usage
```bash
$ sh checkConnection.sh
Timestamp            Site                           RTT
13:37:40-31-03-20  google.com                     0.020471
13:37:40-31-03-20  bbc.co.uk                      0.021049
13:37:45-31-03-20  google.com                     0.022137
13:37:45-31-03-20  bbc.co.uk                      0.022437
```
