function prescale(data)
% prescale standardize the data with 0 mean and 1 standard deviation

NUM_SUBFOLD = 9;
NUM_SIGNS = 95;
NUM_EX = NUM_SIGNS * 3 * NUM_SUBFOLD;

full = data{1};

for i = 2:NUM_EX
    full = horzcat(full, data{i});
end

% mu and sigma2 are column vectors
mu = mean(full,2);
sigma2 = std(full,0,2);

for i = 1:NUM_EX
    data{i} = standardize(data{i},mu,sigma2);
end

save('scaled_data.mat','data','mu','sigma2');
end