function read_sign_names()

% PATH: path to the subfolders containing training data

PATH = '../tctodd/tctodd1/';

NUM_SUBFOLD = 1;
NUM_SIGNS = 95;
NUM_EX = NUM_SIGNS * 3 * NUM_SUBFOLD;

ind = 0;
sign_names = cell(NUM_SIGNS,1);

% list all files in the subfolder
files = dir(PATH);
for j = 1 : length(files);
    if(files(j).isdir == 0 && files(j).name(1) ~= '.')
        ind = ind + 1;
        if (mod(ind,3)==0)
            str = files(j).name(1:end-6);
            sign_names{ind/3} = str;
        end
    end
end

if(ind ~= NUM_EX)
    fprintf('Error: the number of training examples is wrong');
else
    save('sign_names.mat','sign_names');
end
