clear
close all
clc
chanlocs = readlocs('cap64.loc');

% path_temp = 'D:\Participant Folders_new\'; %TCD Laptop
path_temp = 'S:\R-MNHS-SPP\Bellgrove-data\4. Dan Newman\Participant Folders_new\'; %Monash PC
% save_path = 'D:\Participant Folders_new\';

%% Create paths for subjects

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

%% Define TCD and Monash subjects

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

%% Load DAT1

load('DAT1genotypesforMatlab.mat')
DAT1_split=[]; DAT1_nosplit=[]; dud_temp=[];
for s = 1:length(subject_folder)
    for i = 1:size(DAT1genotypesforMatlab,1)
        if strcmp(subject_folder{s},DAT1genotypesforMatlab{i,1})
            if ~isempty(DAT1genotypesforMatlab{i,2})
                DAT1_split(s) = str2num(DAT1genotypesforMatlab{i,2});
                DAT1_nosplit(s) = max(str2num(DAT1genotypesforMatlab{i,2}),1);
            else
                DAT1_split(s) = NaN;
                DAT1_nosplit(s) = NaN;
                dud_temp = [dud_temp,s];
            end
        end
    end
    if ismember(subject_folder{s},TCD_bigdots)
        subject_location(s) = 1;
    elseif ismember(subject_folder{s},Monash_bigdots)
        subject_location(s) = 2;
    else
        keyboard
    end
end

%%
DAT1_tags = {'0/1 DAT1 10-repeats','2 DAT1 10-repeats'};
side_tags = {'Left','Right'};
%% Get rid of duds/include only particular subjects

% LK_07_04_14: coherence at 35%; 1
% AR_08_04_14 & MH_14_04_14: No ITI 3, side 2... 2,3
% 414M_LA: zscore RT index > 3; 74
% AA_15_04_14: zscore RT index > 2.5; 4

large_CPP = {'301M_MO'};
large_N2c = {'PR_20_04_14','036M_JK','226M_SM','331M_CL','061M_LG','377M_BL'};
low_alpha_trials = {'AR_08_04_14' '191M_DM' '186M_AF'};

for s2 = 1:length(subject_folder)
    for s = 1:length(TCD_bigdots)
        if strcmp(TCD_bigdots{s},subject_folder{s2})
            TCD_index(s) = s2;
        end
    end
    for s = 1:length(Monash_bigdots)
        if strcmp(Monash_bigdots{s},subject_folder{s2})
            Monash_index(s) = s2;
        end
    end
    for s = 1:length(large_CPP)
        if strcmp(large_CPP{s},subject_folder{s2})
            large_CPP_index(s) = s2;
        end
    end
    for s = 1:length(large_N2c)
        if strcmp(large_N2c{s},subject_folder{s2})
            large_N2c_index(s) = s2;
        end
    end
    for s = 1:length(low_alpha_trials)
        if strcmp(low_alpha_trials{s},subject_folder{s2})
            low_alpha_trials_index(s) = s2;
        end
    end
end
%%
duds = [low_alpha_trials_index]; % low_alpha_trials_index= 2,44,59 %4 and 74 could also be kicked out as they are RT outliers. 1 because of coherence
single_participants = [];
%%
if ~isempty(duds) && isempty(single_participants)
    subject_folder([duds]) = [];
    allsubj([duds]) = [];
    DAT1_split([duds]) = [];
    DAT1_nosplit([duds]) = [];
    subject_location([duds]) = [];
end

if ~isempty(single_participants)
    subject_folder = subject_folder(single_participants);
    allsubj = allsubj(single_participants);
    DAT1_split = DAT1_split(single_participants);
    DAT1_nosplit = DAT1_nosplit(single_participants);
    subject_location = subject_location(single_participants);
 end

%% Define channels, having combined Brain Products and Biosemi data

exclude_chans = [24 28 33 37 61];
plot_chans = [1:23,25:27,29:32,34:36,38:60,62:64];
% exclude_chans = [];
% plot_chans = [1:64];
left_hemi = [1:23,25:27];
right_hemi = [34:36,39:46,49:60,62:64];
centre_chans = [29:32,38,47,48];
elec_pairs = [1,34;2,35;3,36;4,39;5,40;6,41;7,42; ...
    8,43;9,44;10,45;11,46;12,49;13,50;14,51;15,52; ...
    16,53;17,54;18,55;19,56;20,57;21,58;22,59;23,60; ...
    25,62;26,63;27,64];

tester = zeros(64,1);
% tester(left_hemi) = 1;
figure
topoplot(tester,chanlocs,'maplimits', ...
    [min(tester)  max(tester)],'electrodes','numbers','plotchans',plot_chans);
% figure
% topoplot(tester,chanlocs,'maplimits', ...
%     [min(tester)  max(tester)],'electrodes','labels','plotchans',plot_chans);

%% Triggers

% LK has coherence 35%!!!
% for i = 1:length(conditiondescrip)
%     disp(conditiondescrip{i})
% end
% Trigger 1: coherence 50, motion dir 270, ITI 3.06, patch 1
% Trigger 2: coherence 50, motion dir 270, ITI 3.06, patch 2
% Trigger 3: coherence 50, motion dir 270, ITI 5.17, patch 1
% Trigger 4: coherence 50, motion dir 270, ITI 5.17, patch 2
% Trigger 5: coherence 50, motion dir 270, ITI 7.29, patch 1
% Trigger 6: coherence 50, motion dir 270, ITI 7.29, patch 2

% ITI,left/right
targcodes = zeros(3,2);
targcodes(1,:) = [101,102];
targcodes(2,:) = [103,104];
targcodes(3,:) = [105,106];

%% 
fs=500;
numch=64;
% rtlim=[0.700 1.800];
rtlim=[0.200 1.500];

% ch_CPP = [31,32];
ch_CPP = [31];
% ch_alpha_asym = [40];
% ch_alpha_asym = [39,40];
% ch_alpha_asym = [62];
ch_alpha_asym = [62,64];
% ch_alpha_asym = [59,60,62,63,64];
% ch_alpha_asym = [55:56];
alpha_t1 = 299;
alpha_t2 = 349;

% ch_lr = [60,62;23,25];
% ch_rl = [23,25;60,62];
% ch_lr = [60;23];
% ch_rl = [23;60];

% ch_lr{1} = [53,60];
% ch_lr{2} = [23,25];
ch_lr{1} = [60];
ch_lr{2} = [23];
ch_rl{1} = [23];
ch_rl{2} = [60];

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

% zscore threshold
z_thresh = 3;

