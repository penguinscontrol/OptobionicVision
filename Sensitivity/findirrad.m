function[irrmags, expressions, chr2locs]=findirrad(lengthC,nseg,posC,irrad,expr,posP,N_pixel)

halfway=lengthC/(2*nseg);

chr2locs = [1:nseg]./nseg-1./(2.*nseg);
xAll = zeros(1,ceil(nseg/2));
yAll = xAll;
%posC(1);
% if mod(nseg,2)==0
%     nseg=nseg+1;
% end
for n=1:nseg; %ceil(nseg/2)   
    y=find(posP<=posC(1)+halfway*(1+2*(n-1)),1,'last');
    x=find(fliplr(posP)>=posC(2),1,'last');
%    posC(1)+halfway*(1+2*(n-1))
%      if(posP(x(end))==posP(end))
%          x=x-1;
%      end
    xAll(n)=x;
    yAll(n)=y;
    
%     point=xAll(n)+N_pixel*(yAll(n)-1);
%     if point>length(irrad)
%         irrmags(n)=0;
%     else
%         irrmags(n)=irrad(point);
%     end
    irrmags(n) = irrad(x,y);
    expressions(n) = expr(x,y);
    %irrmags(n)
    if find(posP==posC(1)+halfway*(1+2*(n-1)));% & posP(end)~=posC(1)+halfway*(1+2*(n-1))
        irrmags(n)=mean(irrad(x:(x+1),y));
        expressions(n) = mean(expr(x:(x+1),y));
    end
end



