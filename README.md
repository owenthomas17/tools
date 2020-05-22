# Intro
This script doesn't aim to achieve much by itself. It stems from wanting to check my local internet connection
against various places of the internet in order to determine if my ISP is having problems or not. It provides enough
raw data to later perform some analysis against with the least dependencies possible. It produces output that is
human readable and is easy to parse for further scripts

## Websites file Example
```bash
$ ls -l  websites
-rw-r--r-- 1 owen owen 71 Mar 31 12:29 websites
$ cat websites
https://google.com
https://bbc.co.uk
http://192.168.0.1
```

## Example usage
By default the script reads a file called `websites`, it performs a curl against each website, records the time
it took to complete a TCP 3 way handshake and formats/prints the results to stdout. 

Overrides
- You can override the file name by passing the name/path as `$1` the default is `websites`
- You can override the check interval by passing an int as `$2` the default is 5 seconds

```bash
$ sh checkConnection.sh
Timestamp            Site                           DNS_RTT         Request_RTT
13:58:26-22-05-20    https://google.com             0.039036        0.072523
13:58:26-22-05-20    https://bbc.co.uk              0.020391        0.059398
13:58:26-22-05-20    http://192.168.0.1             0.000233        0.004511
13:58:32-22-05-20    https://google.com             0.013081        0.075408
13:58:33-22-05-20    https://bbc.co.uk              0.021771        0.056940
13:58:33-22-05-20    http://192.168.0.1             0.000395        0.004084
```
