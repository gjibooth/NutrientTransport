function [psi, psi_l, psi_m, psi_e, R, Z] = streamfunction(Rl0, Rm0, Re0, n, Plin, Plout, Pein, Peout, beta)
    
% Define radial and axial arrays
rl_array = linspace(0, Rl0, n);
rm_array = linspace(Rl0, Rm0, n);
re_array = linspace(Rm0, Re0, n);
z_array = linspace(0,1,n);
    
% Define meshgrid
[~, r_l] = meshgrid(z_array, rl_array);
[~, r_m] = meshgrid(z_array, rm_array);
[z, r_e] = meshgrid(z_array, re_array);

% Define streamfunction in each domain
A = log(Rm0)./(16);
B = -log(Rm0)./(16.*log(Rm0./Re0)).*((Re0.^2 - Rm0.^2).^2 + (Re0.^4 - Rm0.^4).*log(Rm0./Re0));

psi_l = -((1./(16.*(A - B))).*(r_l.^2.*(-2 + r_l.^2).*(B.*(-Pein + Peout) + A.*(Plin - Plout) + B.*sqrt((1./A - 1./B).*beta).*((Pein - Plin).* cosh((-1 + z).*sqrt((1./A - 1./B).*beta)) + (-Peout + Plout).*cosh(z.*sqrt((1./A - 1./B).*beta))).* csch(sqrt((1./A - 1./B).*beta)))));

psi_m = (B.*(-Pein + Peout) + A.*(Plin - Plout) + B.*sqrt((1./A - 1./B).*beta).*(-Peout + Plout + (Pein - Plin).*cosh(sqrt((1./A - 1./B).*beta))).* csch(sqrt((1./A - 1./B).*beta)))./(16.*(A - B)) + ((Pein + exp(2.*sqrt((1./A - 1./B).*beta)).*(Pein - Plin) - Plin + 2.*exp(sqrt((1./A - 1./B).*beta)).*(-Peout + Plout)).*beta)./ ((-1 + exp(2.*sqrt((1./A - 1./B).*beta))).* sqrt((1./A - 1./B).*beta).*log(Rm0)) - ((exp(2.*sqrt((1./A - 1./B).*beta)).*(Pein - Plin) + exp(2.*z.*sqrt((1./A - 1./B).*beta)).*(Pein - Plin) + exp(sqrt((1./A - 1./B).*beta)).*(-Peout + Plout) + exp((1 + 2.*z).*sqrt((1./A - 1./B).*beta)).*(-Peout + Plout)).*beta)./ (exp(z.* sqrt((1./A - 1./B).*beta)).*((-1 + exp(2.*sqrt((1./A - 1./B).*beta))).*sqrt((1./A - 1./B).*beta).* log(Rm0)));

psi_e = (1./(32.*(A - B).*B.*sqrt((1./A - 1./B).*beta).*log(Rm0./Re0))).* ((A - B).*(Pein + exp(2.*sqrt((1./A - 1./B).*beta)).*(Pein - Plin) - Plin + 2.*exp(sqrt((1./A - 1./B).*beta)).*(-Peout + Plout)).*Re0.^2.* (Re0 - Rm0).*(Re0 + Rm0).*beta.*(1 - coth(sqrt((1./A - 1./B).*beta))) + ((A - B).*(exp(2.*sqrt((1./A - 1./B).*beta)).*(Pein - Plin) + exp(2.*z.*sqrt((1./A - 1./B).*beta)).*(Pein - Plin) + exp(sqrt((1./A - 1./B).*beta)).*(-Peout + Plout) + exp((1 + 2.*z).*sqrt((1./A - 1./B).*beta)).*(-Peout + Plout)).* Re0.^2.*(Re0 - Rm0).* (Re0 + Rm0).*beta.*(-1 + coth(sqrt((1./A - 1./B).*beta))))./ exp(z.*sqrt((1./A - 1./B).*beta)) + (A - B).*(Pein + exp(2.*sqrt((1./A - 1./B).*beta)).*(Pein - Plin) - Plin + 2.*exp(sqrt((1./A - 1./B).*beta)).*(-Peout + Plout)).* Re0.^4.*beta.* (1 - coth(sqrt((1./A - 1./B).*beta))).*log(Rm0./Re0) + ((A - B).*(exp(2.*sqrt((1./A - 1./B).*beta)).*(Pein - Plin) + exp(2.*z.*sqrt((1./A - 1./B).*beta)).*(Pein - Plin) + exp(sqrt((1./A - 1./B).*beta)).*(-Peout + Plout) + exp((1 + 2.*z).*sqrt((1./A - 1./B).*beta)).*(-Peout + Plout)).* Re0.^4.*beta.* (-1 + coth(sqrt((1./A - 1./B).*beta))).*log(Rm0./Re0))./ exp(z.*sqrt((1./A - 1./B).*beta)) + 2.*B.* sqrt((1./A - 1./B).*beta).*(B.*(-Pein + Peout) + A.*(Plin - Plout) + B.*sqrt((1./A - 1./B).*beta).* (-Peout + Plout + (Pein - Plin).*cosh(sqrt((1./A - 1./B).*beta))).* csch(sqrt((1./A - 1./B).*beta))).*log(Rm0./Re0) + (B.*r_e.^2.* sqrt((1./A - 1./B).*beta).*(B.*(exp(z.*sqrt((1./A - 1./B).*beta)) - exp((2 + z).*sqrt((1./A - 1./B).*beta))).*(Pein - Peout) + A.*(exp((2 + z).*sqrt((1./A - 1./B).*beta)).*(Plin - Plout) + exp(z.*sqrt((1./A - 1./B).*beta)).*(-Plin + Plout) + exp(2.*sqrt((1./A - 1./B).*beta)).*(Pein - Plin).* sqrt((1./A - 1./B).*beta) + exp(2.*z.*sqrt((1./A - 1./B).*beta)).*(Pein - Plin).* sqrt((1./A - 1./B).*beta) + exp(sqrt((1./A - 1./B).*beta)).*(-Peout + Plout).* sqrt((1./A - 1./B).*beta) + exp((1 + 2.*z).*sqrt((1./A - 1./B).*beta)).*(-Peout + Plout).* sqrt((1./A - 1./B).*beta))).*(1 - coth(sqrt((1./A - 1./B).*beta))).* ((Re0 - Rm0).*(Re0 + Rm0).*(-1 + 2.*log(r_e./Re0)) + (r_e.^2 - 2.*Re0.^2).*log(Rm0./Re0)))./ exp(z.*sqrt((1./A - 1./B).*beta)) + B.*Rm0.^2.* sqrt((1./A - 1./B).*beta).*(B.*(1 - exp(2.*sqrt((1./A - 1./B).*beta))).*(Pein - Peout) + A.*(-Plin + exp(2.*sqrt((1./A - 1./B).*beta)).*(Plin - Plout) + Plout + (Pein - Plin).*sqrt((1./A - 1./B).*beta) + exp(2.*sqrt((1./A - 1./B).*beta)).*(Pein - Plin).* sqrt((1./A - 1./B).*beta) + 2.*exp(sqrt((1./A - 1./B).*beta)).*(-Peout + Plout).* sqrt((1./A - 1./B).*beta))).*(1 - coth(sqrt((1./A - 1./B).*beta))).*(Re0.^2 - Rm0.^2 + Rm0.^2.*log(Rm0./Re0)));

% Combine streamfunction values
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