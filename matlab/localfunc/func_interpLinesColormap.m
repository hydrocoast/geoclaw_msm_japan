function cl=func_interpLinesColormap(num)
% colormap lines from Yu Chida
cl_base=lines(7) ;
xc=1:1:7 ;
xcin=min(xc):(max(xc)-min(xc))/(num-1):max(xc) ;
cl=zeros(num,3) ;
for i=1:1:3
    tmpx=interp1(xc,cl_base(:,i),xcin) ;
    cl(:,i)=tmpx ;
end

end