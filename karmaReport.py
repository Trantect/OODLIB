import os

def totalCoverage():
    os.system("./node_modules/karma-coverage/node_modules/.bin/istanbul report --root ./report/coverage/ --dir ./report/coverage/")

totalCoverage()
