clear
close all
clc

path_temp = 'D:\Ger\Evidence Acculumation Project\Dots Analysis\Study Participants\';

subject_folder = {'AC_20-02-13'};
allsubj = {'AC'};
allblocks = {[1:12]};
duds = [];
single_participants = [];

file_start = 1;

if ~isempty(duds) && isempty(single_participants)
    subject_folder([duds]) = [];
    allsubj([duds]) = [];
    blocks([duds]) = [];
end

if ~isempty(single_participants)
    subject_folder = subject_folder(single_participants);
    allsubj = allsubj(single_participants);
    blocks = blocks(single_participants);
end

nchan = 64;

% for s=file_start:length(subject_folder)
%     matfiles{s} = [path_temp subject_folder{s} '\' allsubj{s} 'chanvars.mat'];
% end
for s=file_start:length(subject_folder)
    matfiles{s} = [path_temp subject_folder{s} '\' allsubj{s} '_CD_chanvars.mat'];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

chanlocs = readlocs('cap64.loc');
for s=file_start:length(subject_folder)
    disp(subject_folder{s})
    load(matfiles{s})
    % 1,4,7,11
%     chanVar = chanVar(:,1:7);
%     chanVar = chanVar(:,8:14);
%     chanVar = chanVar(:,[1:3,6:14]);
    chanVar = double(chanVar);
    
%     badchans = [40,41,46,54,57,58,62,64,105,109,117];
%     changechans = [39,42,47,57,65,110,118]; % must be in same order as badchans.
%     chanVar(badchans(1:end),:) = chanVar(changechans(1:end),:);
    
    avVar = mean(chanVar,2); 
        
    % average variance for each channel across all 16 conditions
    % on a second sweep for a given subject, might want to plot topo again
    % after getting rid of a really bad one (to make it easier to see other
    % bad channels) - so do something like:
    % avVar(104) = avVar(103);  % quick hack - make a reall bad chan equal its neighbor
    
    figure;
    topoplot(avVar,chanlocs,'plotchans',[1:64],'electrodes','numbers');
    title(subject_folder{s})
    
    figure; hold on
    h = plot(chanVar(1:64,:));
    title(subject_folder{s})
    legend(h,'Location','NorthEast');
    
end