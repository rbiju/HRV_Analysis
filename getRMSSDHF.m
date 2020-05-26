function [rmssd, hfp] = getRMSSDHF(tabledata, filetitle, p_limit)

if contains(filetitle, 'before')
    prefix = 'Pre-';
elseif contains(filetitle, 'after')
    prefix = 'Post-';
end

s = size(tabledata);

if s(2) == 1
    tabledata = table2array(tabledata);
    matdata = csvDealer2(tabledata);
elseif s(2) == 2
    matdata = table2array(tabledata);
end

matdata = trimmer(matdata);
datax = matdata(:,1);
datay = matdata(:,2);

[xpks, ypks, wavy] = waveletfunc(datax, datay, p_limit);

rmssd = rms(diff(xpks));

[psd, f, hfp] = correctHF(xpks, ypks);

%peaks of interest highlighted in time domain
subplot(2,1,1)
plot(datax, datay, 'k',xpks, ypks, 'r*', datax, wavy, 'b');
legend('Raw Data', 'R wave peaks', 'Wavelet Transform');
xlim([10 300]);
ylim([0 5]);
title(strcat(prefix, 'Exercise ECG'));
xlabel('time (s)');
ylabel('voltage (V)');
hold off

%region of interest highlighted in freq domain
subplot(2,1,2)

plot(f,psd);
xlim([0,1]);
ylim([0,0.15]);
title(strcat(prefix, 'Exercise AR PSD estimate'));
xlabel('frequency (Hz)');
ylabel('PSD (s^2)');

sgtitle(filetitle);
filename = strcat(filetitle, '.png');
filename = [pwd '/results/' filename];
set(gcf, 'Position',  [100, 100, 1000, 400])
saveas(gcf, filename);

end

function trimmed = trimmer(data)
datax = data(:,1);
mask = (datax >= 10 & datax <= 300);
trimmed = data(mask, :);
end
