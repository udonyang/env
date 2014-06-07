#!/bin/sh
echo \
	"Dwylkz's Codeforces© data digger.\n"\
	"	usage:		dcd.sh INNAME OUTNAME FILE\n"\
	"	INNAME:		specify a file to store input data.\n"\
	"	OUTNAME:	specify a file to store output data.\n"\
	"	FILE:			input file.\n"
awk -v i="$1" -v o="$2" -f digger.awk "$3"
