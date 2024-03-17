function [r, z] = transform(s, psi, Rl0, Rm0, Re0, n, Plin, Plout, Pein, Peout, beta)

% Interpolation method
method = 'linear';

% Define axisymmetric coordinate system
if psi == 0
    r = zeros(1,length(s));
    z = s;
else
rl_array = linspace(0, Rl0, n);
rm_array = linspace(Rl0, Rm0, n);
re_array = linspace(Rm0, Re0, n);
z_array = linspace(0,1,n);

% Define axisymmetric meshgrid
[~, R_l] = meshgrid(z_array, rl_array);
[~, R_m] = meshgrid(z_array, rm_array);
[Z, R_e] = meshgrid(z_array, re_array);

% Calculate streamfunction values in each domain
[~,psi_l,psi_m,psi_e, ~, ~] = streamfunction(Rl0, Rm0, Re0, n, Plin, Plout, Pein, Peout, beta);


if psi  <= psi_l(end) %in the lumen
    [M,~] = contour(Z, R_l, psi_l, [psi,psi]); 
    M = M(:,2:end)';
    if length(M) <=1
    M = [nan,nan;nan,nan];
    L = 1;
    else
    [~,L] = arclength(M(:,1),M(:,2));
    L = cumsum(L);
    end
    s_array = [0; L./L(end)];

elseif psi >= psi_e(1)
    [M,~] = contour(Z, R_e, psi_e, [psi,psi]); 
    M = M(:,2:end)';
    [~,L] = arclength(M(:,1),M(:,2));
    L = cumsum(L);
    s_array = 2 + [0; L./L(end)];

else
    [M_l,~] = contour(Z, R_l, psi_l, [psi,psi]);
    M_l = M_l(:,2:end)';
    [~,L_l] = arclength(M_l(:,1),M_l(:,2));
    L_l = cumsum(L_l);
    sl = [0; L_l./L_l(end)];

    [M_m,~] = contour(Z, R_m, psi_m, [psi,psi]);  
    M_m = M_m(:,2:end)';
    if length(M_m) <=1
    M_m = [nan,nan;nan,nan];
    L_m = 1;
    else
    [~,L_m] = arclength(M_m(:,1),M_m(:,2));
    L_m = cumsum(L_m);
    end
    sm = 1 + [0; L_m./L_m(end)];
    
    [M_e,~] = contour(Z, R_e, psi_e, [psi,psi]);
    M_e = M_e(:,2:end)';
    if length(M_e) <=1
    M_e = [nan,nan;nan,nan];
    L_e = 1;
    else
    [~,L_e] = arclength(M_e(:,1),M_e(:,2));
    L_e = cumsum(L_e);
    end
    se = 2 + [0; L_e./L_e(end)];

    s_array = cat(1, sl, sm, se);
    s_array(length(sl) + length(sm)+1,:) = [];
    s_array(length(sl)+1, :) = [];

    
    M = cat(1, M_l, M_m, M_e);

    M(length(M_l) + length(M_m)+1,:) = [];
    M(length(M_l)+1, :) = [];
end

xdata = (1:length(s_array))';

s_array=interp1(xdata(~isnan(s_array)),s_array(~isnan(s_array)),xdata);

for i = 1:length(s)
    if s(i) >= s_array(1) && s(i) <= s_array(end)
        r(i) = interp1(s_array,M(:,2),s(i),method);
        z(i) = interp1(s_array,M(:,1),s(i),method);
    else
        r(i) = nan;
        z(i) = nan;
    end
end

end
end