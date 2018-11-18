#!/usr/bin/env python
# -*- coding: utf-8 -*-
# title           :Mocis.py
# description     :This program displays an interactive menu on CLI
# author          :Stefan Baumgartner
# date            :10.06.2018
# version         :0.1
# usage           :python menu.py
# notes           :This is just the Overlay
# python_version  :3.6
# =======================================================================
# Import the modules needed to run the script.
import sys, os, subprocess, platform

# Main definition - constants
menu_actions = {}
menu_actions_installer1 = {}
config = "/usr/local/share/mocis/config/config.cfg"
repo_uni = "/usr/local/share/mocis/repo/uni"
repo = "/usr/local/share/mocis/repo"
# =======================
#     Core Variables
# =======================
print_main_menu = '''
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#   Welcome                                     #
#   Please choose the menu you want to start:   #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#  
#   1. Benchmark                                #
#   2. Installation                             #
#   3. Interfaces                               #
#   4. Docker                                   #
#   5. Security                                 #
#   6. About                                    #
#   7. Feedback                                 #
#   8. Licence                                  #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
#                   [Q] Quit                    #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
'''
print_sub_m1 = '''
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#   Chose your favorite Benchmark !             #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#   1. Mocis                                    #
#   2. Storage-Plan                             #
#   3. Bench @Iandk                             #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
#           [-] Back | [Q] Quit                 #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
'''
print_sub_m2 = '''
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#     Welcome to the Installtain section !      #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#   1.Webserver                                 #
#-------------------PHP-------------------------#
#   2.PHP 5/7                                   #
#-----------------DATABASE----------------------#
#   3.MySQL, Mariadb, Mongodb,...               #
#------------------SHARES-----------------------#
#   5.NFS                                       #
#   6.OpenMediaVault                            #
#------------------Proxmox----------------------#
#   7.Proxmox-CE                                #
#   8.Proxmox Mail                              #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
#           [-] Back | [Q] Quit                 #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
'''
print_sub_m2_1 = '''
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#       Welcome to the Webserver section !      #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#   1.  Apache2.4                               #
#   2.  Nginx                                   #
#   3.  lighttpd                                #
#   4.  LAMP-PHP7     (Apache2, PHP, MariaDB)   #
#   5.  IMSCP         (Website Interface)       #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
#           [-] Back | [Q] Quit                 #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
'''
print_sub_m2_2 = '''
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#           Welcome to the PHP section !        #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#   1.  PHP7.0 Common                           #
#   2.  PHP5   Common       (Out of Date)       #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
#           [-] Back | [Q] Quit                 #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
'''
print_sub_m2_3 = '''
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#           Welcome to the PHP section !        #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#   1.  MySQL                                   #
#   2.  MariaDB                                 #
#   3.  MongoDB                                 #
#   4.  PostgreSQL                              #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
#           [-] Back | [Q] Quit                 #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
'''
print_sub_m3 = '''
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#              Chose your Interface             #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#   1.Easy-Webinterface                         #
#   2.Webmin                                    #
#   3.Nextcloud                                 #
#   4.PhpMyAdmin                                #
#   5.Sinusbot                                  #
#   6.Gitlab-CE                                 #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
#           [-] Back | [Q] Quit                 #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
'''
print_sub_m4 = '''
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#             Docker Installation !             #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#--------------Core Installation----------------#
#   1. Docker-CE                                #
#   2. Docker-Compose                           #
#------------------Services---------------------#
#   3. Portainer-Webinterface                   #
#   4. Swirl-Webinterface                       #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
#            [-] Back | [Q] Quit                #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
'''
print_sub_m5 = '''
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#           Let's Secure your Server !          #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#   1. Let's Encrypt                            #
#   2. Teampass                                 #
#   3. Smark Checker                            #
#   4. OpenVPN                                  #
#   5. Password generator                       #
#   6. vmWare Tools                             #
#   7. Fail2Ban                                 #
#   8. SSH Key Importer                         #
#   9. SSH Key Generator                        #
#  10. rkhunter                                 #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
#        [+] Next | [-] Back | [Q] Quit         #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
'''
print_sub_m6 = '''
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#   Hello and Welcome to the About section !    #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Mocis is a free and easy to use application,  #
# which allows you to install many servives and #
# also has built in Benchmarking tool and       #
# security related installations                #
#                                               #
# Thanks to all helper and active testers:      #
#                                               #
# Thhunder                                      #
# iTweek (ts3-server.ch)                        #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
#            [-] Back | [Q] Quit                #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
'''
print_sub_m7 = ''' 
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#      Welcome to the Feedback section!         #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Thank you for your intrest to give us         #
# your feedback.                                #
# Sadly there is actualy a problem to submit    #
# your feedback directly from this menu.        #
# But we would like if you take 10 seconds and  #
# write your resume on our Twitter wall.        #
#                                               #
# Twitter: mocis_sh                             #
#                                               #
# Thank you for your Intrest                    #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
#            [-] Back | [Q] Quit                #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
'''
print_sub_m8 = '''
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#  MIT Licence -Copyright (c) 2017-2018 Mocis   #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Permission is hereby granted, free of charge, #
# to any person containing a Copy of this       #
# software and associated documentation files   #
# (the 'Software'), to deal in teh Sofware      #
# whitout restriction, including without        #
# limitation the rights to use, copy, modify,   #
# merge, publish, distribute, sublicense,       #
# and/or sell copies of the Software, and to    #
# permit persons to whom the Software is        #
# funished to do so, subject to the following   #
# conditions:                                   #
#                                               #
# The above copyright nmotice and this          #
# permission notice shall be included in all    #
# copies or substantial portions of the Software#
#                                               #
# THE SOFTWARE IS PROVIDED 'AS IS' WHITOUT      #
# WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,     #
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES   #
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR  #
# PURPOSE AND NININFRIGMENT. IN NO EVENT SHALL  #
# THE AUTHORS OR COPYRIGHT HILDERS BE LIABLE    #
# FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,    #
# WHETHER IN AN ACTUON OF CONTRACT, TORT OR     #
# OTHERWISE, ARISTING FROM, OUT OF OR IN        #
# CONNECTION WITH THE SOFTWARE OR THE USE OR    #
# OTHER DEALINGS IN THE SOFTWARE                #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
#            [-] Back | [Q] Quit                #
#-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-#
'''


