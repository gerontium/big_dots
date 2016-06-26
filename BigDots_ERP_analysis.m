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

%%
DAT1_tags = {'0/1 DAT1 10-repeats','2 DAT1 10-repeats'};
side_tags = {'Left','Right'};
%% Get rid of duds/include only particular subjects

% LK_07_04_14: coherence at 35%; 1
% AR_08_04_14 & MH_14_04_14: No ITI 3, side 2... 2,3
% 414M_LA: zscore RT index > 3; 74
% AA_15_04_14: zscore RT index > 2.5; 4
duds = [1,74,dud_temp];
single_participants = [];

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

% ch_CPP = [31,32];
ch_CPP = [31];

% ch_lr = [60,62;23,25];
% ch_rl = [23,25;60,62];
ch_lr = [60;23];
ch_rl = [23;60];

% stim-locked erps
ts = -0.500*Fs:1.800*Fs;
t = ts*1000/Fs;

% resp-locked erps
trs = [-.500*Fs:Fs*.100];
tr = trs*1000/Fs;

BL_erp = [-100,0];

% zscore threshold
z_thresh = 3;

%% Start loop
for s=1:length(allsubj)
    pause(1)
    load([path_temp subject_folder{s} '\' allsubj{s} 'big_dots_erp'],'erp_LPF_8Hz_CSD','allRT','allrespLR','allTrig','allblock_count',...
        'BL_resp_artrej','ET_BL_resp_artrej');
    erp = erp_LPF_8Hz_CSD;
                
    % Baseline erp
    baseline_erp = mean(erp(:,find(t>=BL_erp(1) & t<=BL_erp(2)),:),2);
    erp = erp-repmat(baseline_erp,[1,size(erp,2),1]); % baseline full erp
    
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
            RT_factors(s,iti,side) = mean([RTs{s,iti,side}]); % can't include AR_08_04_14 & MH_14_04_14 because of mistake
            
            hit{s,iti,side} = find(allTrig==targcodes(iti,side) & allrespLR==1 & ...
                allRT>rtlim(1)*Fs & allRT<rtlim(2)*Fs);
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
        N2c_side(s,:,side) = squeeze(mean(mean(erp(ch_lr(side,:),:,[conds{s,:,side}]),1),3));
        N2i_side(s,:,side) = squeeze(mean(mean(erp(ch_rl(side,:),:,[conds{s,:,side}]),1),3));
    end
    
% %     erp_mean = (squeeze(mean(mean(mean(ERP_uptarg(s,:,:,:,:,:),4),5),6))+squeeze(mean(mean(mean(ERP_righttarg(s,:,:,:,:,:),4),5),6)))/2;
% %     figure
% %     plottopo(erp_mean(:,:),'chanlocs',chanlocs,'limits',[t(1) t(end) ...
% %         min(min(min(erp_mean(plot_chans,:))))  max(max(max(erp_mean(plot_chans,:))))], ...
% %         'title',[allsubj{s}],'legend',{'90 deg (up)','60 deg','30 deg','0 deg (right)'},'showleg','off','ydir',1)
% %     pause(1)
end

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

% t1 = 500; t2 = 600;
% plot_mean = squeeze(mean(mean(ERP_group_side(:,find(t>=t1 & t<t2),:),2),3));
% figure
% topoplot(plot_mean,chanlocs,'maplimits', ...
%     [min(plot_mean) max(plot_mean)], ...
%     'electrodes','numbers','plotchans',plot_chans);

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

t1 = 250; t2 = 350;
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

t1 = 260; t2 = 280;
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

return
%% Trial counts

for s = 1:length(allsubj)
    trial_counts(s) = length([RTs{s,:,:}]);
end
figure, plot(trial_counts)
figure, plot(zscore(trial_counts)) % 1, 42, 55 had low trial numbers

%% Behavioural analysis

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
figure, plot(zscore(RT_index))

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




















%% RT Stats
% RT_means_side(s,side,targdir)
% RT_means_side2 = reshape(RT_means_side,size(RT_means_side,1),4); % side then targdir
RT_means_side2 = [squeeze(RT_means_side(:,1,1)),squeeze(RT_means_side(:,2,1)),squeeze(RT_means_side(:,1,2)),squeeze(RT_means_side(:,2,2))];
RT_means_coh2 = [squeeze(RT_means_coh(:,1,1)),squeeze(RT_means_coh(:,2,1)),squeeze(RT_means_coh(:,1,2)),squeeze(RT_means_coh(:,2,2))];
% RT_all(s,coh,iti,side,targdir)
RT_all2 = reshape(RT_all,size(RT_all,1),2*2*2); % coh, side, targdir
hit_rate2 = reshape(hit_rate,size(hit_rate,1),2*2*2); % coh, side, targdir

%% Plots
close all
cohs = [1,2];
N2c_amp1 = squeeze(mean(N2c_amp(:,cohs,:,:),4)); % subj x dir
N2c_amp2 = [squeeze(mean(N2c_amp(:,cohs,:,1),2)),squeeze(mean(N2c_amp(:,cohs,:,2),2))]; % subj x dir, relative to actual motion dir
N2c_amp3 = [squeeze(mean(N2c_amp(:,cohs,:,1),2)),fliplr(squeeze(mean(N2c_amp(:,cohs,:,2),2)))]; % subj x dir, relative to target dir

N2c_amp_coh = [squeeze(mean(N2c_amp(:,1,:,1),2)),squeeze(mean(N2c_amp(:,1,:,2),2)),...
    squeeze(mean(N2c_amp(:,2,:,1),2)),squeeze(mean(N2c_amp(:,2,:,2),2))]; % motion dir, targ dir, coherence
N2c_amp_sub = squeeze(mean(N2c_amp(:,cohs,:,1),2))-squeeze(mean(N2c_amp(:,cohs,:,2),2));

all_N2c = squeeze(mean(N2c_amp_coh,2));

colors3 = {'b' 'r' 'g' 'c' 'm'};
N2c_amp_means = squeeze(mean(N2c_amp2,1));
N2c_amp_stds = squeeze(std(N2c_amp2,[],1));
figure
clear h
for i = 1:4
    h(i) = plot([1,2],[N2c_amp_means(i),N2c_amp_means(i+4)],'Color',colors3{i},'LineWidth',2); hold on
end
set(gca,'FontSize',16,'ylim',[-2.5,0],'xlim',[0,3],'xtick',[1,2],'xticklabel',{'Upward Targets','Rightward Targets'});%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Target Condition','FontName','Arial','FontSize',16)
title('N2c amplitude across target conditions')
legend(h,{'90 deg (up)','60 deg','30 deg','0 deg (right)'}, ...
    'FontSize',8,'Location','SouthEast');

% figure
% clear h
% for i = 1:4
%     h(i) = errorbar([N2c_amp_means(i),N2c_amp_means(i+4)],[N2c_amp_stds(i),N2c_amp_stds(i+4)],'Color',colors3{i},'LineWidth',2); hold on
% end

% CPP_uptarg(s,:,coh,side,motion)
CPP_uptarg2 = squeeze(mean(mean(mean(CPP_uptarg(:,:,cohs,:,:),4),3),1)); % time x motion
CPP_righttarg2 = squeeze(mean(mean(mean(CPP_righttarg(:,:,cohs,:,:),4),3),1)); % time x motion
N2c_uptarg2 = squeeze(mean(mean(mean(N2c_uptarg(:,:,cohs,:,:),4),3),1)); % time x motion
N2c_righttarg2 = squeeze(mean(mean(mean(N2c_righttarg(:,:,cohs,:,:),4),3),1)); % time x motion
N2i_uptarg2 = squeeze(mean(mean(mean(N2i_uptarg(:,:,cohs,:,:),4),3),1)); % time x motion
N2i_righttarg2 = squeeze(mean(mean(mean(N2i_righttarg(:,:,cohs,:,:),4),3),1)); % time x motion

CPP_motion = (CPP_uptarg2+fliplr(CPP_righttarg2))/2;
N2c_motion = (N2c_uptarg2+fliplr(N2c_righttarg2))/2;
N2i_motion = (N2i_uptarg2+fliplr(N2i_righttarg2))/2;
N2c_motion2 = (N2c_uptarg2+N2c_righttarg2)/2;

clear h
figure
for motion = 1:4
    h(motion) = plot(t,squeeze(N2c_motion2(:,motion)),'Color',colors3{motion},'LineWidth',2,'LineStyle','-'); hold on
end

set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('N2c: Collapsed across target motion')
line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,{'90 deg (up)','60 deg','30 deg','0 deg (right)'}, ...
    'FontSize',8,'Location','SouthEast');

