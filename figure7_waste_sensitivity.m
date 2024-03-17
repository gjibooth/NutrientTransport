close all
clear

% Add paths
addpath(genpath('./functions'))

%% PARAMETERS
[rl0, rm0, re0, cell_thickness, l, k, phi_m, phi_c, qlin, qein, plout, peout, eta, Wbar, dl, dm, dc, Rm0, Re0, Qlin, Plout, Qein, Peout, epsilon, beta, delta, Cin, Vmax, Km, Peclet_l, Dm] = parameters();
[Plin, Pein] = QtoP(Qlin, Qein, Plout, Peout, Rm0, Re0, beta);
vmax = 125.867487.*1e-15.*4e8./(60.*cell_thickness);
cin = 0.23354;
[dl_waste, dm_waste, dc_waste, Vmax_waste,Peclet_l_waste] = waste_parameters(phi_m, phi_c, Wbar, vmax, l, cin);
Dm_waste = phi_m;


if Plin < Plout
    error('Reverse flow')
end

font_size = 20;

n = 100;        % Number of parameter values

% Define coordinate system
Rm0_array = linspace(1.5,4.5,n);
beta_array = 10.^linspace(-4,-1,n);
Plin_array = linspace(Plin, 5.*Plin, n);
Pein_array = linspace(0, 300, n);

% Initialise cells
wm_rm0 = cell(n,1);
wm_beta = cell(n,1);
wm_plin = cell(n,1);
wm_pein = cell(n,1);
wm_opt = cell(n,1);

wm_min = zeros(1,n);
wm_max = zeros(1,n);
wm_avg = zeros(1,n);
wm_optimum = zeros(1,n);

wm_beta_min = zeros(1,n);
wm_beta_max = zeros(1,n);
wm_beta_avg = zeros(1,n);
wm_beta_opt = cell(n,1);
wm_beta_optimum = zeros(1,n);

wm_plin_min = zeros(1,n);
wm_plin_max = zeros(1,n);
wm_plin_avg = zeros(1,n);
wm_plin_opt = cell(n,1);
wm_plin_optimum = zeros(1,n);

wm_pein_min = zeros(1,n);
wm_pein_max = zeros(1,n);
wm_pein_avg = zeros(1,n);
wm_pein_opt = cell(n,1);
wm_pein_optimum = zeros(1,n);

color = ametrine(3);

[~, ~, wm_const_opt] = optimalWasteMembraneConc(Rm0, n, epsilon, delta, Peclet_l, phi_m, phi_c, Dm, Vmax, Km, Peclet_l_waste, Dm_waste, Vmax_waste);
wm_const_opt = wm_const_opt(end,:);

