function [crunched] = dataCruncher()
csv_files = dir('*.csv');
filenames = {csv_files(:).name};
%throwing out 1(plim=0.8), 5, 7
p_limits = [1 1 0.45 0.6 0.6 0.5 0.7 0.5 0.5 0.5 1 1 1 1];
for i = 1:length(filenames)
    filename = filenames{i};
    filetitle = filename(1:end-4);
    tabledata = readtable(filename);
    [rmssd, hf] = getRMSSDHF(tabledata, filetitle, p_limits(i));
    crunched(i,1) = rmssd; %#ok<*AGROW>
    crunched(i,2) = hf;
end
