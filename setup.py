"""
@file   Set up various aspects of my terminal workflow on UNIX systems
@author Quinn Smith
"""
import argparse
from dotfile import *
def getArgs():
    parser = argparse.ArgumentParser(description="Set Up My Terminal Workflow")
    parser.add_argument("--unlink", dest="unlink", nargs="*", type=str, help="Unlink dotfiles")
    parser.add_argument("--update", dest="update", nargs="*", type=str, help="Update tags")
    parser.add_argument("--link",   dest="link",   nargs="*", type=str, help="Link dotfiles")
    args = parser.parse_args()
    return args


def main():
    args = getArgs()



if __name__=="__main__":
    main()
