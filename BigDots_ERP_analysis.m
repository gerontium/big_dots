clear
close all
clc
chanlocs = readlocs('cap64.loc');

% path_temp = 'D:\Participant Folders_new\'; %TCD Laptop
% path_temp = 'S:\R-MNHS-SPP\Bellgrove-data\4. Dan Newman\Participant Folders_new\'; %Monash PC
path_temp = 'C:\Users\Dan\Desktop\Big_Dots_Data\';

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
end
%%
duds = [1]; %% 1(LK_07_04_14) completed the wrong paradigm  
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
 
%% Use Current Source Density transformed erp? 1=yes, 0=no
CSD=0;

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
    [min(tester)  max(tester)],'electrodes','labels','plotchans',plot_chans);
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
rtlim=[0.300 1.500];
% rtlim=[0.300 1.200];

% ch_CPP = [31,32];
ch_CPP = [31];

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

% resp-locked erps
trs = [-.700*fs:fs*.100];
tr = trs*1000/fs;

BL_erp = [-100,0];

% zscore threshold
z_thresh = 3;

%% Start loop
for s=1:length(allsubj)
    pause(1)
    load([path_temp subject_folder{s} '\' allsubj{s} 'big_dots_erp'],'erp_LPF_8Hz','erp_LPF_35Hz','erp_LPF_35Hz_CSD','allRT','allrespLR','allTrig','allblock_count',...
        'BL_resp_artrej','ET_BL_resp_artrej');
    
    if strcmp(subject_folder{s},'331M_CL') % really odd tiny artifact meant this trial was messing with CSD!
        allRT(53) = 0; allrespLR(53) = 0; allTrig(53) = 0;
    end

     if CSD
         erp=double(erp_LPF_35Hz_CSD);
     else
         erp=double(erp_LPF_35Hz);
     end
                
    % Baseline erp
    baseline_erp = mean(erp(:,find(t>=BL_erp(1) & t<=BL_erp(2)),:),2);
    erp = erp-repmat(baseline_erp,[1,size(erp,2),1]); % baseline full erp
    
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
                allRT>rtlim(1)*fs & allRT<rtlim(2)*fs & BL_resp_artrej==1 & ET_BL_resp_artrej & validrlock);

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
    for iti = 1:3, RT_iti_index(s,iti) = (RT_factors(s,iti,1)-RT_factors(s,iti,2))/((RT_factors(s,iti,1)+RT_factors(s,iti,2))/2); end
    RT_median_index(s) = (RT_median_all(s,1)-RT_median_all(s,2))/((RT_median_all(s,1)+RT_median_all(s,2))/2);
    RT_log_index(s) = (RT_log_all(s,1)-RT_log_all(s,2))/((RT_log_all(s,1)+RT_log_all(s,2))/2);
    RT_index_zs(s) = (RT_all_zs(s,1)-RT_all_zs(s,2))/((RT_all_zs(s,1)+RT_all_zs(s,2))/2);        
    
    disp(['Subject ',allsubj{s},' Total Valid Trials: ',num2str(length([conds{s,:,:}])), ...
        ' = ',num2str(round(100*(length([conds{s,:,:}]))/(16*18))),'%'])
    
    for side = 1:2
        ERP_side(s,:,:,side) = squeeze(mean(erp(1:numch,:,[conds{s,:,side}]),3));
        ERPr_side(s,:,:,side) = squeeze(mean(erpr(1:numch,:,[conds{s,:,side}]),3));
        CPP_side(s,:,side) = squeeze(mean(mean(erp(ch_CPP,:,[conds{s,:,side}]),1),3));
        CPPr_side(s,:,side) = squeeze(mean(mean(erpr(ch_CPP,:,[conds{s,:,side}]),1),3));
        N2c_side(s,:,side) = squeeze(mean(mean(erp(ch_lr{side},:,[conds{s,:,side}]),1),3));
        N2i_side(s,:,side) = squeeze(mean(mean(erp(ch_rl{side},:,[conds{s,:,side}]),1),3));
  %% Code adapted from Ger's Current Biology cpp code to pull out CPP onset latency:
        % Define CPP onset search window, from 0 to 1000ms
        CPP_search_t  = [0,1000];
        % Same window in samples
        CPP_search_ts  = [find(t==CPP_search_t(1)),find(t==CPP_search_t(2))];
        % Size of sliding window. This is in fact 1/4 of the search window in ms.
        % So 25 is 100ms. (25 samples x 2ms either side of a particular sample).
        max_search_window = 25;
        

