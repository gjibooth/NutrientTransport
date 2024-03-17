function fig_xaxis(label,fontSize,limits)

% SETUPXAXIS Label x-axis and set its limits.
%
%     SETUPXAXIS(label, limits, fontSize) labels the current figure's
%     x-axis by label. The axis limits specified as a two-element vector of
%     the form [xmin xmax] in limits.
%
% T.C. Sykes (mm13tcs@leeds.ac.uk)
% University of Leeds (2019)

% fig_xaxis Same as setupaxis with the option to choose whether we have limits
% or not
%
% Evangelia Antonopoulou (scea@leeds.ac.uk)

    xlabel(label,'interpreter','LaTeX','FontSize',fontSize);
    if (nargin==3)
        xlim(limits);
    end  

end
