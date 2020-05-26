function matdata = csvDealer2(cellarray)
a = cellfun(@csvDealer, cellarray, 'UniformOutput', false);
matdata = vertcat(a{:});
end