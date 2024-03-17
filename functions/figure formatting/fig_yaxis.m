function fig_yaxis(label, fontSize, limits)
        
% SETUPYAXIS Label y-axis and set its limits.
%
%     SETUPYAXIS(label, limits, fontSize) labels the current figure's
%     y-axis by label. The axis limits specified as a two-element vector of
%     the form [ymin ymax] in limits.
%
% T.C. Sykes (mm13tcs@leeds.ac.uk)
% University of Leeds (2019)

% fig_yaxis Same as setupaxis with the option to choose whether we have limits
% or not
%
% Evangelia Antonopoulou (scea@leeds.ac.uk)

    ylabel(label,'interpreter','LaTeX','FontSize',fontSize);
    if (nargin==3)
        ylim(limits);
    end

end
