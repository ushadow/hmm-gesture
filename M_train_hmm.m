function [hmm error classification] ...
    = M_train_hmm(data, num_signs, Q, M, ITER, cov_type)
% data: scaled data for training
% num_signs: number of signs (hmm models) to train
% cov_type: 'full', 'diag', 'spherical' 

disp(cov_type);
% there are 70 samples per each word
total_samples = 70;
%
% We will (later) perform 10-hold cross validation.
N_FOLD = 10;
sample_per_fold = total_samples / N_FOLD;

hmm = cell(num_signs,1);

test_data = zeros(0);
train_data = cell(total_samples-sample_per_fold,1);

% Just for now, we select one fold (7 samples) as test data over 70
% samples, and set the remaining 63 samples as training data.
% random number between 1 and 10
% COMMENT OUT THE FOLLOWING LINE WHEN PERFORMING 10-FOLD CROSS VALIDATION
for t = floor(mod(rand(1)*N_FOLD,N_FOLD))+1;          
%for t = 1 : N_FOLD     
    for i = 1 : num_signs, % floor(mod(rand(1)*95,95))+1;   %numsigns 
        fprintf('\n-----[Q=%d, M=%d, ITER=%d, (word idx=%d)]-----\n', Q, M, ITER, i);
        % start index number for each word chunk (contains 70 samples each)
        start_idx = ((i-1) * total_samples + 1);        
        % index number for test data in each word chunk
        test_idx = (t-1) * sample_per_fold;         
        
        % get test data
        test_from = start_idx + test_idx;
        test_to = test_from + sample_per_fold - 1;
        test_data = horzcat(test_data, data(test_from : test_to));    
                 
        % get training data
        train_data = data(start_idx : start_idx + total_samples - 1); 
        train_data(test_idx + 1 : test_idx + sample_per_fold) = [];   
        
        % initialize hmm
        [prior0, transmat0, mu0, Sigma0, mixmat0] = M_initialize(train_data, Q, M, cov_type);

        % train hmm using EM algorithm
        [hmm{i}.LL, hmm{i}.prior1, hmm{i}.transmat1, hmm{i}.mu1, hmm{i}.Sigma1, hmm{i}.mixmat1] = ...
           mhmm_em(train_data, prior0, transmat0, mu0, Sigma0, mixmat0, 'max_iter', ITER);
    end 
end

error = 0;
classification = 0;
[error classification] = M_test(test_data,hmm); 
disp(cov_type);
fprintf('\nError(Q=%d, M=%d, ITER=%d) = %.4f\n', Q, M, ITER, error);