# =======================
#     Call Functions
# =======================
def f_sh_test():
    os.system('clear')
    platform.release()


def f_sh_mocis():
    os.system('clear')
    os.chdir(repo_uni)
    os.chmod('mocis_bench.sh', 0o777)
    subprocess.call("./mocis_bench.sh", shell=True)
    print('Thanks for using our Benchmark')
    return

def f_sh_storageplan():
    os.system('clear')
    os.chdir(repo_uni)
    subprocess.call("bash ensky_bench", shell=True)
    print('Thanks for using storage-plan benchmark')
    return


def f_sh_iandk():
    os.system('clear')
    os.chdir(repo_uni)
    subprocess.call("bash ian_bench.sh", shell=True)
    print('Thanks for using Iandk benchmark')
    return


# Webserver
#
def f_sh_apache():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_apache", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_nginx():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_nginx", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_lighttpd():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_lighttpd", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_php70_lamp():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_php70_lamp", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_imscp():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_imscp", shell=True)
    print('if error encured please use the feedback function')
    return


# PHP7 Verions
#
def f_sh_php70_common():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_php70_common", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_php5_common():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_php5_common", shell=True)
    print('if error encured please use the feedback function')
    return


# Datenbankserver
#
def f_sh_mysql():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_mysql", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_mariadb():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_mariadb", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_mongodb():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_mongodb", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_postgresql():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_postgresql", shell=True)
    print('if error encured please use the feedback function')
    return