%         consecutive_windows=10;%Number of consecutive windows that p must be less than .05 for in order to call it a CPP onset       
        if any(strcmp(subject_folder(s),{'ND_16_05_14'})) || any(strcmp(subject_folder(s),{'036M_JK'}))
             consecutive_windows=50;%had to make it longer for these participants otherwise it records a false CPP onset
        else
            consecutive_windows=15;%15 works well for everybody else
        end
        %%        
        CPP_temp = squeeze(mean(erp(ch_CPP,:,[conds{s,:,side}]),1)); % time x trial
        CPPs(:,side) = squeeze(mean(CPP_temp(:,:),2)); % average across trial for plot later on, not used to find onsets.
        % constrain the search window according to parameters above.
        CPP_temp = squeeze(CPP_temp(find(t>=CPP_search_t(1) & t<=CPP_search_t(2)),:));
        prestim_temp = find(t<CPP_search_t(1)); % so we can add it on after getting max peak.
        
        % we want sliding windows for each trial, create smoothed waveform.
        clear win_mean win_mean_inds tstats ps
        for trial = 1:size(CPP_temp,2)
            counter = 1;
            for j = max_search_window:2:size(CPP_temp,1)-max_search_window
                win_mean(counter,trial) = mean(CPP_temp([j-max_search_window+1:j+max_search_window-1],trial));
                win_mean_inds(counter) = j;
                counter = counter+1;
            end
        end
        
        % do t-test to zero across the smoothed trials.
        for tt = 1:size(win_mean,1)
            
            if strcmp( subject_folder(s),'AD48C') %This participant has strainge CPP baseline, so do CPP onset t-test against -1.5 instead of against 0
                [~,P,~,STATS] = ttest(win_mean(tt,:),-1.5);
            else
                [~,P,~,STATS] = ttest(win_mean(tt,:));
            end
            tstats(tt) = STATS.tstat;
            ps(tt) = P;
        end
        
        % when does the ttest cross 0.05? If at all?
%         onsetp05 = find(ps<0.05 & tstats>0,1,'first');

        %DN: added this in to explicitly make sure the "consecutive_windows" number of following p-values from onset are also lower than 0.05.
        clear allp05
        allp05= find(ps<0.05 & tstats>0);
        onsetp05=[];
        for i = 1:length(allp05)
            if  (i+consecutive_windows-1)<=length(allp05)
                if allp05(i+consecutive_windows-1)-allp05(i)==consecutive_windows-1 %if there is at least 15 consecutive windows where p<.05
                    onsetp05=allp05(i);
                    break
                end
            else
                onsetp05=allp05(i);
                break
            end
        end

        
        % get timepoint of min index.
        if ~isempty(onsetp05)
            onset_ind = win_mean_inds(onsetp05);
            CPP_onset_ind = onset_ind + length(prestim_temp); % see above, this needs to be added to get the overall time with respect to t.
            CPP_side_onsets(s,side) = t(CPP_onset_ind);
        else % onsetp05 is empty, no significant CPP.
            disp([allsubj{s},': bugger']) %AD48C has no CPP onset
            CPP_side_onsets(s,side) = 0;
        end
        
% %     plot the smoothed waveforms, the corresponding t-tests and p-values.
% %     Make sure the 10 (DN:30) following p-values from onset are also lower than
% %     0.05.
        
