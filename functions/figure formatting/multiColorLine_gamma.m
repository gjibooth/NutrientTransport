function multiColorLine(x,y,c,font_size_labels,cposition,cmap)

numPoints = numel(x);
diffPoints = numel(x)-numel(c);

%maxc=max(c);
maxc=0.072;
minc=0.035;

if nargin < 6
    cmap = jet(256);
end

% for i=1:length(c)
%     if max(c)>maxc
%         c(i)=c(i)-(max(c)-maxc);
%     end
% end

%cn = ( c-min(c) )/( max(c)-min(c) );  %normalise
%cn = ( c-min(c) )/( maxc-min(c) );  %normalise
cn = ( c-minc )/( maxc-minc );  %normalise
%cn = c;
cn = ceil(cn*size(cmap,1)); % get as many values as colour map
cn = max(cn,1); % one value is 0 so make that single 0 to 1 to avoid index problems



% line segments from i to i+1
for i=1:numPoints-diffPoints
    line(x(i:i+1), y(i:i+1), 'Color', cmap(cn(i),:), 'LineWidth', 2)
end

if nargin>3
% Colorbar properties
colormap(cmap);
cb=colorbar(cposition);

maxc=0.072;
cb.Ticks=[0.03 0.04 0.05 0.06 0.07];
cb.TickLabels={0.03 0.04 0.05 0.06 0.07};
caxis([0.03 0.072])

% maxc=max(c);
% cb.Ticks=[0 round(max(c)/4,2) round(max(c)/2,2) round((3*max(c))/4,2) round(max(c),2)];
% cb.TickLabels={0 round(max(c)/4,2) round(max(c)/2,2) round((3*max(c))/4,2) round(max(c),2)};
% caxis([0 round(max(c),2)])
% 
% %caxis([0 round(max(c),1)])
% % cb.Ticks=[0 round(max(c)/2,2) round(max(c),2)];
% % cb.TickLabels={0 round(max(c)/2,1) round(max(c),1)};
% %caxis([0 round(max(c),2)])
% 
cb.FontSize = font_size_labels;
cb.FontName = 'latex';
cb.LineWidth = 2;
cb.TickLabelInterpreter = 'latex';
cb.Label.FontSize = font_size_labels;
cb.Label.Interpreter = 'latex';
cb.Label.String = 'Surface tension (N/m)';

% Set width and position of colorbar
posa=get(gca,'position');
x=get(cb,'Position');
x(1)=0.55;
x(3)=0.025;
set(cb,'Position',x)
set(gca,'position',posa)
% % Move graph to centre; colorbar moves graph to the left
% posa = get(gca, 'Position');
% xoffset = 0.05;
% posa(1) = posa(1) + xoffset;
% set(gca, 'Position', posa)

% Set colorbar label and label's position
c = findobj(gcf,'type','colorbar');
pos = get(c,'Position');
cLP1=11.5*pos(1);
% cLP2 = 0.15;
c.Label.Rotation = -90; % to rotate the text
% cLP=c.Label.Position;
c.Label.Position(1)= cLP1;


end