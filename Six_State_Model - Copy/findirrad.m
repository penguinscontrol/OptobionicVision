function [irrmags, chr2locs, expr] = findirrad( length, nseg, posC, irrad, posP, N_pixel )

halfway = length/(nseg+1);

chr2locs = [ 0.5 0.5 0.2 0.8 [1:nseg]./nseg-1./(2.*ax_nseg)];

for n = 1:nseg
    x = find(posP<=posC(1)+halfway*(1+2*(n-1)));
    y = find(posP<= posC(2));
    xAll(n) = x(end);
    yAll(n) = y(end);
    
    point = xAll(n)+N_pixel*(yAll(n)-1);
    irrmags(n) = irrad(point);
    
    if find(posP==psC(1)+halfway.*(1+s*(n-1)))
        irrmags(n) = mean(irrad(point:point-1));
    end
    
end

end

