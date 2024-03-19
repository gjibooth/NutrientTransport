close all
clear

% Add paths
addpath(genpath('./functions'))

%% PARAMETERS
[rl0, rm0, re0, cell_thickness, l, k, phi_m, phi_c, qlin, qein, plout, peout, eta, Wbar, dl, dm, dc, Rm0, Re0, Qlin, Plout, Qein, Peout, epsilon, beta, delta, Cin, Vmax, Km, Peclet_l, Dm] = parameters();
[Plin, Pein] = QtoP(Qlin, Qein, Plout, Peout, Rm0, Re0, beta);
if Plin < Plout
    error('Reverse flow')
end

font_size = 20;

n = 200;            % Number of parameter values

% Membrane thickness parameter values
Rm0_array = linspace(1.5,4.5,n);

% Peclet number parameter valus
Peclet_array = linspace(0.1,20,n)./(epsilon.^2);

% Initialise cells
Cm_rm0 = cell(n,1);
Cm_peclet = cell(n,1);
Cm_opt = cell(n,1);

Cm_avg = zeros(n);
Cm_optimum = zeros(n);

color = ametrine(3);

for i = 1:n
    for j = 1:n
        [Zm, Rm, Cm_rm0{j}] = membraneConc(Rm0_array(i), Re0, n, Plin, Plout, Pein, Peout, beta, epsilon, delta, Peclet_array(j), phi_m, phi_c, Dm, Vmax, Km);
        Cm_end = Cm_rm0{j}(end,:);
        Cm_avg(i,j) = mean(Cm_end,'all');
        [~, ~, Cm_opt{j}] = optimalMembraneConc(Rm0_array(i), epsilon, delta, Peclet_array(j), phi_m, phi_c, Dm, Vmax, Km, n);
        Cm_optimum(i,j) = Cm_opt{j}(end);
    end
end

[P,R] = meshgrid(epsilon.^2.*Peclet_array, Rm0_array);

figure(1)
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot, 'DefaultAxesFontSize', font_size);
set(groot, 'DefaultAxesLineWidth', 2);

subplot(1,2,1)
hold on
h = pcolor(R,P,Cm_avg);
h.EdgeColor = 'none';
[c2,h2] = contour(R,P,Cm_avg, [0.1 0.3 0.5 0.7 0.9], 'LineColor', 'w', 'ShowText',true,'LineWidth',3);
clabel(c2, h2,'FontSize',14,'FontWeight','bold','Color','w');

xlabel('$R_{m0}$', 'FontSize', font_size, 'Interpreter', 'latex')
ylabel('$\varepsilon^2\mathcal{P}_l$','FontSize', font_size, 'Interpreter', 'latex')
title('Homogeneous Permeability', 'FontSize', font_size, 'Interpreter', 'latex')

subplot(1,2,2)
hold on
h = pcolor(R,P,Cm_optimum);
h.EdgeColor = 'none';
[c2,h2] = contour(R,P,Cm_optimum, [0.1 0.3 0.5 0.7 0.9], 'LineColor', 'w', 'ShowText',true,'LineWidth',3);
clabel(c2, h2,'FontSize',14,'FontWeight','bold','Color','w')

xlabel('$R_{m0}$','FontSize', font_size, 'Interpreter', 'latex')
ylabel('$\varepsilon^2\mathcal{P}_l$', 'FontSize', font_size, 'Interpreter', 'latex')

c = colorbar;
c.Label.Interpreter = 'latex';
c.Label.String = '$\overline{c}|_{R_{m0}}$';
c.Label.FontSize = font_size;
c.LineWidth = 1.5;
caxis([0 1]);
set(c,'TickLabelInterpreter','latex')
title('Heterogeneous Permeability','FontSize', font_size, 'Interpreter', 'latex')

colormap(ametrine)
