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

n = 300; % Mesh size

Cm = cell(3,1);
Pl = cell(3,1);
Pe = cell(3,1);

Pl_new = cell(n,1);
Pe_new = cell(n,1);

delta_P = zeros(1,n);

font_size = 24;

%% FUNCTIONS
% Nutrient Transport
range = [0,0.3,0.6].*Plout;

for i = 1:length(range)
%     [Plin, Pein] = QtoP(range(i), Qein, Plout, Peout, Rm0, Re0, beta);
    [Zm, Rm, Cm{i}] = membraneConc(Rm0, Re0, n, Plin, Plout, Pein, range(i), beta, epsilon, delta, Peclet_l, phi_m, phi_c, Dm, Vmax, Km);
    [~,~,~,Pl{i},~,~,~,~,~,~,~,Pe{i},~] = fluids(Rm0,Re0,Plin,Plout,Pein,range(i),beta,n);
end

%% FIGURES
figure(1)
setfiguresize([20 7])

subplot(2,3,1)
hold on
plt1 = pcolor(Zm,Rm,Cm{1});
set(plt1,'EdgeColor','none')
fig_xaxis('$z$',font_size)
fig_yaxis('$r$', font_size)
xlim([0 1])
c = colorbar;
c.Label.Interpreter = 'latex';
c.Label.String = '$c$';
c.Label.FontSize = font_size;
c.LineWidth = 1.5;
caxis([min(Cm{1},[],'all'), max(Cm{1},[],'all')]);
set(c,'TickLabelInterpreter','latex')
colormap(ametrine)
basicfiguresetup(font_size,1.5,'$P_{e,out} = 0$')

box on
testa = gca;
testa.Box = 'on';
testa.LineWidth = 2.5;

subplot(2,3,2)
hold on
plt1 = pcolor(Zm,Rm,Cm{2});
set(plt1,'EdgeColor','none')
fig_xaxis('$z$',font_size)
xlim([0 1])
c = colorbar;
c.Label.Interpreter = 'latex';
c.Label.String = '$c$';
c.Label.FontSize = font_size;
c.LineWidth = 1.5;
caxis([min(Cm{2},[],'all'), max(Cm{2},[],'all')]);
set(c,'TickLabelInterpreter','latex')
colormap(ametrine)
basicfiguresetup(font_size,1.5,'$P_{e,out} = 0.3P_{l,out}$')

box on
testa = gca;
testa.Box = 'on';
testa.LineWidth = 2.5;

subplot(2,3,3)

hold on
plt1 = pcolor(Zm,Rm,Cm{3});
set(plt1,'EdgeColor','none')
fig_xaxis('$z$',font_size)
xlim([0 1])
c = colorbar;
c.Label.Interpreter = 'latex';
c.Label.String = '$c$';
c.Label.FontSize = font_size;
c.LineWidth = 1.5;
caxis([min(Cm{3},[],'all')-0.001, max(Cm{3},[],'all')]);
set(c,'TickLabelInterpreter','latex')
colormap(ametrine)
basicfiguresetup(font_size,1.5,'$$P_{e,out} = 0.6P_{l,out}$')

box on
testa = gca;
testa.Box = 'on';
testa.LineWidth = 2.5;

color = ametrine(3);

subplot(2,3,[4,5,6])
hold on
h1 = plot(Zm(1,:), Pl{1}(1,:) - Pe{1}(1,:), 'LineWidth',5, 'Color',color(1,:), 'DisplayName','$P_{e,out} = 0$');
h2 = plot(Zm(1,:), Pl{2}(1,:) - Pe{2}(1,:), 'LineWidth',5, 'Color',color(2,:), 'DisplayName','$P_{e,out} = 0.3P_{l,out}$');
h3 = plot(Zm(1,:), Pl{3}(1,:) - Pe{3}(1,:), 'LineWidth',5, 'Color',color(3,:), 'DisplayName','$P_{e,out} = 0.6P_{l,out}$');
basicfiguresetup(font_size,1.5)
fig_xaxis('$z$',font_size)
fig_yaxis('$P_l - P_e$', font_size)
xlim([0 1])
figurelegend([h1 h2 h3],'','',16,true,'southwest','',1);
