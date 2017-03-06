%%% runafew
clear
close all
clc

%%
path_temp = 'C:\Users\Dan\Desktop\Big_Dots_Data\';
% path_temp = 'D:\Participant Folders_new\'; %TCD Laptop
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

 
CSD=0; %Use Current Source Density transformed erp? 1=yes, 0=no


% ch_N2i = [23;27];
% ch_LR=ch_N2i;
% ch_N2c = [27;23]; % right hemi channels for left target, vice versa.
% ch_for_ipsicon(1,:) = [27;23];
% ch_for_ipsicon(2,:) = [23;27];
% ch_l = [23];
% ch_r = [27];
% ch_front = 5; %5=Fz
% ch_CPP = [53];%25=Pz; 53=CPz
ch_beta=[13];

fs=500;

% stim-locked erps
% ts = -0.500*fs:1.800*fs;
% t = ts*1000/fs;
ts = -0.700*fs:1.800*fs;
t = ts*1000/fs;
ts_crop = -0.500*fs:1.500*fs;
t_crop = ts_crop*1000/fs;

% resp-locked erps
trs = [-.700*fs:fs*.100];
tr = trs*1000/fs;

BL_erp = [-100,0];
BL_beta = [-100];

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
ID_vector=cell(32000,1); %this will save the subjects ID for each single trial can be pasted into SPSS for ID column. Code at the end of the script clear the emplt cells


%% beta filter
beta_bandlimits = [20,35]; % defining the filter for beta bandpass.
[H,G]=butter(4,[2*(beta_bandlimits(1)/fs) 2*(beta_bandlimits(2)/fs)]); % beta bandpass for 500Hz

window = 26; % in samples. Time is double this.
skip_step = window/2;

% beta time
beta_t=[]; cca=1;
for tt = 1:skip_step:length(t_crop)-window
    beta_t(:,cca) = mean(t_crop(tt:tt+window-1));
    cca=cca+1;
end

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
     
     %% Baseline erp
    baseline_erp = mean(erp(:,find(t>=BL_erp(1) & t<=BL_erp(2)),:),2);
    erp = erp-repmat(baseline_erp,[1,size(erp,2),1]); % baseline full erp
    

    %% beta Spectrotemporal Evolution (TSE) a la Thut 
    beta_TSE = []; 
    for trial = 1:size(erp,3)
        % filtering to beta
        ep_filt = filtfilt(H,G,squeeze(erp(:,:,trial))')';
        % chop off ends and rectify
        ep_filt = abs(ep_filt(:,find(t>=t_crop(1) & t<=t_crop(end))));
        % smooth
        cca=1;
        for tt = 1:skip_step:size(ep_filt,2)-window
             beta_TSE(:,cca,trial) = mean(ep_filt(:,tt:tt+window-1),2);
            cca=cca+1;
        end
    end
    

    % Baseline beta
    baseline_beta = mean(beta_TSE(:,find(beta_t<=BL_beta),:),2);
    beta_TSE_base = beta_TSE-repmat(baseline_beta,[1,size(beta_TSE,2),1]); % baseline full erp
 %%       
    %if the final trial was a miss there will be no RT recorded, just need
    %to add a zero for RT in that case
    if length(allRT)<length(allrespLR)
        allRT(length(allRT):length(allrespLR))=0;
    end
    
    allTrials=allTrig; % just renamed this because it makes more sense to me to call it trials
     
%% Response locked TSE
%Response locked TSE time (ms)
beta_tr= -600:25:100;
%Response locked TSE time in samples
beta_trs = [-.600*40:40*.100];

beta_TSEr = zeros(size(beta_TSE,1),length(beta_tr),size(beta_TSE,3));    
    
    validrlock = zeros(1,length(allRT)); % length of RTs.
    for n=1:length(allRT);
        [blah,RTsamp] = min(abs(beta_t*fs/1000-allRT(n))); % get the sample point of the RT.
        if RTsamp+beta_trs(1) >0 & RTsamp+beta_trs(end)<=length(beta_t) & allRT(n)>0 % is the RT larger than 1st stim RT point, smaller than last RT point.
            beta_TSEr(:,:,n) = beta_TSE(:,RTsamp+beta_trs,n);
            beta_TSEr_base(:,:,n) = beta_TSE_base(:,RTsamp+beta_trs,n);
            validrlock(n)=1;
        end
    end  

    %% DN: master_matrix_R columns:
    %1.Subject number; 2.total trial number;  3.inter-subject trial number;
    %4.Time; % 5 Response Locked Beta
 
    for trial=1:length(allTrials) % get rid of last trigger?
        total_numtr = total_numtr+1;      
        ID_vector(current:current+(length(beta_tr)-1)) = subject_folder(s);
        %% 1. Subject number:
        master_matrix_R(current:current+(length(beta_tr)-1),1) = s;
        %% 2. total trial number:
        master_matrix_R(current:current+(length(beta_tr)-1),2) = total_numtr;
        %% 3. inter-subject trial number
        master_matrix_R(current:current+(length(beta_tr)-1),3) = trial;
        %% 4. Time:
         master_matrix_R(current:current+(length(beta_tr)-1),4)=beta_tr; 
        %% 5. Response Locked Beta TSE (Baselined)
        master_matrix_R(current:current+(length(beta_tr)-1),5)=beta_TSEr_base(ch_beta,:, trial);
        %% 6.  Response Locked Beta TSE (NOT Baselined)
        master_matrix_R(current:current+(length(beta_tr)-1),6)=beta_TSEr(ch_beta,:, trial);
        
        current=current+length(beta_tr);
    end
end
% find empty cells in ID_vector
emptyCells = cellfun(@isempty,ID_vector);
% remove empty cells
ID_vector(emptyCells) = [];

%Save the data in .csv format to be read into R for inferential stats analysis
csvwrite (['master_matrix_R_Resp_locked_beta_TSE.csv'],master_matrix_R)
cell2csv ('ID_vector_Resp_locked_beta_TSE.csv',ID_vector)

