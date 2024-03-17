function [Rl,Ul,Wl,Pl,Rm,Um,Wm,Pm,Re,Ue,We,Pe,z] = fluids(Rm0,Re0,Plin,Plout,Pein,Peout,beta,n)

% Define coordinate system
rl_array = linspace(0,1,n);
rm_array = linspace(1,Rm0,n);
re_array = linspace(Rm0,Re0,n);
z_array = linspace(0,1,n);

[~,Rl] = meshgrid(z_array,rl_array);
[~,Rm] = meshgrid(z_array,rm_array);
[z,Re] = meshgrid(z_array,re_array);

% Solve fluid flow
A = log(Rm0)./(16);
B = -log(Rm0)./(16.*log(Rm0./Re0)).*((Re0.^2 - Rm0.^2).^2 + (Re0.^4 - Rm0.^4).*log(Rm0./Re0));
lambda1 = sqrt(beta.*(B-A)./(B.*A));
lambda2 = -sqrt(beta.*(B-A)./(B.*A)); 

C = (B - A)./B;

c1 = (Plout - Peout - exp(lambda2).*(Plin - Pein))./((A./beta).*(exp(lambda1) - exp(lambda2)).*lambda1.^2);
c2 = (Peout - Plout - exp(lambda1).*(Pein - Plin))./((A./beta).*(exp(lambda1) - exp(lambda2)).*lambda2.^2);
c3 = Plout - Plin + c1.*(1-exp(lambda1)) + c2.*(1-exp(lambda2));

Pl = ((Plin - Pein).*((z-1).*(exp(lambda1) - exp(lambda2)) - (exp(lambda1.*(z-1)) - exp(lambda2.*(z-1)))) - (Plout - Peout).*((z).*(exp(lambda1) - exp(lambda2)) - (exp(lambda1.*(z)) - exp(lambda2.*(z)))))./((exp(lambda1) - exp(lambda2)).*C) + (Plout - Plin).*z + Plin;
Pe = ((Plin - Pein).*((B./(B-A)).*(z-1).*(exp(lambda1) - exp(lambda2)) - (A./(B-A)).*(exp(lambda1.*(z-1)) - exp(lambda2.*(z-1)))) - (Plout - Peout).*((B./(B-A)).*(z).*(exp(lambda1) - exp(lambda2)) - (A./(B-A)).*(exp(lambda1.*(z)) - exp(lambda2.*(z)))))./(exp(lambda1) - exp(lambda2)) + (Plout - Plin).*z + Plin;

Pm = (Pe - Pl).*log(Rm)./(log(Rm0)) + Pl;

dPldz = c1.*lambda1.*exp(lambda1.*z) + c2.*lambda2.*exp(lambda2.*z) + c3;
dPedz = c1.*lambda1.*(1-(A./beta).*(lambda1.^2)).*exp(lambda1.*z) + c2.*lambda2.*(1-(A./beta).*(lambda2.^2)).*exp(lambda2.*z) + c3;

d2Pldz2 = c1.*lambda1.^2.*exp(lambda1.*z) + c2.*lambda2.^2.*exp(lambda2.*z);
d2Pedz2 = c1.*lambda1.^2.*(1-(A./beta).*(lambda1.^2)).*exp(lambda1.*z) + c2.*lambda2.^2.*(1-(A./beta).*(lambda2.^2)).*exp(lambda2.*z);

Wl = 1./(4).*dPldz.*(Rl.^2-1);
Ul = Rl./(16).*d2Pldz2.*(2-Rl.^2);

Um = (beta.*(Pl - Pe))./(Rm.*log(Rm0));
Wm = beta.*log(Rm)./(log(Rm0)).*(dPldz - dPedz) - beta.*dPldz;

We = 1./(4).*dPedz.*(Re.^2 - Re0.^2 + (Re0.^2 - Rm0.^2).*log(Re./Re0)./log(Rm0./Re0));
Ue = 1./(16.*Re.*log(Rm0./Re0)).*d2Pedz2.*(2.*Re.^2.*(Rm0.^2 - Re0.^2).*log(Re./Re0) - (Re.^2-Re0.^2).*(Rm0.^2 - Re0.^2 + (Re.^2 - Re0.^2).*log(Rm0./Re0)));
end

