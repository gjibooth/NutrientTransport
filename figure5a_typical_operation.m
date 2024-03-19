close all
clear

% Add paths
addpath(genpath('./functions'))

%% PARAMETERS
[rl0, rm0, re0, cell_thickness, l, k, phi_m, phi_c, qlin, qein, plout, peout, eta, Wbar, dl, dm, dc, Rm0, Re0, Qlin, Plout, Qein, Peout, epsilon, beta, delta, Cin, Vmax, Km, Peclet_l, Dm] = parameters();
[Plin, Pein] = QtoP(Qlin, Qein, Plout, Peout, Rm0, Re0, beta);

n = 200; % Mesh size

font_size = 24;

%% FUNCTIONS
% Nutrient Transport
z = linspace(0,1,n);
[Zl, Rl] = meshgrid(z,z);
Cl = ones(n);
[Zm, Rm, Cm] = membraneConc(Rm0, Re0, n, Plin, Plout, Pein, Peout, beta, epsilon, delta, Peclet_l, phi_m, phi_c, Dm, Vmax, Km);
tic
[Ze, Re, Ce] = methodOfLines(1, Rm0, Re0, n, Plin, Plout, Pein, Peout, beta, epsilon, delta, Peclet_l, phi_m, phi_c, Dm, Vmax, Km);
toc
% Fluid Flow
[psi, psi_l, psi_m, psi_e, R, Z] = streamfunction(1, Rm0, Re0, n, Plin, Plout, Pein, Peout, beta);

%% FIGURES
figure(1)
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot, 'DefaultAxesFontSize', font_size);
set(groot, 'DefaultAxesLineWidth', 2);
hold on
plt1 = pcolor(Zl,Rl,Cl);
plt2 = pcolor(Zm,Rm,Cm);
plt3 = pcolor(Ze,Re, Ce);
contour(Z,R,psi, 8, 'Color','w','LineWidth',4)
plot(z,ones(1,n),'Color','k','LineWidth',3)
plot(z,repmat(Rm0,1,n),'Color','k','LineWidth',3)
plot(z,repmat(Re0,1,n),'Color','k','LineWidth',3)
set(plt1,'EdgeColor','none')
set(plt2,'EdgeColor','none')
set(plt3,'EdgeColor','none')
c = colorbar;
c.Label.Interpreter = 'latex';
c.Label.String = '$c$';
c.Label.FontSize = font_size;
c.LineWidth = 1.5;
set(c,'TickLabelInterpreter','latex')
xlabel('$z$','FontSize', font_size, 'Interpreter', 'latex')
ylabel('$r$', 'FontSize', font_size, 'Interpreter', 'latex')
xlim([0 1])
caxis([0, 1]);
colormap(ametrine)