%         if side==1
%             figure
%             subplot(3,2,1)
%             plot(win_mean_inds,mean(win_mean,2))
%             title(subject_folder{s})
%             subplot(3,2,3)
%             plot(win_mean_inds,tstats)
%             subplot(3,2,5)
%             plot(win_mean_inds,ps), hold on
%             line(xlim,[0.05,0.05],'Color','k','LineWidth',1);
%             if ~isempty(onsetp05)
%                 line([onset_ind,onset_ind],ylim,'Color','g','LineWidth',1);
%             else
%                 line([0,0],ylim,'Color','r','LineWidth',1);
%             end
%         else
%             subplot(3,2,2)
%             plot(win_mean_inds,mean(win_mean,2))
%             title(subject_folder{s})
%             subplot(3,2,4)
%             plot(win_mean_inds,tstats)
%             subplot(3,2,6)
%             plot(win_mean_inds,ps), hold on
%             line(xlim,[0.05,0.05],'Color','k','LineWidth',1);
%             if ~isempty(onsetp05)
%                 line([onset_ind,onset_ind],ylim,'Color','g','LineWidth',1);
%             else
%                 line([0,0],ylim,'Color','r','LineWidth',1);
%             end
%         end
    end
%           pause(1)
%%   plot CPP with onset marked 
%     colors = {'b' 'r' 'g' 'm' 'c'};
%     figure
%     for side = 1:2
%         plot(t,squeeze(CPPs(:,side)),'Color',colors{side},'LineWidth',2), hold on
%         line([mean(CPP_side_onsets(s,side),1),mean(CPP_side_onsets(s,side),1)],ylim,'Color',colors{side},'LineWidth',1.5);
%         line([0,0],ylim,'Color','k','LineWidth',1);
%         line(xlim,[0,0],'Color','k','LineWidth',1);
%     end
%     title(subject_folder{s})
%     pause(1)
    
%     pause(1)
end

%% Quick check of RT index
[~,p,~,stats] = ttest(RT_index);
disp(['RT index to zero: t = ' num2str(stats.tstat) ', p = ' num2str(p)])
[~,p,~,stats] = ttest2(RT_index(find(DAT1_nosplit==1)),RT_index(find(DAT1_nosplit==2)));
disp(['RT index x DAT1: t = ' num2str(stats.tstat) ', p = ' num2str(p)])

figure
plot(zscore(RT_index))
%% Grand average ERP
% chan x time x side
ERP_group_side = squeeze(mean(ERP_side(:,:,:,:),1));

figure
plottopo(ERP_group_side(:,:,:),'chanlocs',chanlocs,'limits',[t(1) t(end) ...
    min(min(min(ERP_group_side(plot_chans,:,:))))  max(max(max(ERP_group_side(plot_chans,:,:))))], ...
    'title',['ERP left vs right targets'],'legend',side_tags,'showleg','on','ydir',1)

clear time_windows
time_windows(1,:) = [100:50:500];
time_windows(2,:) = time_windows(1,:)+50;
for side = 1:2
    figure
    for t_temp = 1:size(time_windows,2)
        plot_mean = squeeze(mean(mean(ERP_group_side(:,find(t>time_windows(1,t_temp) & t<time_windows(2,t_temp)),side),2),3));
        subplot(3,3,t_temp)
        topoplot(plot_mean,chanlocs,'maplimits', ...
            [min(min(min(ERP_group_side(:,find(t>time_windows(1,1) & t<time_windows(2,end)),:))))...
            max(max(max(ERP_group_side(:,find(t>time_windows(1,1) & t<time_windows(2,end)),:))))], ...
            'electrodes','off','plotchans',plot_chans);
        title([side_tags{side},' targets: ',num2str(time_windows(1,t_temp)),' ms to ',num2str(time_windows(2,t_temp)),' ms']);
        colorbar
    end
