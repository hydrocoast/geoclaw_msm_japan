% =======================================================================
% (function) collect_pnt_timeseries
% Nobuki Fukui, Kyoto University
% Description: collect point gauge data in 3D matrix
% ---------------------------------------------------------------------
% Syntax: 
% data_timeseries = collect_pnt_timeseries( X_pnt, Y_pnt,...
%     info_region,timelap,dataorg)
% X_pnt, Y_pnt: ほしい点のxy座標(lonlatでもおけ)
% info_region: 計算領域の基本情報->これは事前に作成しておく
% 
% ---------------------------------------------------------------------
% Update:
% ?????????, v1, 作成
% 2021/11/6, v2, squeezeでかなり時間をとるので別案を利用
% =====================================================================

function [data_timeseries] = collect_pnt_timeseries(X_pnt,Y_pnt,...
    info_region,timelap,dataorg,flag_filloutliers)


% parse information of region
nx = info_region.nx; ny = info_region.ny;
dx = info_region.dx; dy = dx;
xorg = info_region.xorg; yorg = info_region.yorg;
xvec = xorg:dx:xorg+(nx-1)*dx;
yvec = yorg:dy:yorg+(ny-1)*dy;

% construct mesh grid data
[X,Y] = meshgrid(xvec,yvec);
X = double(X); % single -> double
Y = double(Y); % single -> double[
sz = size(X);

% preallocation
data_timeseries = zeros(1,length(timelap));

% find distance between target point and grid reference points
dist = sqrt((X-X_pnt).^2+(Y-Y_pnt).^2);

% find intex where distance is minimum -> i.e. target point
I = find( dist == min(dist(:)), 1 );

% case division when multiple candidates of target point is detected
if length(I) == 1
    disp('>>> target point is detected ...')
elseif length(I) > 1
    error('>>> more than 2 points are detected ...')
else
    error('>>>> No data is found (T_T)')
end

% convert index to subscription (i.e. i and j)
[row,col] = ind2sub(sz, I);

% pick up point gauge data
data_timeseries(1,:) = dataorg(:,row,col);

% (optional) replace outliers using linear interpolation
if flag_filloutliers == 1
    data_timeseries = filloutliers( data_timeseries, 'linear', 'median');
end

% set NaN value as zero
data_timeseries(isnan(data_timeseries)) = 0;

end