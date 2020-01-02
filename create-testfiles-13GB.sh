#!/bin/bash

GIGS=13

create_dir() {
	local FILE=$1
	local SRC=$FILE.bin
	local DIR=$FILE.dir
	local DST=$DIR/test.bin
	[[ -d $DIR ]] || mkdir $DIR
	[[ -f $DST ]] || cp $SRC $DST
}

set -x
[[ -f random1.bin ]] || dd if=/dev/urandom of=random1.bin bs=1G count=$GIGS iflag=fullblock
[[ -f random2.bin ]] || dd if=/dev/urandom of=random2.bin bs=1G count=$GIGS iflag=fullblock
[[ -f zeros.bin ]]   || dd if=/dev/zero    of=zeros.bin   bs=1G count=$GIGS iflag=fullblock
[[ -f ones.bin ]]    || dd if=/dev/zero bs=1G count=$GIGS iflag=fullblock | tr "\000" "\377" > ones.bin

create_dir random1
create_dir random2
create_dir zeros
create_dir ones
