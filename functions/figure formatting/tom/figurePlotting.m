%% Droplet Height

clf;
hold on;
fig1 = plot([1, 2],[1, 2],'r.','MarkerSize',8);
fig2 = plot([1, 2],[2, 3],'mo','MarkerSize',8);
fig3 = plot([1, 2],[3, 1],'b*','MarkerSize',8);
fig4 = plot([1, 2],[4, 4],'k.','MarkerSize',8);

fig_xaxis('Time (ms)',[0 3],18);
fig_yaxis('Droplet Height (mm)',[0 5],18);
fig_legend({'entry 1','entry 2',...
    'entry 3','entry 4'},...
    {'title'},18);
fig_expandAxes();
fig_size([16 8]);
fig_basics(18,1.5);
fig_saveFigure('fileName', false, false, false);