% return
clear h
figure
for motion = 1:4
    h(motion) = plot(t,squeeze(CPP_uptarg2(:,motion)),'Color',colors3{motion},'LineWidth',3,'LineStyle','-');hold on
end

set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('CPP: Target = Upward motion')
line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,{'90 deg (up)','60 deg','30 deg','0 deg (right)'}, ...
    'FontSize',16,'Location','NorthWest');

clear h
figure
for motion = 1:4
    h(motion) = plot(t,squeeze(CPP_righttarg2(:,motion)),'Color',colors3{motion},'LineWidth',3,'LineStyle','-');hold on
end

set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('CPP: Target = Rightward motion')
line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,{'90 deg (up)','60 deg','30 deg','0 deg (right)'}, ...
    'FontSize',16,'Location','NorthWest');

clear h
figure
for motion = 1:4
    h(motion) = plot(t,squeeze(N2c_uptarg2(:,motion)),'Color',colors3{motion},'LineWidth',3,'LineStyle','-');hold on
end

set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('N2c: Target = Upward motion')
line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,{'90 deg (up)','60 deg','30 deg','0 deg (right)'}, ...
    'FontSize',16,'Location','SouthEast');

clear h
figure
for motion = 1:4
    h(motion) = plot(t,squeeze(N2c_righttarg2(:,motion)),'Color',colors3{motion},'LineWidth',3,'LineStyle','-');hold on
