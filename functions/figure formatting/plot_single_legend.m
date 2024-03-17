function A = plot_single_legend(data,x,y,markers,line_width,legend_on,legend_title,legend_text,add_text,text,figure_number)
    
% Plot figures with legends with single values
%
% data: data to be used as legend
% x: x values
% y: y values
% markers: symbol choices
% legend_text: text or numbers used for legend (single values of data)
% add_text: extra text after the value for legend
% text: 1 if the legend is text; 0 if the legend is data values
% figure_number: in the case where there are more than one in the script
%                use figure numbers
%
% E. Antonopoulou (scea@leeds.ac.uk)
% University of Leeds (2019)

    values = single_values(data);
    counter = zeros(length(values),1); 
    ploter = zeros(length(legend_text),1);

    figure(figure_number)
    
    for i=1:length(data)
        for j=1:length(values)
            if (data(i)==values(j))
                if (counter(j)==0)
                    if (text==1)
                        ploter(j)=plot(x(i),y(i),markers{j},'LineWidth',line_width,'DisplayName',eval('legend_text{j}'));
                    elseif (text==0)
                        plot_values_cell=sprintfc('%.1f',legend_text);
                        if (ismember(data(i),legend_text))
                            k=find(legend_text==data(i));
                            ploter(k)=plot(x(i),y(i),markers{k},'LineWidth',line_width,'DisplayName',[eval('plot_values_cell{k}'),add_text]);
                        end
                    end
                    hold on
                    counter(j)=1;
                end
                if (text==1)
                    plot(x(i),y(i),markers{j},'LineWidth',line_width,'DisplayName',eval('legend_text{j}'));
                else
                     if (ismember(data(i),legend_text))
                            plot(x(i),y(i),markers{k},'LineWidth',line_width,'DisplayName',[eval('plot_values_cell{k}'),add_text]);
                     end
                end
                hold on
            end
        end
    end
    grid off
    
    if (legend_on==1)
        lgd = legend('show',ploter(1:end),'Location','northeast');
        set(lgd,'box','on');
        %set(lgd,'Location','eastoutside');
        set(lgd,'Location','northeast');
        title(lgd,legend_title,'FontWeight','bold');
        set(lgd,'interpreter','LaTeX')
        %set(lgd,'FontSize',10);
    end
end