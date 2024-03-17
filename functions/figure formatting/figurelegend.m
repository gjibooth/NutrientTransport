function Lgd = figurelegend(plots,labels, legendTitle, fontSize, bkgd, lcn, position, numColumns)
%function Lgd = figurelegend(plots, legendTitle, fontSize, bkgd, lcn, position, numColumns)
%  FIGURELEGEND Add and place the figure legend on the current figure.
%
%     FIGURELEGEND(labels, legendTitle, fontSize, bkgd, lcn) creates a
%     legend from the string array labels, such as {'Jan','Feb','Mar'},
%     with title legendTitle, font size fontSize and compass-based location
%     identifier lcn. The logical variable bkgd (true or false) specifies
%     whether to include a solid white background on the legend.
%
%     For no legend title, use legendTitle=''. Note that the title must be
%     specified as a character array, not a cell array.
%
%     This function creates a legend entry for each data series on the
%     figure.
%
% T.C. Sykes (mm13tcs@leeds.ac.uk)
% University of Leeds (2019)
%     
%    numColumns: for long legends, use columns
%
% E. Antonopoulou (scea@leeds.ac.uk)
% University of Leeds (2020)

% Legend basics
% if isempty(plots)==0
%    Lgd = legend(plots,labels);
% else
%    Lgd = legend(labels);
% end

for i=1:length(plots)
    labels{i}=plots(i).DisplayName;
end
Lgd = legend(plots,labels);

% Legend background (true -> white; false -> transparent)
if bkgd==true
    set(Lgd,'box','on');
    set(Lgd,'Color','white');
%    set(Lgd,'EdgeColor','none');
    set(Lgd,'EdgeColor','k');
else
    set(Lgd,'box','off');
end

% Construct legend title
set(Lgd,'interpreter','LaTeX');
if isempty(legendTitle)==0
    legendTitle = strcat('\bf{',legendTitle,'}');
    title(Lgd,legendTitle);
end

% Legend location
if ~exist('lcn','var')
    lcn='northeast';         % default legend location
end
set(Lgd,'Location',lcn);     % set legend location

% Legend position

if (isempty(position)==0) && (isempty(plots)==0)
  Lgd = legend(plots,labels,'Position',position);
elseif (isempty(position)==0) && (isempty(plots)==1)
  Lgd = legend(labels,'Position',position);
end

% Font size
set(Lgd,'FontSize',fontSize);

% Number of columns
set(Lgd,'NumColumns', numColumns); 