end


%% Make some scalp plots for R:
%CPP scalp topo
t1 = 450; t2 = 600;
plot_mean = squeeze(mean(mean(ERP_group_side(:,find(t>=t1 & t<t2),:),2),3));
figure
topoplot(plot_mean,chanlocs,'maplimits', ...
    [min(plot_mean) max(plot_mean)], ...
    'electrodes','off','plotchans',plot_chans);

%N2 scalp topo
t1 = 200; t2 = 300;
for side = 1:2
    plot_mean = squeeze(mean(mean(ERP_group_side(:,find(t>=t1 & t<t2),side),2),3));
    figure
    topoplot(plot_mean,chanlocs,'maplimits', ...
        [min(plot_mean) max(plot_mean)], ...
        'electrodes','off','plotchans',plot_chans);
end


%% Grand average ERPr
% chan x time x side
ERPr_group_side = squeeze(mean(ERPr_side(:,:,:,:),1));

figure
plottopo(ERPr_group_side(:,:,:),'chanlocs',chanlocs,'limits',[tr(1) tr(end) ...
    min(min(min(ERPr_group_side(plot_chans,:,:))))  max(max(max(ERPr_group_side(plot_chans,:,:))))], ...
    'title',['ERPr left vs right targets'],'legend',side_tags,'showleg','on','ydir',1)

clear time_windows
time_windows(1,:) = [-350:50:50];
time_windows(2,:) = time_windows(1,:)+50;
for side = 1:2
    figure
    for t_temp = 1:size(time_windows,2)
        plot_mean = squeeze(mean(mean(ERPr_group_side(:,find(tr>time_windows(1,t_temp) & tr<time_windows(2,t_temp)),side),2),3));
        subplot(3,3,t_temp)
        topoplot(plot_mean,chanlocs,'maplimits', ...
            [min(min(min(ERPr_group_side(:,find(tr>time_windows(1,1) & tr<time_windows(2,end)),:))))...
            max(max(max(ERPr_group_side(:,find(tr>time_windows(1,1) & tr<time_windows(2,end)),:))))], ...
            'electrodes','off','plotchans',plot_chans);
        title([side_tags{side},' targets (resp-locked): ',num2str(time_windows(1,t_temp)),' ms to ',num2str(time_windows(2,t_temp)),' ms']);
        colorbar
    end
end

% t1 = -100; t2 = 0;
% plot_mean = squeeze(mean(mean(ERPr_group_side(:,find(tr>=t1 & tr<t2),:),2),3));
% figure
% topoplot(plot_mean,chanlocs,'maplimits', ...
%     [min(plot_mean) max(plot_mean)], ...
%     'electrodes','numbers','plotchans',plot_chans);
%% Plot CPP x target side
CPP = squeeze(mean(CPP_side,1)); % time x side
clear h
figure
for side = 1:2
    h(side) = plot(t,squeeze(CPP(:,side)),'LineWidth',3,'LineStyle','-');hold on
end
set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('CPP: Left vs Right Hemifield Targets')
line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,side_tags, ...
    'FontSize',16,'Location','NorthWest');

% figure
% for s = 1:length(allsubj)
%     CPP = squeeze(mean(CPP_side(s,:,:),3));
%     if max(CPP)>60
%         disp(subject_folder{s})
%     end
%     plot(t,CPP,'LineWidth',1,'LineStyle','-');hold on
% end
% set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
% ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
% xlabel('Time (ms)','FontName','Arial','FontSize',16)
% title('CPP: Left vs Right Hemifield Targets')
% line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
% line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');

%% Plot CPPr x target side
CPPr = squeeze(mean(CPPr_side,1)); % time x side
clear h
figure
for side = 1:2
    h(side) = plot(tr,squeeze(CPPr(:,side)),'LineWidth',3,'LineStyle','-');hold on
end

