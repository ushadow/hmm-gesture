function I = path(data,ex,hmm)
B = mixgauss_prob(data{ex,1}, hmm.mu1, hmm.Sigma1, hmm.mixmat1);


[p] = viterbi_path(hmm.prior1, hmm.transmat1, B);

I = int32(p);

fout = fopen('path.txt','w');

fprintf(fout,'%d\n',I);
fclose(fout);
