% ========================================================================
% (program) make_movie
% Nobuki Fukui, Kyoto University
% Description: make movie using sequential image files
% ------------------------------------------------------------------------
% Input: image files (>=2)
% Output: movie file 
% ------------------------------------------------------------------------
% Update:
% 2022/7/29, v1, re-organized legacy code
% =======================================================================

%% 
close all
clear
fclose all;

%%
% % file names
casenamefig = '090400UTC_GPV';
runname = 'testrun_haishen_Wa05'
read_dir = ['../CalSet/',runname,'/_output/visclaw_plots'];
figname_prefix = 'haishen_eta';

videoname = ['mov_eta_',casenamefig,'_',runname,'.mp4'];


nTimeStep_start = 121;%0;
nTimeStep_skip  = 1;
nTimeStep_end   = 220;

% file names
% casenamefig = '090400UTC_GPV';
% read_dir = './fig/haishen';
% figname_prefix = 'fig_storm_field_haishen';
% 
% videoname = ['mov_storm_',casenamefig,'.mp4'];
% 
% 
% nTimeStep_start = 89;%0;
% nTimeStep_skip  = 1;
% nTimeStep_end   = 144;


%%

nt = (nTimeStep_end-nTimeStep_start)/nTimeStep_skip;

v = VideoWriter(videoname,'MPEG-4');
v.FrameRate = 7; 
open(v)

for it = nTimeStep_start:nTimeStep_skip:nTimeStep_end

    aaa = (it-nTimeStep_start) / (nTimeStep_end - nTimeStep_start);

    c_monitor = ['>>> Now Loading Images ',num2str(aaa*100),'%'];
    disp(c_monitor)

    figname=[figname_prefix,'-',num2str(it,'%03u'),'.png'];
%     figname=[figname_prefix,'_',num2str(it),'.png'];
    A = imread(fullfile(read_dir,figname));
    writeVideo(v,A)
    
end
close(v)