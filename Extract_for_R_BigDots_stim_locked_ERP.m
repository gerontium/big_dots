%%% runafew
clear
close all
clc

%%
% path_temp = 'S:\R-MNHS-SPP\Bellgrove-data\4. Dan Newman\Participant Folders_new\'; %Monash PC
path_temp = 'C:\Users\Dan\Desktop\Big_Dots_Data\';
%%
subject_folder = {'LK_07_04_14','AR_08_04_14','MH_14_04_14','AA_15_04_14','NT_16_04_14', ...
    'OF_28_04_14','RO_25_04_14','PR_20_04_14','AS_23_04_14','OM_07_05_14', ... % 10
    'RM_06_05_14','SB_08_05_14','GW_09_05_14','OS_09_05_14','AC_13_05_14', ...
    'ND_16_05_14','SF_20_05_14','TL_23_05_14','JC_23_05_14','EL_24_05_14', ... % 20
    'SH_25_05_14','059M_HP','093M_BR','036M_JK','221M_SJ', ...
    '068M_CB','301M_MO','118M_CS','265M_EZ','291M_KS', ... % 30
    '106M_NH','302M_BS','289M_AS','303M_SA','103M_JK', ...
    '314M_LK','226M_SM','037M_JD','338M_SC','091M_SW', ... % 40
    '134M_JM','331M_CL','108M_CY','191M_DM','243M_JB', ...
    '136M_JC','339M_YV','353M_AT','352M_MK','061M_LG', ... % 50
    '235M_JM','374M_PP','325M_KR','279M_FT','114M_CS', ...
    '378M_MG','133M_DC','392M_PH','186M_AF','404M_RO', ... % 60
    '147M_EB','400M_ED','398M_LO','384M_PD','205M_LE', ...
    '328M_EW','418M_AM','189M_WM','203M_VF','234M_SW', ... % 70
    '220M_NB','377M_BL','427M_SS','414M_LA','458M_AH', ...
    '439M_TM','484M_AI','453M_LB','422M_MK','323M_CZ','240M_FM'}; % 81
allsubj = {'LK','AR','MH','AA','NT','OF','RO','PR','AS','OM', ...
    'RM','SB','GW','OS','AC','ND','SF','TL','JC','EL', ...
    'SH','HP1M','BR2M','JK3M','SJ4M','CB5M','MO6M','CS7M','EZ8M','KS9M', ...
    'NH10M','BS11M','AS12M','SA13M','JK14M','LK15M','SM16M','JD17M','SC18M','SW19M', ...
    'JM20M','CL21M','CY22M','DM24M','JB25M','JC26M','YV27M','AT28M','MK29M','LG30M', ...
    'JM31M','PP32M','KR33M','FT34M','CS35M','MG36M','DC37M','PH38M','AF39M','RO40M', ...
    'EB41M','ED42M','LO43M','PD44M','LE45M','EW46M','AM47M','WM48M','VF49M','SW50M',...
    'NB52M','BL53M','SS54M','LA55M','AH56M','TM57M','AI58M','LB59M','MK60M','CZ61M','FM51M'};

%%

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
    '484M_AI','453M_LB','422M_MK','323M_CZ','240M_FM'};
%%
duds = [1]; %1 completed the wrong paradigm %4 and 74 could also be kicked out as they are RT outliers
single_participants = [];
%%
if ~isempty(duds) && isempty(single_participants)
    subject_folder([duds]) = [];
    allsubj([duds]) = [];  
end

if ~isempty(single_participants)
    subject_folder = subject_folder(single_participants);
    allsubj = allsubj(single_participants);
end
 

 
CSD=0; %Use Current Source Density transformed erp? 1=yes, 0=no



ch_CPP = [31];
ch_LR = [23;60];
ch_N2c = [60;23];


fs=500;

% stim-locked erps
ts = -0.700*fs:1.800*fs;
t = ts*1000/fs;

BL_erp = [-100,0];


