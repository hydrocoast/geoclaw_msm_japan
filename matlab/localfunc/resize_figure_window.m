% ======================================================================= 
% (function) resize_figure_window
% Nobuki Fukui, Kyoto University
% Description: figure windowのサイズを変える
% ----------------------------------------------------------------------
% Syntax: resize_figure_window(nw,nh)
% Input: nw(幅の伸縮比), nh(高さの伸縮比)
% ----------------------------------------------------------------------
% Update: 2019/3/11, v1, 作成(参考 
% https://hydrocoast.jp/index.php?MATLAB/Figure%E3%81%AE%E8%AA%BF%E6%95%B4) 
% ======================================================================

function resize_figure_window(nw,nh)

% 最大サイズの取得
scrsz = get(groot,'ScreenSize');
maxW = scrsz(3);
maxH = scrsz(4);

p = get(gcf,'Position');
dw = p(3)-min(nw*p(3),maxW);
dh = p(4)-min(nh*p(4),maxH);
set(gcf,'Position',[p(1)+dw/2  p(2)+dh  min(nw*p(3),maxW)  min(nh*p(4),maxH)])

end