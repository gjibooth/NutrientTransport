function fig_legend(legendText, titleString, fontSize)

    Lgd = legend(legendText);
    set(Lgd,'box','off');
    set(Lgd,'Location','northeast');
    title(Lgd,titleString,'FontWeight','bold');
    set(Lgd,'interpreter','LaTeX')
    set(Lgd,'FontSize',fontSize);
    
end