# GIT Server
#
def f_sh_gitlab():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_gitlab", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_nfs():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_nfs_server", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_omv():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_openmediavault", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_pve():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_proxmoxhyper", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_pve_mail():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_proxmoxmailgw", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_easywi():
    os.system('clear')
    subprocess.call("bash easy-wi_install.sh", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_webmin():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_webmin", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_nextcloud():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_nextcloud", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_phpmyadmin():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_phpmyadmin", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_sinusbot():
    os.system('clear')
    os.chdir(repo_uni)
    subprocess.call('perl Sinusbot.pl', shell=True)
    print('DEMO-Content')
    return


# Security
#
def f_sh_ssl():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_cert_ssl", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_teampass():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_teampass", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sh_smartcheck():
    os.system('clear')
    print('if error encured please use the feedback function')
    return


def f_sh_ovpn():
    os.system('clear')
    os.chdir(repo_uni)
    os.subprocess('bash openvpn-install', shell=True)
    print('Thank your for securing your server')
    return


def f_py_pwgen():
    import random
    chars = 'abcdefghijklmnopqrsuvwxyz._=!?>+*%&/()ABCDEFGHIJKLMNOPQRSUVW1234567890@'
    length = input('Password lenght?')
    length = int(length)
    password = ''
    # for c in range(length)
    password = random.choice(chars)
    print(password)


def f_docker_ce():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_docker_ce", shell=True)
    print('if error encured please use the feedback function')
    return


def f_vmware_tools():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_vmware", shell=True)
    print('if error encured please use the feedback function')
    return


def f_fail2ban():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_fail2ban", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sshkey_imp():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_sshkey_imp", shell=True)
    print('if error encured please use the feedback function')
    return


def f_sshkey_gen():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_sshkey_gen", shell=True)
    print('if error encured please use the feedback function')
    return


def f_rkhunter():
    os.system('clear')
    os.chdir(repo)
    subprocess.call("bash installation --call_rkhunter", shell=True)
    print('if error encured please use the feedback function')
    return


# =======================
#     MENUS FUNCTIONS
# =======================
# Main menu
def main_menu():
    os.system('clear')
    print(print_main_menu)
    choice = raw_input(" >>  ")
    exec_menu(choice)
    return


# Menu 1
def sub_menu1():
    print(print_sub_m1)
    choice = raw_input(" >>  ")
    exec_menu1(choice)
    return


# Menu 2
def sub_menu2():
    print(print_sub_m2)
    choice = raw_input(" >>  ")
    exec_menu2(choice)
    return


# Menu 3
def sub_menu3():
    print(print_sub_m3)
    choice = raw_input(" >>  ")
    exec_menu3(choice)
    return


# Menu 4
def sub_menu4():
    print(print_sub_m4)
    choice = raw_input(" >>  ")
    exec_menu4(choice)
    return


# Menu 5
def sub_menu5():
    print(print_sub_m5)
    choice = raw_input(" >>  ")
    exec_menu5(choice)
    return


# Menu 6
def sub_menu6():
    print(print_sub_m6)
    choice = raw_input(" >>  ")
    exec_menu(choice)
    return


# Menu 7
def sub_menu7():
    print(print_sub_m7)
    choice = raw_input(" >>  ")
    exec_menu(choice)
    return


# Menu 8
def sub_menu8():
    print(print_sub_m8)
    choice = raw_input(" >>  ")
    exec_menu(choice)
    return


# Sub Menu 2.1
def sub_menu2_1():
    print(print_sub_m2_1)
    choice = raw_input(" >>  ")
    exec_sub_menu2_1(choice)
    return


# Sub Menu 2.2
def sub_menu2_2():
    print(print_sub_m2_2)
    choice = raw_input(" >>  ")
    exec_sub_menu2_2(choice)
    return


# Sub Menu 2.3
def sub_menu2_3():
    print(print_sub_m2_3)
    choice = raw_input(" >>  ")
    exec_sub_menu2_3(choice)
    return


# Execute menu
def exec_menu(choice):
    os.system('clear')
    ch = choice.lower()
    if ch == '':
        menu_actions['main_menu']()
    else:
        try:
            menu_actions[ch]()
        except KeyError:
            print("Invalid selection, please try again.\n")
            menu_actions['main_menu']()
    return