no_of_bins = 2;
bin_counter = fliplr(1:no_of_bins);
% plotting parameters
for bin = 1:no_of_bins
    rt_bins_tags{bin} = num2str(bin);
end
% rt_bins_tags{1} = [rt_bins_tags{1},' (Fast RT)'];
% rt_bins_tags{end} = [rt_bins_tags{end},' (Slow RT)'];

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
%% Start loop
for s=1:length(allsubj)
    pause(1)
    load([path_temp subject_folder{s} '\' allsubj{s} 'big_dots_erp'],'erp_LPF_35Hz','allRT','allrespLR','allTrig','allblock_count',...
        'BL_resp_artrej','ET_BL_resp_artrej','pretarg_artrej','ET_pretarg_artrej');
    if strcmp(subject_folder{s},'331M_CL') % really odd tiny artifact meant this trial was messing with CSD!
        allRT(53) = 0; allrespLR(53) = 0; allTrig(53) = 0;
    end
    erp = double(erp_LPF_35Hz);
                
    % Baseline erp
    baseline_erp = mean(erp(:,find(t>=BL_erp(1) & t<=BL_erp(2)),:),2);
    erp = erp-repmat(baseline_erp,[1,size(erp,2),1]); % baseline full erp
        
    % Alpha Spectrotemporal Evolution a la Thut 
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
        % asymmetry: right minus left. more positive = more right hemi alph
        alpha_asym(right_hemi,:,trial) = (alpha_TSE(right_hemi,:,trial)-alpha_TSE(left_hemi,:,trial))./...
            ((alpha_TSE(right_hemi,:,trial)+alpha_TSE(left_hemi,:,trial))/2);
    end

    % Baseline alpha
    baseline_alpha = mean(alpha_TSE(:,find(alpha_t<=BL_alpha),:),2);
    alpha_TSE_base = alpha_TSE-repmat(baseline_alpha,[1,size(alpha_TSE,2),1]); % baseline full erp
    
    disp(['Subject ' num2str(s) ': ' allsubj{s} ' number of trials = ' num2str(length(find(allTrig)))])
    
    erpr = zeros(size(erp,1),length(tr),size(erp,3));    
    
    validrlock = zeros(1,length(allRT)); % length of RTs.
    for n=1:length(allRT);
        [blah,RTsamp] = min(abs(t*fs/1000-allRT(n))); % get the sample point of the RT.
        if RTsamp+trs(1) >0 & RTsamp+trs(end)<=length(t) & allRT(n)>0 % is the RT larger than 1st stim RT point, smaller than last RT point.
            erpr(:,:,n) = erp(:,RTsamp+trs,n);
            validrlock(n)=1;
        end
    end

    % AR_08_04_14 & MH_14_04_14 had no side 3, side 2
    for side = 1:2
        for iti = 1:3
            % calcs the indices of the triggers for each
            % appropriate trial type.
%             conds{s,iti,side} = find(allTrig==targcodes(iti,side) & allrespLR==1 & ...
%                 allRT>rtlim(1)*fs & allRT<rtlim(2)*fs & ET_BL_resp_artrej==1);
            conds{s,iti,side} = find(allTrig==targcodes(iti,side) & allrespLR==1 & ...
                allRT>rtlim(1)*fs & allRT<rtlim(2)*fs & BL_resp_artrej & ET_BL_resp_artrej & pretarg_artrej & ET_pretarg_artrej & validrlock);
%             conds{s,iti,side} = find(allTrig==targcodes(iti,side) & allrespLR==1 & ...
%                 allRT>rtlim(1)*fs & allRT<rtlim(2)*fs & pretarg_artrej & ET_pretarg_artrej);
            
            RTs{s,iti,side} = allRT([conds{s,iti,side}])*1000/fs;
            RTs_log{s,iti,side} = log(allRT([conds{s,iti,side}])*1000/fs);
            RT_zs{s,iti,side} = zscore([RTs_log{s,iti,side}]);
            RT_factors(s,iti,side) = mean([RTs{s,iti,side}]); % can't include AR_08_04_14 & MH_14_04_14 because of mistake
            
            hit{s,iti,side} = find(allTrig==targcodes(iti,side) & allrespLR==1 & ...
                allRT>rtlim(1)*fs & allRT<rtlim(2)*fs);
            miss{s,iti,side} = find(allTrig==targcodes(iti,side) & allrespLR==3);
            
            if (strcmp(subject_folder{s},'AR_08_04_14') | strcmp(subject_folder{s},'MH_14_04_14')) & iti==3
                conds{s,iti,side} = []; RTs{s,iti,side} = []; RTs_log{s,iti,side} = []; RT_zs{s,iti,side} = []; 
                hit{s,iti,side} = []; miss{s,iti,side} = []; RT_factors(s,iti,side) = NaN;
            end
        end
        RT_all(s,side) = mean([RTs{s,:,side}]);
        temp = [RTs{s,:,side}]; tempz = [RT_zs{s,:,side}];
        temp = temp(find(tempz<z_thresh));
        RT_all_zs(s,side) = mean(temp);
        RT_median_all(s,side) = median([RTs{s,:,side}]);
        RT_log_all(s,side) = mean([RTs_log{s,:,side}]);
        
        hit_all(s,side) = length([hit{s,:,side}]);
        miss_all(s,side) = length([miss{s,:,side}]);        
        hit_rate(s,side) = 100*hit_all(s,side)/(miss_all(s,side)+hit_all(s,side));
    end
    RT_index(s) = (RT_all(s,1)-RT_all(s,2))/((RT_all(s,1)+RT_all(s,2))/2);
%     RT_index(s) = (RT_all_zs(s,1)-RT_all_zs(s,2))/((RT_all_zs(s,1)+RT_all_zs(s,2))/2);
    for iti = 1:3, RT_iti_index(s,iti) = (RT_factors(s,iti,1)-RT_factors(s,iti,2))/((RT_factors(s,iti,1)+RT_factors(s,iti,2))/2); end
    RT_median_index(s) = (RT_median_all(s,1)-RT_median_all(s,2))/((RT_median_all(s,1)+RT_median_all(s,2))/2);
    RT_log_index(s) = (RT_log_all(s,1)-RT_log_all(s,2))/((RT_log_all(s,1)+RT_log_all(s,2))/2);
    RT_index_zs(s) = (RT_all_zs(s,1)-RT_all_zs(s,2))/((RT_all_zs(s,1)+RT_all_zs(s,2))/2);        
    
    disp(['Subject ',allsubj{s},' Total Valid Trials: ',num2str(length([conds{s,:,:}])), ...
        ' = ',num2str(round(100*(length([conds{s,:,:}]))/(16*18))),'%'])
    
    clear alpha_asym_bins RT_bins RT_bins_all
    for side = 1:2
        counters = ones(1,no_of_bins);
        
        ERP_side(s,:,:,side) = squeeze(mean(erp(1:numch,:,[conds{s,:,side}]),3));
        ERPr_side(s,:,:,side) = squeeze(mean(erpr(1:numch,:,[conds{s,:,side}]),3));
        CPP_side(s,:,side) = squeeze(mean(mean(erp(ch_CPP,:,[conds{s,:,side}]),1),3));
        CPPr_side(s,:,side) = squeeze(mean(mean(erpr(ch_CPP,:,[conds{s,:,side}]),1),3));
        N2c_side(s,:,side) = squeeze(mean(mean(erp(ch_lr{side},:,[conds{s,:,side}]),1),3));
        N2i_side(s,:,side) = squeeze(mean(mean(erp(ch_rl{side},:,[conds{s,:,side}]),1),3));
        
        alpha_side(s,:,:,side) = squeeze(mean(alpha_TSE(1:numch,:,[conds{s,:,side}]),3));
        alpha_base_side(s,:,:,side) = squeeze(mean(alpha_TSE_base(1:numch,:,[conds{s,:,side}]),3));
        alpha_asym_side(s,:,:,side) = squeeze(mean(alpha_asym(1:numch,:,[conds{s,:,side}]),3));
        alpha_asym_avg_side(s,right_hemi,:,side) = (alpha_side(s,right_hemi,:,side)-alpha_side(s,left_hemi,:,side))./...
            ((alpha_side(s,right_hemi,:,side)+alpha_side(s,left_hemi,:,side))/2);
            
        for iti = 1:3
            RT_temp = RTs{s,iti,side};
            alpha_asym_temp = squeeze(mean(mean(alpha_asym(ch_alpha_asym,find(alpha_t>=alpha_t1 & alpha_t<=alpha_t2),[conds{s,iti,side}]),1),2));
            alpha_temp = squeeze(mean(mean(alpha_TSE(ch_alpha_asym,find(alpha_t>=alpha_t1 & alpha_t<=alpha_t2),[conds{s,iti,side}]),1),2));
            
%             [alpha_asym_temp,indx] = sort(alpha_asym_temp);
            [alpha_temp,indx] = sort(alpha_temp);
            
            RT_temp = RT_temp(indx);
            
            group_size = floor(length(RT_temp)/no_of_bins);

            for bin = 1:no_of_bins
                alpha_asym_bins{bin,side}(counters(bin):counters(bin)+group_size-1) = ...
                    alpha_asym_temp(end-bin_counter(bin)*group_size+1:end-(bin_counter(bin)-1)*group_size);
                RT_bins{bin,side}(counters(bin):counters(bin)+group_size-1) = ...
                    RT_temp(end-bin_counter(bin)*group_size+1:end-(bin_counter(bin)-1)*group_size);
                counters(bin)=counters(bin)+group_size;
            end
        end
        for chan = 1:numch
            for tt = 1:length(alpha_t)
                counters_all = ones(1,no_of_bins);
                for iti = 1:3
                    RT_temp = RTs{s,iti,side};
                    alpha_asym_temp = squeeze(mean(mean(alpha_asym(chan,tt,[conds{s,iti,side}]),1),2));
                    alpha_temp = squeeze(mean(mean(alpha_TSE(chan,tt,[conds{s,iti,side}]),1),2));
                    
%                     [alpha_asym_temp,indx] = sort(alpha_asym_temp);
                    [alpha_temp,indx] = sort(alpha_temp);
                    
                    RT_temp = RT_temp(indx);
                    
                    group_size = floor(length(RT_temp)/no_of_bins);
                    
                    for bin = 1:no_of_bins
                        RT_bins_all{chan,tt,bin,side}(counters_all(bin):counters_all(bin)+group_size-1) = ...
                            RT_temp(end-bin_counter(bin)*group_size+1:end-(bin_counter(bin)-1)*group_size);
                        counters_all(bin)=counters_all(bin)+group_size;
                    end
                end
            end
        end
    end
    for bin = 1:no_of_bins
        disp(['Subject ',allsubj{s},' Bin ',num2str(bin),' = ',num2str(size([alpha_asym_bins{bin,:}],2))])
        alpha_asym_bins_mean(s,bin) = squeeze(mean([alpha_asym_bins{bin,:}]));
        RT_bins_mean(s,bin) = squeeze(mean([RT_bins{bin,:}]));
        RT_asym_bins_mean(s,bin) = (squeeze(mean([RT_bins{bin,1}]))-squeeze(mean([RT_bins{bin,2}])))/...
            ((squeeze(mean([RT_bins{bin,1}]))+squeeze(mean([RT_bins{bin,2}])))/2);
        
        for chan = 1:numch
            for tt = 1:length(alpha_t)
                RT_bins_mean_all(s,chan,tt,bin) = squeeze(mean([RT_bins_all{chan,tt,bin,:}]));
                RT_asym_bins_mean_all(s,chan,tt,bin) = (squeeze(mean([RT_bins_all{chan,tt,bin,1}]))-squeeze(mean([RT_bins_all{chan,tt,bin,2}])))/...
                    ((squeeze(mean([RT_bins_all{chan,tt,bin,1}]))+squeeze(mean([RT_bins_all{chan,tt,bin,2}])))/2);
            end
        end                
    end
end

%% Quick check of RT index
[~,p,~,stats] = ttest(RT_index);
disp(['RT index to zero: t = ' num2str(stats.tstat) ', p = ' num2str(p)])
[~,p,~,stats] = ttest2(RT_index(find(DAT1_nosplit==1)),RT_index(find(DAT1_nosplit==2)));
disp(['RT index x DAT1: t = ' num2str(stats.tstat) ', p = ' num2str(p)])

figure
plot(zscore(RT_index))

%% Inside subjects relationship with behaviour.
% alpha: regular
% RT: regular
% close all
% SEM = std(RT_asym_bins_mean(:,:),[],1)/sqrt(length(allsubj));
% figure
% h = errorbar(mean(RT_asym_bins_mean,1),SEM);
% h.LineWidth = 2;
% 
% stat_temp = col_convert_long(RT_asym_bins_mean);

% ANOVA
bins_names={}; table_names={};
for bin = 1:no_of_bins
    bins_names{bin} = ['Y',num2str(bin)];
    table_names{bin,1} = ['Bin ',num2str(bin)];
end
if no_of_bins==2
    tab = table(RT_bins_mean(:,1),RT_bins_mean(:,2),'VariableNames',bins_names);
elseif no_of_bins==3
    tab = table(RT_bins_mean(:,1),RT_bins_mean(:,2),RT_bins_mean(:,3),'VariableNames',bins_names);
elseif no_of_bins==4
    tab = table(RT_bins_mean(:,1),RT_bins_mean(:,2),RT_bins_mean(:,3),RT_bins_mean(:,4),'VariableNames',bins_names);
elseif no_of_bins==5
    tab = table(RT_bins_mean(:,1),RT_bins_mean(:,2),RT_bins_mean(:,3),RT_bins_mean(:,4),RT_bins_mean(:,5),'VariableNames',bins_names);
end
within = table(table_names,'VariableNames',{'Alpha'});
rm = fitrm(tab,[bins_names{1},'-',bins_names{end},'~1'],'WithinDesign',within); % ,'Y1-Y3~1'
ranovatbl = ranova(rm);
disp(['Stim-locked alpha bins: F = ',num2str(ranovatbl{1,4}),', p = ',num2str(ranovatbl{1,5})])

% (s,chan,tt,bin)
stat_values=[];
for chan = plot_chans
    for tt = 1:length(alpha_t)
        if no_of_bins==2
            tab = table(squeeze(RT_bins_mean_all(:,chan,tt,1)),squeeze(RT_bins_mean_all(:,chan,tt,2)),...
                'VariableNames',bins_names);
        elseif no_of_bins==3
            tab = table(squeeze(RT_bins_mean_all(:,chan,tt,1)),squeeze(RT_bins_mean_all(:,chan,tt,2)),...
                squeeze(RT_bins_mean_all(:,chan,tt,3)),'VariableNames',bins_names);
        elseif no_of_bins==4
            tab = table(squeeze(RT_bins_mean_all(:,chan,tt,1)),squeeze(RT_bins_mean_all(:,chan,tt,2)),...
                squeeze(RT_bins_mean_all(:,chan,tt,3)),squeeze(RT_bins_mean_all(:,chan,tt,4)),'VariableNames',bins_names);
        elseif no_of_bins==5
            tab = table(squeeze(RT_bins_mean_all(:,chan,tt,1)),squeeze(RT_bins_mean_all(:,chan,tt,2)),...
                squeeze(RT_bins_mean_all(:,chan,tt,3)),squeeze(RT_bins_mean_all(:,chan,tt,4)),...
                squeeze(RT_bins_mean_all(:,chan,tt,5)),'VariableNames',bins_names);
        end
        within = table(table_names,'VariableNames',{'Alpha'});
        rm = fitrm(tab,[bins_names{1},'-',bins_names{end},'~1'],'WithinDesign',within); % ,'Y1-Y3~1'
        ranovatbl = ranova(rm);
        stat_values(chan,tt,1) = ranovatbl{1,4};
        stat_values(chan,tt,2) = ranovatbl{1,5};
    end
end

% SEM = std(squeeze(mean(mean(RT_bins_mean_all(:,[57],find(alpha_t>=499 & alpha_t<=549),:),3),2)),[],1)/sqrt(length(allsubj));
% figure
% h = errorbar(squeeze(mean(mean(mean(RT_bins_mean_all(:,[57],find(alpha_t>=499 & alpha_t<=549),:),3),2),1)),SEM);
% h.LineWidth = 2;

figure
plottopo(stat_values(:,:,1),'chanlocs',chanlocs,'limits',[alpha_t(1) alpha_t(end) ...
    min(min(min(stat_values(plot_chans,:,1))))  max(max(max(stat_values(plot_chans,:,1))))], ...
    'title',['Alpha vs RT asym F-values'],'legend',side_tags,'showleg','off','ydir',1)
figure
plottopo(stat_values(:,:,2),'chanlocs',chanlocs,'limits',[alpha_t(1) alpha_t(end) ...
    0  0.05], ...
    'title',['Alpha vs RT asym p-values'],'legend',side_tags,'showleg','off','ydir',1)

% stat_values(left_hemi,:,:) = repmat(mean(stat_values,1),[length(left_hemi),1,1]);
% stat_values(centre_chans,:,:) = repmat(mean(stat_values,1),[length(centre_chans),1,1]);

figure
cc=0;
for tt = 1:length(alpha_t)
    if cc<9, cc=cc+1; else figure, cc=1; end
    subplot(3,3,cc)
    plot_mean = squeeze(mean(stat_values(:,tt,1),2));
    topoplot(plot_mean,chanlocs,'maplimits', ...
        [min(min(stat_values(:,:,1)))...
        max(max(stat_values(:,:,1)))], ...
        'electrodes','off','plotchans',plot_chans);
    title(['Alpha F-values: ',num2str(alpha_t(tt)),' ms']);
    colorbar
end

figure
cc=0;
for tt = 1:length(alpha_t)
    if cc<9, cc=cc+1; else figure, cc=1; end
    subplot(3,3,cc)
    plot_mean = squeeze(mean(stat_values(:,tt,2),2));
    topoplot(plot_mean,chanlocs,'maplimits', ...
        [0 0.05], ...
        'electrodes','off','plotchans',plot_chans);
    title(['Alpha p-values: ',num2str(alpha_t(tt)),' ms']);
    colorbar
end

  return
%% Inside subjects relationship with behaviour.
% alpha: right minus left, more negative means greater left hemi alpha
% RT: left minus right, more negative means faster leftward RT
% regular correlation would be positive correlation.
% close all
SEM = std(RT_asym_bins_mean(:,:),[],1)/sqrt(length(allsubj));
figure
h = errorbar(mean(RT_asym_bins_mean,1),SEM);
h.LineWidth = 2;

% stat_temp = col_convert_long(RT_asym_bins_mean);

% ANOVA
bins_names={}; table_names={};
for bin = 1:no_of_bins
    bins_names{bin} = ['Y',num2str(bin)];
    table_names{bin,1} = ['Bin ',num2str(bin)];
end
if no_of_bins==2
    tab = table(RT_asym_bins_mean(:,1),RT_asym_bins_mean(:,2),'VariableNames',bins_names);
elseif no_of_bins==3
    tab = table(RT_asym_bins_mean(:,1),RT_asym_bins_mean(:,2),RT_asym_bins_mean(:,3),'VariableNames',bins_names);
elseif no_of_bins==4
    tab = table(RT_asym_bins_mean(:,1),RT_asym_bins_mean(:,2),RT_asym_bins_mean(:,3),RT_asym_bins_mean(:,4),'VariableNames',bins_names);
elseif no_of_bins==5
    tab = table(RT_asym_bins_mean(:,1),RT_asym_bins_mean(:,2),RT_asym_bins_mean(:,3),RT_asym_bins_mean(:,4),RT_asym_bins_mean(:,5),'VariableNames',bins_names);
end
within = table(table_names,'VariableNames',{'Alpha'});
rm = fitrm(tab,[bins_names{1},'-',bins_names{end},'~1'],'WithinDesign',within); % ,'Y1-Y3~1'
ranovatbl = ranova(rm);
disp(['Stim-locked alpha asym bins: F = ',num2str(ranovatbl{1,4}),', p = ',num2str(ranovatbl{1,5})])

% (s,chan,tt,bin)
stat_values=[];
for chan = right_hemi
    for tt = 1:length(alpha_t)
        if no_of_bins==2
            tab = table(squeeze(RT_asym_bins_mean_all(:,chan,tt,1)),squeeze(RT_asym_bins_mean_all(:,chan,tt,2)),...
                'VariableNames',bins_names);
        elseif no_of_bins==3
            tab = table(squeeze(RT_asym_bins_mean_all(:,chan,tt,1)),squeeze(RT_asym_bins_mean_all(:,chan,tt,2)),...
                squeeze(RT_asym_bins_mean_all(:,chan,tt,3)),'VariableNames',bins_names);
        elseif no_of_bins==4
            tab = table(squeeze(RT_asym_bins_mean_all(:,chan,tt,1)),squeeze(RT_asym_bins_mean_all(:,chan,tt,2)),...
                squeeze(RT_asym_bins_mean_all(:,chan,tt,3)),squeeze(RT_asym_bins_mean_all(:,chan,tt,4)),'VariableNames',bins_names);
        elseif no_of_bins==5
            tab = table(squeeze(RT_asym_bins_mean_all(:,chan,tt,1)),squeeze(RT_asym_bins_mean_all(:,chan,tt,2)),...
                squeeze(RT_asym_bins_mean_all(:,chan,tt,3)),squeeze(RT_asym_bins_mean_all(:,chan,tt,4)),...
                squeeze(RT_asym_bins_mean_all(:,chan,tt,5)),'VariableNames',bins_names);
        end
        within = table(table_names,'VariableNames',{'Alpha'});
        rm = fitrm(tab,[bins_names{1},'-',bins_names{end},'~1'],'WithinDesign',within); % ,'Y1-Y3~1'
        ranovatbl = ranova(rm);
        stat_values(chan,tt,1) = ranovatbl{1,4};
        stat_values(chan,tt,2) = ranovatbl{1,5};
    end
end

SEM = std(squeeze(mean(mean(RT_asym_bins_mean_all(:,[57],find(alpha_t>=499 & alpha_t<=549),:),3),2)),[],1)/sqrt(length(allsubj));
figure
h = errorbar(squeeze(mean(mean(mean(RT_asym_bins_mean_all(:,[57],find(alpha_t>=499 & alpha_t<=549),:),3),2),1)),SEM);
h.LineWidth = 2;

figure
plottopo(stat_values(:,:,1),'chanlocs',chanlocs,'limits',[alpha_t(1) alpha_t(end) ...
    min(min(min(stat_values(plot_chans,:,1))))  max(max(max(stat_values(plot_chans,:,1))))], ...
    'title',['Alpha asym vs RT asym F-values'],'legend',side_tags,'showleg','off','ydir',1)
figure
plottopo(stat_values(:,:,2),'chanlocs',chanlocs,'limits',[alpha_t(1) alpha_t(end) ...
    0  0.05], ...
    'title',['Alpha asym vs RT asym p-values'],'legend',side_tags,'showleg','off','ydir',1)

stat_values(left_hemi,:,:) = repmat(mean(stat_values,1),[length(left_hemi),1,1]);
stat_values(centre_chans,:,:) = repmat(mean(stat_values,1),[length(centre_chans),1,1]);

figure
cc=0;
for tt = 1:length(alpha_t)
    if cc<9, cc=cc+1; else figure, cc=1; end
    subplot(3,3,cc)
    plot_mean = squeeze(mean(stat_values(:,tt,1),2));
    topoplot(plot_mean,chanlocs,'maplimits', ...
        [min(min(stat_values(:,:,1)))...
        max(max(stat_values(:,:,1)))], ...
        'electrodes','off','plotchans',plot_chans);
    title(['Alpha asym F-values: ',num2str(alpha_t(tt)),' ms']);
    colorbar
end

figure
cc=0;
for tt = 1:length(alpha_t)
    if cc<9, cc=cc+1; else figure, cc=1; end
    subplot(3,3,cc)
    plot_mean = squeeze(mean(stat_values(:,tt,2),2));
    topoplot(plot_mean,chanlocs,'maplimits', ...
        [0 0.05], ...
        'electrodes','off','plotchans',plot_chans);
    title(['Alpha asym p-values: ',num2str(alpha_t(tt)),' ms']);
    colorbar
end

 return
%% Alpha check

% %{
alpha_group_side = squeeze(mean(alpha_side(:,:,:,:),1)); % chan x time x side
figure
plottopo(alpha_group_side(:,:,:),'chanlocs',chanlocs,'limits',[alpha_t(1) alpha_t(end) ...
    min(min(min(alpha_group_side(plot_chans,:,:))))  max(max(max(alpha_group_side(plot_chans,:,:))))], ...
    'title',['Alpha left vs right targets'],'legend',side_tags,'showleg','on','ydir',1)

t1 = -500; t2 = -50;
figure
plot_mean = squeeze(mean(mean(alpha_group_side(:,find(alpha_t>=t1 & alpha_t<=t2),:),2),3));
topoplot(plot_mean,chanlocs,'maplimits', ...
    [min(plot_mean) max(plot_mean)], ...
    'electrodes','off','plotchans',plot_chans);
% topoplot(plot_mean,chanlocs,'maplimits', ...
%     [-max(abs(plot_mean)) max(abs(plot_mean))], ...
%     'electrodes','off','plotchans',plot_chans);
% topoplot(plot_mean,chanlocs,'maplimits',[-4 4], ...
%     'electrodes','off','plotchans',plot_chans);
colorbar('FontSize',12)
title(['Pretarget Alpha -500ms to 0ms'],'FontSize',12);

alpha_base_group_side = squeeze(mean(alpha_base_side(:,:,:,:),1)); % chan x time x side
figure
plottopo(alpha_base_group_side(:,:,:),'chanlocs',chanlocs,'limits',[alpha_t(1) alpha_t(end) ...
    min(min(min(alpha_base_group_side(plot_chans,:,:))))  max(max(max(alpha_base_group_side(plot_chans,:,:))))], ...
    'title',['Alpha (BL corrected) left vs right targets'],'legend',side_tags,'showleg','on','ydir',1)

clear time_windows
time_windows(1,:) = [0:100:800];
time_windows(2,:) = time_windows(1,:)+100;
for side = 1:2    
    figure
    for tt = 1:size(time_windows,2)
        plot_mean = squeeze(mean(alpha_base_group_side(:,find(alpha_t>=time_windows(1,tt) & alpha_t<=time_windows(2,tt)),side),2));
        subplot(3,3,tt)
        topoplot(plot_mean,chanlocs,'maplimits', ...
            [min(min(min(alpha_base_group_side(:,find(alpha_t>time_windows(1,1) & alpha_t<time_windows(2,end)),:))))...
            max(max(max(alpha_base_group_side(:,find(alpha_t>time_windows(1,1) & alpha_t<time_windows(2,end)),:))))], ...
            'electrodes','off','plotchans',plot_chans);
        title([side_tags{side},' targ alpha: ',num2str(time_windows(1,tt)),' ms to ',num2str(time_windows(2,tt)),' ms']);
        colorbar
    end
end

t1 = 50; t2 = 500;
figure
for side = 1:2
    plot_mean = squeeze(mean(alpha_base_group_side(:,find(alpha_t>=t1 & alpha_t<=t2),side),2));
    subplot(1,2,side)
    topoplot(plot_mean,chanlocs,'maplimits', ...
        [min(squeeze(mean(mean(alpha_base_group_side(:,find(alpha_t>=t1 & alpha_t<=t2),:),3),2))) ...
        max(squeeze(mean(mean(alpha_base_group_side(:,find(alpha_t>=t1 & alpha_t<=t2),:),3),2)))], ...
        'electrodes','off','plotchans',plot_chans);    
    colorbar('FontSize',12)
    title(['PostTarget Alpha -500ms to 0ms: ' side_tags{side} ' Targets'],'FontSize',12);
end

% alpha_asym_group_side = squeeze(mean(alpha_asym_side(:,:,:,:),1)); % chan x time x side 
alpha_asym_group_side = squeeze(mean(alpha_asym_avg_side(:,:,:,:),1));
figure
plottopo(alpha_asym_group_side(:,:,:),'chanlocs',chanlocs,'limits',[alpha_t(1) alpha_t(end) ...
    min(min(min(alpha_asym_group_side(plot_chans,:,:))))  max(max(max(alpha_asym_group_side(plot_chans,:,:))))], ...
    'title',['Alpha asymmetry left vs right targets'],'legend',side_tags,'showleg','on','ydir',1)

clear time_windows
time_windows(1,:) = [0:100:800];
time_windows(2,:) = time_windows(1,:)+100;
for side = 1:2    
    figure
    for tt = 1:size(time_windows,2)
        plot_mean = squeeze(mean(alpha_asym_group_side(:,find(alpha_t>=time_windows(1,tt) & alpha_t<=time_windows(2,tt)),side),2));
        subplot(3,3,tt)
        topoplot(plot_mean,chanlocs,'maplimits', ...
            [min(min(min(alpha_asym_group_side(:,find(alpha_t>time_windows(1,1) & alpha_t<time_windows(2,end))))))...
            max(max(max(alpha_asym_group_side(:,find(alpha_t>time_windows(1,1) & alpha_t<time_windows(2,end))))))], ...
            'electrodes','off','plotchans',plot_chans);
        title([side_tags{side},' targ alpha asym: ',num2str(time_windows(1,tt)),' ms to ',num2str(time_windows(2,tt)),' ms']);
        colorbar
    end
end

t1 = -500; t2 = -50;
figure
plot_mean = squeeze(mean(mean(alpha_asym_group_side(:,find(alpha_t>=t1 & alpha_t<=t2),:),2),3));
topoplot(plot_mean,chanlocs,'maplimits', ...
    [min(squeeze(mean(mean(alpha_asym_group_side(:,find(alpha_t>=t1 & alpha_t<=t2),:),3),2))) ...
    max(squeeze(mean(mean(alpha_asym_group_side(:,find(alpha_t>=t1 & alpha_t<=t2),:),3),2)))], ...
    'electrodes','off','plotchans',plot_chans);
colorbar('FontSize',12)
title(['PostTarget Alpha asymmetry -500ms to 0ms'],'FontSize',12);

%}
%% Correlations between alpha and behaviour
% alpha: right minus left, more negative means greater left hemi alpha
% RT: left minus right, more negative means faster leftward RT
% regular correlation would be positive correlation.

% ch_alpha_asym = [53:60,62:64];
% ch_alpha_asym = [54,55,59];
ch_alpha_asym = [54:59];
% ch_alpha_asym = [44];

% close all
t1 = -301; t2 = -51; z_thresh = 2.5;
% t1 = 899; t2 = 1299; z_thresh = 2.5; 
alpha_asym_pretarg = squeeze(mean(mean(mean(alpha_asym_side(:,ch_alpha_asym,find(alpha_t>=t1 & alpha_t<=t2),:),2),3),4))';
% alpha_asym_pretarg = squeeze(mean(mean(mean(alpha_asym_avg_side(:,ch_alpha_asym,find(alpha_t>=t1 & alpha_t<=t2),:),2),3),4))';
alpha_zscores = zscore(alpha_asym_pretarg);
RT_zscores = zscore(RT_index);
indx = find(abs(alpha_zscores)<z_thresh & abs(RT_zscores)<z_thresh);

[R,P] = corrcoef(alpha_asym_pretarg(indx),RT_index(indx)); % 50 and 54 have large zscores
disp(['Alpha asymmetry vs RT index: R = ' num2str(R(1,2)) ', p = ' num2str(P(1,2))])
figure
scatter(alpha_asym_pretarg(indx),RT_index(indx)), hold on
lsline

alpha_corr_topo=[];
for chan = right_hemi 
    alpha_asym_pretarg = squeeze(mean(mean(mean(alpha_asym_side(:,chan,find(alpha_t>=t1 & alpha_t<=t2),:),2),3),4))';
%     alpha_asym_pretarg = squeeze(mean(mean(mean(alpha_asym_avg_side(:,chan,find(alpha_t>=t1 & alpha_t<=t2),:),2),3),4))';
    alpha_zscores = zscore(alpha_asym_pretarg);
    RT_zscores = zscore(RT_index);
    indx = find(abs(alpha_zscores)<z_thresh & abs(RT_zscores)<z_thresh);
    [R,P] = corrcoef(alpha_asym_pretarg(indx),RT_index(indx));
    alpha_corr_topo(chan,1) = R(1,2);
    alpha_corr_topo(chan,2) = P(1,2);
    for tt = 1:length(alpha_t)
        alpha_asym_pretarg = squeeze(mean(mean(mean(alpha_asym_side(:,chan,tt,:),2),3),4))';
%         alpha_asym_pretarg = squeeze(mean(mean(mean(alpha_asym_avg_side(:,chan,tt,:),2),3),4))';
        alpha_zscores = zscore(alpha_asym_pretarg);
        RT_zscores = zscore(RT_index);
        indx = find(abs(alpha_zscores)<z_thresh & abs(RT_zscores)<z_thresh);
        [R,P] = corrcoef(alpha_asym_pretarg(indx),RT_index(indx));
        alpha_corr_topo_tt(chan,tt,1) = R(1,2);
        alpha_corr_topo_tt(chan,tt,2) = P(1,2);
        
        RT_index2 = RT_index(indx); alpha_asym_pretarg2 = alpha_asym_pretarg(indx); DAT1_nosplit2 = DAT1_nosplit(indx);
        [~,p,~,stats] = ttest2(alpha_asym_pretarg2(find(DAT1_nosplit2==1)),alpha_asym_pretarg2(find(DAT1_nosplit2==2)));
        alpha_DAT1_topo_tt(chan,tt,1) = stats.tstat;
        alpha_DAT1_topo_tt(chan,tt,2) = p;
    end
end
alpha_corr_topo(left_hemi,:) = repmat(mean(alpha_corr_topo,1),[length(left_hemi),1]);
alpha_corr_topo(centre_chans,:) = repmat(mean(alpha_corr_topo,1),[length(centre_chans),1]);
alpha_corr_topo_tt(left_hemi,:,:) = repmat(mean(alpha_corr_topo_tt,1),[length(left_hemi),1,1]);
alpha_corr_topo_tt(centre_chans,:,:) = repmat(mean(alpha_corr_topo_tt,1),[length(centre_chans),1,1]);
alpha_DAT1_topo_tt(left_hemi,:,:) = repmat(mean(alpha_DAT1_topo_tt,1),[length(left_hemi),1,1]);
alpha_DAT1_topo_tt(centre_chans,:,:) = repmat(mean(alpha_DAT1_topo_tt,1),[length(centre_chans),1,1]);

figure
subplot(1,2,1)
plot_mean = alpha_corr_topo(:,1);
topoplot(plot_mean,chanlocs,'maplimits', ...
    [min(plot_mean) max(plot_mean)], ...
    'electrodes','numbers','plotchans',plot_chans,'intsquare','off');
colorbar('FontSize',12)
subplot(1,2,2)
plot_mean = alpha_corr_topo(:,2);
topoplot(plot_mean,chanlocs,'maplimits', ...
    [0 0.05], ...
    'electrodes','numbers','plotchans',plot_chans);
colorbar('FontSize',12)

figure
cc=0;
for tt = 1:length(alpha_t)
    if cc<9, cc=cc+1; else figure, cc=1; end
    subplot(3,3,cc)
    plot_mean = squeeze(mean(alpha_corr_topo_tt(:,tt,1),2));
    topoplot(plot_mean,chanlocs,'maplimits', ...
        [min(min(alpha_corr_topo_tt(:,:,1)))...
        max(max(alpha_corr_topo_tt(:,:,1)))], ...
        'electrodes','off','plotchans',plot_chans);
    title(['Alpha asym corr: ',num2str(alpha_t(tt)),' ms']);
    colorbar
end

figure
cc=0;
for tt = 1:length(alpha_t)
    if cc<9, cc=cc+1; else figure, cc=1; end
    subplot(3,3,cc)
    plot_mean = squeeze(mean(alpha_DAT1_topo_tt(:,tt,1),2));
    topoplot(plot_mean,chanlocs,'maplimits', ...
        [min(min(alpha_DAT1_topo_tt(:,:,1)))...
        max(max(alpha_DAT1_topo_tt(:,:,1)))], ...
        'electrodes','off','plotchans',plot_chans);
    title(['Alpha asym DAT1: ',num2str(alpha_t(tt)),' ms']);
    colorbar
end


%% Alpha asymmetry vs RT by side
% alpha: right minus left, more negative means greater left hemi alpha
% RT: more negative means faster RT
% RT_all(s,side)

% ch_alpha_asym = [49,50,55,56];
% ch_alpha_asym = [53:60,62:64];
ch_alpha_asym = [54,55,59];
% ch_alpha_asym = [54:59];
% ch_alpha_asym = [44];

% close all
t1 = -301; t2 = -51; z_thresh = 2.5;
% t1 = 899; t2 = 1299; z_thresh = 2.5; 
alpha_asym_pretarg = squeeze(mean(mean(mean(alpha_asym_side(:,ch_alpha_asym,find(alpha_t>=t1 & alpha_t<=t2),:),2),3),4))';
% alpha_asym_pretarg = squeeze(mean(mean(mean(alpha_asym_avg_side(:,ch_alpha_asym,find(alpha_t>=t1 & alpha_t<=t2),:),2),3),4))';
alpha_zscores = zscore(alpha_asym_pretarg);
RT_zscores = zscore(RT_all,[],1);
indx = find(abs(alpha_zscores)<z_thresh);% & abs(RT_zscores)<z_thresh);

