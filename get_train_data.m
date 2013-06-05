function train_data = get_train_data(data,ind,folders)
% Get training data for a particular sign at index ind (1...95) from 
% specific folders
% folders: a vector of subfolders for training

% start index relative to a sub folder
start_index = (ind - 1) * 3 + 1;

train_data = reshape(data(start_index:start_index+2,folders),1,3*length(folders));

end