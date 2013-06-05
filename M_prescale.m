function M_prescale(M_data, M_num_samples)
% M_: the data is from multiple users
%
% prescale standardize the data with 0 mean and 1 standard deviation

fprintf('length=%d\n', length(M_data));
M_full = M_data{1};

for i = 2:length(M_data)    
    fprintf('[%d] concatenating...\n',i);   
    M_full = horzcat(M_full, M_data{i});
end

% mu and sigma2 are column vectors
M_mu = mean(M_full,2);
M_sigma2 = std(M_full,0,2);

for i = 1:length(M_data)
    fprintf('[%d] standardizing...\n',i);
    M_data{i} = standardize(M_data{i}, M_mu, M_sigma2);
end

save('M_scaled_data.mat','M_data', 'M_num_samples', 'M_mu','M_sigma2');
end