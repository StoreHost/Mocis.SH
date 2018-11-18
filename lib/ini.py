#!/usr/bin/env python
# -*- coding: utf-8 -*-
#title           :init.py
#description     :This python script creates the Config file 
#author          :Stefan Baumgartner
#date            :16.06.2018
#version         :1.00
#usage           :python init.py
#notes           :Please change only when you know what you do!!
#python_version  :2.7.6
#=======================================================================
# Import the modules needed to run the script.
import sys, os, subprocess, platform
# Reads the Distribution on your System
os = str(platform.dist())
config = ""
oslist = os.split(',')
branchversion1 = os.replace('\'', "")
branchversion2 = branchversion1.replace('(',"")
branchversion3 = branchversion2.replace(')',"")
branchversion4 = branchversion3.replace(',',"")


def f_write_config():
   with open ("/usr/local/share/mocis/config/config.cfg", "w") as OS:
       OS.write('OS = %s\n' % branchversion4[:-1])
       ostxt =  "Your currently installed Linux Distribution is: "
       print ostxt + branchversion4[:-1]
       print 'File created'
       return
def f_write_config_bash():
   with open ("/usr/local/share/mocis/config/config.cfg", "w") as OS:
       OS.write('OS="%s\n"' % branchversion4[:-1])
       print ostxt + branchversion4[:-1]
       print 'File created'
       return


# =======================
#      MAIN PROGRAM
# =======================

# Main Program
if __name__ == "__main__":
    # Launch main menu
    f_write_config()

