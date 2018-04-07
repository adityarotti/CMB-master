import healpy as h
from matplotlib import pyplot as plt
import numpy as np

nside=256
mask=h.read_map("mask1.fits")
cl=h.read_cl("thrycl.fits")
m=h.synfast(cl[0],nside)

wl=h.alm2cl(h.map2alm(mask,lmax=2*nside))
h.write_cl("mask_cl.fits",wl)

cld=h.alm2cl(h.map2alm(m,lmax=2*nside))
h.write_cl("cld.fits",cld)

m=m*mask
h.write_map("masked_cmb.fits",m)
clmd=h.alm2cl(h.map2alm(m,lmax=2*nside))
h.write_cl("clmd.fits",clmd)






