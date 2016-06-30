clear
close all
clc
chanlocs = readlocs('cap64.loc');

path_temp = 'D:\Participant Folders_new\'; %TCD Laptop
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
    '439M_TM','484M_AI','453M_LB','422M_MK','323M_CZ'}; % 80
allsubj = {'LK','AR','MH','AA','NT','OF','RO','PR','AS','OM', ...
    'RM','SB','GW','OS','AC','ND','SF','TL','JC','EL', ...
    'SH','HP1M','BR2M','JK3M','SJ4M','CB5M','MO6M','CS7M','EZ8M','KS9M', ...
    'NH10M','BS11M','AS12M','SA13M','JK14M','LK15M','SM16M','JD17M','SC18M','SW19M', ...
    'JM20M','CL21M','CY22M','DM24M','JB25M','JC26M','YV27M','AT28M','MK29M','LG30M', ...
    'JM31M','PP32M','KR33M','FT34M','CS35M','MG36M','DC37M','PH38M','AF39M','RO40M', ...
    'EB41M','ED42M','LO43M','PD44M','LE45M','EW46M','AM47M','WM48M','VF49M','SW50M',...
    'NB52M','BL53M','SS54M','LA55M','AH56M','TM57M','AI58M','LB59M','MK60M','CZ61M'};

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
    '484M_AI','453M_LB','422M_MK','323M_CZ'};

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

DAT1_tags = {'0/1 DAT1 10-repeats','2 DAT1 10-repeats'};

% Get testing times
load('test_times.mat')

%% Load SLF

load('slf_mat.mat')
SLF_measures=[]; dud_temp_slf=[];
for s = 1:length(subject_folder)
    found = 0;
    for i = 1:size(slf_subj,1)
        if strcmp(subject_folder{s},subject_ID{i})
            SLF_measures(s,:) = slf_subj(i,:);
            found = 1;
        end
    end
    if found==0
        dud_temp_slf = [dud_temp_slf,s];
    end
end

%% Get rid of duds/include only particular subjects

% LK_07_04_14: coherence at 35%; 1
% AR_08_04_14 & MH_14_04_14: No ITI 3, side 2... 2,3
% 414M_LA: zscore RT index > 3; 74
% AA_15_04_14: zscore RT index > 2.5; 4
duds = [1,4,74];
single_participants = [];

if ~isempty(duds) && isempty(single_participants)
    subject_folder([duds]) = [];
    allsubj([duds]) = [];
    DAT1_split([duds]) = [];
    DAT1_nosplit([duds]) = [];
    subject_location([duds]) = [];
    test_times([duds]) = [];
%     SLF_measures([duds]) = [];
end

if ~isempty(single_participants)
    subject_folder = subject_folder(single_participants);
    allsubj = allsubj(single_participants);
    DAT1_split = DAT1_split(single_participants);
    DAT1_nosplit = DAT1_nosplit(single_participants);
    subject_location = subject_location(single_participants);
    test_times = test_times(single_participants);
%     SLF_measures = SLF_measures(single_participants);
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
Fs=500;
numch=64;
rtlim=[0.300 1.500];
% rtlim=[0.300 1.200];

ch_CPP = [31];

% ch_lr = [59,60;22,23];
% ch_rl = [22,23;59,60];
ch_lr = [60;23];
ch_rl = [23;60];

% stim-locked erps
ts = -0.500*Fs:1.800*Fs;
t = ts*1000/Fs;

% resp-locked erps
trs = [-.500*Fs:Fs*.100];
tr = trs*1000/Fs;

% zscore threshold
z_thresh = 3;