end

set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-15,4]);%,'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('N2c: Target = Rightward motion')
line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,{'90 deg (up)','60 deg','30 deg','0 deg (right)'}, ...
    'FontSize',16,'Location','SouthEast');

clear h
figure
for motion = 1:4
    h(motion) = plot(t,squeeze(N2i_uptarg2(:,motion)),'Color',colors3{motion},'LineWidth',3,'LineStyle','-');hold on
end

set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('N2i: Target = Upward motion')
line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,{'90 deg (up)','60 deg','30 deg','0 deg (right)'}, ...
    'FontSize',16,'Location','SouthEast');

clear h
figure
for motion = 1:4
    h(motion) = plot(t,squeeze(N2i_righttarg2(:,motion)),'Color',colors3{motion},'LineWidth',3,'LineStyle','-');hold on
end

set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-15,4]);%,'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('N2i: Target = Rightward motion')
line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,{'90 deg (up)','60 deg','30 deg','0 deg (right)'}, ...
    'FontSize',16,'Location','SouthEast');

% Combine upwards and rightwards targets
clear h
figure
for motion = 1:4
    h(motion) = plot(t,squeeze(CPP_motion(:,motion)),'Color',colors3{motion},'LineWidth',3,'LineStyle','-');hold on
    plot(t,squeeze(N2c_motion(:,motion)),'Color',colors3{motion},'LineWidth',2,'LineStyle','--');
    plot(t,squeeze(N2i_motion(:,motion)),'Color',colors3{motion},'LineWidth',2,'LineStyle',':');
end

set(gca,'FontSize',16,'xlim',[-100,1200],'xtick',[-100,0:200:1200]);%,'ylim',[-4,8],'ytick',[-4:2:8]);%,'ylim',[-1.5,0.5]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
xlabel('Time (ms)','FontName','Arial','FontSize',16)
title('CPP & N2c: Target vs non target motions')
h(motion+1) = line([0,0],ylim,'Color','k','LineWidth',1.5,'LineStyle','--');
h(motion+2) = line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle',':');
h(motion+3) = line(xlim,[0,0],'Color','k','LineWidth',1.5,'LineStyle','-');
legend(h,{'Target Dir','30 deg','60 deg','90 deg','N2c','N2i','CPP'}, ...
    'FontSize',8,'Location','NorthWest');

return
ERP_uptarg_avg = squeeze(mean(ERP_uptarg,1)); % chan x time x coh x side x motion
ERP_righttarg_avg = squeeze(mean(ERP_righttarg,1)); % chan x time x coh x side x motion