# Execute installation menu 1
def exec_menu1(choice):
    os.system('clear')
    ch = choice.lower()
    if ch == '':
        menu_actions['sub_menu1']()
    else:
        try:
            menu_actions_installer1[ch]()
        except KeyError:
            print("Invalid selection, please try again.\n")
            menu_actions_installer1['sub_menu1']()
    return


# Execute installation menu 2
def exec_menu2(choice):
    os.system('clear')
    ch = choice.lower()
    if ch == '':
        menu_actions2['sub_menu2']()
    else:
        try:
            menu_actions2[ch]()
        except KeyError:
            print("Invalid selection, please try again.\n")
            menu_actions2['sub_menu2']()


# Execute installation menu 3
def exec_menu3(choice):
    os.system('clear')
    ch = choice.lower()
    if ch == '':
        menu_actions3['sub_menu3']()
    else:
        try:
            menu_actions3[ch]()
        except KeyError:
            print("Invalid selection, please try again.\n")
            menu_actions3['sub_menu3']()


# Execute installation menu 4
def exec_menu4(choice):
    os.system('clear')
    ch = choice.lower()
    if ch == '':
        menu_actions4['sub_menu4']()
    else:
        try:
            menu_actions4[ch]()
        except KeyError:
            print("Invalid selection, please try again.\n")
            menu_actions4['sub_menu4']()


# Execute installation menu 5
def exec_menu5(choice):
    os.system('clear')
    ch = choice.lower()
    if ch == '':
        menu_actions5['sub_menu5']()
    else:
        try:
            menu_actions5[ch]()
        except KeyError:
            print("Invalid selection, please try again.\n")
            menu_actions5['sub_menu5']()


# Execute installation menu 6
def exec_menu6(choice):
    os.system('clear')
    ch = choice.lower()
    if ch == '':
        menu_actions6['sub_menu6']()
    else:
        try:
            menu_actions6[ch]()
        except KeyError:
            print("Invalid selection, please try again.\n")
            menu_actions6['sub_menu6']()


# Execute installation menu 7
def exec_menu7(choice):
    os.system('clear')
    ch = choice.lower()
    if ch == '':
        menu_actions7['sub_menu7']()
    else:
        try:
            menu_actions7[ch]()
        except KeyError:
            print("Invalid selection, please try again.\n")
            menu_actions7['sub_menu7']()


# Execute installation menu 8
def exec_menu7(choice):
    os.system('clear')
    ch = choice.lower()
    if ch == '':
        menu_actions8['sub_menu8']()
    else:
        try:
            menu_actions8[ch]()
        except KeyError:
            print("Invalid selection, please try again.\n")
            menu_actions8['sub_menu8']()


# Execute Submenu Webserver Menu 3
def exec_sub_menu2_1(choice):
    os.system('clear')
    ch = choice.lower()
    if ch == '':
        sub_menu_action2_1['sub_menu2_1']()
    else:
        try:
            sub_menu_action2_1[ch]()
        except KeyError:
            print("Invalid selection, please try again.\n")
            sub_menu_action2_1['sub_menu2_1']()


def exec_sub_menu2_2(choice):
    os.system('clear')
    ch = choice.lower()
    if ch == '':
        sub_menu_action2_2['sub_menu2_2']()
    else:
        try:
            sub_menu_action2_2[ch]()
        except KeyError:
            print("Invalid selection, please try again.\n")
            sub_menu_action2_2['sub_menu2_2']()


def exec_sub_menu2_3(choice):
    os.system('clear')
    ch = choice.lower()
    if ch == '':
        sub_menu_action2_3['sub_menu2_3']()
    else:
        try:
            sub_menu_action2_3[ch]()
        except KeyError:
            print("Invalid selection, please try again.\n")
            sub_menu_action2_3['sub_menu2_3']()


# Back to main menu
def back():
    menu_actions['main_menu']()


# Next Submenu to menu 5
# def next_sub_m5():
# menu_actions['sub_menu_5_2']()

# Back Submenu to menu 2
def back_sub_m2_1():
    menu_actions2['sub_menu2']()


# Exit program
def exit():
    sys.exit()


