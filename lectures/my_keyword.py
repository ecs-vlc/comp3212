#! /usr/bin/python

import sys
#import shutil
#import string
#import re
import fileinput


fn = sys.argv[1]
file = open(fn,'r')
found = False
for line in file:
    if line.find('\keywords{') != -1:
        line = line.replace('\keywords{','')
        found = True
    if found:
        if line.find('}') != -1:
            line = line.replace('}','')
            sys.stdout.write(line)
            sys.exit(0)
        sys.stdout.write(line)

        
    
