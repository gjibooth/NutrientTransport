function [Plin, Pein] = QtoP(Qlin, Qein, Plout, Peout, Rm0, Re0, beta)

A = log(Rm0)./(16);
B = -log(Rm0)./(16.*log(Rm0./Re0)).*((Re0.^2 - Rm0.^2).^2 + (Re0.^4 - Rm0.^4).*log(Rm0./Re0));
lambda1 = sqrt(beta.*(B-A)./(B.*A));

% Inlet lumen pressure
Plin = (A.*(-1 + exp(2.*lambda1)).*(Plout + 16.*Qlin) - B.*(16.*(-1 + exp(2.*lambda1)).*Qlin + 2.*exp(lambda1).*Plout.*lambda1 + Peout.*(-1 + exp(2.*lambda1) - 2.*exp(lambda1).*lambda1) + ((1 + exp(2.*lambda1).*(-1 + lambda1) + lambda1).* ((Re0.^2 - Rm0.^2).^2.*((-B).*(1 + exp(2.*lambda1)).* Peout.*lambda1 + A.*(2.*exp(lambda1).*(Peout - Plout) + Plout + exp(2.*lambda1).*Plout).* lambda1 + 16.*A.*Qlin.*(1 + exp(2.*lambda1).*(-1 + lambda1) + lambda1)) + ((-B).*(1 + exp(2.*lambda1)).*(16.*Qein + Peout.*(Re0.^4 - Rm0.^4)).* lambda1 + A.*(16.*(-1 + exp(2.*lambda1)).*Qein + (Re0.^4 - Rm0.^4).* ((2.*exp(lambda1).*(Peout - Plout) + Plout + exp(2.*lambda1).* Plout).*lambda1 + 16.*Qlin.*(1 + exp(2.*lambda1).*(-1 + lambda1) + lambda1)))).* log(Rm0./Re0)))./ ((A - B).*(1 + exp(2.*lambda1)).*(Re0.^2 - Rm0.^2).*lambda1.* (Re0.^2 - Rm0.^2 + (Re0.^2 + Rm0.^2).*log(Rm0./Re0)))))./ (A.*(-1 + exp(2.*lambda1)) - B.*(1 + exp(2.*lambda1)).*lambda1);

% Inlet ECS pressure
Pein = ((Re0.^2 - Rm0.^2).^2.*((-B).*(1 + exp(2.*lambda1)).*Peout.*lambda1 + A.*(2.*exp(lambda1).*(Peout - Plout) + Plout + exp(2.*lambda1).*Plout).* lambda1 + 16.*A.*Qlin.*(1 + exp(2.*lambda1).*(-1 + lambda1) + lambda1)) + ((-B).*(1 + exp(2.*lambda1)).*(16.*Qein + Peout.*(Re0.^4 - Rm0.^4)).* lambda1 + A.*(16.*(-1 + exp(2.*lambda1)).*Qein + (Re0.^4 - Rm0.^4).* ((2.*exp(lambda1).*(Peout - Plout) + Plout + exp(2.*lambda1).*Plout).* lambda1 + 16.*Qlin.*(1 + exp(2.*lambda1).*(-1 + lambda1) + lambda1)))).* log(Rm0./Re0))./((A - B).*(1 + exp(2.*lambda1)).*(Re0.^2 - Rm0.^2).*lambda1.* (Re0.^2 - Rm0.^2 + (Re0.^2 + Rm0.^2).*log(Rm0./Re0)));
end

