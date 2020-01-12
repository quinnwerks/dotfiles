"""
@file   Set up various aspects of my terminal workflow on UNIX systems
@author Quinn Smith
"""
import argparse
import sys
from manager import *
def getArgs(parser):
    parser_args = parser.parse_args()
    return_args = {"link":set(parser_args.link), \
                   "unlink":set(parser_args.unlink), \
                   "update":set(parser_args.update)}
    return return_args

def setUpParser():
    parser = argparse.ArgumentParser(description="Set Up My Terminal Workflow")
    parser.add_argument("--link",   dest="link",   nargs="*", default=[], type=str, help="Link dotfiles")
    return parser


def main():
    logging.basicConfig(format='%(asctime)s - %(message)s', level=logging.INFO)
    parser = setUpParser()
    args = getArgs(parser)
    if(len(sys.argv)==1):
        parser.print_help(sys.stderr)
    else:
        manager = Manager()
        manager.run(args)



if __name__=="__main__":
    main()
