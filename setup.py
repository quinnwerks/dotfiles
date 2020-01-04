"""
@file   Set up various aspects of my terminal workflow on UNIX systems
@author Quinn Smith
"""
import argparse
from dotfile import *
def getArgs():
    parser = argparse.ArgumentParser(description="Set Up My Terminal Workflow")
    parser.add_argument("--vim", dest="vim", help="Set up vim workflow", action="store_true")
    parser.add_argument("--all", dest="all", help="Set up all available workflows", action="store_true")
    args = parser.parse_args()
    return {"vim":args.vim, "all":args.all}




def main():
    args = getArgs()
    dfile = Vimrc()
    dfile.configure()



if __name__=="__main__":
    main()
