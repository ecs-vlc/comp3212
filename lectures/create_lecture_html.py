#!/usr/bin/env python3

import re
import yaml
import subprocess
import os
import shutil

def add_file(html, file, description, location):
    fullfile = f"../site/{location}/{file}"
    if os.path.isfile(fullfile):
        html.write(f"<li> <a href=\"{location}/{file}\">{description}</a></li>\n")


def extract(str):
    _, endpart = str.split("{")
    mid, _ = endpart.split("}")
    return mid


    
def preamble(html):
    html.write('''<HTML>
    <HEAD>
    <TITLE>Lecture Notes COMP3212
    </TITLE>
    </HEAD>

    <H1 align="center">Lecture Notes</H1>

    <h2>Lectures on Computational Biology</h2>

    <ol>
    ''')

def getKeywords(file) :
    with open(file, "r") as file:
        lesson = ""
        cnt = 0
        for line in file:
            cnt = cnt + 1
            m = re.search("\\\\lesson\\{(.+?)\\}", line)
            if m:
                lesson = m.group(1)
            m = re.search("\\\\keywords\\{(.+?)\\}", line)
            if m: 
                return lesson, m.group(1)
            if cnt>10:
                break
        return lesson, ""
        
def add_lectures(html, lectures):
    for lecture in lectures:
        tex = f"{lecture}.tex"
        lesson, keywords = getKeywords(tex)
        html.write(f"<div id=\"{lecture}\">")
        html.write(f"<li><b>{lesson}</b>: {keywords}\n")
        html.write(f"<ul> <li> <a href=\"lectures_pdf/{lecture}.pdf\">Lecture PDF</a>,\n")
        html.write(f"  <a href=\"lectures_pdf/{lecture}_prn.pdf\">Printable PDF</a>,\n")
        html.write(f"  <a href=\"lectures_pdf/{lecture}_prn_4.pdf\">(4 per page)</a>,\n")
        html.write(f"  <a href=\"lectures_pdf/{lecture}_prn_8.pdf\">(8 per page)</a>,\n</li>\n")
        add_file(html, f"{lecture}-subsidiary.pdf", "Notes", "notes_pdf")
        html.write("</ul>")
        html.write("\n")
        html.write("</li>\n")
        html.write("</div>")

def endpage(html):
    html.write('''
    </ol>

    <ul>
    <li> <a href="lecture_pdf/lectures_8.pdf">Complete set of Notes</a></li>
    </ul>


    </HTML>
    ''')

def git_update():
    subprocess.call(["git", "add", ".."])
    subprocess.call(["git", "commit", "-m", "\"update lectures\""])
    subprocess.call(["git", "push"])

def main():
    dir = "/Users/apb1/Documents/teaching/courses/COMP3212/github/site/"
    with open("lectures.tex", "r") as f:
        lectures = [extract(line) for line in f if re.search("^\\\\lecture{", line)]
    
    with open(f"{dir}/lectures.html", "w") as html:
        preamble(html)
        add_lectures(html, lectures)
        endpage(html)

    git_update()

if __name__ == '__main__':
    main()
