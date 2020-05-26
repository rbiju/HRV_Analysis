function [h1, h2, p1, p2, means, seoms] = statsmachine()

crunched = dataCruncher();

temp1 = crunched(1:2:end, 1); %after rmssd
temp2 = crunched(2:2:end, 1); %before
temp3 = crunched(1:2:end, 2); %after hf
temp4 = crunched(2:2:end, 2); %before

[h1,p1] = ttest(temp2, temp1);
[h2,p2] = ttest(temp4, temp3);

arrangedmat = horzcat(temp2, temp1, temp4, temp3);

means = mean(arrangedmat);
seoms = std(arrangedmat) / sqrt(length(arrangedmat));

X = categorical({'Pre-Exercise RMSSD','Post-Exercise RMSSD'});
X = reordercats(X, {'Pre-Exercise RMSSD','Post-Exercise RMSSD'});

X1 = categorical({'Pre-Exercise HFP','Post-Exercise HFP'});
X1 = reordercats(X1, {'Pre-Exercise HFP','Post-Exercise HFP'});

figure
bar(X, means(1:2));
titletxt1 = strcat('Cumulative RMSSD readings', ' (p-val = ', num2str(p1), ')');
title(titletxt1);
ylabel('RMSSD (V)')
hold on
er = errorbar(X,means(1:2),seoms(1:2),seoms(1:2));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
hold off
saveas(gcf, [pwd '/results/summary_rmssd.png']);


figure
bar(X1, means(3:4));
titletxt2 = strcat('Cumulative HFP readings', ' (p-val = ', num2str(p2), ')');
title(titletxt2);
ylabel('HFP (s^2)')
hold on
er = errorbar(X1,means(3:4),seoms(3:4),seoms(3:4));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
hold off
saveas(gcf, [pwd '/results/summary_hfp.png']);

xlfile = [pwd '/results/summary.xlsx'];
xlmat = vertcat(arrangedmat, [0 0 0 0], means, seoms, [p1, p2, h1, h2]);
xlswrite(xlfile, xlmat);

close all
end
