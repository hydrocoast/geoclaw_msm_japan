% ========================================================================
% (function) func_pickup_crosssection
% Nobuki Fukui, Kyoto University
% Description: pickup specific cross-section
% ------------------------------------------------------------------------
% Syntax: data_crosssection (cell)
%           = func_pickup_crosssection(info_region,lonlat,data2d)
% Input: info_region --> region information data (cell)
%        lonlat_cs --> min and max of longitude and latitude for specific area
%        lonlat_cs = [lon_min,lon_max,lat_target];
%        data2d --> ex. inundation depth
% Output: data_crosssection --> data in cross-section distribution (cell)
%         ex) data_crosssection{i}
%             --> i-th crosssection (you can specify multiple cross-sections)
% ------------------------------------------------------------------------
% Update:
% v1, 2020/03/16, 1st edition
% v2, 2020/10/20, ŽÎ‚ß‚É‚à‘Î‰ž‚³‚¹‚é
% v3, 2021/01/26, ’¼ŒðÀ•WŒn‚É‘Î‰ž‚³‚¹‚é
% v4, 2021/07/27, ”gŒü‚«‚ªX•ûŒü‚Æ‹t‚Ìê‡‚É‚à‘Î‰ž
% ========================================================================

function data_crosssection ...
    = func_pickup_crosssection(info_region,lonlat_cs,data2d...
    ,flag_coordinate,flag_dir)

% data setup
%       numCS = length(lonlat_cs(:,1));
%       data_crosssection = cell(numCS,1);

% pickup infomation of region
nx = info_region.nx; ny = info_region.ny;
dx = info_region.dx; dy = dx;
xorg = info_region.xorg; yorg = info_region.yorg;
xvec = xorg:dx:xorg+(nx-1)*dx;
yvec = yorg:dy:yorg+(ny-1)*dy;

% mesh construction
[X,Y] = meshgrid(xvec,yvec);

X = double(X);Y = double(Y);
[lat,lon] = latlonUTM(X,Y,'51R');


if flag_coordinate == 1 % longitude and latitude
    
    % find linear function of cross section
    p = polyfit(lonlat_cs(:,1),lonlat_cs(:,2),1);
    lat_cs = polyval(p,lon);
    lonmin = min(lonlat_cs(:,1));
    lonmax = max(lonlat_cs(:,1));
    
    if dx >= 50
        Ind_region = ...
            abs(lat-lat_cs)<0.00022&lon>=lonmin&lon<=lonmax;
    elseif dx == 30
        Ind_region = ...
            abs(lat-lat_cs)<0.00012&lon>=lonmin&lon<=lonmax;
    elseif dx == 20
        Ind_region = ...
            abs(lat-lat_cs)<0.00005&lon>=lonmin&lon<=lonmax;
    elseif dx == 10
        Ind_region = ...
            abs(lat-lat_cs)<0.00003&lon>=lonmin&lon<=lonmax;
    elseif dx >= 5
        Ind_region = ...
            abs(lat-lat_cs)<0.000015&lon>=lonmin&lon<=lonmax;
    elseif dx == 1
        Ind_region = ...
            abs(lat-lat_cs)<0.000002&lon>=lonmin&lon<=lonmax;
    end
    
elseif flag_coordinate == 2 % xy cartesian coordinate
    
    
    % find linear function of cross section
    p = polyfit(lonlat_cs(:,1),lonlat_cs(:,2),1);
    Y_cs = polyval(p,X);
    Xmin = min(lonlat_cs(:,1));
    Xmax = max(lonlat_cs(:,1));
    
    if dx == 5
        threshold = 5;
    elseif dx == 20
        threshold = 20;
    elseif dx == 30
        threshold = 15;
    elseif dx == 50
        threshold = 30;
    elseif dx == 90
        threshold = 50;
    end
    
    Ind_region = ...
        abs(Y-Y_cs)<threshold&X>=Xmin&X<=Xmax;
    
end





data1d_spec = data2d(Ind_region);
lon_spec = lon(Ind_region);
x_spec = X(Ind_region);
lat_spec = lat(Ind_region);
y_spec = Y(Ind_region);

% ƒ_ƒu‚Á‚Ä‚¢‚é•”•ª‚ðíœ‚·‚é

if flag_dir == 1 || flag_dir == 2 % “Œ¼•ûŒü
    
    for ii = 1:1:length(data1d_spec)
        
        tmp = x_spec(ii);
        
        for jj = ii+1:1:length(data1d_spec)
            
            
            if x_spec(jj) == tmp
                
                data1d_spec(jj) = NaN;
                lon_spec(jj) = NaN;
                x_spec(jj) = NaN;
                y_spec(jj) = NaN;
                lat_spec(jj) = NaN;
                
                
            end
            
        end
        
        
    end
    
    ind_double = isnan(data1d_spec);
    data1d_spec(ind_double) = [];
    lon_spec(ind_double) = [];
    x_spec(ind_double) = [];
    y_spec(ind_double) = [];
    lat_spec(ind_double) = [];
    
    
elseif flag_dir == 3 || flag_dir == 4 % “ì–k•ûŒü
    
    for ii = 1:1:length(data1d_spec)
        
        tmp = y_spec(ii);
        
        for jj = ii+1:1:length(data1d_spec)      
            
            if y_spec(jj) == tmp
                
                data1d_spec(jj) = NaN;
                lon_spec(jj) = NaN;
                x_spec(jj) = NaN;
                y_spec(jj) = NaN;
                lat_spec(jj) = NaN;
                                
            end
            
        end
        
        
    end
    
    ind_double = isnan(data1d_spec);
    data1d_spec(ind_double) = [];
    lon_spec(ind_double) = [];
    x_spec(ind_double) = [];
    y_spec(ind_double) = [];
    lat_spec(ind_double) = [];
    
    
end

% ”gŒü‚«‚Ìˆá‚¢‚É‘Î‰ž
if flag_dir == 1 % +X•ûŒü
    
    data_crosssection.xx = x_spec - min(x_spec);
    data_crosssection.data = data1d_spec;
    data_crosssection.lon = lon_spec;
    data_crosssection.x = x_spec;
    
    
elseif flag_dir == 2 % -X•ûŒü
    
    % reverse LR
    data1d_spec = flipud(data1d_spec);
    lon_spec = flipud(lon_spec);
    lat_spec = flipud(lat_spec);
    
    data_crosssection.xx = flipud( max(x_spec) - x_spec );
    data_crosssection.data = data1d_spec;
    data_crosssection.lon = lon_spec;
    data_crosssection.x = flipud(x_spec);
    
    
elseif flag_dir == 3 % +Y•ûŒü
   
    data_crosssection.xx = y_spec - min(y_spec);
    data_crosssection.data = data1d_spec;
    data_crosssection.lat = lat_spec;
    data_crosssection.x = y_spec;
    
    
elseif flag_dir == 4 % -Y•ûŒü
    
    % reverse UD
    data1d_spec = flipud(data1d_spec);
    lon_spec = flipud(lon_spec);
    lat_spec = flipud(lat_spec);
    
    data_crosssection.xx = flipud( max(y_spec) - y_spec );
    data_crosssection.data = data1d_spec;
    data_crosssection.lat = lat_spec;
    data_crosssection.x = flipud(y_spec);
    
end

% 
% figure(999);clf
% pcolor(lon,lat,data2d)
% shading flat
% hold on
% plot(lon_spec,lat_spec,'r')
% hold off

clear data1d_spec

end










