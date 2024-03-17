function [Zred, R_mred, wm] = optimalWasteMembraneConc(Rm0, n, epsilon, delta, Peclet_l, phi_m, phi_c, D_m, Vmax, Km, Peclet_l_waste, Dm_waste, Vmax_waste)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    [Zred, R_mred, Cm] = optimalMembraneConc(Rm0, epsilon, delta, Peclet_l, phi_m, phi_c, D_m, Vmax, Km, n);

    rate = -Vmax_waste.*Cm(end,:)./(Km + Cm(end,:));
    
    xi = -epsilon.^2.*Peclet_l_waste./(Dm_waste.*phi_m.*log(Rm0));

    A2 = -epsilon.*delta.*phi_c.^2.*log(Rm0).*rate./(epsilon.^2.*Peclet_l_waste.*Rm0.^(-(xi + 1)));
   
    s = (R_mred - 1)./(Rm0-1) + 1;
    x = ((s-1).*(Rm0-1)+1).^(-xi);
    wm = A2.*x;
%     Cm(isinf(Cm)|isnan(Cm)) = 1;
end

