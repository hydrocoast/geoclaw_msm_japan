% ========================================================================
% (function) func_upscale_2darray
% Nobuki Fukui, Kyoto University
% Description: calculate grid average to upscale fine mesh data
% -----------------------------------------------------------------------
% Syntax:
% dataupscale = func_upscale(dataorg,dx)
% Input: dataorg --> mesh data in fine mesh (2D array)
%        dx --> upscaled mesh size
%        dx_org --> original mesh size
% Output: dataupscale --> upscaled mesh data in dx
% ------------------------------------------------------------------------
% Update
% 2020/03/03, v1, first edition
% 2020/08/20, v2, revision for dx = 20, 40
% ========================================================================

function dataupscale = func_upscale_2darray(dataorg,dx,dx_org)

 % obtain size of array
 [nrows,ncols] = size(dataorg);
 
 % size of upscaled array
 ratio_dx = dx_org/dx;
 skip    = 1/ratio_dx;
 nrows_upscale = ceil(nrows * ratio_dx);
 ncols_upscale = ceil(ncols * ratio_dx);
   
 
 % preallcation
 dataupscale = zeros(nrows_upscale,ncols_upscale);
%  dataorg(isnan(dataorg)) = 0;
 
 ii = 1;
 
 for i = 1:skip:nrows
    
     jj = 1;
     
     for j = 1:skip:ncols
        
         ie = i+skip-1;
         je = j+skip-1;
         if ie > nrows; ie = nrows; end
         if je > ncols; je = ncols; end
         
         datapartial = dataorg(i:ie,j:je) ;
         
         dataupscale(ii,jj) ...
             = nanmean(nanmean(datapartial));
                  
         jj = jj + 1;
         
     end
     
     ii = ii + 1;
     
 end
 
%  dataupscale = flipud(dataupscale);
 
end






