for side = 1:2
    [R,P] = corrcoef(alpha_asym_pretarg(indx),RT_all(indx,side));
    disp(['Alpha asymmetry vs ' side_tags{side} ' RT: R = ' num2str(R(1,2)) ', p = ' num2str(P(1,2))])
    figure
    scatter(alpha_asym_pretarg(indx),RT_all(indx,side)), hold on
    lsline
end

for side = 1:2
    alpha_corr_topo=[];
    for chan = right_hemi
        alpha_asym_pretarg = squeeze(mean(mean(mean(alpha_asym_side(:,chan,find(alpha_t>=t1 & alpha_t<=t2),side),2),3),4))';
        %     alpha_asym_pretarg = squeeze(mean(mean(mean(alpha_asym_avg_side(:,chan,find(alpha_t>=t1 & alpha_t<=t2),:),2),3),4))';
        alpha_zscores = zscore(alpha_asym_pretarg);
%         RT_zscores = zscore(RT_index);
        indx = find(abs(alpha_zscores)<z_thresh);% & abs(RT_zscores)<z_thresh);
        [R,P] = corrcoef(alpha_asym_pretarg(indx),RT_all(indx,side));
        alpha_corr_topo(chan,1) = R(1,2);
        alpha_corr_topo(chan,2) = P(1,2);
        for tt = 1:length(alpha_t)
            alpha_asym_pretarg = squeeze(mean(mean(mean(alpha_asym_side(:,chan,tt,side),2),3),4))';
            %         alpha_asym_pretarg = squeeze(mean(mean(mean(alpha_asym_avg_side(:,chan,tt,:),2),3),4))';
            alpha_zscores = zscore(alpha_asym_pretarg);
