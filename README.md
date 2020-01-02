# SD-Card formatting considerations and benchmarking

This project attempts to make an attempt to answer "does formatting really matter".
* Photographers believe/state they don't loose media often because they format often. However, people who don't format cards often also experience that they do not have media loss. How to deal with an extreme rare event that almost never happen and there is no hard data to go on? 
* Photographers have very strong opinions, claiming that formatting cards yields performance benefits and prolongs life of cards. There clearly are some basis for claims about the importance of how a card is formatted, see SD Card Association notes down the file.

The tangable, messuarable aspect of formatting ought to be messurable;
* Can we demonstrate that how a card is formatted has a clear performance impact?
* Can we demonstrate that a card is faster to write too if there's ones (0xFF...) on the card? (card flash in erased state)

So far, I fail to see any impact at all if we consider 1-2% to be within margin of error. Or if there is an impact, it is not occuring for many sectors.

## Benchmark Sandisk Ultra (16GB) class 10, 12-13GB tests

|    |         |     Windows(exFAT)  | SDCF-Full           | GH5(FAT32)          |
+----+---------+---------------------+---------------------+---------------------+
|  1 | random1 | 12128754 Bytes/sec. | 12396301 Bytes/sec. | 12532854 Bytes/sec. |
|  2 | random2 | 12186485 Bytes/sec. | 12450118 Bytes/sec. | 12508253 Bytes/sec. |
|  3 | ones    | 12255314 Bytes/sec. | 12541014 Bytes/sec. | 12570734 Bytes/sec. |
|  4 | random1 | 12294085 Bytes/sec. | 12508532 Bytes/sec. | 12538049 Bytes/sec. |
|  5 | ones    | 12324653 Bytes/sec. | 12548464 Bytes/sec. | 12614756 Bytes/sec. |
|  6 | random2 | 12295428 Bytes/sec. | 12484910 Bytes/sec. | 12593365 Bytes/sec. |

Test cases:
* Windows(exFAT): card formatted in windows to exFAT, settings that violates SDA recommendations. Full format. Test using large 13 GiB file.
* SDCF-Full: Full format using SD Card Formatter 5.0.1 by Tuxera Inc, downloaded from [SD Card Association sdcard.org](https://www.sdcard.org/downloads/formatter/). Test using four 3GiB files to get under FAT32 limitations.

Note; SDCF-Full (FAT32) vs Windows (formatted with exFAT):
* Formatted to SDA specification appears to yield a 1 - 2% performance improvement. Perhaps to minor to be an actual result, could just be exFAT vs FAT performance or messurement fluke. Or if there is any alignment issue causing the windows format to be slower, it has negible real world impact. 
* Cannot demonstrate any noticeable performance gains upon formatting with either tool compared to just deleting files.
* Cannot demonstrate any noticeable performance gains upon first writing ones to card. Card does not appear to be aware of any potential speed improvements due to all ones on card. 
Note; GH5 card formatting is *superfast*. It also does not change exFAT to FAT32 if card was formatted incorrectly. I have doubts about camera doing much else than a quick format. If it really earases card, card must be bloody fast at erasing.

Note; GH5(FAT32) tests are still processing, not yet complete.

Note; output from formatting with SD Card Formatter:
```
---------------------------
SD Card Formatter
---------------------------
Formatting was successfully completed.

Volume information:
File system: FAT32
Capacity: 14.83 GB (15 923 150 848 bytes)
Free space: 14.83 GB (15 923 118 080 bytes)
Cluster size: 32 kilobytes
Volume label: LUMIX
---------------------------
OK   
---------------------------

``` 

## Purpose of these tests

Photography influencers commonly recommend the following:
* Do not delete files. Instead format.
* Format cards often (before each use?)
* Format card in camera, not in computer.

Typically there are no strong technical reasons presented, more "I do this and I don't have card failure often".

But does these recommendations make any sense?

## What SD-Card Assocication say?

### Formatter FAQ

"Data portability of SD memory cards among SD host products like computers, digital still cameras, digital video camcorders, broadcast recorders, set top boxes, drive recorders, smartphones, drones and many other devices."

"Formatting within FAT parameters optimized for flash memories in SD memory cards for better performance and endurance."

### SD Card File System Specification Version 3.0 (Confidential)

A leaked copy of the File System Specification is available on internet.

It includes various sections of interest:
* CHS parameter recommendation
* Sector size recommendation
* Cluster size recommendation
* Boundary Unit size recommendation

Very interresting tidbits:
* "...shall be determined taking the erase block size of the physical layer into account"
* "Card manufacturers should set this... EraseBlockSize..."

More narrow specifications of FAT/exFAT/etc. Stated purpose: limited for optimization.

Interrestingly, exFAT is only supported for cards > 32896MB in this specifcation.

Speculation; It would appear that that a card not formatted to specification MAY
* Not perform optimally.
* Increase writes to card.
* Possibly not be understood by some SD-Card devices that only support SDA compliant formatting.

E.g. if card is not formatted to specification, the sectors and clusters may not align with card internal flash boundaries, a write could impact many internal flash sectors instead of just one.

## What is earisng and ease block sizes?

[Wikipedia:Flash Memory](https://en.wikipedia.org/wiki/Flash_memory).
Erasing is setting a large number of sectors to 1 (i.e. 0xFFFFFFF...).
A cell containing zeros cannot be written, it must be erased.
"If no erased page is available, a block must be erased before copying data to a page in that block".
