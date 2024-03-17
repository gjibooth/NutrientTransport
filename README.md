# Optimal metabolite transport in hollow fibre membrane bioreactors
Figure-generating code for the XXX article, "Optimal metabolite transport in hollow fibre membrane bioreactors" by Booth, G et al.

## Reproducing figures
Each figure is produced by individual MATLAB files, written using MATLAB R2022a:

* Figure 3: Transformation from axysymmetric to streamfunction-arclength coordinates
* Figure 5a: Nutrient concentration in bioreactor under typical operating conditions
* Figure 5b: Comparing membrane concentration under varying transmural pressure drops
* Figure 6a: Comparing outer membrane wall nutrient concentration under varying inlet pressures and membrane permeabilities
* Figure 6b: Comparing outer membrane wall nutrient concentration under varying membrane wall thickness and lumen P\'eclet numbers
* Figure 7: Comparing outer membrane wall waste metabolite concentration under varying inlet pressures and membrane thicknesses

## Requirements
Additional dependencies are required to reproduce these figures:

1. [Arclength calculator](https://viewer.mathworks.com/?viewer=plain_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Fe87feb46-b95f-46d3-b03f-9673422aab48%2Fd97fad3c-9349-4c7e-bb11-937bc860ae83%2Ffiles%2FRetinalTortuosityAnalysis%2Fsupplementary_functions%2Farc_length.m&embed=web) saved as `arclength.m`.
2. [Ametrine colourmap](https://github.com/briochemc/MATLAB_colormaps/blob/master/ametrine.m) saved as `ametrine.m`.
