clear
close all

addpath(genpath('./functions/'))

% Load model parameters
[rl0, rm0, re0, cell_thickness, l, k, phi_m, phi_c, qlin, qein, plout, peout, eta, Wbar, dl, dm, dc, Rm0, Re0, Qlin, Plout, Qein, Peout, epsilon, beta, delta, Cin, Vmax, Km, Peclet_l, Dm] = parameters();
[Plin, Pein] = QtoP(Qlin, Qein, Plout, Peout, Rm0, Re0, beta);

%% COORDINATE SYSTEM
n = 300;                        % Number of points per line
m = 14;                         % Number of streamlines
lil = 0.00001;                  % Numerical correction factor

% Define colour scheme
colors = ametrine(6);

% Define axisymmetric coordinates
z_array = linspace(0,1,n);                    
rl_array = linspace(0,1,n);    
rm_array = linspace(1,Rm0,n);
re_array = linspace(Rm0,Re0,n);

% Define meshgrid
[~, R_l] = meshgrid(z_array, rl_array);
[~, R_m] = meshgrid(z_array, rm_array);
[Z, R_e] = meshgrid(z_array, re_array);

% Concatinate meshgrids
R_array = cat(2,rl_array, rm_array, re_array);

R_array(length(rl_array) + length(rm_array) + 1) = [];
R_array(length(rl_array)+1) = [];

[ZZ, R] = meshgrid(z_array, R_array);

% Solve streamfunction across whole domain
[psi, psi_l, psi_m, psi_e, ~, ~] = streamfunction(1, Rm0, Re0, n, Plin, Plout, Pein, Peout, beta);
    
% Identify maximum streamline value
psi_max = max(psi,[],'all')-lil;

% Choose your coordinate points
psi_value = linspace(0,psi_max,n);
s_value = linspace(0,3,13);

tic
    for j = 1:length(psi_value)
        [r(:,j), z(:,j)] = transform(s_value, psi_value(j), 1, Rm0, Re0, n, Plin, Plout, Pein, Peout, beta);
    end
toc

% Identify critical streamlines
psi_lcrit = psi_l(end);
psi_ecrit = psi_e(1);

% Define streamfunction-arclength coordinates
psi_array = linspace(0,psi_max,m);
s_array = linspace(0,3,3*m);

psil_array = [linspace(0,psi_lcrit,m) NaN(1,2*m)];
psim_array = [NaN(1,m) linspace(psi_lcrit, psi_ecrit, m) NaN(1,m)];
psie_array = [NaN(1, 2*m) linspace(psi_ecrit, psi_max, m)];

% Define meshgrid
[~, SPYl] = meshgrid(s_array, psil_array);
[~, SPYm] = meshgrid(s_array, psim_array);
[S, SPYe] = meshgrid(s_array, psie_array);

[Ml,~] = contour(Z, R_l, psi_l, [psi_lcrit,psi_lcrit]); 
 Ml = Ml(:,2:end)';

[Me,~] = contour(Z, R_e, psi_e, [psi_ecrit,psi_ecrit]); 
 Me = Me(:,2:end)';


%% PLOT
set(groot,'defaultFigureVisible','on')
font_size = 22;
figure('Name','Coordinate Transform')
subplot(1,2,1)
hold on

contour(ZZ, R, psi, m, 'Color', colors(2,:), 'LineWidth', 3)

plot(Ml(:,1),Ml(:,2),'--','LineWidth',5, 'Color', 'k')
plot(Me(:,1),Me(:,2),'--','LineWidth',5, 'Color', 'k')

plot(zeros(1,m),linspace(1,Rm0,m), '--','LineWidth',5,'Color','k')
plot(ones(1,m),linspace(1,Rm0,m), '--','LineWidth',5,'Color','k')

for i = 1:length(s_value)
    hold on
    if s_value(i) == 0
        plot(zeros(1,n),rl_array,'Color', colors(4,:),'LineWidth',3)
    elseif s_value(i) == 1
        plot(ones(1,n),rl_array, 'Color', colors(4,:),'LineWidth',3)
    elseif s_value(i) == 1.25
        plot(z_array, repmat(1 + (Rm0-1)./4,1,n), 'Color', colors(4,:),'LineWidth',3)
    elseif s_value(i) == 1.5
        plot(z_array, repmat((1+Rm0)./2,1,n), 'Color', colors(4,:),'LineWidth',3)
    elseif s_value(i) == 1.75
        plot(z_array, repmat(1 + 3.*(Rm0-1)./4,1,n), 'Color', colors(4,:),'LineWidth',3)
    elseif s_value(i) == 2
        plot(zeros(1,n),re_array, 'Color', colors(4,:),'LineWidth',3)
    elseif s_value(i) > 2 && s_value(i) < 3
        plot(z(i,:), r(i,:), 'Color', colors(4,:), 'LineWidth',3)
        z(i,1) = 0;
        [right,ok] = max(z(i,:));
        plot(linspace(right,1,20),linspace(r(i,ok),Rm0,20), 'Color', colors(4,:),'LineWidth',3)
    elseif s_value(i) == 3
        plot(ones(1,n),re_array, 'Color', colors(4,:),'LineWidth',3)
    else
        hold on
        plot(z(i,:), r(i,:), 'Color', colors(4,:), 'LineWidth',3)
    end
