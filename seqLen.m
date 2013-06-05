function [min,max]= seqLen(data)

min = 1000;
max = 0;

for i=1:length(data),
    l = size(data{i},2);
    if(l<min)
        min = l;
    end
    if(l>max)
        max = l;
    end
end
