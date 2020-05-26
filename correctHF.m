function [PSD, f, hfp] = correctHF(xpks, ypks)

%resampling
xr = linspace(min(xpks), max(xpks), length(xpks));
yr = resample(ypks, xr, 'spline');

figure
plot(xpks, ypks, 'b', xr, yr, 'r');

Ts = mean(diff(xr));
fs = 1/Ts;

[PSD,f] = pburg(yr,10,[],fs);

fmask = (f > 0.15 & f < 0.4);
inty = PSD(fmask);
intx = f(fmask);
hfp = trapz(intx, inty);
end
