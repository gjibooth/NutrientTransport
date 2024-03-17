function [Zred, R_mred, Cm] = optimalMembraneConc(Rm0, epsilon, delta, Peclet_l, phi_m, phi_c, D_m, Vmax, Km, n)
    
    rm_array = linspace(1,Rm0,n);
    z_array = linspace(0,1,n);
    
    [Zred,R_mred] = meshgrid(z_array,rm_array);

    xi = -epsilon.^2.*Peclet_l./(D_m.*phi_m.*log(Rm0));

    a = phi_m.*D_m.*xi.*Rm0.^(-2.*xi-1);
    b = phi_m.*D_m.*xi.*Rm0.^(-xi-1).*(Km + 1) - epsilon.*delta.*phi_c.^2.*Vmax.*Rm0.^(-xi);
    c = -epsilon.*delta.*phi_c.^2.*Vmax;
    A2 = (-b - sqrt(b.^2 - 4.*a.*c))./(2.*a);
    s = (R_mred - 1)./(Rm0-1) + 1;
    x = (((s-1).*(Rm0-1)+1).^(-xi));
    Cm = 1 + A2.*x;
    Cm(isnan(Cm))=0;
end

