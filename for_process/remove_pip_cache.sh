#!/bin/bash
pip cache purge

if [ "$#" -gt 0 ]; then
    cache_dir=$(pip cache dir)
    rm -rf "$cache_dir"
fi
