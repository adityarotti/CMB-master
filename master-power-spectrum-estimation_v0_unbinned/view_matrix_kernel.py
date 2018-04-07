d=loadtxt("fort.10")

imshow(log10(d), interpolation='nearest', cmap=plt.cm.ocean)
colorbar()
savefig("coupling_matrix.png",dpi=200)
