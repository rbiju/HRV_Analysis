function [xpks, ypks, wavy] = waveletfunc(datax, datay, p_limit)
wt = modwt(datay,4);
wtrec = zeros(size(wt));
wtrec(2:3,:) = wt(2:3,:);
y = imodwt(wtrec,'sym4');
[pks, locs, ~, p] = findpeaks(y);
mask1 = p >= p_limit;
ypks = pks(mask1);
xndx = locs(mask1);
xpks = datax(xndx);
wavy = y;
end