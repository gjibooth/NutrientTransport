close all
clear

% Add paths
addpath(genpath('../functions'))

%% PARAMETERS
[rl0, rm0, re0, cell_thickness, l, k, phi_m, phi_c, qlin, qein, plout, peout, eta, Wbar, dl, dm, dc, Rm0, Re0, Qlin, Plout, Qein, Peout, epsilon, beta, delta, Cin, Vmax, Km, Peclet_l, Dm] = parameters();
[Plin, Pein] = QtoP(Qlin, Qein, Plout, Peout, Rm0, Re0, beta);
if Plin < Plout
    error('Reverse flow')
end

font_size = 20;

n = 300;     % Number of axial points
j = 20;      % Number of parameter values

% Permeability parameter values
beta_array = linspace(-5,-1,j);
beta_array = 1.*10.^(beta_array);

% Inlet pressure parameter values
Plin_array = linspace(Plin, 5.*Plin, j);
Pein_array = linspace(0,Plin-10,j);

% Colour scheme
color = ametrine(j);

% Optimal permeability membrane concentration
[~, ~, Cm_opt] = optimalMembraneConc(Rm0, epsilon, delta, Peclet_l, phi_m, phi_c, Dm, Vmax, Km, n);

figure(1)
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot, 'DefaultAxesFontSize', font_size);
set(groot, 'DefaultAxesLineWidth', 2);
setfiguresize([21 5])
subplot(1,3,1)
hold on
for i = 1:j
    [Zm, Rm, Cm] = membraneConc(Rm0, Re0, n, Plin, Plout, Pein, Peout, beta_array(i), epsilon, delta, Peclet_l, phi_m, phi_c, Dm, Vmax, Km);
    plot(Zm(1,:), Cm(end,:),'LineWidth',4,'Color',color(i,:))
end
plot(Zm(1,:),Cm_opt(end,:),'--','LineWidth',4,'Color','k')
xlabel('$z$', 'FontSize', font_size, 'Interpreter', 'latex')
ylabel('$c|_{R_{m0}}$', 'FontSize', font_size, 'Interpreter', 'latex')
title('$\kappa \in (10^{-4}, 10^{-1})$', 'FontSize', font_size, 'Interpreter', 'latex')

subplot(1,3,2)
hold on
for i = 1:j
    [Zm, Rm, Cm_plout] = membraneConc(Rm0, Re0, n, Plin_array(i), Plout, Pein, Peout, beta, epsilon, delta, Peclet_l, phi_m, phi_c, Dm, Vmax, Km);
    plot(Zm(1,:), Cm_plout(end,:),'LineWidth',4,'Color',color(i,:))
end
plot(Zm(1,:),Cm_opt(end,:),'--','LineWidth',4,'Color','k')
xlabel('$z$','FontSize', font_size, 'Interpreter', 'latex')
title('$P_{l,in} \in (P_{l,in}, 5P_{l,in}) $','FontSize', font_size, 'Interpreter', 'latex')

subplot(1,3,3)
hold on
for i = 1:j
    [Zm, Rm, Cm_peout] = membraneConc(Rm0, Re0, n, Plin, Plout, Pein_array(i), Peout, beta, epsilon, delta, Peclet_l, phi_m, phi_c, Dm, Vmax, Km);
    plot(Zm(1,:), Cm_peout(end,:),'LineWidth',4,'Color',color(i,:))
end
h1 = plot(nan,nan, 'LineWidth',4,'Color',color(end,:), 'DisplayName','Homogeneous Permeability');
h2 = plot(Zm(1,:),Cm_opt(end,:),'--','LineWidth',4,'Color','k', 'DisplayName','Heterogeneous Permeability');
leg = legend([h1,h2], 'FontSize', font_size, 'Interpreter', 'latex');
set(leg, 'Location', 'southeast')
xlabel('$z$','FontSize', font_size, 'Interpreter', 'latex')
title('$P_{e,in} \in (0, P_{l,in}) $','FontSize', font_size, 'Interpreter', 'latex')