#!/bin/bash

create_dir() {
	local FILE=$1
	local DIR=$FILE.dir
	[[ -d $DIR ]] || mkdir $DIR
	[[ -f $DIR/test-000.bin ]] || cp $FILE-000.bin $DIR/test-000.bin
	[[ -f $DIR/test-001.bin ]] || cp $FILE-001.bin $DIR/test-001.bin
	[[ -f $DIR/test-002.bin ]] || cp $FILE-002.bin $DIR/test-002.bin
	[[ -f $DIR/test-003.bin ]] || cp $FILE-003.bin $DIR/test-003.bin
}

set -x
[[ -f random1-000.bin ]] || dd if=/dev/urandom of=random1-000.bin bs=1G count=3 iflag=fullblock
[[ -f random1-001.bin ]] || dd if=/dev/urandom of=random1-001.bin bs=1G count=3 iflag=fullblock
[[ -f random1-002.bin ]] || dd if=/dev/urandom of=random1-002.bin bs=1G count=3 iflag=fullblock
[[ -f random1-003.bin ]] || dd if=/dev/urandom of=random1-003.bin bs=1G count=3 iflag=fullblock

[[ -f random2-000.bin ]] || dd if=/dev/urandom of=random2-000.bin bs=1G count=3 iflag=fullblock
[[ -f random2-001.bin ]] || dd if=/dev/urandom of=random2-001.bin bs=1G count=3 iflag=fullblock
[[ -f random2-002.bin ]] || dd if=/dev/urandom of=random2-002.bin bs=1G count=3 iflag=fullblock
[[ -f random2-003.bin ]] || dd if=/dev/urandom of=random2-003.bin bs=1G count=3 iflag=fullblock

[[ -f ones-000.bin ]]    || dd if=/dev/zero bs=1G count=3 iflag=fullblock | tr "\000" "\377" > ones-000.bin
[[ -f ones-001.bin ]]    || dd if=/dev/zero bs=1G count=3 iflag=fullblock | tr "\000" "\377" > ones-001.bin
[[ -f ones-002.bin ]]    || dd if=/dev/zero bs=1G count=3 iflag=fullblock | tr "\000" "\377" > ones-002.bin
[[ -f ones-003.bin ]]    || dd if=/dev/zero bs=1G count=3 iflag=fullblock | tr "\000" "\377" > ones-003.bin

create_dir random1
create_dir random2
create_dir ones
