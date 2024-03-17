function basicfiguresetup(fontSize, axesWidth, figureTitle)
% BASICFIGURESETUP Set basic figure preferences, especially for the axes.
%
%     BASICFIGURESETUP(fontSize, axesWidth, figureTitle) sets the font size
%     of the axes as fontSize and the axes width as axesWidth, both
%     scalars. figureTitle is an optional argument specifying the figure
%     title (the default is no title).
%
% T.C. Sykes (mm13tcs@leeds.ac.uk)
% University of Leeds (2019)

% Add title (if desired)
if nargin==3
    title(figureTitle,'interpreter','LaTeX','FontSize',fontSize);
end

% Guide preferences
grid off;       % No grid lines
box on;         % Outer box

% Axes preferences
ax = gca;
set(ax,'FontSize',fontSize,'LineWidth',axesWidth,...
    'TickLabelInterpreter','LaTeX');

% Increase tick length from standard by 50% (must clf previous figure)
oldTickLength = ax.TickLength;
ax.TickLength = 1.5*oldTickLength;
