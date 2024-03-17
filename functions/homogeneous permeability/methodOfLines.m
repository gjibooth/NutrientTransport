function [z,r,C] = methodOfLines(Rl0, Rm0, Re0, n, Plin, Plout, Pein, Peout, beta, epsilon, delta, Peclet_l, phi_m, phi_c, D_m, Vmax, Km)

    [~, ~, ~, psi_e, ~, ~] = streamfunction(Rl0, Rm0, Re0, n, Plin, Plout, Pein, Peout, beta);
    
    psi_re0 = psi_e(1);
    psie_i = linspace(min(psi_e,[],"all"), max(psi_e,[],"all")-0.0001,n);

    [~, ix] = min(abs(psi_re0-psie_i));

    De_eff = zeros(n);

    for  i = 1:length(psie_i)
        De_eff(:,i) = effectiveDiffusivity('ecs', psie_i(i), Rl0, Rm0, Re0, n, Plin, Plout, Pein, Peout, beta);
    end
    
    De_eff = fillmissing(De_eff,'movmean',5);
    
    s_max = 3;
    s_init = 2;
    
    options = odeset('RelTol',1e-8,'AbsTol',1e-6);

    [~, ~, Cm] = membraneConc(Rm0, Re0, ix, Plin, Plout, Pein, Peout, beta, epsilon, delta, Peclet_l, phi_m, phi_c, D_m, Vmax, Km);

    Cm_init = flip(Cm(end,:));

    Init = [Cm_init, zeros(1,n-ix)];

    [s,C] = ode45(@(s,C) discretization_ode(s,C,psie_i,n,Peclet_l,De_eff, epsilon),[s_init s_max],Init,options);

    for i = 1:length(psie_i)
    [r(:,i), z(:,i)] = transform(s, psie_i(i), Rl0, Rm0, Re0, n, Plin, Plout, Pein, Peout, beta);
    end

end

function dC = discretization_ode(s,C,psie_i,n, Peclet_l, De_eff, epsilon)

h = psie_i(2) - psie_i(1);

dC = zeros(n,1);

Ds = linspace(2,3,n);

% Governing equation for C.
for k = 2:n-1
    Dk = interp1(Ds,De_eff(:,k),s);
    Dkm1 = interp1(Ds,De_eff(:,k-1),s);
    Dkp1 = interp1(Ds,De_eff(:,k+1),s);

    dC(k) = 1/(epsilon.^2.*Peclet_l)*(Dk*((C(k+1)-2*C(k)+C(k-1))/(h^2)) + ((Dkp1-Dkm1)/(2*h))*((C(k+1)-C(k-1))/(2*h)));
end

end
