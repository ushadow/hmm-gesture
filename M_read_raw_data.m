function M_read_raw_data()
% M_: the data is from multiple users
%
% In each file, there are [n by 15] values, where each row represents the 
% observed value and has recorded in every 10ms. 
% For each row x_i, the column attribute is recorded as follows: 
%
% x_i = [x, y, z, roll, pitch, yaw, thumb, fore, index, ring, little, keycode,
% gs1, gs2, receiver values]
%
% 'picth', 'yaw', 'little', 'keycode', 'gs1', 'gs2', and 'receiver vales' 
% should be ignored (check 
% http://archive.ics.uci.edu/ml/datasets/Australian+Sign+Language+signs 
% for more information). The index numbers for those columns are [5 6 11 12
% 13 14 15]. This makes the dimension of our feature vector to be 8.
IGNORE_COLUMNS = [5 6 11 12 13 14 15];

% PATH: path to the subfolders containing training data
PATH = '../signs/';
NUM_OF_WORDS = 95;

subfolders = dir(PATH);
subfolders = subfolders(3:length(subfolders), :); %ignores '\.' and '\..'

% get the number of samples for each word in each folder
for i = 1 : length(subfolders)    
    folder = strcat(PATH,subfolders(i).name,'/');  
        
    % list all files in the subfolder
    files = dir(folder);
    files = files(3:length(files), :); %ignores '\.' and '\..'
    
    % Each folder contains different number of files for one word.
    M_num_samples(i) = floor(length(files)/NUM_OF_WORDS);
    fprintf('Subject [%d] : %d samples\n', i, M_num_samples(i));
end;

ind = 0;

% read raw data
for i = 1 : NUM_OF_WORDS
    cnt = 0;
    fprintf('\n\n>>>>Word [%d]\n',i);
    for j = 1 : length(subfolders)
        folder = strcat(PATH,subfolders(j).name,'/');  
        disp(folder);
        for k = 1 : M_num_samples(j)                        
            % list all files in the subfolder
            files = dir(folder);
            files = files(3:length(files), :); %ignores '\.' and '\..'
                        
            % get an index number of the file
            file_idx = (i-1)*M_num_samples(j) + k;
            fullpath = strcat(folder,files(file_idx).name);
            d = load(fullpath);
        
            disp(fullpath);
            
            % delete columns to be ignored        
            for ign=1:length(IGNORE_COLUMNS)
                d(:,IGNORE_COLUMNS(length(IGNORE_COLUMNS)-ign+1))=[]; 
            end;
        
            cnt = cnt + 1;
            ind = ind + 1;
            
            % transpose the matrix so that each column is a feature vector
            M_raw_data{ind} = d';             
        end;
    end;
    
    if( cnt ~= sum(M_num_samples) ) 
        fprintf('WARNING: [%d] word count = %d\n', i, cnt);
    end;    
end;
% check correct number of examples are read
if(ind ~= NUM_OF_WORDS*sum(M_num_samples))
    fprintf('Error: the number of training examples is wrong');
else
    save('M_raw_data.mat','M_raw_data', 'M_num_samples');
end


