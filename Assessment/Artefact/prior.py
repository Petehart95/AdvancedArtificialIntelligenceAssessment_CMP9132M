import sys
import random

def sampleVariable(vari, value):
  sampledValue = None
  randnum = random.random()
 
  value1 = None
  value2 = None
  
  #print (value)
  for i in range(len(vari)):
    value1 = vari["+"+value]
    value2 = vari["-"+value]
  if randnum<value1: 
    sampledValue = "+"+value
  else:
    sampledValue = "-"+value

  return sampledValue


vars = ["B", "E", "A", "J", "M"]

varB = {}
varB["+b"] = 0.001
varB["-b"] = 0.999

varE = {}
varE["+e"] = 0.002
varE["-e"] = 0.998

varA = {}
varA["+a|+b +e"] = 0.95
varA["+a|+b -e"] = 0.94
varA["+a|-b +e"] = 0.29
varA["+a|-b -e"] = 0.001
varA["-a|+b +e"] = 0.05
varA["-a|+b -e"] = 0.06
varA["-a|-b +e"] = 0.71
varA["-a|-b -e"] = 0.999

varJ = {}
varJ["+j|+a"] = 0.90
varJ["+j|-a"] = 0.05
varJ["-j|+a"] = 0.10
varJ["-j|-a"] = 0.95

varM = {}
varM["+m|+a"] = 0.70
varM["+m|-a"] = 0.01
varM["-m|+a"] = 0.30
varM["-m|-a"] = 0.99

N = 1000
for i in range(int(N)):
  event = []
  sampledValueB = sampleVariable(varB, "b")
  event.append(sampledValueB)

  sampledValueE = sampleVariable(varE, "e")
  event.append(sampledValueE)

  conditionalA = "a|"+sampledValueB+" "+sampledValueE
  sampledValueA = sampleVariable(varA, conditionalA)
  sampledValueA_split = sampledValueA.split("|")
  event.append(sampledValueA_split[0])

  conditionalJ = "j|"+sampledValueA_split[0]
  sampledValueJ = sampleVariable(varJ, conditionalJ)
  sampledValueJ_split = sampledValueJ.split("|")
  event.append(sampledValueJ_split[0])
  print(sampledValueA_split[0])
  conditionalM = "m|"+sampledValueA_split[0]
  sampledValueM = sampleVariable(varM, conditionalM)
  sampledValueM_split = sampledValueM.split("|")
  event.append(sampledValueM_split[0])