set(gca,'FontSize',16,'xlim',[-500,100]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('CPP (resp-locked): Left vs Right Hemifield Targets')
line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,side_tags, ...
    'FontSize',16,'Location','NorthWest');

%% Plot N2c x target side
N2c = squeeze(mean(N2c_side,1)); % time x side
clear h
figure
for side = 1:2
    h(side) = plot(t,squeeze(N2c(:,side)),'LineWidth',3,'LineStyle','-');hold on
end
set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('N2c: Left vs Right Hemifield Targets')
line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,side_tags, ...
    'FontSize',16,'Location','NorthWest');

% figure
% for s = 1:length(allsubj)
%     N2c = squeeze(mean(N2c_side(s,:,:),3));
%     if min(N2c(find(t<500)))<-5
%         disp(subject_folder{s})
%     else
% %         plot(t,N2c,'LineWidth',1,'LineStyle','-');hold on
%     end
%     plot(t,N2c,'LineWidth',1,'LineStyle','-');hold on
% end
% set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
% ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
% xlabel('Time (ms)','FontName','Arial','FontSize',16)
% title('CPP: Left vs Right Hemifield Targets')
% line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
% line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');

%% Plot N2i x target side
N2i = squeeze(mean(N2i_side,1)); % time x side
clear h
figure
for side = 1:2
    h(side) = plot(t,squeeze(N2i(:,side)),'LineWidth',3,'LineStyle','-');hold on
end
set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('N2i: Left vs Right Hemifield Targets')
line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,side_tags, ...
    'FontSize',16,'Location','NorthWest');

% return
%% CPP x DAT1
colors = {'b','r'};
linestyles = {'-','--'};
cc=1;
clear h
figure
for dat = 1:2
    CPP = squeeze(mean(CPP_side(find(DAT1_nosplit==dat),:,:),1)); % time x side    
    for side = 1:2
        h(cc) = plot(t,squeeze(CPP(:,side)),'Color',colors{side},'LineWidth',2,'LineStyle',linestyles{dat});hold on
        cc=cc+1;
    end
end
set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('CPP: Left vs Right Hemifield Targets')
line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,{'Left/DAT1 no repeat','Right/DAT1 no repeat','Left/DAT1 repeat','Right/DAT1 repeat'},...
    'FontSize',16,'Location','NorthWest');

t1 = 270; t2 = 470;
stat_temp = squeeze(mean(CPP_side(:,find(t>=t1 & t<=t2),:),2)); % subj x side
stat_temp = [stat_temp,DAT1_nosplit'];

%% CPPr x DAT1
colors = {'b','r'};
linestyles = {'-','--'};
cc=1;
clear h
figure
for dat = 1:2
    CPPr = squeeze(mean(CPPr_side(find(DAT1_nosplit==dat),:,:),1)); % time x side    
    for side = 1:2
        h(cc) = plot(tr,squeeze(CPPr(:,side)),'Color',colors{side},'LineWidth',2,'LineStyle',linestyles{dat});hold on
        cc=cc+1;
    end
end
set(gca,'FontSize',16,'xlim',[-500,100]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('CPP (resp-locked): Left vs Right Hemifield Targets')
line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,{'Left/DAT1 no repeat','Right/DAT1 no repeat','Left/DAT1 repeat','Right/DAT1 repeat'},...
    'FontSize',16,'Location','NorthWest');

%% N2c x DAT1
colors = {'b','r'};
linestyles = {'-','--'};
cc=1;
clear h
figure
for dat = 1:2
    N2c = squeeze(mean(N2c_side(find(DAT1_nosplit==dat),:,:),1)); % time x side    
    for side = 1:2
        h(cc) = plot(t,squeeze(N2c(:,side)),'Color',colors{side},'LineWidth',2,'LineStyle',linestyles{dat});hold on
        cc=cc+1;
    end
end
set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('N2c: Left vs Right Hemifield Targets')
line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,{'Left/DAT1 no repeat','Right/DAT1 no repeat','Left/DAT1 repeat','Right/DAT1 repeat'},...
    'FontSize',16,'Location','NorthWest');

