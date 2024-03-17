close all
clear

% Add paths
addpath(genpath('Homogeneous Permeability/'))
addpath(genpath('Optimal Permeability/'))
addpath(genpath('/Users/george/Documents/MATLAB/'))

%% PARAMETERS
[rl0, rm0, re0, cell_thickness, l, k, phi_m, phi_c, qlin, qein, plout, peout, eta, Wbar, dl, dm, dc, Rm0, Re0, Qlin, Plout, Qein, Peout, epsilon, beta, delta, Cin, Vmax, Km, Peclet_l, Dm] = parameters();
[Plin, Pein] = QtoP(Qlin, Qein, Plout, Peout, Rm0, Re0, beta);
% if Plin < Plout
%     error('Reverse flow')
% end

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
fig_xaxis('$z$',font_size)
fig_yaxis('$r$', font_size)
xlim([0 1])
caxis([0, 1]);
colormap(ametrine)
basicfiguresetup(font_size,1.5)
setfiguresize([16 5.5])

testa = gca;
a = plotboxpos(gca);
testa.Box = 'off';
b = axes('Position',a,...
'LineWidth',1.5,...
'Box','off','xtick',[],'ytick',[],...
'Color','none');
movegui('center')

% [Rl,Ul,Wl,Pl,Rm,Um,Wm,Pm,Re,Ue,We,Pe,z] = fluids(Rm0,Re0,Plin,Plout,Pein,Peout,beta,n);
% 
