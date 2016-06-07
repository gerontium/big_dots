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

% datafolder = 'C:\Documents and Settings\Geronimo\My Documents\College Files\Dots Analysis\bilateral dots data\';
% matfolder = 'C:\Documents and Settings\Geronimo\My Documents\College Files\Dots Analysis\bilateral dots data\';
% path_temp = 'C:\Users\Ger Loughnane\Documents\Main Files\PhD\Projects\Evidence Acculumation Project\Dots Analysis\Study Participants\';
path_temp = 'C:\Users\Ger Loughnane\Documents\Main Files\PhD\Projects\Evidence Acculumation Project\Dots Analysis\Study Participants\';

subject_folder = {'TM_07-02-13','NO_11-02-13','AT_11-02-13','MG_12-02-13','DD_15-02-13', ...
    'PT_19-02-13','AC_20-02-13','AF_20-02-13','KH_21-02-13','ER_22-02-13', ...
    'BD_22-02-13','MR_25-02-13','EO_26-02-13','MC_27-02-13','ED_28-02-13', ...
    'WW_28-02-13','LC_15-03-13','HK_15-03-13','HM_15-03-13','KO_15-03-13', ...
    'SY_01-03-13_M','RKR_06-03-13_M','PN_14-02-13_M','PF_13-02-13_M','PD_05-03-13_M', ...
    'PB_09-03-13_M','NS_28-02-13_M','LMc_12-02-13_M','JW_14-03-13_M','JG_27-02-13_M', ...
    'CK_10-03-13_M','NC1T','NM2T','RP3T','NO4T', ...
    'MT5T','FS6T','016M_MO_M','011M_EB_M','176M_TD_M', ...
    '174M_MS_M','173M_GW_M','166M_CK_M','153M_PD_M','150M_PN_M', ...
    '131M_JB_M','128M_SY_M','105M_MS_M','072M_MN_M','069M_AS_M', ...
    '065M_LB_M','043M_SC_M','036M_JK_M','177M_CK_M','178M_AM_M', ...
    '179M_MB_M'};
allsubj = {'TM','NO','AT','MG','DD','PT','AC','AF','KH','ER', ...
    'BD','MR','EO','MC','ED','WW','LC','HK','HM','KO', ...
    'SY','RKR','PN','PF','PD','PB','NS','LMc','JW','JG', ...
    'CK','NC','NM','RP','NO','MT','FS','MO','EB','TD', ...
    'MS','GW','CK','PD','PN','JB','SY','MS','MN','AS', ...
    'LB','SC','JK','CK','AM','MB'};
TCD_pilot = {'TM_07-02-13','NO_11-02-13','AT_11-02-13','MG_12-02-13','DD_15-02-13', ...
    'PT_19-02-13','AC_20-02-13','AF_20-02-13','KH_21-02-13','ER_22-02-13', ...
    'BD_22-02-13','MR_25-02-13','EO_26-02-13','MC_27-02-13','ED_28-02-13', ...
    'WW_28-02-13','LC_15-03-13','HK_15-03-13','HM_15-03-13','KO_15-03-13'};
Monash_pilot = {'SY_01-03-13_M','RKR_06-03-13_M','PN_14-02-13_M','PF_13-02-13_M','PD_05-03-13_M', ...
    'PB_09-03-13_M','NS_28-02-13_M','LMc_12-02-13_M','JW_14-03-13_M','JG_27-02-13_M', ...
    'CK_10-03-13_M'};
TCD_bigdots = {'NC1T','NM2T','RP3T','NO4T', ...
    'MT5T','FS6T'};
Monash_bigdots = {'016M_MO_M','011M_EB_M','176M_TD_M','174M_MS_M','173M_GW_M', ...
    '166M_CK_M','153M_PD_M','150M_PN_M','131M_JB_M','128M_SY_M', ...
    '105M_MS_M','072M_MN_M','069M_AS_M','065M_LB_M','043M_SC_M', ...
    '036M_JK_M','177M_CK_M','178M_AM_M','179M_MB_M'};
reverse_mapping = {'128M_SY_M','131M_JB_M','153M_PD_M','036M_JK_M','173M_GW_M', ...
    '174M_MS_M','176M_TD_M','065M_LB_M','179M_MB_M'};

duds = [1:31,32:37];
single_participants = [];

file_start = 1;
blocks_TCD_pilot = {[1:7],[1:7],[1:7],[1:7],[1:7],[1:7],[1,2,0,4:7],[1:7],[1:7],[1:7],[1:7],[1:7],[1:7],[1:7],[1:7],[1:7],[1:7],[1:7],[1:7],[1:7]};
blocks_Monash_pilot = {[1:7],[1:7],[1:7],[1:7],[1:7],[1:7],[1:7],[1:7],[1:7],[1:7],[1:7]};
blocks_TCD_bigdots = {[1:7;1:7],[1:7;1:7],[1:5,0,7;1:7],[1:7;1:7],[1:7;1:7],[1:7;1:7]};
blocks_Monash_bigdots = {[1:7;1:7],[1:7;1:7],[1:7;1:7],[1:7;1:7],[1:7;1:7],[1:7;1:7],[1:7;1:7],[1:7;1:7],[1:7;1:7],[1:7;1:7], ...
    [1:7;1:7],[1:7;1:7],[1:7;1:7],[1:7;1:7],[1:7;1:7],[1:7;1:7],[1:7;1:7],[1:7;1:7],[1:7;zeros(1,7)]};