t1 = 250; t2 = 290;
stat_temp = squeeze(mean(N2c_side(:,find(t>=t1 & t<=t2),:),2)); % subj x side
stat_temp = [stat_temp,DAT1_nosplit'];

%% N2i x DAT1
colors = {'b','r'};
linestyles = {'-','--'};
cc=1;
clear h
figure
for dat = 1:2
    N2i = squeeze(mean(N2i_side(find(DAT1_nosplit==dat),:,:),1)); % time x side    
    for side = 1:2
        h(cc) = plot(t,squeeze(N2i(:,side)),'Color',colors{side},'LineWidth',2,'LineStyle',linestyles{dat});hold on
        cc=cc+1;
    end
end
set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('N2i: Left vs Right Hemifield Targets')
line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,{'Left/DAT1 no repeat','Right/DAT1 no repeat','Left/DAT1 repeat','Right/DAT1 repeat'},...
    'FontSize',16,'Location','NorthWest');


%% Extract Response Locked CPP slope"
%CPP build-up defined as the slope of a straight line fitted to the
%response-locked waveform at during "slope_timeframe_index" defined for
%each participant here:
clear slope_timeframe_index 
for s=1:length(allsubj)
 slope_timeframe_index(s,2)=find(mean(CPPr_side(s,:,:),3)==max(mean(CPPr_side(s,find(tr<0),:),3)));%max amplitude index
end
slope_timeframe_index(:,1)=slope_timeframe_index(:,2)-50;%subtract 50samples (i.e. 100ms) from max amplitude index to form slope_timeframe window
%Now find and save CPPr slope
for s=1:length(allsubj)
    for side = 1:2  
        coef = polyfit(tr(slope_timeframe_index(s,1):slope_timeframe_index(s,2)),(CPPr_side(s,slope_timeframe_index(s,1):slope_timeframe_index(s,2),side)),1);% coef gives 2 coefficients fitting r = slope * x + intercept
        CPPr_slope(s,side)=coef(1);  
    end
end