for i = 1:n
    [Zm, Rm, wm_rm0{i}] = wasteMembraneConc(Rm0_array(i), Re0, n, Plin, Plout, Pein, Peout, beta, epsilon, delta, Peclet_l, phi_m, phi_c, Dm, Vmax, Km, Peclet_l_waste, Dm_waste, Vmax_waste);

    wm_end = wm_rm0{i}(end,:);
    wm_min(i) = min(wm_end,[],'all');
    wm_max(i) = max(wm_end,[],'all');
    wm_avg(i) = mean(wm_end,'all');
    [~, ~, wm_opt{i}] = optimalWasteMembraneConc(Rm0_array(i), n, epsilon, delta, Peclet_l, phi_m, phi_c, Dm, Vmax, Km, Peclet_l_waste, Dm_waste, Vmax_waste);

    wm_optimum(i) = wm_opt{i}(end);
    
    % Beta
    [~, ~, wm_beta{i}] = wasteMembraneConc(Rm0, Re0, n, Plin, Plout, Pein, Peout, beta_array(i), epsilon, delta, Peclet_l, phi_m, phi_c, Dm, Vmax, Km, Peclet_l_waste, Dm_waste, Vmax_waste);
    wm_beta_end = wm_beta{i}(end,:);
    wm_beta_min(i) = min(wm_beta_end,[],'all');
    wm_beta_max(i) = max(wm_beta_end,[],'all');
    wm_beta_avg(i) = mean(wm_beta_end,'all');

   % Plin
   [~, ~, wm_plin{i}] = wasteMembraneConc(Rm0, Re0, n, Plin_array(i), Plout, Pein, Peout, beta, epsilon, delta, Peclet_l, phi_m, phi_c, Dm, Vmax, Km, Peclet_l_waste, Dm_waste, Vmax_waste);
   wm_plin_end = wm_plin{i}(end,:);
   wm_plin_min(i) = min(wm_plin_end,[],'all');
   wm_plin_max(i) = max(wm_plin_end,[],'all');
   wm_plin_avg(i) = mean(wm_plin_end,'all');

   % Pein
   [~, ~, wm_pein{i}] = wasteMembraneConc(Rm0, Re0, n, Plin, Plout, Pein_array(i), Peout, beta, epsilon, delta, Peclet_l, phi_m, phi_c, Dm, Vmax, Km, Peclet_l_waste, Dm_waste, Vmax_waste);
   wm_pein_end = wm_pein{i}(end,:);
   wm_pein_min(i) = min(wm_pein_end,[],'all');
   wm_pein_max(i) = max(wm_pein_end,[],'all');
   wm_pein_avg(i) = mean(wm_pein_end,'all');
end


figure(1)
setfiguresize([21 5])
subplot(1,3,3)
hold on
plot(Rm0_array, wm_min, 'LineWidth',2,'Color',color(2,:))
plot(Rm0_array, wm_max, 'LineWidth',2,'Color',color(2,:))
patch([Rm0_array fliplr(Rm0_array)], [wm_min fliplr(wm_max)], color(2,:))
h1 = plot(Rm0_array, wm_avg, 'LineWidth',4,'Color',color(2,:), 'DisplayName','Homogoeneous Permeability');
h2 = plot(Rm0_array, wm_optimum,'LineWidth',4,'Color',color(1,:),'DisplayName','Heterogeneous Permeability');
alpha(0.4)
fig_xaxis('$R_{m0}$',font_size)
figurelegend([h1 h2],'','',16,true,'northwest','',1);
xlim([1.5 4.5])
basicfiguresetup(font_size,1.5)

subplot(1,3,1)
hold on
plot(Plin_array, wm_plin_min, 'LineWidth',2,'Color',color(2,:))
plot(Plin_array, wm_plin_max, 'LineWidth',2,'Color',color(2,:))
patch([Plin_array fliplr(Plin_array)], [wm_plin_min fliplr(wm_plin_max)], color(2,:))
plot(Plin_array, wm_plin_avg, 'LineWidth',4,'Color',color(2,:))
plot(Plin_array, wm_const_opt,'LineWidth',4,'Color',color(1,:))
alpha(0.4)
fig_xaxis('$P_{l,in}$',font_size)
fig_yaxis('$w|_{R_{m0}}$',font_size)
xlim([Plin_array(1) Plin_array(end)])
basicfiguresetup(font_size,1.5)

subplot(1,3,2)
hold on
plot(Pein_array, wm_pein_min, 'LineWidth',2,'Color',color(2,:))
plot(Pein_array, wm_pein_max, 'LineWidth',2,'Color',color(2,:))
patch([Pein_array fliplr(Pein_array)], [wm_pein_min fliplr(wm_pein_max)], color(2,:))
plot(Pein_array, wm_pein_avg, 'LineWidth',4,'Color',color(2,:))
plot(Pein_array, wm_const_opt,'LineWidth',4,'Color',color(1,:))
alpha(0.4)
fig_xaxis('$P_{e,in}$',font_size)
xlim([Pein_array(1) Pein_array(end)])
basicfiguresetup(font_size,1.5)