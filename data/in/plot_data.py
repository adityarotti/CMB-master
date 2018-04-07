import healpy as h
from matplotlib import pyplot as plt
import numpy as np

nside=256

mask=h.read_map("mask1.fits")
fsky=sum(mask)/size(mask)
cl=h.read_cl("thrycl.fits")
cld=h.read_cl("cld.fits")
clmd=h.read_cl("clmd.fits")
clmaster1=h.read_cl("../out/clin_cl_nrlz1.fits")
clmaster2=h.read_cl("../out/mapin_cl_nrlz1.fits")

ell=np.arange(2*nside+1)
plt.plot(ell,ell*(ell+1)*cld/(2.*np.pi),"g-",label="Sim.")
plt.plot(ell,ell*(ell+1)*clmaster1/(2.*np.pi),"b.",label="Master 1")
plt.plot(ell,ell*(ell+1)*clmaster2/(2.*np.pi),"c-",label="Master 2")
plt.plot(ell,ell*(ell+1)*clmd/(2.*np.pi),"r-",label="Masked Sim.")
plt.plot(ell,ell*(ell+1)*clmd/(2.*np.pi*(fsky**1.)),"r-.",label="Masked Sim. fsky corr")
plt.plot(ell,ell*(ell+1)*cl[0][:2*nside+1]/(2.*np.pi),"k-",linewidth=2,label="Thry")
plt.xlabel("multipole, $\ell$")
plt.ylabel("$\ell(\ell+1)C_{\ell}/(2 \pi)$ $\mu K^2$")
plt.legend(loc=0)
plt.savefig("spectra.png",dpi=150)

