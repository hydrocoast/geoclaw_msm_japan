% ====================================================================
% (program) check_gauge
% Nobuki Fukui, Tottori University
% Description: read point gauge (surge height) data
% --------------------------------------------------------------------
% Input: gauge00001.txt etc...
% -------------------------------------------------------------------
% Update:
% 2022/8/23,v1,first edition
% ===================================================================

%%
close all
clear
fclose all;
addpath localfunc

%%
n_gauge = 13;
casename = 'testrun_haishen_Wa05';
caldir = ['../CalSet/',casename];

font = 'Helvetica';fontsize = 16;
xrange = [59 81];yrange = [0 1];
xti = 60:3:80;

starttime = datetime(2020,9,4,0,0,0);
basetime = datetime(2020,9,6,12,0,0);
endtime = datetime(2020,9,7,9,0,0);
timelap = basetime:hours(3):endtime;
xti_str = datestr(timelap,'mm/dd HH:MM');

%%
fdir = [caldir,'/_output'];
for i_gauge = 1:1:n_gauge
    txtname = ['gauge',num2str(i_gauge,'%05u'),'.txt'];
    Gauge(i_gauge) = func_read_gauge(fullfile(fdir,txtname));
end

load tidalgauge_data.mat

%%
i_gplt = 1;
timevec_obs = datevec(time_obs{i_gplt});
time_hours_obs = hours( datetime( timevec_obs ) - starttime );

time_hours = hours( seconds( Gauge(i_gplt).time ) );

fig = figure(1);clf;hold on
p1=plot(time_hours,Gauge(i_gplt).eta,'-','LineWidth',1.0);
p2=plot(time_hours_obs,obsdata{i_gplt},'--^','LineWidth',1.0);
ylabel('\eta [m]')
set(gca,'FontSize',fontsize,'FontName',font)
xlim(xrange);ylim(yrange)
xticks(xti);xticklabels(xti_str)
grid on
le = legend([p1,p2],{'Cal.','Obs.'});

