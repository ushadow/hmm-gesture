function [error_rate, classification] = M_test(data,hmm)
% test data always starts from the first data from a subfolder

% number of signs to test
num_signs = length(hmm);
num_tests = length(data);
classification = zeros(num_signs);

error = 0;

for i = 1 : num_tests, 
    max_ll = -inf;
    sign = 0; % classification
    for j = 1 : num_signs, 
        ll = mhmm_logprob(data{i},hmm{j}.prior1, hmm{j}.transmat1,...
            hmm{j}.mu1, hmm{j}.Sigma1, hmm{j}.mixmat1);
        if(ll>max_ll)
            max_ll = ll;
            sign = j;
        end
    end

    n = num_tests / num_signs;
    
    actual_sign = floor((i-1)/n) + 1;
    classification(actual_sign,sign) = classification(actual_sign,sign) + 1;
    if( actual_sign ~= sign )
        error = error + 1;
    end
end

error_rate = error / num_tests;

end
        
    