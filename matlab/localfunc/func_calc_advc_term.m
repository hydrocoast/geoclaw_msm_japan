% ====================================================================
% (function) func_calc_advc_term
% Nobuki Fukui, Kyoto University
% description: calculate advection term
% -----------------------------------------------------------------
% 
% 
% 


function advc = func_calc_advc_term(phi,dx,flag_dir)

    % find gradient
    [phi_x,phi_y] = gradient(phi);
     
    if flag_dir == 1
        
        advc = phi_x ./ dx;
        
    elseif flag_dir == 2
        
        advc = phi_y ./ dx;
        
    else
       
        error(['!! flag_dir should be 1 or 2 !!'])
        
    end
    

end