end

plot(z_array, zeros(1,n), 'Color', colors(2,:), 'LineWidth',3)
plot(z_array, ones(1,n),'k', 'LineWidth',3)
plot(z_array, repmat(Rm0,1,n),'k', 'LineWidth',3)
plot(z_array, repmat(Re0,1,n),'k', 'LineWidth',3)
xlim([0 1])
ylim([0 Re0])

fig_xaxis('$z$',font_size)
fig_yaxis('$r$', font_size)

basicfiguresetup(font_size,1.5)
testa = gca;
testa.Box = 'off';

subplot(1,2,2)
hold on
for i = 1:length(psi_array)-1
    if psi_array(i) <= psi_lcrit
        plot(linspace(0,1,m),repmat(psi_array(i),1,m), 'Color', colors(2,:),'LineWidth',3)
    elseif psi_array(i) >= psi_ecrit
        plot(linspace(2,3,m),repmat(psi_array(i),1,m), 'Color', colors(2,:),'LineWidth',3)
    else
        plot(linspace(0,3,m),repmat(psi_array(i),1,m), 'Color', colors(2,:),'LineWidth',3)
    end
end

plot(linspace(2,3,m),repmat(psi_array(end),1,m),'k','LineWidth',3)

plot(linspace(0,1,m), zeros(1,m), 'Color', colors(2,:),'LineWidth',3)

plot(s_array,repmat(psi_lcrit,1,length(s_array)),'--','LineWidth',5, 'Color', 'k')
plot(s_array,repmat(psi_ecrit,1,length(s_array)),'--','LineWidth',5, 'Color', 'k')

plot(zeros(1,m),linspace(0,psi_ecrit,m), 'Color', colors(4,:), 'LineWidth',3)
plot(repmat(0.25,1,m),linspace(0,psi_ecrit,m), 'Color', colors(4,:), 'LineWidth',3)
plot(repmat(0.5,1,m),linspace(0,psi_ecrit,m), 'Color', colors(4,:), 'LineWidth',3)
plot(repmat(0.75,1,m),linspace(0,psi_ecrit,m), 'Color', colors(4,:), 'LineWidth',3)
plot(ones(1,m),linspace(0,psi_lcrit,m), 'Color', colors(4,:), 'LineWidth',3)
plot(repmat(1.25,1,m),linspace(psi_lcrit,psi_ecrit,m), 'Color', colors(4,:), 'LineWidth',3)
plot(repmat(1.5,1,m),linspace(psi_lcrit,psi_ecrit,m), 'Color', colors(4,:), 'LineWidth',3)
plot(repmat(1.75,1,m),linspace(psi_lcrit,psi_ecrit,m), 'Color', colors(4,:), 'LineWidth',3)
plot(repmat(2,1,m),linspace(psi_ecrit,psi_max+lil,m), 'Color', colors(4,:), 'LineWidth',3)
plot(repmat(2.25,1,m),linspace(psi_lcrit,psi_max+lil,m), 'Color', colors(4,:), 'LineWidth',3)
plot(repmat(2.5,1,m),linspace(psi_lcrit,psi_max+lil,m), 'Color', colors(4,:), 'LineWidth',3)
plot(repmat(2.75,1,m),linspace(psi_lcrit,psi_max+lil,m), 'Color', colors(4,:), 'LineWidth',3)
plot(repmat(3,1,m),linspace(psi_lcrit,psi_max+lil,m), 'Color', colors(4,:), 'LineWidth',3)

plot(ones(1,m),linspace(psi_lcrit,psi_ecrit,m),'k','LineWidth',3)
plot(repmat(2,1,m),linspace(psi_lcrit,psi_ecrit,m),'k','LineWidth',3)

fig_xaxis('$s$',font_size)
fig_yaxis('$\psi$', font_size)
xlim([0 3])
ylim([0 psi_max+lil])

h1 = plot(nan, nan, 'LineWidth', 3, 'Color', colors(2,:), 'DisplayName', 'Streamlines (constant $\psi$)');
h2 = plot(nan, nan, 'LineWidth', 3, 'Color', colors(4,:), 'DisplayName', 'Streamline contours (constant $s$)');
h3 = plot(nan, nan, 'LineWidth', 3, 'Color', 'k', 'DisplayName', 'Domain boundaries');
h4 = plot(nan, nan, '--', 'LineWidth', 5, 'Color', 'k', 'DisplayName', 'Critical streamlines ($\psi_{i,crit}$)');

figurelegend([h1, h2, h3, h4],'','',14,true,'southeast','',4);

basicfiguresetup(font_size,1.5)
testa = gca;
a = plotboxpos(gca);
testa.Box = 'off';

setfiguresize([20 10])
hold off

