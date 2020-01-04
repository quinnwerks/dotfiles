"""
@file   Set up various aspects of my terminal workflow on UNIX systems
@author Quinn Smith
"""
import argparse
from manager import *
def getArgs():
    parser = argparse.ArgumentParser(description="Set Up My Terminal Workflow")
    parser.add_argument("--unlink", dest="unlink", nargs="*", default=[], type=str, help="Unlink dotfiles")
    parser.add_argument("--update", dest="update", nargs="*", default=[], type=str, help="Update tags")
    parser.add_argument("--link",   dest="link",   nargs="*", default=[], type=str, help="Link dotfiles")
    parser_args = parser.parse_args()
    return_args = {"link":set(parser_args.link), \
                   "unlink":set(parser_args.unlink), \
                   "update":set(parser_args.update)}
    return return_args


def main():
    logging.basicConfig(format='%(asctime)s - %(message)s', level=logging.INFO)
    args = getArgs()
    print(args)
    manager = Manager()
    manager.run(args)



if __name__=="__main__":
    main()
