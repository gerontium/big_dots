% getChannelVars.m 
% Computes and saves the channel variances for each block, so these
% can be plotted to look for bad channels using check4badchans.m.
% Variance calc from FFT spectrum so can avoid certain frequencies.
% list ALL BDF files in a study in a cell array of cell arrays such that
% files{s}{n} is the name of the nth file of session (subject) s.
% also list session IDs (subject initials or whatever) in cell array sessionID.
clear all
close all
clc

path_temp = 'F:\Drug_data\';

subject_folder = {'P01'};
allsubj = {'01'};
drug_cond = [{'ATM','CIT','MPH','PLA'}];
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

nchan = 128;
for s=file_start:length(subject_folder)
    for n=1:length(allblocks{s})
        files{s}{n} = [path_temp subject_folder{s} '\' allsubj{s} '_' num2str(allblocks{s}(n)) '.bdf'];
%         matfiles{s} = [path_temp subject_folder{s} '\' allsubj{s} '_' num2str(blocks(n)) '.mat'];
    end
    matfiles{s} = [path_temp subject_folder{s} '\' allsubj{s} 'chanvars.mat'];
end

% how much of the spectrum to use?
speclims = [0.5 40];  % Limits in Hz

%%%%%%%%%%%%%%%%%%%%% From here it's all standard

h = waitbar(0,'Please wait...');
steps = length(allsubj);
step = file_start-1;                
for s=file_start:length(allsubj)    
    chanlocs = readlocs('cap128.loc');

    files1 = files{s};
    matfiles1 = matfiles{s};
    disp(s)
    disp(allsubj{s})
    tic
    if s==file_start
        waitbar(step/steps,h)
    else
        min_time = round((end_time*(steps-step))/60);
        sec_time = round(rem(end_time*(steps-step),60));
        waitbar(step/steps,h,[num2str(min_time),' minutes remaining'])
    end        
    step=step+1;
        
    clear chanVar
    for b=1:length(files1)
        % For the purposes of looking for bad channels, it seems most sensible to leave the BDF referenced as it was recorded.
        % If we average-reference, a bad channel's badness is diluted and may spread to other channels.
        % With a single reference channel, it would be ok, as long as that channel is clean.
        EEG = pop_biosig(files1{b}, 'blockepoch', 'off','channels',[1:nchan]);

        % Fish out the event triggers and times
        clear trigs stimes
        for i=1:length(EEG.event)
            trigs(i)=EEG.event(i).type;
            stimes(i)=EEG.event(i).latency;
        end
        temp = abs(fft(EEG.data(:,stimes(1):stimes(end))'))'; % FFT amplitude spectrum
        tempF = [0:size(temp,2)-1]*EEG.srate/size(temp,2); % Frequency scale
        chanVar(:,b) = mean(temp(:,find(tempF>speclims(1) & tempF<speclims(2))),2);       % ROW of variances        
    end
    save(matfiles1,'chanVar')
    end_time = toc;
end
close(h)

