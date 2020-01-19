"""
@file   The collection of classes used to link dotfiles 
@author Quinn Smith
"""
import logging
import os
from pathlib import Path
from abc import ABC,abstractmethod

class Dotfile(ABC):
    """
    @brief Abstract class which defines the generic setup of a dotfile.
    """
    def __init__(self):
        self.__home_file   = ""
        self.__file_subdir = ""
        self.__comment_tok = ""
        self.__link_map    = {} 
        self.setVars()
    
    def configure(self, arg):
        if arg is "link":
            self.link()
        elif arg is "unlink":
            self.unlink()
        elif arg is "update":
            self.update()
        else:
            logging.warning("%s is not an argument for a dotfile" % arg)

    def link(self):
        self.__findFilesToLink()
        self.__linkFiles()

    def update(self):
        pass

    def unlink(self):
        pass

    def setCommentTok(self, comment_char):
        self.__comment_tok = comment_char

    def setPaths(self, home_file, file_subdir):
        self.__home_file   = home_file
        self.__file_subdir = file_subdir

    def __linkFiles(self):
        f = self.__openHomeFile()
        for link in self.__link_map.values():
            f.write(link)
        f.close

    def __findFilesToLink(self):
        repo_dir = Path(os.path.dirname(os.path.abspath(__file__))) 
        file_dir = Path(repo_dir, self.__file_subdir)
        for _, _, files in os.walk(file_dir): 
            for name in files:
                file_path = Path(file_dir, name)
                comment = self.__getCommentTag(file_path)
                link    = self.__getLink(file_path)
                self.__link_map[comment] = link 
        
        f = self.__createHomeFile()
        for line in f:
            if line in self.__link_map:
                del self.__link_map[line]
        f.close()

    def __getHomeFilePath(self):
        home_dir    = Path.home() 
        file_name   = self.__home_file 
        file_path   = Path(home_dir, file_name)
        return file_path
    
    def __createHomeFile(self):
        file_path = self.__getHomeFilePath()
        file_path.touch(exist_ok=True)
        file_handle = open(file_path, "r")
        return file_handle

    def __openHomeFile(self):
        file_path = self.__getHomeFilePath()
        file_handle = open(file_path, "a")
        return file_handle
    
    def __getLink(self, file_path):
        comment = self.__getCommentTag(file_path)
        source = self.getSourceStr(file_path)
        return "\n%s%s\n" % (comment, source)
    
    def __getCommentTag(self, file_path):
        return "%s<AUTOGEN>:%s\n" % (self.__comment_tok, file_path)

    @abstractmethod
    def setVars(self):
        pass

    @abstractmethod
    def getSourceStr(self, file_path):
        pass

class Vimrc(Dotfile):
    def setVars(self):
        self.setCommentTok("\"")
        self.setPaths(".vimrc", "vim")
    
    def getSourceStr(self, file_path):
        return "try\n\tsource %s\ncatch\nendtry" % (file_path)
        
class Zshrc(Dotfile):
    def setVars(self):
        self.setCommentTok("#")
        self.setPaths(".zshrc", "zsh")

    def getSourceStr(self, file_path):
        return "if [ -f %s ]; then\n\tsource %s\nelse\n\tprint \"%s not found\"\nfi" % (file_path, file_path, file_path)

class TmuxConf(Dotfile):
    def setVars(self):
        self.setCommentTok('#')
        self.setPaths(".tmux.conf", "tmux")

    def getSourceStr(self, file_path):
        return "source-file %s" % (file_path)
