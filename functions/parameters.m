function [rl0, rm0, re0, cell_thickness, l, k, phi_m, phi_c, qlin, qein, plout, peout, eta, Wbar, dl, dm, dc, Rm0, Re0, Qlin, Plout, Qein, Peout, epsilon, beta, delta, Cin, Vmax, Km, Peclet_l, Dm] = parameters()

%% DIMENSIONAL PARAMETERS
% Bioreactor
rl0 = 200e-6;                   % Lumen radius (m)
rm0 = 400e-6;                   % Membrane radius (m)
cell_thickness = 10e-6;         % Cell thickness (m)
re0 = 1000e-6;                  % ECS radius (m)
l = 10e-2;                      % Length (m)
k = 2.39e-16;                   % Membrane permeability (m^2)
phi_m = 0.77;                   % Membrane porosity
phi_c = 0.6;                    % Cell porosity

% Fluid
qlin = 3.3e-8;                  % Inlet lumen flowrate (m^3/s)
qein = 3.3e-9;                  % Inlet ECS flowrate (m^3/s)
plout = 105500;                 % Outlet lumen pressure (Pa)
peout = 0;                      % Outlet ECS pressure (Pa)
eta = 1e-3;                     % Viscosity (Pa s)
Wbar = qlin./(2.*pi.*rl0.^2);   % Typical fluid velocity (m/s)

% Oxygen
cin = 0.23354;                                              % Inlet lumen concentration (mol/m^3)
vmax = 125.867487.*1e-15.*4e8./(60.*cell_thickness);        % Maximum uptake rate (mol/m^3s)
km = 0.00111528e-3;                                         % Michaelis constant (mol/m^3)
dl = 3e-9;                                                  % Lumen oxygen diffusivity (m^2/s)
dm = phi_m.*dl;                                             % Membrane oxygen diffusivity (m^2/s)
dc = phi_c.*dl;                                             % Cell layer oxygen diffusivity (m^2/s)

%% NONDIMENSIONAL SCALINGS
epsilon = rl0./l;                                           % Lumen aspect ratio
Pscale = eta.*Wbar./(epsilon.^2.*l);                        % Pressure scaling
Qscale = 2.*pi.*epsilon.^2.*l.^2.*Wbar;                     % Flowrate scaling

%% DIMENSIONLESS PARAMETERS
% Bioreactor                       
Rm0 = rm0./rl0;                     % Membrane radius
Re0 = re0./rl0;                     % ECS radius
Qlin = qlin./Qscale;                % Inlet lumen flowrate
Qein = qein./Qscale;                % Inlet ECS flowrate
Plout = plout./Pscale;              % Outlet lumen pressure
Peout = peout./Pscale;              % Outlet ECS pressure
beta = k./(epsilon.^4.*l.^2);       % Nondimensional permeability
delta = cell_thickness./l;          % Cell layer thickness

% Oxygen
Cin = 1;                            % Inlet lumen concentration
Vmax = vmax.*l.^2./(cin.*dc);       % Maximum uptake rate
Km = km./cin;                       % Michaelis constant


Peclet_l = Wbar.*l./dl;             % Lumen Peclet number
Dm = phi_m;                         % Membrane diffusivity
end

