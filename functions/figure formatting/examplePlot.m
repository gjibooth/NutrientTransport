% examplePlot.m
%
% A script to plot data, demonstrating the use of the figure formatting
% functions.
%
% T.C. Sykes (mm13tcs@leeds.ac.uk)
% University of Leeds (2019)

% Make up some data
fakeXData  = linspace(0,2*pi,100);
fakeYData1 = sin(fakeXData);
fakeYData2 = cos(fakeXData);

% Plot data
clf
plot(fakeXData, fakeYData1, 'r-', 'LineWidth', 2);
hold on
plot(fakeXData, fakeYData2, 'b-', 'LineWidth', 2);

% Figure formatting
setupxaxis('X axis label, abbreviation (units)', [0 2*pi], 12);
setupyaxis('Y axis label, abbreviation (units)', [-1 1],   12);
figurelegend({'Sine Curve','Cosine Curve'}, ...
    'Legend Title', 12, true, 'southwest');
setfiguresize([5 4]);
basicfiguresetup(12, 2, 'Figure Title');
expandfigureaxes();

% Save plot
saveasbitmap('image', 'png', true);     % do not run with saveaseps
% saveaseps('examplePlot.m', true);     % run only in the command line