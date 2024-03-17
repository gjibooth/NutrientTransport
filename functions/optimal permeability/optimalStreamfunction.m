function [psi, psi_l, psi_m, psi_e, R, Z] = optimalStreamfunction(Rl0, Rm0, Re0, Plin, Plout, Pein, Peout, n)
    rl_array = linspace(0, Rl0, n);
    rm_array = linspace(Rl0, Rm0, n);
    re_array = linspace(Rm0, Re0, n);
    z_array = linspace(0,1,n);
    
    % Define meshgrid
    [~, r_l] = meshgrid(z_array, rl_array);
    [~, r_m] = meshgrid(z_array, rm_array);
    [z, r_e] = meshgrid(z_array, re_array);

    A = log(Rm0)./(16);
    B = -log(Rm0)./(16.*log(Rm0./Re0)).*((Re0.^2 - Rm0.^2).^2 + (Re0.^4 - Rm0.^4).*log(Rm0./Re0));
    
    
    psi_l = -((r_l.^2.*(-2 + r_l.^2).*(1 + 2.*A.*(Plin - Plout) - 2.*z))./(32.*A));
    
    psi_m = (1 + 2.*A.*Plin - 2.*A.*Plout)./(32.*A) - z./log(Rm0);
    
    psi_e = -((1./(32.*B)).*(-(B./A) + r_e.^4 - 2.*r_e.^2.*Re0.^2 + 2.*B.*(Pein - Peout).*r_e.^2.*(r_e.^2 - 2.*Re0.^2) + Rm0.^4 - 2.*B.*(Plin - Plout + (-Pein + Peout).*Rm0.^4) - 2.* z.*((r_e.^2 - Re0.^2).^2 + ((Re0 - Rm0).*(Re0 + Rm0).*(-r_e.^2 + Re0.^2 + 2.*r_e.^2.*log(r_e./Re0)))./ log(Rm0./Re0)) - ((1 + 2.*B.*(Pein - Peout)).* Rm0.^2.*(-Re0.^2 + Rm0.^2))./log(Rm0./Re0) + ((1 + 2.*B.*(Pein - Peout)).* r_e.^2.*(Re0 - Rm0).*(Re0 + Rm0).*(-1 + 2.*log(r_e./Re0)))./ log(Rm0./Re0)));
         
    psi = cat(1, psi_l, psi_m, psi_e);
    psi(length(r_l) + length(r_m)+1,:) = [];
    psi(length(r_l)+1, :) = [];

    R = cat(1,r_l, r_m, r_e);
    Z = cat(1, z, z, z);
    R(length(r_l) + length(r_m)+1,:) = [];
    R(length(r_l)+1, :) = [];
    Z(length(r_l) + length(r_m)+1,:) = [];
    Z(length(r_l)+1, :) = [];
end