# =======================
#    MENUS DEFINITIONS
# =======================
# Menu definition
menu_actions = {
    'main_menu': main_menu,
    '1': sub_menu1,  # Menu 2
    '2': sub_menu2,
    '3': sub_menu3,
    '4': sub_menu4,
    '5': sub_menu5,
    '6': sub_menu6,
    '7': sub_menu7,
    '8': sub_menu8,
    '10': f_sh_test,
    '-': back,
    '+': next,
    'q': exit,
}
# Menu definition
menu_actions_installer1 = {
    'sub_menu1': sub_menu1,
    '1': f_sh_mocis,
    '2': f_sh_storageplan,
    '3': f_sh_iandk,
    '-': back,
    '+': next,
    'q': exit,
}
# Menu 2 definition
menu_actions2 = {
    'sub_menu2': sub_menu2,
    '1': sub_menu2_1,
    '2': sub_menu2_2,
    '3': sub_menu2_3,
    '4': f_sh_nfs,
    '5': f_sh_omv,
    '6': f_sh_pve,
    '7': f_sh_pve_mail,
    '-': back,
    '+': next,
    'q': exit,
}
# Menu 3 definition
menu_actions3 = {
    'sub_menu3': sub_menu3,
    '1': f_sh_easywi,
    '2': f_sh_webmin,
    '3': f_sh_nextcloud,
    '4': f_sh_phpmyadmin,
    '5': f_sh_sinusbot,
    '6': f_sh_gitlab,
    '-': back,
    '+': next,
    'q': exit,
}
# Menu 4 definition
menu_actions4 = {
    'sub_menu4': sub_menu4,
    '1': f_docker_ce,
    '2': f_sh_webmin,
    '3': f_sh_nextcloud,
    '4': f_sh_phpmyadmin,
    '5': f_sh_sinusbot,
    '-': back,
    '+': next,
    'q': exit,
}
# Menu 5 definition
menu_actions5 = {
    'sub_menu5': sub_menu5,
    '1': f_sh_ssl,
    '2': f_sh_teampass,
    '3': f_sh_smartcheck,
    '4': f_sh_ovpn,
    '5': f_py_pwgen,
    '6': f_vmware_tools,
    '7': f_fail2ban,
    '8': f_sshkey_imp,
    '9': f_sshkey_gen,
    '10': f_rkhunter,
    '-': back,
    '+': next,
    'q': exit,
}
# SUB Menu 5_2 definition
# menu_actions5 = {
# 'sub_menu5': sub_menu5,
# 'B': back,
# '0': exit,
# }
# Menu 6 definition
menu_actions6 = {
    'sub_menu6': sub_menu6,
    '-': back,
    '+': next,
    'q': exit,
}
# Menu 7 definition
menu_actions7 = {
    'sub_menu7': sub_menu7,
    '-': back,
    '+': next,
    'q': exit,
}
# Menu 8 definition
menu_actions8 = {
    'sub_menu8': sub_menu8,
    '-': back,
    '+': next,
    'q': exit,
}
# Sub Menu 2_1 definition
sub_menu_action2_1 = {
    'sub_menu2_1': sub_menu2_1,
    '1': f_sh_apache,
    '2': f_sh_nginx,
    '3': f_sh_lighttpd,
    '4': f_sh_php70_lamp,
    '5': f_sh_imscp,
    '-': back_sub_m2_1,
    '+': next,
    'q': exit,
}
# Sub Menu 2_2 definition
sub_menu_action2_2 = {
    'sub_menu2_2': sub_menu2_2,
    '1': f_sh_php70_common,
    '2': f_sh_php5_common,
    '-': back_sub_m2_1,
    '+': next,
    'q': exit,
}
# Sub Menu 2_3 definition
sub_menu_action2_3 = {
    'sub_menu2_3': sub_menu2_3,
    '1': f_sh_mysql,
    '3': f_sh_mongodb,
    '4': f_sh_postgresql,
    '-': back_sub_m2_1,
    '+': next,
    'q': exit,
}
# =======================
#      MAIN PROGRAM
# =======================

# Main Program
if __name__ == "__main__":
    # Launch main menu
    main_menu()
    # subprocess.call("python lib/init.py", shell=True)