%             RT_zscores = zscore(RT_index);
            indx = find(abs(alpha_zscores)<z_thresh);% & abs(RT_zscores)<z_thresh);
            [R,P] = corrcoef(alpha_asym_pretarg(indx),RT_all(indx,side));
            alpha_corr_topo_tt(chan,tt,1) = R(1,2);
            alpha_corr_topo_tt(chan,tt,2) = P(1,2);
            
%             RT_index2 = RT_index(indx); alpha_asym_pretarg2 = alpha_asym_pretarg(indx); DAT1_nosplit2 = DAT1_nosplit(indx);
%             [~,p,~,stats] = ttest2(alpha_asym_pretarg2(find(DAT1_nosplit2==1)),alpha_asym_pretarg2(find(DAT1_nosplit2==2)));
%             alpha_DAT1_topo_tt(chan,tt,1) = stats.tstat;
%             alpha_DAT1_topo_tt(chan,tt,2) = p;
        end
    end
    alpha_corr_topo(left_hemi,:) = repmat(mean(alpha_corr_topo,1),[length(left_hemi),1]);
    alpha_corr_topo(centre_chans,:) = repmat(mean(alpha_corr_topo,1),[length(centre_chans),1]);
    alpha_corr_topo_tt(left_hemi,:,:) = repmat(mean(alpha_corr_topo_tt,1),[length(left_hemi),1,1]);
    alpha_corr_topo_tt(centre_chans,:,:) = repmat(mean(alpha_corr_topo_tt,1),[length(centre_chans),1,1]);
