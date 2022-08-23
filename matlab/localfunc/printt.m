% ========================================================================
% (function) printt
% Coastal Engineering lab., Kyoto University
% Description: save figure in PNG, EPS (in color), and FIG
% -----------------------------------------------------------------------
% Syntax:
% printt( name ) --> 'name.png', 'name.eps', and 'name.fig' are saved
% printt( fig, name ) --> figure handle (fig) can be specified
% printt( fig, name, resolution ) --> resolution (ex. '-r400') can be
% specified
% ------------------------------------------------------------------------
% Update:
% 2021/11/05, NF modified the original code
% ========================================================================

function printt( varargin )

% check for the number of variables
narginchk(1,4)

% conditional branch based on nargin
if nargin == 1
    
    % parse multiple variables
    name = varargin{1};
    
    % print
    print('-dpng',name)
    print('-depsc',name)
    saveas(gcf,name,'fig')
    
elseif nargin == 2
    
    % parse multiple variables
    name = varargin{2};
    fig  = varargin{1};
    
    % print
    print(fig,'-dpng',name)
    print(fig,'-depsc',name)
    saveas(fig,name,'fig')
    
elseif nargin == 3
    
    % parse multiple variables
    name = varargin{2};
    fig  = varargin{1};
    resolution = varargin{3};
    
    % print
    print(fig,'-dpng',name,resolution)
    print(fig,'-depsc',name,resolution)
    saveas(fig,name,'fig')
    
end


end




% printt
% ‰æ‘œƒtƒ@ƒCƒ‹‚Ì•Û‘¶
% jpeg, eps, fig



% function printt(name)
% print('-dpng',name)
% print('-depsc',name)
% saveas(gcf,name,'fig')
