function [dl_waste, dm_waste, dc_waste, Vmax_waste,Peclet_l_waste] = waste_parameters(phi_m, phi_c, Wbar, vmax, l, cin)
%PARAMETERS Summary of this function goes here
%   Detailed explanation goes here
              % Cell porosity

% CO2
dl_waste = 2.88e-9;                                               % m^2/s
dm_waste = phi_m.*dl_waste;
dc_waste = phi_c.*dl_waste;



%% DIMENSIONLESS
Vmax_waste = vmax.*l.^2./(cin.*dc_waste);


Peclet_l_waste = Wbar.*l./dl_waste;
end

