import  re
import ask

with open("lectures.tex", "r") as f:
    for line in f:
        if re.search("lecture{", line):
            _, l = line.split("{")
            print(l)
