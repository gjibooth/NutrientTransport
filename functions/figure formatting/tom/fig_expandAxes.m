function fig_expandAxes()

    fig = gcf;
    fig.PaperPositionMode = 'auto';

    if isunix~=1
        style = hgexport('factorystyle');
        style.Bounds = 'tight';
        hgexport(fig,'-clipboard',style,'applystyle', true);
        drawnow;
    else
        warning('Linux system, so axes have not been expanded')
    end
    
end