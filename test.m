% data: Each column represents a subfolder, the order of data in each 
%       column is ordered alphabetically, capital letter is in front of 
%       lower case.
%       Each row represents the same sign.
%       The signs in data is continuous and it only contains the signs
%       trained in hmm.
function [error_rate, classification] = test(data,hmm)

% number of signs to test
num_signs = length(hmm);

[r,c] = size(data);

classification = zeros(num_signs);

error = 0;

for i = 1 : r, %sign
    
    % there are 3 samples for each sign in each subfolder
    actual_sign = floor((i-1)/3) + 1;

    for k = 1 : c,
        max_ll = -inf;
        sign = 0; % classification
        for j = 1 : num_signs,
            ll = mhmm_logprob(data{i,k},hmm{j}.prior1, hmm{j}.transmat1,...
                hmm{j}.mu1, hmm{j}.Sigma1, hmm{j}.mixmat1);
            if(ll>max_ll)
                max_ll = ll;
                sign = j;
            end
        end
    
        classification(actual_sign,sign) = classification(actual_sign,sign) + 1;
        if( actual_sign ~= sign )
            error = error + 1;
        end
    end
end

error_rate = error / (r*c);

end
        
    