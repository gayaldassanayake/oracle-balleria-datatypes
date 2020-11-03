from random import choice

def generateString():
    x=""
    for i in range(999):
        x+=choice("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

    print(x, len(x))
