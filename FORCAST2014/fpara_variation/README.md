# SOFIA
Repository for SOFIA data analysis.

Directory FORCAST2014 contains data products from analysis of SOFIA FORCAST
observations of Jupiter in May 2014.  

Directory fpara_variation contains the datafiles necessary to reproduce Fig. 7
of Fletcher et al. (2017, http://dx.doi.org/10.1016/j.icarus.2016.10.002).  For
three latitudes (55N, 0, 55S) there are three *.mre files.  The `sofia_*.mre`
files contain spectral fits for our best-fitting T(p) and para-H2 profile.  The
`fp-0.05_*.mre` and `fp+0.05_*.mre` contain forward models for when the whole
para-H2 profile is artificially increased or decreased by 0.05.

SOFIAfits.eps shows both radiance and brightness temperatures extracted from
these MRE files using `plot_sofia.pro`, which calls the subroutine `zreadmre.pro`