blocks = [blocks_TCD_pilot,blocks_Monash_pilot,blocks_TCD_bigdots,blocks_Monash_bigdots];

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
for s=file_start:length(subject_folder)
    k=0;
    for session = 1:2
        if ismember(subject_folder{s},TCD_pilot)
            block_temp = blocks{s}(session,:);
            for n=1:length(block_temp)
                k=k+1;
                files{s}{k} = [path_temp subject_folder{s} '\' allsubj{s} '_CD_' num2str(blocks(n)) '.bdf'];
%                 matfiles{s}{k} = [path_temp subject_folder{s} '\' allsubj{s} '_CD_' num2str(blocks(n)) '.mat'];
            end
        elseif ismember(subject_folder{s},Monash_pilot)
            block_temp = blocks{s}(session,:);
            if strcmp(subject_folder{s},'RKR_06-03-13_M')
                for n=1:length(block_temp)
                    k=k+1;
                    paths{s}{k} = [path_temp subject_folder{s} '\'];
                    files{s}{k} = [allsubj{s} 'c' num2str(block_temp(n)) '.vhdr'];
                    matfiles{s}{k} = [path_temp subject_folder{s} '\' allsubj{s} 'c' num2str(block_temp(n)) '.mat'];
                end
            else
                for n=1:length(block_temp)
                    k=k+1;
                    paths{s}{k} = [path_temp subject_folder{s} '\'];
                    files{s}{k} = [allsubj{s} '_c' num2str(block_temp(n)) '.vhdr'];
%                     matfiles{s}{k} = [path_temp subject_folder{s} '\' allsubj{s} '_c' num2str(block_temp(n)) '.mat'];
                end
            end
        elseif ismember(subject_folder{s},TCD_bigdots)
            block_temp = blocks{s}(session,:);
            block_temp(find(ismember(block_temp,0))) = [];
            for n=1:length(block_temp)
                k=k+1;
                files{s}{k} = [path_temp subject_folder{s} '\Session' num2str(session) '\' allsubj{s} num2str(session) '_C',num2str(block_temp(n)) '.bdf'];
%                 matfiles{s}{k} = [path_temp subject_folder{s} '\Session' num2str(session) '\' allsubj{s} num2str(session) '_C',num2str(block_temp(n)) '.mat'];
            end
        elseif ismember(subject_folder{s},Monash_bigdots)
            block_temp = blocks{s}(session,:);
            block_temp(find(ismember(block_temp,0))) = [];
            if strcmp(subject_folder{s},'043M_SC_M') && session==1
                for n=1:length(block_temp)
                    k=k+1;
                    paths{s}{k} = [path_temp subject_folder{s} '\Session' num2str(session) '\'];
                    files{s}{k} = ['043M_SC_c' num2str(block_temp(n)) '.vhdr'];
%                     matfiles{s}{k} = [path_temp subject_folder{s} '\043M_SC_c' num2str(block_temp(n)) '.mat'];
                end
            else
                for n=1:length(block_temp)
                    k=k+1;
                    paths{s}{k} = [path_temp subject_folder{s} '\Session' num2str(session) '\'];
                    files{s}{k} = [allsubj{s} num2str(session) '_C' num2str(block_temp(n)) '.vhdr'];
%                     matfiles{s}{k} = [path_temp subject_folder{s} '\' allsubj{s} num2str(session) '_C' num2str(block_temp(n)) '.mat'];
                end
            end
        end
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
    if ismember(subject_folder{s},TCD_pilot)
        chanlocs = readlocs('cap64.loc');
    elseif ismember(subject_folder{s},Monash_pilot)
        load('C:\Users\Ger Loughnane\Documents\Main Files\PhD\Projects\Evidence Acculumation Project\Dots Analysis\BP_chanlocs.mat','chanlocs')
        paths1 = paths{s};
    elseif ismember(subject_folder{s},TCD_bigdots)
        chanlocs = readlocs('cap64.loc');
    elseif ismember(subject_folder{s},Monash_bigdots)
        load('C:\Users\Ger Loughnane\Documents\Main Files\PhD\Projects\Evidence Acculumation Project\Dots Analysis\BP_chanlocs.mat','chanlocs')
        paths1 = paths{s};
    end
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
        if ismember(subject_folder{s},TCD_pilot) | ismember(subject_folder{s},TCD_bigdots)
            EEG = pop_biosig(files1{b}, 'blockepoch', 'off','channels',[1:nchan]);
        elseif ismember(subject_folder{s},Monash_pilot) | ismember(subject_folder{s},Monash_bigdots)
            EEG = pop_loadbv(paths1{b},files1{b});
            EEG = pop_rmdat(EEG, {'boundary'},[0 1] ,1); %DN: this deletes the data from 0 to 1 sec around the DC Correction triggers that BrainVision puts in
            for i=1:length([EEG.event.latency]) %DN: round the event latencies back to whole numbers (intergers), because the pop_rmdat line (above) makes non-interger latencies at the points where you kicked out the bad DC Correction data
                EEG.event(i).latency = round([EEG.event(i).latency]);
            end
            EEG = letterkilla_old(EEG); %DN: removes the letters that Brain Products appends to the triggers
        end

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

