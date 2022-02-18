#!/bin/bash

SOURCE="$0"
while [ -h "$SOURCE"  ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
echo "shell dir is: $DIR"

#Linux
#/usr/bin/su  - root  -c   "$DIR/openresty-stop.sh"
#/usr/bin/su  - root  -c   "$DIR/openresty-start.sh"

#当前Mac机器下的stop命令
$DIR/openresty-stop.sh
$DIR/openresty-start.sh