%% Start loop
for s=1:length(allsubj)
    pause(1)
    load([path_temp subject_folder{s} '\' allsubj{s} 'big_dots_erp'],'erp_LPF_35Hz_CSD','allRT','allrespLR','allTrig','allblock_count',...
        'BL_resp_artrej','ET_BL_resp_artrej');
    erp = erp_LPF_35Hz_CSD;
                
    disp(['Subject ' num2str(s) ': ' allsubj{s} ' number of trials = ' num2str(length(find(allTrig)))])
    
    erpr = zeros(size(erp,1),length(tr),size(erp,3));    
    
    validrlock = zeros(1,length(allRT)); % length of RTs.
    for n=1:length(allRT);
        [blah,RTsamp] = min(abs(t*Fs/1000-allRT(n))); % get the sample point of the RT.
        if RTsamp+trs(1) >0 & RTsamp+trs(end)<=length(t) & allRT(n)>0 % is the RT larger than 1st stim RT point, smaller than last RT point.
            erpr(:,:,n) = erp(:,RTsamp+trs,n);
            validrlock(n)=1;
        end
    end
    
    % check art reject
    elec_bad_trials(s) = length(find(BL_resp_artrej==0));
    ET_bad_trials(s) = length(find(ET_BL_resp_artrej==0));

    % AR_08_04_14 & MH_14_04_14 had no side 3, side 2
    for side = 1:2
        for iti = 1:3
            % calcs the indices of the triggers for each
            % appropriate trial type.
%             conds{s,iti,side} = find(allTrig==targcodes(iti,side) & allrespLR==1 & ...
%                 allRT>rtlim(1)*Fs & allRT<rtlim(2)*Fs & ET_BL_resp_artrej==1);
            conds{s,iti,side} = find(allTrig==targcodes(iti,side) & allrespLR==1 & ...
                allRT>rtlim(1)*Fs & allRT<rtlim(2)*Fs & BL_resp_artrej==1 & ET_BL_resp_artrej & validrlock);

            RTs{s,iti,side} = allRT([conds{s,iti,side}])*1000/Fs;
            RTs_log{s,iti,side} = log(allRT([conds{s,iti,side}])*1000/Fs);
            RT_zs{s,iti,side} = zscore([RTs_log{s,iti,side}]);
            hit{s,iti,side} = find(allTrig==targcodes(iti,side) & allrespLR==1 & ...
                allRT>rtlim(1)*Fs & allRT<rtlim(2)*Fs);
            miss{s,iti,side} = find(allTrig==targcodes(iti,side) & allrespLR==3);
            
            RT_factors(s,iti,side) = mean([RTs{s,iti,side}]); % can't include AR_08_04_14 & MH_14_04_14 because of mistake
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
    for iti = 1:3, RT_iti_index(s,iti) = (RT_factors(s,iti,1)-RT_factors(s,iti,2))/((RT_factors(s,iti,1)+RT_factors(s,iti,2))/2); end
    RT_median_index(s) = (RT_median_all(s,1)-RT_median_all(s,2))/((RT_median_all(s,1)+RT_median_all(s,2))/2);
    RT_log_index(s) = (RT_log_all(s,1)-RT_log_all(s,2))/((RT_log_all(s,1)+RT_log_all(s,2))/2);
    RT_index_zs(s) = (RT_all_zs(s,1)-RT_all_zs(s,2))/((RT_all_zs(s,1)+RT_all_zs(s,2))/2);        
    
    disp(['Subject ',allsubj{s},' Total Valid Trials: ',num2str(length([conds{s,:,:}])), ...
        ' = ',num2str(round(100*(length([conds{s,:,:}]))/(16*18))),'%'])
end

%% Trial counts

for s = 1:length(allsubj)
    trial_counts(s) = length([RTs{s,:,:}]);
end
figure, plot(trial_counts)
figure, plot(zscore(trial_counts)) % 1, 42, 55 had low trial numbers

% figure
% plot(elec_bad_trials), hold on
% plot(ET_bad_trials)
%% General behavioural analysis

% Regular RT: x side and x index
% RTs{s,iti,side}
% percentiles = prctile([RTs{:,:,:}],[0.5 1 5 95 99 99.5])
clear counts edges
figure
for side = 1:2
    histogram([RTs{:,:,side}],25), hold on
    [counts{side},edges{side}] = histcounts([RTs{:,:,side}],25);
end
figure
for side = 1:2
    plot(edges{side}(1:end-1),counts{side}), hold on
end
RT_index = RT_index';
figure, histogram(RT_index,15)
for dat = 1:2
    figure, plot(zscore(RT_index(find(DAT1_nosplit==dat))))
end
% a = find(DAT1_nosplit==2);
% open a

% % Log RTs
% clear counts edges
% figure
% for side = 1:2
%     histogram([RTs_log{:,:,side}],25), hold on
%     [counts{side},edges{side}] = histcounts([RTs_log{:,:,side}],25);
% end
% figure
% for side = 1:2
%     plot(edges{side}(1:end-1),counts{side}), hold on
% end
% RT_log_index = RT_log_index';
% figure, histogram(RT_log_index,15)
% figure, plot(zscore(RT_log_index))

%% RTs and RT index x DAT1

clear counts edges
for dat = 1:2
    figure
    for side = 1:2
        histogram([RTs{find(DAT1_nosplit==dat),:,side}],25), hold on
        [counts{dat,side},edges{dat,side}] = histcounts([RTs{find(DAT1_nosplit==dat),:,side}],25);
    end
    title(['RT x side: ',DAT1_tags{dat}])
end
for dat = 1:2
    figure
    for side = 1:2
        plot(edges{dat,side}(1:end-1),counts{dat,side}), hold on
    end
    title(['RT x side: ',DAT1_tags{dat}])
end
        
RT_side_mat = [RT_all,DAT1_nosplit',subject_location'];

% % RT_factors(s,iti,side). NB can't include AR_08_04_14 & MH_14_04_14 if
% % looking at this.
% RT_iti_side_mat = [squeeze(RT_factors(:,1,1)),squeeze(RT_factors(:,1,2)), ...
%     squeeze(RT_factors(:,2,1)),squeeze(RT_factors(:,2,2)), ...
%     squeeze(RT_factors(:,3,1)),squeeze(RT_factors(:,3,1))]; % side then iti
% RT_iti_side_mat = [RT_iti_side_mat,DAT1_nosplit'];
% RT_iti_index = [RT_iti_index,DAT1_nosplit'];

clear h
figure
for dat = 1:2
    h(dat) = histogram(RT_index(find(DAT1_nosplit==dat)),12); hold on    
end
title(['RT index: ',DAT1_tags{1},' vs ',DAT1_tags{2}])
legend(h,{DAT1_tags{1},DAT1_tags{2}}, ...
    'FontSize',12,'Location','NorthWest');

[~,p,~,stats] = ttest(RT_index);
disp(['RT index to zero: t = ' num2str(stats.tstat) ', p = ' num2str(p)])
[~,p,~,stats] = ttest2(RT_index(find(DAT1_nosplit==1)),RT_index(find(DAT1_nosplit==2)));
disp(['RT index x DAT1: t = ' num2str(stats.tstat) ', p = ' num2str(p)])

% % zscore eliminated below threshold
% [~,p,~,stats] = ttest(RT_index_zs);
% disp(['RT index to zero (zscore eliminated): t = ' num2str(stats.tstat) ', p = ' num2str(p)])
% [~,p,~,stats] = ttest2(RT_index_zs(find(DAT1_nosplit==1)),RT_index_zs(find(DAT1_nosplit==2)));
% disp(['RT index x DAT1 (zscore eliminated): t = ' num2str(stats.tstat) ', p = ' num2str(p)])

return