%     alpha_DAT1_topo_tt(left_hemi,:,:) = repmat(mean(alpha_DAT1_topo_tt,1),[length(left_hemi),1,1]);
%     alpha_DAT1_topo_tt(centre_chans,:,:) = repmat(mean(alpha_DAT1_topo_tt,1),[length(centre_chans),1,1]);
%     
    figure
    subplot(1,2,1)
    plot_mean = alpha_corr_topo(:,1);
    topoplot(plot_mean,chanlocs,'maplimits', ...
        [min(plot_mean) max(plot_mean)], ...
        'electrodes','numbers','plotchans',plot_chans,'intsquare','off');
    colorbar('FontSize',12)
    subplot(1,2,2)
    plot_mean = alpha_corr_topo(:,2);
    topoplot(plot_mean,chanlocs,'maplimits', ...
        [0 0.05], ...
        'electrodes','off','plotchans',plot_chans);
    colorbar('FontSize',12)
end

for side = 1:2
    alpha_corr_topo=[];
    for chan = plot_chans
        alpha_pretarg = squeeze(mean(mean(mean(alpha_side(:,chan,find(alpha_t>=t1 & alpha_t<=t2),side),2),3),4))';
        alpha_zscores = zscore(alpha_pretarg);
%         RT_zscores = zscore(RT_index);
        indx = find(abs(alpha_zscores)<z_thresh);% & abs(RT_zscores)<z_thresh);
        [R,P] = corrcoef(alpha_pretarg(indx),RT_all(indx,side));
        alpha_corr_topo(chan,1) = R(1,2);
        alpha_corr_topo(chan,2) = P(1,2);
        for tt = 1:length(alpha_t)
            alpha_pretarg = squeeze(mean(mean(mean(alpha_side(:,chan,tt,side),2),3),4))';
            alpha_zscores = zscore(alpha_pretarg);
