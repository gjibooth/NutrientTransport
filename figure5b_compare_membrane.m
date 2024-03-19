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
color = ametrine(3);
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot, 'DefaultAxesFontSize', font_size);
set(groot, 'DefaultAxesLineWidth', 2);

subplot(2,1,1)
hold on
plt1 = plot(Zm(1,:),Cm{1}(end,:),'LineWidth',5, 'Color',color(1,:));
plt2 = plot(Zm(1,:),Cm{2}(end,:),'LineWidth',5, 'Color',color(2,:));
plt3 = plot(Zm(1,:),Cm{3}(end,:),'LineWidth',5, 'Color',color(3,:));
ylabel('$c|_{R_{m0}}$', 'FontSize', font_size, 'Interpreter','latex')
xlim([0 1])

subplot(2,1,2)
hold on
h1 = plot(Zm(1,:), Pl{1}(1,:) - Pe{1}(1,:), 'LineWidth',5, 'Color',color(1,:), 'DisplayName','$P_{e,out} = 0$');
h2 = plot(Zm(1,:), Pl{2}(1,:) - Pe{2}(1,:), 'LineWidth',5, 'Color',color(2,:), 'DisplayName','$P_{e,out} = 0.3P_{l,out}$');
h3 = plot(Zm(1,:), Pl{3}(1,:) - Pe{3}(1,:), 'LineWidth',5, 'Color',color(3,:), 'DisplayName','$P_{e,out} = 0.6P_{l,out}$');
leg = legend([h1,h2,h3], 'FontSize', font_size, 'Interpreter', 'latex');
set(leg, 'Location', 'southwest')
xlabel('$z$', 'FontSize', font_size, 'Interpreter','latex')
ylabel('$P_l - P_e$', 'FontSize', font_size, 'Interpreter','latex')
xlim([0 1])

leg = legend('Interpreter', 'latex');
set(leg, 'Location', 'southwest')