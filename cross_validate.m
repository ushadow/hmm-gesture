function [error total_classification]= cross_validate(data,signs,Q)
% INPUT:
% data: scaled data for training, the cells in the data is organized into
%       columns for different subfolders
% signs: a vector of signs (hmm models) to train
% Q: number of states

NUM_FOLDS = 4;
NUM_SAMPLES_PER_SIGN = 3;

%training subfolders;
TR = 1:8;
num_test_folders = length(TR)/NUM_FOLDS;

num_signs = length(signs);

hmm = cell(num_signs,1);

t = 9; % t is the test subfolder number

% Gaussian mixture
M = 1;

total_error = 0;
total_classification = zeros(num_signs);

for f = 1 : NUM_FOLDS,
    
    start_test_folder = (f-1)*num_test_folders+1;
    test_folders = start_test_folder:start_test_folder+1;
    
    % always start from the first sign, and continously
    test_data = data(1:NUM_SAMPLES_PER_SIGN*num_signs,test_folders);
    train_folders = TR;
    train_folders(test_folders)=[];
    
    for i = 1 : num_signs,
        
        train_data = get_train_data(data,signs(i),train_folders);

        % Initialize parameters

        [prior0, transmat0, mu0, Sigma0, mixmat0] = initialize(train_data,Q, M);

        [hmm{i}.LL, hmm{i}.prior1, hmm{i}.transmat1, hmm{i}.mu1, hmm{i}.Sigma1, hmm{i}.mixmat1] = ...
           mhmm_em(train_data, prior0, transmat0, mu0, Sigma0, mixmat0, 'max_iter', 10);

        hmm{i}.bic = BIC(train_data,hmm{i});
        hmm{i}.sign = signs(i);
    end

    [error classification] = test(test_data,hmm);
    total_error = total_error + error;
    total_classification = total_classification + classification;
end

error  = total_error/NUM_FOLDS;
