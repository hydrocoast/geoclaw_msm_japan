
function Gauge = func_read_gauge(filename)
    
    fid = fopen(filename,'r');
    
    header = textscan(fid,'%s %9s %6d %10s%18.10f %18.10f'); 
    Gauge.lat = header{6}(1);
    Gauge.lon = header{5}(1);
    dataorg = readmatrix(filename);

    Gauge.AMRlevel = dataorg(:,1);
    Gauge.time = dataorg(:,2);
    Gauge.q1 = dataorg(:,3);
    Gauge.q2 = dataorg(:,4);
    Gauge.q3 = dataorg(:,5);
    Gauge.eta = dataorg(:,6);

    fclose(fid);
    
end

