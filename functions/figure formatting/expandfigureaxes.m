function expandfigureaxes()
%  EXPANDFIGUREAXES Minimise the surrounding white space on the figure.
%
%     EXPANDFIGUREAXES() expands the axes using the tight style, only when
%     using the Microsoft Windows version of MATLAB.
%
%     hgexport(fig,'-clipboard',...) writes figure fig to the Microsoft
%     Windows clipboard, in order to apply the tight style. Copying to the
%     clipboard is not supported in the UNIX version of MATLAB, so an if
%     statement voids this function on UNIX based system.
%
% T.C. Sykes (mm13tcs@leeds.ac.uk)
% University of Leeds (2019)

fig = gcf;
fig.PaperPositionMode = 'auto';

% Expand axes if the UNIX version of MATLAB is not being used
if isunix~=1
    
    style = hgexport('factorystyle');
    style.Bounds = 'tight';
    hgexport(fig,'-clipboard',style,'applystyle', true);
    drawnow;
    
    % If crop is too tight then loosen
    ax = gca;
    % x-axis (max. useable space should be 0.995)
    if ax.Position(1) + ax.Position(3) > 0.995
        warning('x-axis cropping reduced (safe to disregard)');
        ax.Position(3) = ( 0.995 - ax.Position(1) );
    end
    % y-axis (max. useable space should be 0.995)
    if ax.Position(2) + ax.Position(4) > 0.995
        warning('y-axis cropping reduced (safe to disregard)');
        ax.Position(2) = ( 0.995 - ax.Position(4) );
    end
    
else
    warning('Linux system, so axes have not been expanded')
end