% patch,ITI
targcodes = zeros(2,3);
targcodes(1,1) = [101]; % patch 1, ITI 1
targcodes(2,1) = [102]; % patch 2, ITI 1
targcodes(1,2) = [103]; % patch 1, ITI 2
targcodes(2,2) = [104]; % patch 2, ITI 2
targcodes(1,3) = [105]; % patch 1, ITI 3
targcodes(2,3) = [106]; % patch 2, ITI 3



master_matrix_R = []; % This saves the matrix for SPSS/R analysis.
total_numtr = 0;
ID_vector=cell(length(subject_folder)*205*length(t),1); %this will save the subjects ID for each single trial can be pasted into SPSS for ID column. Code at the end of the script clear the emplt cells


%% STFT parameters
t=[];
no_of_cycles = 8;
% % get a broad range, e.g. beta, 20 to 35Hz
fs_STFT = [20:35]; % stftlen_STFT = 140; % 8 cycles = 280 ms (at mid frequency, i.e. 28 Hz for beta), = 140 samples. 
stftlen_STFT = round((1000/round(median(fs_STFT))*no_of_cycles)/2);


%%
mat_file='big_dots_erp.mat';
%%
current=1;
for s=1:length(allsubj)
    disp(['Subject: ',num2str(s)])
    disp(['Subject: ',allsubj{s}])
    
%% Load the participant's .mat file:
        load([path_temp subject_folder{s} '\' allsubj{s} mat_file])

    if strcmp(subject_folder{s},'331M_CL') % really odd tiny artifact meant this trial was messing with CSD!
        allRT(53) = 0; allrespLR(53) = 0;
    end
        

%%
     if CSD
         erp=double(erp_LPF_35Hz_CSD);
     else
         erp=double(erp_LPF_35Hz);
     end
     
%% Make the epoch shorter by cutting off unnecessary time at start and end
erp=(erp(:,find(t==-100):find(t==1200),:));
ts = -0.100*fs:1.200*fs;
t = ts*1000/fs;     
     
 %% Baseline erp
    baseline_erp = mean(erp(:,find(t>=BL_erp(1) & t<=BL_erp(2)),:),2);
    erp = erp-repmat(baseline_erp,[1,size(erp,2),1]); % baseline full erp
    
    
    %if the final trial was a miss there will be no RT recorded, just need
    %to add a zero for RT in that case
    if length(allRT)<length(allrespLR)
        allRT(length(allRT):length(allrespLR))=0;
    end
    
    allTrials=allTrig; % just renamed this because it makes more sense to me to call it trials
     
    %% DN: master_matrix_R columns:
    %1.Subject number; 2.total trial number;  3.inter-subject trial number;
    %4.Time; % 5 Response Locked Beta
 
    for trial=1:length(allTrials) % get rid of last trigger?
        total_numtr = total_numtr+1;      
        ID_vector(current:current+(length(t)-1)) = subject_folder(s);
        %% 1. Subject number:
        master_matrix_R(current:current+(length(t)-1),1) = s;
        %% 2. total trial number:
        master_matrix_R(current:current+(length(t)-1),2) = total_numtr;
        %% 3. inter-subject trial number
        master_matrix_R(current:current+(length(t)-1),3) = trial;
        %% 4. Time:
         master_matrix_R(current:current+(length(t)-1),4)=t; 
        %% 5. Stim Locked CPP
        master_matrix_R(current:current+(length(t)-1),5)=erp(ch_CPP,:, trial);
        %% 6. N2c:
        if ismember(allTrials(trial),targcodes(1,:))% any left patch targcode. i.e. left target
            TargetSide=1;
        else
            TargetSide=2;
        end
        master_matrix_R(current:current+(length(t)-1),6)=erp(ch_N2c(TargetSide,:),:,trial);
        %% 7. N2i: 
        master_matrix_R(current:current+(length(t)-1),7)=erp(ch_LR(TargetSide,:),:,trial);
        
        current=current+length(t);
    end
end
% find empty cells in ID_vector
emptyCells = cellfun(@isempty,ID_vector);
% remove empty cells
ID_vector(emptyCells) = [];

%Save the data in .csv format to be read into R for inferential stats analysis
csvwrite (['master_matrix_R_Stim_locked_ERP.csv'],master_matrix_R)
cell2csv ('ID_vector_Stim_locked_ERP.csv',ID_vector)