%             RT_zscores = zscore(RT_index);
            indx = find(abs(alpha_zscores)<z_thresh);% & abs(RT_zscores)<z_thresh);
            [R,P] = corrcoef(alpha_pretarg(indx),RT_all(indx,side));
            alpha_corr_topo_tt(chan,tt,1) = R(1,2);
            alpha_corr_topo_tt(chan,tt,2) = P(1,2);
        end
    end

    figure
    subplot(1,2,1)
    plot_mean = alpha_corr_topo(:,1);
    topoplot(plot_mean,chanlocs,'maplimits', ...
        [min(plot_mean) max(plot_mean)], ...
        'electrodes','numbers','plotchans',plot_chans,'intsquare','off');
    colorbar('FontSize',12)
    subplot(1,2,2)
    plot_mean = alpha_corr_topo(:,2);
    topoplot(plot_mean,chanlocs,'maplimits', ...
        [0 0.05], ...
        'electrodes','off','plotchans',plot_chans);
    colorbar('FontSize',12)
end

 return



%% Extract pre-target alpha
pre_alpha_chans=[17,18,21,22;54,55,58,59]; %17,18,21,22,26,27;54,55,58,59,63,64
for s = 1:size(allsubj,2)
    for hemi=1:2
        pre_alpha_hemi(s,hemi)=squeeze(mean(mean(mean(alpha_side(s,pre_alpha_chans(hemi,:),1:find(alpha_t==-1),:),2),3),4));
    end
end
%% Extract post-target alpha
for s = 1:size(allsubj,2)
    for side=1:2
        for hemi=1:2
            if hemi==1
            post_alpha_lefthemi(s,side)=squeeze(mean(mean(alpha_side(s,pre_alpha_chans(hemi,:),find(alpha_t>150 & alpha_t<700),side),2),3));
            else
            post_alpha_righthemi(s,side)=squeeze(mean(mean(alpha_side(s,pre_alpha_chans(hemi,:),find(alpha_t>150 & alpha_t<700),side),2),3)); 
            end
        end
    end
end
%% Make participant level matrix for export into SPSS or R
participant_level_alpha(:,1:2)=pre_alpha_hemi; %(LeftHemi, RightHemi) 
participant_level_alpha(:,3:4)=post_alpha_lefthemi; %(LeftTarget, RightTarget)
participant_level_alpha(:,5:6)=post_alpha_righthemi; %(LeftTarget, RightTarget)
open participant_level_alpha

csvwrite (['participant_level_alpha_matrix.csv'],participant_level_alpha)

subject_folder=subject_folder';
cell2csv ('IDs_alpha.csv',subject_folder)
