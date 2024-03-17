function [Plin, Pein] = optimalQtoP(Qlin, Qein, Plout, Peout, Rm0, Re0)

A = log(Rm0)./(16);
B = -log(Rm0)./(16.*log(Rm0./Re0)).*((Re0.^2 - Rm0.^2).^2 + (Re0.^4 - Rm0.^4).*log(Rm0./Re0));

Plin = -(1./(2.*A)) + Plout + 16.*Qlin;

Pein = ((-1 + 2.*B.*Peout).*(Re0.^2 - Rm0.^2).^2 + (32.*B.*Qein - Re0.^4 + Rm0.^4 + 2.*B.*Peout.*(Re0.^4 - Rm0.^4)).*log(Rm0./Re0))./(2.*B.*(Re0.^2 - Rm0.^2).*(Re0.^2 - Rm0.^2 + (Re0.^2 + Rm0.^2).*log(Rm0./Re0)));
end

