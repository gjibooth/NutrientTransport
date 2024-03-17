function D_eff = effectiveDiffusivity(region, psi, Rl0, Rm0, Re0, n, Plin, Plout, Pein, Peout, beta)

Rl_array = linspace(0,Rl0,n);
Re_array = linspace(Rm0,Re0,n);
z_array = linspace(0,1,n);

[~, Rl] = meshgrid(z_array, Rl_array);
[Z, Re] = meshgrid(z_array, Re_array);

if psi == 0
    D_eff = 0;
else

[~, psi_l, ~, psi_e, ~, ~] = streamfunction(Rl0, Rm0, Re0, n, Plin, Plout, Pein, Peout, beta);
    

A = log(Rm0)./(16);
B = -log(Rm0)./(16.*log(Rm0./Re0)).*((Re0.^2 - Rm0.^2).^2 + (Re0.^4 - Rm0.^4).*log(Rm0./Re0));
lambda1 = sqrt(beta.*(B-A)./(B.*A));
lambda2 = -sqrt(beta.*(B-A)./(B.*A));

c1 = (Plout - Peout - exp(lambda2).*(Plin - Pein))./((A./beta).*(exp(lambda1) - exp(lambda2)).*lambda1.^2);
c2 = (Peout - Plout - exp(lambda1).*(Pein - Plin))./((A./beta).*(exp(lambda1) - exp(lambda2)).*lambda2.^2);
c3 = Plout - Plin + c1.*(1-exp(lambda1)) + c2.*(1-exp(lambda2));

for i = 1:length(psi)
    if strcmp(region,'lumen') && psi(i) >= min(psi_l,[],'all') && psi(i) <= max(psi_l,[],'all')
        [M,~] = contour(Z,Rl,psi_l,[psi(i),psi(i)]);
        M = M(:,2:end);
        [l_psi,L] = arclength(M(1,:), M(2,:));
        L = [0; cumsum(L)];
        X = M';
        dPldz = c1.*lambda1.*exp(lambda1.*X(:,1)) + c2.*lambda2.*exp(lambda2.*X(:,1)) + c3;
        W = (1./4).*dPldz.*(X(:,2).^2-1);
        D_eff = X(:,2).^2.*l_psi.*W;
    elseif strcmp(region,'ecs') && psi(i) >= min(psi_e,[],'all') && psi(i) <= max(psi_e,[],'all')
        [M,~] = contour(Z,Re,psi_e,[psi(i),psi(i)]);
        M = M(:,2:end);
        if isempty(M)
            D_eff = 0;
            L = 0;
        else
       [l_psi,L] = arclength(M(1,:), M(2,:));
        L = [0; cumsum(L)];
        X = M';
        dPedz = c1.*lambda1.*(1-(A./beta).*(lambda1.^2)).*exp(lambda1.*X(:,1)) + c2.*lambda2.*(1-(A./beta).*(lambda2.^2)).*exp(lambda2.*X(:,1)) + c3;
        W = (1./4).*dPedz.*(X(:,2).^2 - Re0.^2 + (Re0.^2 - Rm0.^2).*log(X(:,2)./Re0)./log(Rm0./Re0));
        D_eff = X(:,2).^2.*l_psi.*W;
        end
    else
        error('Not valid region')
    end
    if length(D_eff) <= 2
        D_eff = repmat(D_eff(1),n,1);
    else
    xq = linspace(0,l_psi,n);
    D_eff = interp1(L,D_eff,xq);
    end
end
end

