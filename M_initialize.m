function [prior0, transmat0, mu0, Sigma0, mixmat0] ...
    = M_initialize(data, Q, M, cov_type)
% data: training data for a particular sign, each column of data is an 
%       observation (feature vector)
% cov_type: 'full', 'diag', 'spherical'

% total number of examples
num_ex = length(data);

total_ex = 0;

for i = 1:num_ex
    total_ex = total_ex + size(data{i},2);
end

avg_m = floor(total_ex / num_ex);
  
prior0 = zeros(Q,1);
prior0(1) = 1; % initial state parameters

transmat0 = zeros(Q,Q); % transmission parameters
for i = 1:Q-2,
    transmat0(i,i:i+2) = 0.3333;
end
transmat0(Q-1,Q-1:Q) = 0.5;
transmat0(Q,Q) = 1;

feature_len = size(data{1},1);
reshaped_mat = zeros(feature_len, 0);
new_matrix = cell(Q,1);

for i = 1:num_ex,     
    O = data{i};
    m = size(O,2);
    
    % divide the sequence to Q divisions, each division has div observations
    div = floor(m / Q);
    for j = 1:Q,
        start_index = (j-1) * div + 1;
        sub_matrix = O(:,start_index : start_index + div -1);        
        new_matrix{j} = horzcat(new_matrix{j}, sub_matrix);
    end
end

mu0 = zeros(feature_len, Q, M);
Sigma0 = zeros(feature_len, feature_len, Q, M);
mixmat0 = ones(Q,M);

for j = 1:Q, 
    [mu0(:,j,:) Sigma0(:,:,j,:)] = mixgauss_init(M, new_matrix{j}, cov_type); 
end

mixmat0 = mk_stochastic(rand(Q,M));

%mu0 = zeros(feature_len, Q, M);
%Sigma0 = zeros(feature_len, feature_len, Q, M);
%mixmat0 = ones(Q,M);

%for i = 1 : num_ex,
%    reshaped_mat = horzcat(reshaped_mat, data{i});
%end;

%[mu0, Sigma0] = mixgauss_init(Q*M, reshaped_mat, cov_type);

%mu0 = reshape(mu0, [feature_len Q M]);
%Sigma0 = reshape(Sigma0, [feature_len feature_len Q M]);
%mixmat0 = mk_stochastic(rand(Q,M));
