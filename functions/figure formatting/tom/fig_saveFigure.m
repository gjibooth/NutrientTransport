function fig_saveFigure(saveName, logicFIG, logicPNG, logicEPS)

    fig = gcf;
    fig.PaperPositionMode = 'auto';

    if logicFIG==1
        saveas(gcf, saveName);
    end
    
    if logicPNG==1
        saveas(gcf, strcat(saveName,'.png'));
    end
    
    if logicEPS==1
        evalc(strcat('publish(''',saveName,...
            ''',''imageFormat'',''eps'',''createThumbnail'',false)'));
    end

end