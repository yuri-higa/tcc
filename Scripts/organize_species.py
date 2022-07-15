import os
import shutil

# from Bio import SeqIO: can be useful in the future
# https://biopython.org/DIST/docs/tutorial/Tutorial.html#sec2

# count the number of files processed
count = 0
for directory, subdirectories, files in os.walk("./"):
    break
# <files> is a list with all files from this path
# print(files)

for filename in files:
    # print(filename)

    # hidden files must be skipped
    if(filename == ".RData" or filename== ".Rhistory"):
        continue

    # read fasta file
    f = open(filename,"r",encoding="utf8", errors='ignore')
    line = f.readline()
    seq = line.split(" ")

    #extract species' name

    #PAY ATTETION:
    # exceptions: this line does not contain the specie name
    if len(seq) > 2:
        id = seq[0]
        name = seq[1] + " " + seq[2]
    else:
        print("******************")
        print(seq[0])

    # To print name, id and filename
    # print("###############################")
    # print(name) 
    # print(id)
    # print(filename)

    # folder_list has the name of each folder from this path ("./")
    folder_list = []

    # boolean to control if we have to create a new folder
    create_new_folder = True
    for (dirpath, dirnames, filenames) in os.walk("./"):
        folder_list.extend(dirnames)
        break
    for folder in folder_list:
        if (folder == name):
            create_new_folder = False   

    # if any folder of folder_list has the name of this specie: 
    if (create_new_folder == True):
        # create a new folder for this specie and then move it
        os.mkdir(name)
        # move to "./<name>"
        shutil.move(filename,"./"+name)
    # if threre is already a folder for this specie:   
    else:
        # just move
        shutil.move(filename,"./"+name)
    count+=1
    # to print how many files were moved
    #print(count)