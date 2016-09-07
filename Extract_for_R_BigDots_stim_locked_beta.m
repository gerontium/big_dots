%%% runafew
clear
close all
clc

%%
path_temp = 'S:\R-MNHS-SPP\Bellgrove-data\4. Dan Newman\Participant Folders_new\'; %Monash PC
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


%% STFT parameters
STFT_time=[];
no_of_cycles = 8;
% % get a broad range, e.g. beta, 20 to 35Hz
fs_STFT = [20:35]; % stftlen_STFT = 140; % 8 cycles = 280 ms (at mid frequency, i.e. 28 Hz for beta), = 140 samples. 
stftlen_STFT = round((1000/round(median(fs_STFT))*no_of_cycles)/2);

% % get a specific frequency for SSVEP
% fs_STFT = [25]; % or if you want a particular SSVEP frequency
% stftlen_STFT = round((1000/fs_STFT*no_of_cycles)/2);
% for SSVEP frequency make sure it's EXACTLY a particular number of cycles of the frequency. 
% check freq_temp_STFT to make sure SSVEP frequency falls on the range

skip_step = 20;
cc=1;
for tt = 1:skip_step:length(ts)-(stftlen_STFT)
    tf = tt:tt+stftlen_STFT-1;
    nfft = length(tf);
    freq_temp_STFT = (0:ceil((nfft+1)/2)-1)*fs/nfft;
    STFT_time(cc) = mean(t(tf));
    cc=cc+1;
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
    

    %% STFT calculation
disp('Calculating STFT...')
erp = double(erp); % chan x time x trial
STFT = [];
for trial = 1:size(erp,3)
    cc=1;
    for tt = 1:skip_step:size(erp,2)-(stftlen_STFT)
        tf = tt:tt+stftlen_STFT-1; % define time window
        ep = squeeze(erp(:,tf,trial)); % chop out chan x time window
        nfft = size(ep,2);
        ep = detrend(ep')'; % detrend
        fftx = abs(fft(ep,[],2))./(stftlen_STFT/2);
        fftx = fftx(:,1:ceil((nfft+1)/2));
        ind = find(freq_temp_STFT>fs_STFT(1) & freq_temp_STFT<fs_STFT(end));
%         [~,ind] = min(abs(freq_temp_STFT-fs_STFT)); % if you want SSVEP at one particular frequency
        STFT(:,cc,trial) = mean(fftx(:,ind),2);
        cc=cc+1;
    end
end
    % Baseline beta
    baseline_beta = mean(STFT(:,find(STFT_time<=BL_beta),:),2);
    beta_TSE_base = STFT-repmat(baseline_beta,[1,size(STFT,2),1]); % baseline full erp
 %%       
    %if the final trial was a miss there will be no RT recorded, just need
    %to add a zero for RT in that case
    if length(allRT)<length(allrespLR)
        allRT(length(allRT):length(allrespLR))=0;
    end
    
    allTrials=allTrig; % just renamed this because it makes more sense to me to call it trials
     
%% Response locked STFT
%Response locked STFT time (ms)
STFT_timer= -400:40:80;
%Response locked STFT time in samples
STFT_timers = [-.400*25:25*.100];

STFTr = zeros(size(STFT,1),length(STFT_timer),size(STFT,3));    
    
    validrlock = zeros(1,length(allRT)); % length of RTs.
    for n=1:length(allRT);
        [blah,RTsamp] = min(abs(STFT_time*fs/1000-allRT(n))); % get the sample point of the RT.
        if RTsamp+STFT_timers(1) >0 & RTsamp+STFT_timers(end)<=length(STFT_time) & allRT(n)>0 % is the RT larger than 1st stim RT point, smaller than last RT point.
            STFTr(:,:,n) = STFT(:,RTsamp+STFT_timers,n);
            validrlock(n)=1;
        end
    end  

    %% DN: master_matrix_R columns:
    %1.Subject number; 2.total trial number;  3.inter-subject trial number;
    %4.Time; % 5 Response Locked Beta
 
    for trial=1:length(allTrials) % get rid of last trigger?
        total_numtr = total_numtr+1;      
        ID_vector(current:current+(length(STFT_time)-1)) = subject_folder(s);
        %% 1. Subject number:
        master_matrix_R(current:current+(length(STFT_time)-1),1) = s;
        %% 2. total trial number:
        master_matrix_R(current:current+(length(STFT_time)-1),2) = total_numtr;
        %% 3. inter-subject trial number
        master_matrix_R(current:current+(length(STFT_time)-1),3) = trial;
        %% 4. Time:
         master_matrix_R(current:current+(length(STFT_time)-1),4)=STFT_time; 
        %% 5. Response Locked Beta
        master_matrix_R(current:current+(length(STFT_time)-1),5)=STFT(ch_beta,:, trial);

        current=current+length(STFT_time);
    end
end
% find empty cells in ID_vector
emptyCells = cellfun(@isempty,ID_vector);
% remove empty cells
ID_vector(emptyCells) = [];

%Save the data in .csv format to be read into R for inferential stats analysis
csvwrite (['master_matrix_R_Stim_locked_beta.csv'],master_matrix_R)
cell2csv ('ID_vector_Stim_locked_beta.csv',ID_vector)

