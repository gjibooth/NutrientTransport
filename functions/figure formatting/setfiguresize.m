function setfiguresize(size, unit)
% SETFIGURESIZE Set the on screen size and position of the current figure.
%
%     SETFIGURESIZE(size, unit) sets the figure size as size, a two-element
%     vector of the form [width height] in limits. The length unit is
%     specified by the optional argument unit, which is either 'inches'
%     (default) or 'centimeters'.
%
%     The hard-coded figure position is at the extreme bottom left of
%     the primary screen.
%
% T.C. Sykes (mm13tcs@leeds.ac.uk)
% University of Leeds (2019)

% Use the default length unit if an argument is not specified
if nargin~=2
    unit = 'inches';
end

% Set the figure size
fig = gcf;
set(fig, 'Units', unit, 'Position', [0,0,size], 'PaperUnits', unit, ...
    'PaperSize', size);
