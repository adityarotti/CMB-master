import numpy as np
from matplotlib import pylab as plt
d=np.loadtxt("fort.10")

plt.imshow(np.log10(d), interpolation='nearest', cmap=plt.cm.ocean)
plt.colorbar()
plt.savefig("coupling_matrix.png",dpi=200)
