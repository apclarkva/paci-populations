import numpy as np

a=[1, 2, 3]

np.savetxt('test.csv', a, delimiter=',', fmt='%d')