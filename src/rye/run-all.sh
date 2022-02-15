#!/bin/bash

find . -name "compress_*.rye" -print0 | xargs -0 -n1 rye
