function [Zred, R_mred, wm] = wasteMembraneConc(Rm0, Re0, n, Plin, Plout, Pein, Peout, beta, epsilon, delta, Peclet_l, phi_m, phi_c, D_m, Vmax, Km, Peclet_l_waste, Dm_waste, Vmax_waste)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    rm_array = linspace(1,Rm0,n);
    z_array = linspace(0,1,n);
    
    [Zred,R_mred] = meshgrid(z_array,rm_array);
     
    [~,~,~,Pl,~,~,~,~,~,~,~,Pe,~] = fluids(Rm0,Re0,Plin,Plout,Pein,Peout,beta,n);

    [~, ~, Cm] = membraneConc(Rm0, Re0, n, Plin, Plout, Pein, Peout, beta, epsilon, delta, Peclet_l, phi_m, phi_c, D_m, Vmax, Km);
    
    rate = -Vmax_waste.*Cm(end,:)./(Km + Cm(end,:));
    
    xi = epsilon.^2.*Peclet_l_waste.*beta.*(Pe - Pl)./(Dm_waste.*phi_m.*log(Rm0));

    A2 = epsilon.*delta.*phi_c.^2.*log(Rm0).*rate./(epsilon.^2.*Peclet_l_waste.*beta.*(Pe - Pl).*Rm0.^(-(xi + 1)));
   
    s = (R_mred - 1)./(Rm0-1) + 1;
    x = ((s-1).*(Rm0-1)+1).^(-xi);
    wm = A2.*x;
%     Cm(isinf(Cm)|isnan(Cm)) = 1;
end

