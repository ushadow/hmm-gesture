function read_data()

% PATH: path to the subfolders containing training data

PATH = '../tctodd/tctodd';

NUM_SUBFOLD = 9;
NUM_SIGNS = 95;
NUM_EX = NUM_SIGNS * 3 * NUM_SUBFOLD;

ind = 0;

for i = 1 : NUM_SUBFOLD
    
    % list all files in the subfolder
    folder = strcat(PATH,int2str(i),'/');
    files = dir(folder);
    
    % files are ordered alphabetically and Capital case is in front of 
    % lower case
    for j = 1 : length(files);
        if(files(j).isdir == 0 && files(j).name(1) ~= '.')
            fullpath = strcat(folder,files(j).name);
            d = load(fullpath);
            
            ind = ind + 1;
            
            % transpose the matrix so that each column is a feature vector
            raw_data{ind} = d';
        end
    end
end

% check correct number of examples are read
if(ind ~= NUM_EX)
    fprintf('Error: the number of training examples is wrong');
else
    save('raw_data.mat','raw_data');
end
