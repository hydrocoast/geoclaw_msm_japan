function [colormap_tsunami] = colormap_tsunami
%
% Example
% [cm_tsunami] = colormap_tsunami;
% colormap(cm_tsunami)
% colorbar
%
colormap_tsunami = [0:100, 100*ones(1,101); 0:100, 100:-1:0; 100*ones(1,101), 100:-1:0]'/100;
%colormap(cm);
