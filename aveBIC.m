function result = aveBIC(hmm,k)
% k is number of states

totalBic = 0;

num = length(hmm);
for i = 1:num,
    
    bic = hmm{i}.LL(end) - ((k-2)*2 + 1 + k*22 + 23*11*k)/2*log(24); 
    totalBic = totalBic + bic; 
end

result = totalBic/num;