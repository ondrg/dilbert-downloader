#!/bin/sh

SCRIPT_FILE='dilbert.sh'
WANTED_DATE='2018-12-01'
FILE_EXTENSION='.gif'
OUTPUT_FILE="$WANTED_DATE$FILE_EXTENSION"

print_error()
{
        echo "ERROR: $1" >&2
	exit 1
}


if [ ! -f "$SCRIPT_FILE" ]; then
	print_error "Script '$SCRIPT_FILE' does not exists!"
fi

sh "$SCRIPT_FILE" "$WANTED_DATE" "$WANTED_DATE"

if [ ! -f "$OUTPUT_FILE" ]; then
	print_error "Output file '$OUTPUT_FILE' does not exits!"
fi

if [ ! -s "$OUTPUT_FILE" ]; then
	print_error "Output file '$OUTPUT_FILE' is empty!"
fi

rm -f "$OUTPUT_FILE"


exit 0