% chan x time x coh x motion
ERP_uptarg_conip(right_hemi,:,:,:) = squeeze(ERP_uptarg_avg(right_hemi,:,:,1,:)+ERP_uptarg_avg(left_hemi,:,:,2,:))/2;
ERP_uptarg_conip(left_hemi,:,:,:) = squeeze(ERP_uptarg_avg(right_hemi,:,:,2,:)+ERP_uptarg_avg(left_hemi,:,:,1,:))/2;
ERP_uptarg_conip(centre_chans,:,:,:) = squeeze(ERP_uptarg_avg(centre_chans,:,:,2,:)+ERP_uptarg_avg(centre_chans,:,:,1,:))/2;
ERP_uptarg_conip(exclude_chans,:,:,:) = 0;

% chan x time x coh x motion
ERP_righttarg_conip(right_hemi,:,:,:) = squeeze(ERP_righttarg_avg(right_hemi,:,:,1,:)+ERP_righttarg_avg(left_hemi,:,:,2,:))/2;
ERP_righttarg_conip(left_hemi,:,:,:) = squeeze(ERP_righttarg_avg(right_hemi,:,:,2,:)+ERP_righttarg_avg(left_hemi,:,:,1,:))/2;
ERP_righttarg_conip(centre_chans,:,:,:) = squeeze(ERP_righttarg_avg(centre_chans,:,:,2,:)+ERP_righttarg_avg(centre_chans,:,:,1,:))/2;
ERP_righttarg_conip(exclude_chans,:,:,:) = 0;

% chan x time x motion
ERP_uptarg_conip_no_coh = squeeze(mean(ERP_uptarg_conip(:,:,:,:),3));
ERP_righttarg_conip_no_coh = squeeze(mean(ERP_righttarg_conip(:,:,:,:),3));

figure
plottopo(ERP_uptarg_conip_no_coh(:,:,:),'chanlocs',chanlocs,'limits',[t(1) t(end) ...
    min(min(min(ERP_uptarg_conip_no_coh(plot_chans,:,:))))  max(max(max(ERP_uptarg_conip_no_coh(plot_chans,:,:))))], ...
    'title',['Contra and ipsi upwards targets'],'legend',{'90 deg (up)','60 deg','30 deg','0 deg (right)'},'showleg','on','ydir',1)

figure
plottopo(ERP_righttarg_conip_no_coh(:,:,:),'chanlocs',chanlocs,'limits',[t(1) t(end) ...
    min(min(min(ERP_righttarg_conip_no_coh(plot_chans,:,:))))  max(max(max(ERP_righttarg_conip_no_coh(plot_chans,:,:))))], ...
    'title',['Contra and ipsi rightwards targets'],'legend',{'90 deg (up)','60 deg','30 deg','0 deg (right)'},'showleg','on','ydir',1)

temp = (ERP_uptarg_conip_no_coh + ERP_righttarg_conip_no_coh)/2;
erp_group = squeeze(mean(temp,3));
figure
plottopo(erp_group(:,:),'chanlocs',chanlocs,'limits',[t(1) t(end) ...
    min(min(min(erp_group(plot_chans,:))))  max(max(max(erp_group(plot_chans,:))))], ...
    'title',['Group ERP'],'legend',{'90 deg (up)','60 deg','30 deg','0 deg (right)'},'showleg','off','ydir',1)

clear time_windows
time_windows(1,:) = [150:50:550];
time_windows(2,:) = time_windows(1,:)+50;
figure
for t_temp = 1:size(time_windows,2)
    plot_mean = squeeze(mean(erp_group(:,find(t>time_windows(1,t_temp) & t<time_windows(2,t_temp))),2));
    subplot(3,3,t_temp)
    topoplot(plot_mean,chanlocs,'maplimits', ...
        [min(min(erp_group(:,find(t>time_windows(1,1) & t<time_windows(2,end)))))...
        max(max(erp_group(:,find(t>time_windows(1,1) & t<time_windows(2,end)))))], ...
        'electrodes','off','plotchans',plot_chans);
    title(['All targets: ',num2str(time_windows(1,t_temp)),' ms to ',num2str(time_windows(2,t_temp)),' ms']);
    colorbar
end

erp_group_no_targ = squeeze(mean(temp(:,:,[2:4]),3));
% figure
% plottopo(erp_group(:,:),'chanlocs',chanlocs,'limits',[t(1) t(end) ...
%     min(min(min(erp_group(plot_chans,:))))  max(max(max(erp_group(plot_chans,:))))], ...
%     'title',['Group ERP'],'legend',{'90 deg (up)','60 deg','30 deg','0 deg (right)'},'showleg','off','ydir',1)

