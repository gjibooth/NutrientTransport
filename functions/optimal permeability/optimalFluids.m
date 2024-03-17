function [Rl,Ul,Wl,Pl,Rm,Um,Wm,Pm,Re,Ue,We,Pe,z] = optimalFluids(Rm0,Re0,Plin,Plout,Pein,Peout,n)

rl_array = linspace(0,1,n);
rm_array = linspace(1,Rm0,n);
re_array = linspace(Rm0,Re0,n);
z_array = linspace(0,1,n);

[~,Rl] = meshgrid(z_array,rl_array);
[~,Rm] = meshgrid(z_array,rm_array);
[z,Re] = meshgrid(z_array,re_array);


A = log(Rm0)./(16);
B = -log(Rm0)./(16.*log(Rm0./Re0)).*((Re0.^2 - Rm0.^2).^2 + (Re0.^4 - Rm0.^4).*log(Rm0./Re0));

Pl = z.*(z-1)./(2.*A) + (Plout - Plin).*z + Plin;
Pe = z.*(z-1)./(2.*B) + (Peout - Pein).*z + Pein;

Pm = (Pe - Pl).*log(Rm)./(log(Rm0)) + Pl;

dPldz = (2.*z - 1)./(2.*A) + (Plout - Plin);
dPedz = (2.*z - 1)./(2.*B) + (Peout - Pein);

d2Pldz2 = 1./A;
d2Pedz2 = 1./B;

Wl = 1./(4).*dPldz.*(Rl.^2-1);
Ul = Rl./(16).*d2Pldz2.*(2-Rl.^2);

Um = 1./(Rm.*log(Rm0));
Wm = (1./(Pl - Pe)).*log(Rm)./(log(Rm0)).*(dPldz - dPedz) - (1./(Pl - Pe)).*dPldz;

We = 1./(4).*dPedz.*(Re.^2 - Re0.^2 + (Re0.^2 - Rm0.^2).*log(Re./Re0)./log(Rm0./Re0));
Ue = 1./(16.*Re.*log(Rm0./Re0)).*d2Pedz2.*(2.*Re.^2.*(Rm0.^2 - Re0.^2).*log(Re./Re0) - (Re.^2-Re0.^2).*(Rm0.^2 - Re0.^2 + (Re.^2 - Re0.^2).*log(Rm0./Re0)));

end

