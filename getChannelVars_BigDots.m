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
% path_temp = 'C:\Users\Ger Loughnane\Documents\Main Files\PhD\Projects\Evidence Acculumation Project\Dots Analysis\Study Participants\';
path_temp = 'S:\R-MNHS-SPP\Bellgrove-data\4. Dan Newman\Participant Folders_new\';


subject_folder = {'LK_07_04_14','AR_08_04_14','MH_14_04_14','AA_15_04_14','NT_16_04_14', ...
    'OF_28_04_14','RO_25_04_14','PR_20_04_14','AS_23_04_14','OM_07_05_14', ...
    'RM_06_05_14','SB_08_05_14','GW_09_05_14','OS_09_05_14','AC_13_05_14', ...
    'ND_16_05_14','SF_20_05_14','TL_23_05_14','JC_23_05_14','EL_24_05_14', ...
    'SH_25_05_14','059M_HP','093M_BR','036M_JK','221M_SJ', ...
    '068M_CB','301M_MO','118M_CS','265M_EZ','291M_KS', ...
    '106M_NH','302M_BS','289M_AS','303M_SA','103M_JK', ...
    '314M_LK','226M_SM','037M_JD','338M_SC','091M_SW', ...
    '134M_JM','331M_CL','108M_CY','191M_DM','243M_JB', ...
    '136M_JC','339M_YV','353M_AT','352M_MK','061M_LG', ...
    '235M_JM','374M_PP','325M_KR','279M_FT','114M_CS','378M_MG', ...
    '133M_DC','392M_PH','186M_AF','404M_RO','147M_EB','400M_ED','398M_LO', ...
    '384M_PD','205M_LE','328M_EW','418M_AM','189M_WM','203M_VF','234M_SW',...
    '220M_NB','377M_BL','427M_SS','414M_LA','458M_AH','439M_TM',...
    '484M_AI','453M_LB','422M_MK','323M_CZ'};
allsubj = {'LK','AR','MH','AA','NT','OF','RO','PR','AS','OM', ...
    'RM','SB','GW','OS','AC','ND','SF','TL','JC','EL', ...
    'SH','HP1M','BR2M','JK3M','SJ4M','CB5M','MO6M','CS7M','EZ8M','KS9M', ...
    'NH10M','BS11M','AS12M','SA13M','JK14M','LK15M','SM16M','JD17M','SC18M','SW19M', ...
    'JM20M','CL21M','CY22M','DM24M','JB25M','JC26M','YV27M','AT28M','MK29M','LG30M', ...
    'JM31M','PP32M','KR33M','FT34M','CS35M','MG36M','DC37M','PH38M','AF39M','RO40M', ...
    'EB41M','ED42M','LO43M','PD44M','LE45M','EW46M','AM47M', 'WM48M','VF49M','SW50M',...
    'NB52M','BL53M','SS54M','LA55M','AH56M','TM57M','AI58M','LB59M','MK60M','CZ61M'};

TCD_bigdots = {'LK_07_04_14','AR_08_04_14','MH_14_04_14','AA_15_04_14','NT_16_04_14', ...
    'OF_28_04_14','RO_25_04_14','PR_20_04_14','AS_23_04_14','OM_07_05_14', ...
    'RM_06_05_14','SB_08_05_14','GW_09_05_14','OS_09_05_14','AC_13_05_14', ...
    'ND_16_05_14','SF_20_05_14','TL_23_05_14','JC_23_05_14','EL_24_05_14', ...
    'SH_25_05_14'};
Monash_bigdots = {'059M_HP','093M_BR','036M_JK','221M_SJ','068M_CB', ...
    '118M_CS','265M_EZ','301M_MO','291M_KS','106M_NH', ...
    '302M_BS','289M_AS','303M_SA','103M_JK','314M_LK', ...
    '226M_SM','037M_JD','338M_SC','091M_SW','134M_JM', ...
    '331M_CL','108M_CY','191M_DM','243M_JB','136M_JC', ...
    '339M_YV','353M_AT','352M_MK','061M_LG','235M_JM', ...
    '374M_PP','325M_KR','279M_FT','114M_CS','378M_MG','133M_DC', ...
    '392M_PH','186M_AF','404M_RO','147M_EB','400M_ED','398M_LO', ...
    '384M_PD','205M_LE','328M_EW','418M_AM','189M_WM','203M_VF','234M_SW',...
    '220M_NB','377M_BL','427M_SS','414M_LA','458M_AH','439M_TM',...
    '484M_AI','453M_LB','422M_MK','323M_CZ'};


duds = [];
single_participants = [];

file_start = 1;

blocks = {[1:8,10:16] [1:9,11:16] [1:3,5:16] [1:2,4:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:9,11:15] ...
    [1:3,5:15] [1:16] [1:16] [1:16] [1:16] [1:16] [1:15] [1:16] [1:16] [1:16] ...
    [1:16] [1:16] [1:16] [1:15,18] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] ...
    [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] ...
    [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] ...
    [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:14,16]...
    [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16]...
    [1:16] [1:16] [1:16] [1:16] [1:13,15,16] [1:16] [1:10,11:16] [1:16] [1:16] [1:16]};

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
        if ismember(subject_folder{s},TCD_bigdots)
            block_temp = blocks{s};
            block_temp(find(ismember(block_temp,0))) = [];
            for n=1:length(block_temp)
                k=k+1;
                files{s}{k} = [path_temp subject_folder{s} '\' allsubj{s},num2str(block_temp(n)) '.bdf'];
%                 matfiles{s}{k} = [path_temp subject_folder{s} '\Session' num2str(session) '\' allsubj{s} num2str(session) '_C',num2str(block_temp(n)) '.mat'];
            end
        elseif ismember(subject_folder{s},Monash_bigdots)
            block_temp = blocks{s};
            block_temp(find(ismember(block_temp,0))) = [];
                for n=1:length(block_temp)
                    k=k+1;
                    paths{s}{k} = [path_temp subject_folder{s} '\'];
                    files{s}{k} = [allsubj{s} num2str(block_temp(n)) '.vhdr'];
%                     matfiles{s}{k} = [path_temp subject_folder{s} '\' allsubj{s} num2str(session) '_C' num2str(block_temp(n)) '.mat'];
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
    if ismember(subject_folder{s},TCD_bigdots)
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
        if ismember(subject_folder{s},TCD_bigdots)
            EEG = pop_biosig(files1{b}, 'blockepoch', 'off','channels',[1:nchan]);
        elseif ismember(subject_folder{s},Monash_bigdots)
            EEG = pop_loadbv(paths1{b},files1{b});
            EEG = pop_rmdat(EEG, {'boundary'},[0 1] ,1); %DN: this deletes the data from 0 to 1 sec around the DC Correction triggers that BrainVision puts in
            for i=1:length([EEG.event.latency]) %DN: round the event latencies back to whole numbers (intergers), because the pop_rmdat line (above) makes non-interger latencies at the points where you kicked out the bad DC Correction data
                EEG.event(i).latency = round([EEG.event(i).latency]);
            end
            EEG = letterkilla_old(EEG); %DN: removes the letters that Brain Products appends to the triggers
        end
        EEG.data = detrend(EEG.data')'; % GL: NB to prevent trending seeming like a bad channel
        
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