%%%Plot each individual participant's CPPr_slope with time-window varying
%%%per participant
for s=1:length(allsubj)
    clear h
    figure
    for side = 1:2
        h(side) = plot(tr,CPPr_side(s,:,side),'LineWidth',3,'LineStyle','-');hold on       
        coef = polyfit(tr(slope_timeframe_index(s,1):slope_timeframe_index(s,2)),(CPPr_side(s,slope_timeframe_index(s,1):slope_timeframe_index(s,2),side)),1);% coef gives 2 coefficients fitting r = slope * x + intercept
        CPP_slope(s,side)=coef(1);
        r = coef(1) .* tr(slope_timeframe_index(s,1):slope_timeframe_index(s,2)) + coef(2); %r=slope(x)+intercept, r is a vectore representing the linear curve fitted to the erpr during slope_timeframe
        plot(tr(slope_timeframe_index(s,1):slope_timeframe_index(s,2)), r,'Linewidth',2, 'LineStyle', ':');   
    end
    
    set(gca,'FontSize',16,'xlim',[-500,100]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
    ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
    xlabel('Time (ms)','FontName','Arial','FontSize',16)
    title([subject_folder{s}, ' CPP (resp-locked) by Hemifield'])
    line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
    line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
    legend(h,side_tags,'FontSize',16,'Location','NorthWest');
   pause(1) 
end



%% Extract N2c and N2i latency :
for s = 1:size(allsubj,2)
    for side=1:2
        %         to use each participant's average N2c/i to get their peak latency index:
        N2c=N2c_side(s, :, side); 
        N2i=N2i_side(s, :, side); 
        N2c_peak_amp_index_t(s,side)=t(N2c==min(N2c(find(t==150):find(t==400))));%Find max peak latency for N2c in ms
        N2i_peak_amp_index_t(s,side)=t(N2i==min(N2i(find(t==200):find(t==450))));%Find max peak latency for N2i in ms
    end
end
%N2 Latency:
N2cN2i_latency_ByTargetSide = [N2c_peak_amp_index_t,N2i_peak_amp_index_t]; %(LeftTargetN2c_latency, RightTargetN2c_latency, LeftTargetN2i_latency, RightTargetN2i_latency)

% %Plot N2c and N2i per subject showing peak amplitude 
% for s = 1:size(allsubj,2)
% clear h
% figure
% for side = 1:2
%     h(side) = plot(t,squeeze(N2i_side(s,:,side)),'LineWidth',3,'LineStyle',':', 'Color',colors{side});hold on
%     h(side) = plot(t,squeeze(N2c_side(s,:,side)),'LineWidth',3,'LineStyle','-', 'Color',colors{side});hold on
%     line([avN2i_peak_amp_index_t(s,side),avN2i_peak_amp_index_t(s,side)],ylim,'Color',colors{side}, 'Linewidth',2,'LineStyle',':');
%     line([avN2c_peak_amp_index_t(s,side),avN2c_peak_amp_index_t(s,side)],ylim,'Color',colors{side}, 'Linewidth',2,'LineStyle','-');
% end
% 
% set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
% ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
% xlabel('Time (ms)','FontName','Arial','FontSize',16)
% title(['Subj: ',num2str(s),' N2c & N2i(:) by Hemifield'])
% line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
% line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
% legend(h,side_tags, 'FontSize',16,'Location','NorthWest');
% pause(1) 
% end

%% Extract N2c and N2i Amplitude :
window=25; %this is the time (in samples) each side of the peak latency (so it's 50ms each side of peak latency - so a 100ms window)
N2c = squeeze(mean(mean(N2c_side,1),3)); % time 
N2i = squeeze(mean(mean(N2i_side,1),3)); % time 
N2c_peak_amp_index=find(N2c==min(N2c(find(t==150):find(t==450))));%Find Left target max peak latency for N2c
N2i_peak_amp_index=find(N2i==min(N2i(find(t==150):find(t==450))));%Find Left target max peak latency for N2i

for s = 1:size(allsubj,2)
    for side=1:2
        max_peak_N2c(s,side)=squeeze(mean(N2c_side(s,N2c_peak_amp_index-window:N2c_peak_amp_index+window, side),2));
        max_peak_N2i(s,side)=squeeze(mean(N2i_side(s,N2i_peak_amp_index-window:N2i_peak_amp_index+window, side),2)); 
    end
end
N2cN2i_amp_ByTargetSide_ParticipantLevel = [max_peak_N2c,max_peak_N2i]; %(LeftTargetN2c, RightTargetN2c, LeftTargetN2i, RightTargetN2i)


%% Make participant level matrix for export into SPSS or R
participant_level(:,1:2)=max_peak_N2c; %N2c amplitude (LeftTarget, RightTarget)
participant_level(:,3:4)=max_peak_N2i; %N2i amplitude (LeftTarget, RightTarget)
participant_level(:,5:6)=N2c_peak_amp_index_t; %N2c latency (LeftTarget, RightTarget)
participant_level(:,7:8)=N2i_peak_amp_index_t; %N2i latency (LeftTarget, RightTarget)
participant_level(:,9:10)=CPP_side_onsets; %CPP onset (LeftTarget, RightTarget)
participant_level(:,11:12)=CPPr_slope; %response locked CPP slope (LeftTarget, RightTarget)
participant_level(:,13)=subject_location;%1=TCD; 2=Monash
% open participant_level

csvwrite (['participant_level_matrix.csv'],participant_level)

subject_folder=subject_folder';
cell2csv ('IDs.csv',subject_folder)