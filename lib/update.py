#!/usr/bin/env python
# -*- coding: utf-8 -*-
#title           :update.py
#description     :This python script updates the actual branch of mocis
#author          :Stefan Baumgartner
#date            :16.06.2018
#version         :1.00
#usage           :python update.py
#notes           :Please change only when you know what you do!!
#python_version  :2.7.6
#=======================================================================
# Import the modules needed to run the script.
import sys, os, wget, zipfile
from shutil import rmtree
url = "https://dev.mocis.sh/mocis.zip"
filename = "/usr/local/bin/mocis"
path = "/usr/local/share/mocis"
setup = wget.download(url)
# Removes the local isntallation
os.remove(filename)
rmtree(path)
# Download the new Files and install it
setup
with zipfile.ZipFile("mocis.zip", "r") as zip_ref:
  zip_ref.extractall("/usr/local/share/")
  os.rename("/usr/local/share/mocis/lib/mocis.sh", "/usr/local/bin/mocis")
  os.chmod('/usr/local/bin/mocis', 0o755)
print '\nNewest version should be installed... \nplease use now mocis --start'