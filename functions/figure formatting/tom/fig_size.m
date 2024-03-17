function fig_size(size)

    fig = gcf;
    fig.Units = 'inches';
    set(fig, 'Units', 'Inches', 'Position', [0,0,size],...
        'PaperUnits', 'Inches', 'PaperSize', [size]);
    
end