clear time_windows
time_windows(1,:) = [150:50:550];
time_windows(2,:) = time_windows(1,:)+50;
figure
for t_temp = 1:size(time_windows,2)
    plot_mean = squeeze(mean(erp_group_no_targ(:,find(t>time_windows(1,t_temp) & t<time_windows(2,t_temp))),2));
    subplot(3,3,t_temp)
    topoplot(plot_mean,chanlocs,'maplimits', ...
        [min(min(erp_group_no_targ(:,find(t>time_windows(1,1) & t<time_windows(2,end)))))...
        max(max(erp_group_no_targ(:,find(t>time_windows(1,1) & t<time_windows(2,end)))))], ...
        'electrodes','off','plotchans',plot_chans);
    title(['All targets: ',num2str(time_windows(1,t_temp)),' ms to ',num2str(time_windows(2,t_temp)),' ms']);
    colorbar
end

% return

t1 = 575; t2 = 625;
plot_mean = squeeze(mean(erp_group(:,find(t>t1 & t<t2)),2));
figure
topoplot(plot_mean,chanlocs,'maplimits', ...
    [min(plot_mean) max(plot_mean)], 'electrodes','numbers','plotchans',plot_chans);

t1 = 240; t2 = 280;
plot_mean = squeeze(mean(erp_group(:,find(t>t1 & t<t2)),2));
figure
topoplot(plot_mean,chanlocs,'maplimits', ...
    [min(plot_mean) max(plot_mean)], 'electrodes','numbers','plotchans',plot_chans);

ERP_uptarg_con_minus_ip(right_hemi,:,:) = ERP_uptarg_conip_no_coh(right_hemi,:,:)-ERP_uptarg_conip_no_coh(left_hemi,:,:);
ERP_righttarg_con_minus_ip(right_hemi,:,:) = ERP_righttarg_conip_no_coh(right_hemi,:,:)-ERP_righttarg_conip_no_coh(left_hemi,:,:);

figure
plottopo(ERP_uptarg_con_minus_ip(:,:,:),'chanlocs',chanlocs,'limits',[t(1) t(end) ...
    min(min(min(ERP_uptarg_con_minus_ip(plot_chans,:,:))))  max(max(max(ERP_uptarg_con_minus_ip(plot_chans,:,:))))], ...
    'title',['Contra minus ipsi upwards targets'],'legend',{'90 deg (up)','60 deg','30 deg','0 deg (right)'},'showleg','on','ydir',1)

figure
plottopo(ERP_righttarg_con_minus_ip(:,:,:),'chanlocs',chanlocs,'limits',[t(1) t(end) ...
    min(min(min(ERP_righttarg_con_minus_ip(plot_chans,:,:))))  max(max(max(ERP_righttarg_con_minus_ip(plot_chans,:,:))))], ...
    'title',['Contra minus ipsi rightwards targets'],'legend',{'90 deg (up)','60 deg','30 deg','0 deg (right)'},'showleg','on','ydir',1)

return
ERP_uptarg_conip_high_coh = squeeze(mean(ERP_uptarg_conip(:,:,2,:),3));
ERP_righttarg_conip_high_coh = squeeze(mean(ERP_righttarg_conip(:,:,2,:),3));

figure
plottopo(ERP_uptarg_conip_high_coh(:,:,:),'chanlocs',chanlocs,'limits',[t(1) t(end) ...
    min(min(min(ERP_uptarg_conip_high_coh(plot_chans,:,:))))  max(max(max(ERP_uptarg_conip_high_coh(plot_chans,:,:))))], ...
    'title',['Contra and ipsi upwards targets, high coh'],'legend',{'90 deg (up)','60 deg','30 deg','0 deg (right)'},'showleg','on','ydir',1)

figure
plottopo(ERP_righttarg_conip_high_coh(:,:,:),'chanlocs',chanlocs,'limits',[t(1) t(end) ...
    min(min(min(ERP_righttarg_conip_high_coh(plot_chans,:,:))))  max(max(max(ERP_righttarg_conip_high_coh(plot_chans,:,:))))], ...
    'title',['Contra and ipsi rightwards targets, high coh'],'legend',{'90 deg (up)','60 deg','30 deg','0 deg (right)'},'showleg','on','ydir',1)
return
