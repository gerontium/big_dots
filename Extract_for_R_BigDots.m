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
BL_alpha = [-100];
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


%% Alpha filter
alpha_bandlimits = [8,13]; % defining the filter for alpha bandpass.
[H,G]=butter(4,[2*(alpha_bandlimits(1)/fs) 2*(alpha_bandlimits(2)/fs)]); % alpha bandpass for 500Hz

window = 50; % in samples. Time is double this.
skip_step = window/2;

% Alpha time
alpha_t=[]; cca=1;
for tt = 1:skip_step:length(t_crop)-window
    alpha_t(:,cca) = mean(t_crop(tt:tt+window-1));
    cca=cca+1;
end


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
for s=1:length(allsubj)
    disp(['Subject: ',num2str(s)])
    disp(['Subject: ',allsubj{s}])
    
%% Load the participant's .mat file:
        load([path_temp subject_folder{s} '\' allsubj{s} mat_file])
%         load([path_temp subject_folder{s} '\' 'avN2c_ParticipantLevel_peak_amp_index.mat'])
%         load([path_temp subject_folder{s} '\' 'avN2i_ParticipantLevel_peak_amp_index.mat'])
%         load([path_temp subject_folder{s} '\' 'ROIs.mat']) 
     LH_ROI_s=[17,18,21,22]; % 17,18,21,22,26,27   CP5, CP3, P5, P3, PO7, O1
     RH_ROI_s=[54,55,58,59]; % 54,55,58,59,63,64  CP4, CP6, P4, P6, PO4, O6 

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
        
    %% Alpha Spectrotemporal Evolution a la Thut 
    alpha_TSE = []; alpha_asym = [];
    for trial = 1:size(erp,3)
        % filtering to alpha
        ep_filt = filtfilt(H,G,squeeze(erp(:,:,trial))')';
        % chop off ends and rectify
        ep_filt = abs(ep_filt(:,find(t>=t_crop(1) & t<=t_crop(end))));
        % smooth
        cca=1;
        for tt = 1:skip_step:size(ep_filt,2)-window
            alpha_TSE(:,cca,trial) = mean(ep_filt(:,tt:tt+window-1),2);
            cca=cca+1;
        end
    end

    %% Baseline alpha
    baseline_alpha = mean(alpha_TSE(:,find(alpha_t<=BL_alpha),:),2);
    alpha_TSE_base = alpha_TSE-repmat(baseline_alpha,[1,size(alpha_TSE,2),1]); % baseline full erp
    
    %if the final trial was a miss there will be no RT recorded, just need
    %to add a zero for RT in that case
    if length(allRT)<length(allrespLR)
        allRT(length(allRT):length(allrespLR))=0;
    end
    
    allTrials=allTrig; % just renamed this because it makes more sense to me to call it trials
    
     %% calculate the response locked ERPs
    erpr = zeros(size(erp,1),length(tr),size(erp,3));
    validrlock = zeros(1,length(allRT)); % length of RTs.
    for n=1:length(allRT);
        [blah,RTsamp] = min(abs(t*fs/1000-allRT(n))); % get the sample point of the RT.
        if RTsamp+trs(1) >0 & RTsamp+trs(end)<=length(t) & allRT(n)>0 % is the RT larger than 1st stim RT point, smaller than last RT point.
            erpr(:,:,n) = erp(:,RTsamp+trs,n);
            validrlock(n)=1;
        end
    end   
 

%%    
    %DN: master_matrix_R columns:
    %Participant(1), Total Trial no(2), Inter-participant Trial no(3),ITI(4), TargetSide(5)
    % Accuracy (6), Artefact pre-target (7), Artifact baseline to
    % 100mspost-response (8), Artefact any time before response (9), 
    % Artefact between baseline and 1000ms (10), Fixation-Break pre-target (11), Artifact baseline to
    % 100mspost-response (12), Fixation-Break any time before response (13), 
    % Fixation-Break between baseline and 1000ms (14), Reaction time (15),
    %Pre-target AlphaPower overall (16), Pre-target AlphaPower Left Hemi (17)
    %Pre-target AlphaPower Right Hemi (18), Pre-target AlphaAsym (19),
    %Post-target Alpha Power Left Hemi (20), Post-target Alpha Power Right Hemi (21),
    
    %Pre-target Pupil Diameter (20), Number of repeated/invalid trials (21), N2c Amp(22), N2i Amp (23),
	%CPP half peak latency (26), N2c peak latency (27), Respose locked CPP slope (28),
    
    for trial=1:length(allTrials) % get rid of last trigger?
        total_numtr = total_numtr+1;
        ID_vector(total_numtr) = subject_folder(s);
        %% 1. Subject number:
        master_matrix_R(total_numtr,1) = s;
        %% 2. total trial number:
        master_matrix_R(total_numtr,2) = total_numtr;
        %% 3. inter-subject trial number
        master_matrix_R(total_numtr,3) = trial;
        %% 4. ITI:
        if ismember (allTrials(trial), targcodes(:,1)) % any ITI1 targcode.
            master_matrix_R(total_numtr,4) = 1;
        elseif ismember (allTrials(trial), targcodes(:,2))% any ITI2 targcode.
            master_matrix_R(total_numtr,4) = 2;
        else
            master_matrix_R(total_numtr,4) = 3; % any ITI3 targcode.
        end
        %% 5. Target Side:
        if ismember(allTrials(trial),targcodes(1,:)) % any left patch targcode. i.e. left target
            TargetSide=1;
            master_matrix_R(total_numtr,5) = 1;
        else
            TargetSide=2;
            master_matrix_R(total_numtr,5) = 2; %right target
        end
        %% 6. Accuracy:
            master_matrix_R(total_numtr,6) = allrespLR(trial); %no response
%% Meaning of the Artifact and fixation break vectors 
% 'pretarg_artrej', - artifact at any pre-target time 
% 'BL_resp_artrej', - artifact between baseline and 100ms post response
% 'resp_artrej', - artifact any time before response
% 't1000ms_artrej', - artifact between baseline and 1000ms 
% 
% 'ET_pretarg_artrej', - fixation break at any pre-target time 
% 'ET_BL_resp_artrej', - fixation break between baseline and 100ms post response
% 'ET_resp_artrej', - fixation break any time before response
% 'ET_t1000ms_artrej' - fixation break between baseline and 1000ms    
        %% 7. Artefact during pre-target window:
        master_matrix_R(total_numtr,7)= pretarg_artrej(trial); %1=no Artefact; 0=there was an Artefact
        %% 8. Artefact between -100ms to 100ms after response:
        master_matrix_R(total_numtr,8)= BL_resp_artrej(trial); %1=no Artefact; 0=there was an Artefact
        %% 9. Artefact any time before response
        master_matrix_R(total_numtr,9)=resp_artrej(trial); %1=no Artefact; 0=there was an Artefact
        %% 10. Artefact between baseline and 1000ms 
        master_matrix_R(total_numtr,10)=t1000ms_artrej(trial); %1=no fixation break or blink; 0=there was an fixation break or blink 
        %% 11. Fixation Break or Blink during pre-target window:
        master_matrix_R(total_numtr,11) = ET_pretarg_artrej(trial); %1=no fixation break or blink; 0=there was a fixation break or blink
        %% 12. Fixation Break or Blink between -100ms to 100ms after response:
        master_matrix_R(total_numtr,12) = ET_BL_resp_artrej(trial); %1=no fixation or blink; 0=there was a fixation break or blink
        %% 13. Fixation Break or Blink any time before response
        master_matrix_R(total_numtr,13)=ET_resp_artrej(trial); %1=no fixation break or blink; 0=there was an fixation break or blink
        %% 14. Fixation Break or Blink between baseline and 1000ms 
        master_matrix_R(total_numtr,14)=ET_t1000ms_artrej(trial); %1=no fixation break or blink; 0=there was an fixation break or blink      
        %% 15. Reaction time (RT):
        master_matrix_R(total_numtr,15)=allRT(trial)*1000/fs;
        %% 16. Pre-target Alpha Power overall (combining the two ROIs):
        master_matrix_R(total_numtr,16)=squeeze(mean(mean(alpha_TSE([LH_ROI_s RH_ROI_s],find(alpha_t>-500 & alpha_t<0),trial),1),2));
        %% 17. Pre-target Alpha Power Left Hemi:
        master_matrix_R(total_numtr,17)=squeeze(mean(mean(alpha_TSE(LH_ROI_s,find(alpha_t>-500 & alpha_t<0),trial),1),2));
        %% 18. Pre-target Alpha Power Right Hemi:
        master_matrix_R(total_numtr,18)=squeeze(mean(mean(alpha_TSE(RH_ROI_s,find(alpha_t>-500 & alpha_t<0),trial),1),2));
        %% 19.  Pre-target AlphaAsym:
        master_matrix_R(total_numtr,19)=(master_matrix_R(total_numtr,18)-master_matrix_R(total_numtr,17))/(master_matrix_R(total_numtr,18)+master_matrix_R(total_numtr,17)); %(RightHemiROI - LeftHemiROI)/(RightHemiROI + LeftHemiROI)
        %% 20. Post-target Alpha Power Left Hemi:
        master_matrix_R(total_numtr,20)=squeeze(mean(mean(alpha_TSE(LH_ROI_s,find(alpha_t<150 & alpha_t<700),trial),1),2));
        %% 21. Post-target Alpha Power Right Hemi:
        master_matrix_R(total_numtr,21)=squeeze(mean(mean(alpha_TSE(RH_ROI_s,find(alpha_t<150 & alpha_t<700),trial),1),2));   
        %% 22. location (1=TCD; 2=Monash)
        if ismember(subject_folder{s},TCD_bigdots)
             master_matrix_R(total_numtr,22) = 1; %TCD
        elseif ismember(subject_folder{s},Monash_bigdots)
            master_matrix_R(total_numtr,22) = 2; %Monash
        end 
%% HAVE NOT YET UPDATED BELOW FOR BIG DOTS
%         %% 20. Pre-target Pupil Diameter:
%         master_matrix_R(total_numtr,20)=mean(Pupil(find(t==-500):find(t==0),trial));
%         %% 21. Number of repeated trials due to fixation breaks:
%         master_matrix_R(total_numtr,21)=length(allRT(~(~fixation_break_n) & ~(~rejected_trial_n)));  
%         %% 22. N2c Amp (using PARTICIPANT LEVEL AVERAGE to define N2c measurement window):
%         window=25; %this is the time (in samples) each side of the peak latency - so 25 is actually a 100ms window (since fs=500 and this is done each side of the peak latency)
%         master_matrix_R(total_numtr,22)=mean(mean(erp(ch_N2c(TargetSide,:),(avN2c_ParticipantLevel_peak_amp_index_s(TargetSide))-window:avN2c_ParticipantLevel_peak_amp_index_s(TargetSide)+window,trial),1));
%         %% 23. N2i Amp (using PARTICIPANT LEVEL AVERAGE to define N2i measurement window):
%         master_matrix_R(total_numtr,23)=mean(mean(erp(ch_LR(TargetSide,:),avN2c_ParticipantLevel_peak_amp_index_s(TargetSide)-window:avN2c_ParticipantLevel_peak_amp_index_s(TargetSide)+window,trial),1));

%         %% 26. CPP half peak latency:
%         half_max_peak=max(erp(ch_CPP,find(t==0):find(t==1500),trial))/2;
% 
%         half_max_peak_index=find(erp(ch_CPP,find(t==0):find(t==1500),trial)>=half_max_peak,1,'first')+length(find(erp(t<0)));
%         if half_max_peak<0
%             master_matrix_R(total_numtr,26)=0;
%         elseif isempty(half_max_peak_index)
%                 master_matrix_R(total_numtr,26)=0;
%         else 
%         master_matrix_R(total_numtr,26)=t(half_max_peak_index);
%         end
%         
%         %% 27. N2c peak latency:
%         % NB: this is quarter the window size in samples, each sample = 2ms and
%         % it's this either side.
%         window_size = 25;
%         % contra and search frames encompass the entire negativity.
%         contra_peak_t = [150,500]; contra_peak_ts(1) = find(t==contra_peak_t(1)); contra_peak_ts(2) = find(t==contra_peak_t(2));
%         % SEARCHING FOR PEAK LATENCY
%         clear N2c_peak_latencies
%         % for each trial...
%         % search your search timeframe, defined above by contra_peak ts, in sliding windows
%         % NB this is done in samples, not time, it's later converted.
%         clear win_mean win_mean_inds
%         counter2 = 1;
%         for j = contra_peak_ts(1)+window_size:contra_peak_ts(2)-window_size
%             % get average amplitude of sliding window from N2pc electrode
%             if master_matrix_R(total_numtr,6) == 1; %if left target, measure from right hemi (ch_LR(2,:)) electrodes
%                 win_mean(counter2) = squeeze(mean(mean(erp(ch_LR(2,:),j-window_size:j+window_size,trial),1),2));
%             elseif master_matrix_R(total_numtr,6) == 2; %if right target, measure from left hemi (ch_LR(1,:)) electrodes
%                 win_mean(counter2) = squeeze(mean(mean(erp(ch_LR(1,:),j-window_size:j+window_size,trial),1),2));
%             end
%             % get the middle sample point of that window
%             win_mean_inds(counter2) = j;
%             counter2 = counter2+1;
%         end
%         % find the most negative amplitude in the resulting windows
%         [~,ind_temp] = min(win_mean);
%         % get the sample point which had that negative amplitude
%         N2pc_min_ind = win_mean_inds(ind_temp);
%         
%         % if the peak latency is at the very start or end of the search
%         % timeframe, it will probably be bogus. set to NaN.
%         if ind_temp==1 | ind_temp==length(win_mean)
%             master_matrix_R(total_numtr,27)= 0; %%DN: make it 0 instead of NaN, will remove these in R
%         else
%             % it's good! add it in.
%             master_matrix_R(total_numtr,27)=t(N2pc_min_ind);  %N2c_peak_latencies(trial)= t(N2pc_min_ind);
%         end
%        %% 28. Respose locked CPP slope: (just fitting a straight line, like in Kelly and O'Connel J.Neuro, but on trial-by-trial basis)
%         slope_timeframe = [-150,-10];
%         if validrlock(trial)
%             coef = polyfit(tr(tr>slope_timeframe(1) & tr<slope_timeframe(2)),(erpr(ch_CPP,tr>slope_timeframe(1) & tr<slope_timeframe(2),trial)),1); % coef returns 2 coefficients fitting r = slope * x + intercept
%             master_matrix_R(total_numtr,28) = coef(1); %slope
%             %                 r = coef(1) .* tr(tr>slope_timeframe(1) & tr<slope_timeframe(2)) + coef(2); %r=slope(x)+intercept, r is a vectore representing the linear curve fitted to the erpr during slope_timeframe
%             %                 figure
%             %                 plot(tr,erpr(ch_CPP,:,trial),'color','k');
%             %                 hold on;
%             %                 plot(tr(tr>slope_timeframe(1) & tr<slope_timeframe(2)), r, ':');
%             %                 line(xlim,[0,0],'Color','k');
%             %                 line([0,0],ylim,'Color','k');
%             %                 line([slope_timeframe(1),slope_timeframe(1)],ylim,'linestyle',':');
%             %                 line([slope_timeframe(2),slope_timeframe(2)],ylim,'linestyle',':');
%             %                 hold off;
%         end     
    end
end
  
% find empty cells in ID_vector
emptyCells = cellfun(@isempty,ID_vector);
% remove empty cells
ID_vector(emptyCells) = [];

%Save the data in .csv format to be read into R for inferential stats analysis
csvwrite ('master_matrix_R_BigDots.csv',master_matrix_R)
cell2csv ('ID_vector_BigDots.csv',ID_vector)
