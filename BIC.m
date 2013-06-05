function [bic,ndata] = BIC(data,hmm,ind)
% hmm for sign(ind)

if nargin == 2
    train_data = data;
else
    train_data = get_train_data(data,ind,1:8);
end

% number of samples    
ndata =length(train_data);

%counting the number of independent parameter d
%initial probalilities t has 1 parameter t(s1) = 1;
%transition matrix T has (k-2) x 3 + 2 + 1 entries, but each row has to sum to 1 =>
%k*(k-1) independent parameters
%mu: k * 22 entries
%Sigma: k * 22 entries

bic = hmm.LL(end) - ((k-2)*2 + 1 + 2*k*22)/2*log(ndata); 