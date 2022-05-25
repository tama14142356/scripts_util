#!/bin/bash
input_name="$1"
output_name="$2"
if [ -z "$output_name" ]; then
    output_name="final.pdf"
fi
ps2pdf -dPDFSETTINGS=/prepress -dCompatibilityLevel=1.4 "$input_name" "$output_name"