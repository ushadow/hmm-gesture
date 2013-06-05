function [prior0, transmat0,mu,sigma, mixmat0] = initialize(data, Q, M)
% data: training data for a particular sign, each column of data is an 
%       observation (feature vector)

% total number of examples
numex = length(data);

total_m = 0;
for i = 1:numex
    total_m = total_m + size(data{i},2);
end

ave_m = floor(total_m / numex);
  
prior0 = zeros(Q,1);
prior0(1) = 1; % initial state parameters

transmat0 = zeros(Q,Q); % transmission parameters
for i = 1:Q-2,
    transmat0(i,i:i+2) = 0.3333;
end
transmat0(Q-1,Q-1:Q) = 0.5;
transmat0(Q,Q) = 1;

mixmat0 = ones(Q,1);

feature_len = size(data{1},1);

% each column of new_matrix{j} is a feature vector
new_matrix = cell(Q);

mu = zeros(feature_len, Q, M);
sigma = zeros(feature_len, feature_len, Q, M);

for i = 1:numex,
    O = data{i};
    m = size(O,2);
    
    % divide the sequence to Q divisions, each division has div
    % observations
    div = floor(m / Q);
    
    % group observations of the same state together
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
    sigma(:,:,j) = eye(feature_len);
end


end