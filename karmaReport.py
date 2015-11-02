import xml.dom.minidom
import os
import os.path
"""
path = "./karma_report/"
totalTest = 0
totalError = 0


for root,dirs,files in os.walk(path):
    for fn in files:
        dom = xml.dom.minidom.parse(path+fn)
        root = dom.documentElement
        itemList = root.getElementsByTagName('testsuite')
        item = itemList[0]
        tests = item.getAttribute("tests")
        errors = item.getAttribute("errors")
        failures = item.getAttribute("failures")
        totalTest = totalTest + int(tests)
        totalError = totalError + int(errors) + int(failures)
print "============================frontEnd unit test============================="
print
print "totalTest:        " + str(totalTest)
print"totalError:        " + str(totalError)
print
print "==========================================================================="

"""
def totalCoverage():
    os.system("./node_modules/karma-coverage/node_modules/.bin/istanbul report --root ./report/coverage/ --dir ./report/coverage/")

totalCoverage()
