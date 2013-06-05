function [mu,sigma] = initialize_mu_sigma(data, Q, M)
% Q: number of states
% M: number of mixtures

% total number of examples
numex = length(data);

feature_len = size(data{1},1);

% each column of new_matrix{j} is a feature vector
new_matrix = cell(Q);

mu = zeros(feature_len, Q, M);
sigma = zeros(feature_len, feature_len, Q, M);

for i = 1:numex,
    O = data{i};
    m = length(O);
    div = floor(m / Q);
    for j = 1:Q,
        start_index = (j-1) * div + 1;
        sub_matrix = O(:,start_index : start_index + div -1);
        new_matrix{j} = horzcat(new_matrix{j}, sub_matrix);
    end
end

for j = 1:Q,
    
    mu(:,j) = mean(new_matrix{j},2);
    
    % Find var of each row
    % All variance is set to be 1, to avoid log-likelihood to be greater
    % than 1.
    sigma(:,:,j) = eye(feature_len)*2;
end


end