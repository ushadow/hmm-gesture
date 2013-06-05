% INPUT:
% data: scaled data for training, cells in data is organized as in columns
%       for different subfolders
% signs: a vector of signs (hmm models) to train
% Q: number of states

function [hmm error classification]= train_hmm(data,signs,Q)

NUM_SAMPLES_PER_SIGN = 3;

num_signs = length(signs);

hmm = cell(num_signs,1);

t = 9; % t is the test subfolder number
train_folders = 1:8;

M = 1;
  
% always start from the first sign, and continously
test_data = data(1:NUM_SAMPLES_PER_SIGN*num_signs,t);

for i = 1 : num_signs,
    
    train_data = get_train_data(data,signs(i),train_folders);

    % Initialize parameters

    [prior0, transmat0, mu0, Sigma0, mixmat0] = initialize(train_data,Q, M);

    [hmm{i}.LL, hmm{i}.prior1, hmm{i}.transmat1, hmm{i}.mu1, hmm{i}.Sigma1, hmm{i}.mixmat1] = ...
       mhmm_em(train_data, prior0, transmat0, mu0, Sigma0, mixmat0, 'max_iter', 10);
   
    hmm{i}.sign = signs(i);
end

[error classification] = test(test_data,hmm);




