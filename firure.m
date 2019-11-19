clear 
clc

%FIGURE PRODUCTION
load('C:\Users\ahmed\Desktop\gnss research\data to matlab2.mat')
%-------------------------------------------------------------------------------------------
[xData, yData, zData] = prepareSurfaceData( x, y, ex);
% Set up fittype and options.
ft = fittype( 'poly22');%'thinplateinterp';%poly22
% Fit model to data.
[fitresult,~] = fit( [xData, yData], zData, ft );
% Create a figure for the plots.
figure ('position', [0, 0, 1400, 500]);
% Plot fit with data.
subplot( 2, 2, 2 );
h = plot( fitresult, [xData, yData], zData );
legend( h, 'Easting Uncertainty', 'Observation points', 'Location', 'NorthEast' );
% Label axes
xlabel x
ylabel y
zlabel 'Uncertainty (m)'
grid on
view( -18.7, 29.2 );
colormap jet
% Plot residuals.
subplot( 2, 2, 4 );
h = plot( fitresult, [xData, yData], zData, 'Style', 'Residual' );
legend( h, 'Easting Uncertainty - residuals', 'Location', 'NorthEast' );
% Label axes
xlabel x
ylabel y
zlabel 'Uncertainty (m)'
grid on
view( -18.7, 29.2 );
colormap parula
% Make contour plot.
subplot( 1, 2, 1 );
h = plot( fitresult, [xData, yData], zData, 'Style', 'Contour' );
[x1,y1] = meshgrid(min(x):(max(x)-min(x))/10:max(x)+(min(x)-max(x))/20,min(y)-(max(y)-min(y))/10:(max(y)-min(y))/10:max(y)+(max(y)-min(y))/10);
xfit=fitresult(x1,y1);
%contourf(x1,y1,xfit)
legend( h, 'Easting Uncertainty', 'Observation points', 'Location', 'NorthEast' );
% Label axes
xlabel x
ylabel y
grid on
colorbar()
pbaspect([1 1 1])

set(gca,'XTick', x1(1,1):x1(1,3)-x1(1,1):x1(1,size(x1,2)));
set(gca,'YTick', y1(1,1):y1(3,1)-y1(1,1):y1(size(y1,1),1));
colormap parula
%-------------------------------------------------------------------------------------------------------
[xData, yData, zData] = prepareSurfaceData( x, y, ey);
% Set up fittype and options.
ft = fittype( 'poly22' );
% Fit model to data.
[fitresult, ~] = fit( [xData, yData], zData, ft );
% Create a figure for the plots.
figure ('position', [0, 200, 1400, 500]);
% Plot fit with data.
colormap jet
subplot( 2, 2, 2 );
h = plot( fitresult, [xData, yData], zData );
legend( h, 'Northing Uncertainty', 'Observation points', 'Location', 'NorthEast' );
% Label axes
xlabel x
ylabel y
zlabel 'Uncertainty (m)'
grid on
view( -18.7, 29.2 );
colormap parula

% Plot residuals.
subplot( 2, 2, 4 );
h = plot( fitresult, [xData, yData], zData, 'Style', 'Residual' );
legend( h, 'Northing Uncertainty - residuals', 'Location', 'NorthEast' );
% Label axes
xlabel x
ylabel y
zlabel 'Uncertainty (m)'
grid on
view( -18.7, 29.2 );

[x1,y1] = meshgrid(min(x):(max(x)-min(x))/10:max(x)+(min(x)-max(x))/20,min(y)-(max(y)-min(y))/10:(max(y)-min(y))/10:max(y)+(max(y)-min(y))/10);
yfit=fitresult(x1,y1);
colormap parula

% Make contour plot.
subplot( 1, 2, 1 );
h = plot( fitresult, [xData, yData], zData, 'Style', 'Contour' );
legend( h, 'Northing Uncertainty', 'Observation points', 'Location', 'NorthEast' );
% Label axes
xlabel x
ylabel y
grid on
levels =  0:0.003:0.07;
%contourf(x1,y1,yfit,levels)
colorbar()
pbaspect([1 1 1])


set(gca,'XTick', x1(1,1):x1(1,3)-x1(1,1):x1(1,size(x1,2)));
set(gca,'YTick', y1(1,1):y1(3,1)-y1(1,1):y1(size(y1,1),1));
colormap parula

%---------------------------------------------------------------------------------------------
compfit=(xfit.*xfit+yfit.*yfit).^0.5;
%-----------------------------------------------------------------------------
figure('position', [0, 100, 800, 500]);
[C,hContour] = contourf(x1,y1,compfit);
clabel(C,hContour,'FontSize',15,'Color','red')
grid on
colorbar()
% Update the contours immediately, and also whenever the contour is redrawn
%updateContours(hContour);
%addlistener(hContour, 'MarkedClean', @(h,e)updateContours(hContour));
pbaspect([1 1 1])
hold on
%quiver(x1,y1,xfit/2,yfit/2)
quiver(x1,y1,abs(xfit)/10,abs(yfit)/10,0.5,'color','y')
quiver(x1,y1,-abs(xfit)/10,-abs(yfit)/10,0.5,'color','y')
quiver(x1,y1,-abs(xfit)/10,-abs(yfit)/10,0.2,'o','color','y','MarkerFaceColor','k')
%point(x1,y1)
%plot('XData',x1,'YData',y1)
set(gca,'XTick', x1(1,1):x1(1,2)-x1(1,1):x1(1,size(x1,2)));
set(gca,'YTick', y1(1,1):y1(2,1)-y1(1,1):y1(size(y1,1),1));
hold off
colormap parula
%
%function updateContours(hContour)
%    % Update the text label colors
%    drawnow  % very important!
%    levels = hContour.LevelList;
%    labels = hContour.TextPrims;  % undocumented/unsupported
%    lines  = hContour.EdgePrims;  % undocumented/unsupported
%    for idx = 1 : numel(labels)
%        labelValue = str2double(labels(idx).String);
%        lineIdx = find(abs(levels-labelValue)<10*eps, 1);  % avoid FP errors using eps
%        labels(idx).ColorData = lines(lineIdx).ColorData;  % update the label color
 %       %labels(idx).Font.Size = 8;                        % update the label font size
  %  end
%    drawnow  % optional
%end

