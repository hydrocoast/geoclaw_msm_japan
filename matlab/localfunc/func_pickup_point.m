% ========================================================================
% (function) func_pickup_point
% Nobuki Fukui, Kyoto University
% Description: pick up data corresponding to query point
% -----------------------------------------------------------------------
% Syntax:
% datapnt = func_pickup_point( X, Y, data, Xq, Yq )
% X, Y --> x,y coordinate corresponding to data
% data --> 1/2d array data
% Xq, Yq --> query points (1d array)
% -------------------------------------------------------------------------
% Update: 
% 2021/6/28, v1, First edition
% =========================================================================


function datapnt = func_pickup_point( X, Y, data, Xq, Yq )

% variable check
if ~isvector(Xq) && ~isvector(Yq);error('Xq and Yq should be 1d array');end

% number of sample point 
n_pnt = length(Xq);

% preallocation
% datapnt = NaN(n_pnt,1);

% pickup data at query point
for i = 1:1:n_pnt
   
    dist = sqrt( (X-Xq(i)).^2 + (Y-Yq(i)).^2 );
    [mindist,ind_pnt] = min( dist(:) );
    tmp(i) = data( ind_pnt );    
    tmp2(i) = X( ind_pnt );
    tmp3(i) = Y( ind_pnt );
    
end

datapnt.data = tmp;
datapnt.X = tmp2;
datapnt.Y = tmp3;


end























