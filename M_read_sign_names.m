function M_read_sign_names()
% M_: the data is from multiple users
%
% get sign names, which is essentially the names of files in a folder. Each
% file format is represented as [sign-name][index][.sign]. [sign-name] is
% of our interest. This script reads in all the sign names and saves it to
% M_sign_names.mat file.

% PATH: path to the subfolders containing training data
PATH = '../signs/andrew1/';

files = dir(PATH);
files = files(3:length(files), :); %ignores '\.' and '\..'

ind = 0;

M_sign_names = cell(length(files),1);

% list all files in the subfolder
for j = 1 : length(files);
    ind = ind + 1;
    str = files(j).name(1:end-6);
    M_sign_names{ind} = str;
end

if(ind ~= length(files))
    fprintf('Error: the number of training examples is wrong');
else
    save('M_sign_names.mat','M_sign_names');
end
