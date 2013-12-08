function[irrmags, exprlevs, chr2locs]=findirrad(lengthC,nseg,posC,irrad,expr,posP,N_pixel)

halfway=lengthC/(nseg+1)

chr2locs = [1:nseg]./nseg-1./(2.*nseg);
xAll = zeros(1,ceil(nseg/2));
yAll = xAll;
posC(1)
for n=1:ceil(nseg/2)   
    x=find(posP<=posC(1)+halfway*(1+2*(n-1)),1,'last');
    y=find(posP<=posC(2),1,'last');
    posC(1)+halfway*(1+2*(n-1))
%     if(posP(x(end))==posP(end))
%         x=x-1;
%     end
    xAll(n)=x;
    yAll(n)=y;
    
    point=xAll(n)+N_pixel*(yAll(n)-1);
    irrmags(n)=irrad(point);
    exprlevs(n)=expr(point);
    if find(posP==posC(1)+halfway*(1+2*(n-1)))% & posP(end)~=posC(1)+halfway*(1+2*(n-1))
        irrmags(n)=mean(irrad(point:point+1));
        exprlevs(n)=mean(expr(point:point+1));
    end
end



