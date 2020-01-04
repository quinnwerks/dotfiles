"""
@file   File for the manager class.
@author Quinn Smith
"""
import logging
from dotfile import *
class Manager:
    """
    @brief This class manipulates groups of dotfiles
    """
    def __init__(self):
        self.__dotfile_class_map = {"vim":Vimrc}

    def run(self, arg_sets):
        class_map = self.__dotfile_class_map
        for operation in arg_sets:
            file_map = arg_sets[operation]
            if file_map:
                if "all" in file_map:
                    logging.info("Applying %s to all available dotfiles" % operation)
                    file_map = class_map
                else:
                    logging.info("Applying %s to selected files" % operation)
            
                for file_type in file_map:
                    if file_type in class_map:
                        dotfile = class_map[file_type]()
                        dotfile.configure(operation)
                    else:
                        logging.warning("%s is not a supported file type. Skipping operation." \
                                        % file_type)
                            
