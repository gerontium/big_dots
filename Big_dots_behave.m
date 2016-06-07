clear all
close all
clc

path = 'S:\R-MNHS-SPP\Bellgrove-data\4. Dan Newman\Participant Folders_new\';

% for i = 1:length(conditiondescrip)
%     disp(conditiondescrip{i})
% end
% SW:
% par.patchloc = [-10 -6; 10 -6;]; 1 = lower left, 2 = lower
% right
% Trigger 1: coherence 30, patch 1, motion dir 270, coh motion onset 1800
% Trigger 2: coherence 30, patch 2, motion dir 270, coh motion onset 1800
% Trigger 3: coherence 30, patch 1, motion dir 270, coh motion onset 2800
% Trigger 4: coherence 30, patch 2, motion dir 270, coh motion onset 2800
% Trigger 5: coherence 30, patch 1, motion dir 270, coh motion onset 3800
% Trigger 6: coherence 30, patch 2, motion dir 270, coh motion onset 3800
% Trigger 7: coherence none, patch 1, motion dir none, coh motion onset 3800

% patch,ITI
targcodes = zeros(2,3);
targcodes(1,1) = [101]; % patch 1, ITI 1
targcodes(2,1) = [102]; % patch 2, ITI 1
targcodes(1,2) = [103]; % patch 1, ITI 2
targcodes(2,2) = [104]; % patch 2, ITI 2
targcodes(1,3) = [105]; % patch 1, ITI 3
targcodes(2,3) = [106]; % patch 2, ITI 3

rtlim=[0.2 1.5];

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
allblocks = {[1:8,10:16] [1:9,11:16] [1:3,5:16] [1:2,4:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:9,11:15] ...
    [1:3,5:15] [1:16] [1:16] [1:16] [1:16] [1:16] [1:15] [1:16] [1:16] [1:16] ...
    [1:16] [1:16] [1:16] [1:15,18] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] ...
    [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] ...
    [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] ...
    [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:14,16]...
    [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16] [1:16]...
    [1:16] [1:16] [1:16] [1:16] [1:13,15,16] [1:16] [1:10,11:16] [1:16] [1:16] [1:16]};

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

if ~isempty(duds) && isempty(single_participants)
    subject_folder([duds]) = [];
    allsubj([duds]) = [];
    allblocks([duds]) = [];
end

if ~isempty(single_participants)
    subject_folder = subject_folder(single_participants);
    allsubj = allsubj(single_participants);
    allblocks = allblocks(single_participants);
end

total_numtr = 0;
all_the_trigs = [];
for s=1:length(allsubj)
    all_the_trigs_subj = [];
    disp(['Subject: ',num2str(s)])
    disp(['Subject: ',allsubj{s}])
    blocks = allblocks{s};
    clear paths files matfiles; k=0;
    if ismember(subject_folder{s},TCD_bigdots)
        for n=1:length(blocks)
            k=k+1;
            files{k} = [path subject_folder{s} '\' allsubj{s} '_' num2str(blocks(n)) '.bdf'];
            fs=512;
        end
    elseif strcmp(subject_folder{s},'279M_FT')
        k=k+1;
        paths{k} = [path subject_folder{s} '\'];
        files{k} = [allsubj{s} '1eeg.vhdr'];
        for n=2:length(blocks)
            k=k+1;
            paths{k} = [path subject_folder{s} '\'];
            files{k} = [allsubj{s} num2str(blocks(n)) '.vhdr'];
            fs=500;
        end
    elseif strcmp(subject_folder{s},'234M_SW')
        for n=1:length(blocks)
            k=k+1;
            paths{k} = [path subject_folder{s} '\'];
            if n==10
                files{k} = ['SW5010.vhdr'];
            else
                files{k} = [allsubj{s} num2str(blocks(n)) '.vhdr'];
            end
            fs=500;
        end
    elseif strcmp(subject_folder{s},'484M_AI')
        for n=1:length(blocks)
            k=k+1;
            paths{k} = [path subject_folder{s} '\'];
            files{k} = [allsubj{s},'S', num2str(blocks(n)) '.vhdr'];
            fs=500;
        end
    elseif strcmp(subject_folder{s},'453M_LB')
        for n=1:length(blocks)
            k=k+1;
            paths{k} = [path subject_folder{s} '\'];
            if n==11
            files{k} = [allsubj{s}, '12.vhdr'];
            elseif n==12
                files{k} = [allsubj{s}, '12b.vhdr'];  
            else
                files{k} = [allsubj{s} num2str(blocks(n)) '.vhdr'];
            end
            fs=500;
        end
        
    else
        for n=1:length(blocks)
            k=k+1;
            paths{k} = [path subject_folder{s} '\'];
            files{k} = [allsubj{s} num2str(blocks(n)) '.vhdr'];
            fs=500;
        end
    end
    
    
    nchan = 64;
    
    % chanlocs = readlocs('cap64.loc');
    % chanlocs = readlocs('JBhead96.loc');
    % chanlocs(65:96)=[];
    
    erp = []; numtr=0;
    allRT=[]; allrespLR=[]; allTrig=[]; Correct=[]; RT_all=[]; block_count=[]; intra_block_count=[]; intra_block_count2=[];  % note allRT will be in sample points
    for f=1:length(files)
        trial_start = total_numtr;
        disp(f)
        if ismember(subject_folder{s},TCD_bigdots)
            filename=[files{f}];
            EEG = pop_biosig(filename, 'blockepoch', 'off','channels',[1:nchan]);
        else
            pathname=[paths{f}];
            filename=[files{f}];
            EEG = pop_loadbv(pathname,filename);
            %             EEG = pop_rmdat(EEG, {'boundary'},[0 1] ,1); %DN: this deletes the data from 0 to 1 sec around the DC Correction triggers that BrainVision puts in
            %             for i=1:length([EEG.event.latency]) %DN: round the event latencies back to whole numbers (intergers), because the pop_rmdat line (above) makes non-interger latencies at the points where you kicked out the bad DC Correction data
            %                 EEG.event(i).latency = round([EEG.event(i).latency]);
            %             end
            EEG = letterkilla_old(EEG);
        end
        numchan = EEG.nbchan;
        numev = length(EEG.event);
        % Fish out the event triggers and times
        clear trigs stimes
        for i=1:numev
            trigs(i)=EEG.event(i).type;
            stimes(i)=round(EEG.event(i).latency);
        end
        
        targtrigs = [];
        for n=1:length(trigs)
            if ismember(trigs(n),targcodes)
                targtrigs = [targtrigs n];
            end
        end
        
        motion_on = targtrigs;
        %         all_the_trigs = [all_the_trigs,trialCond];
        %         all_the_trigs_subj = [all_the_trigs_subj,trialCond];
        %         disp(length(motion_on))
        %         figure
        %         plot(trigs(motion_on))
        %         keyboard
        
        %         if length(motion_on)~=49
        %             figure
        %             plot(trigs)
        %             title(['Subject ',allsubj{s},', Block ',num2str(f)])
        %             disp(length(motion_on))
        %             a = trigs(motion_on);
        %             figure
        %             plot(trialCond)
        %             title(['Subject ',allsubj{s},', Block ',num2str(f)])
        %             hold on
        %             plot(a-101,'r')
        %             keyboard
        %         end
        
        % 1 = lower left, 2 = lower right, 3 = upper left, 4 = upper right
        % Participant, block no, total trial no, intra block no, side, coherence,
        % motion, button press, RT, congruence, correct/incorrect/no response.
        for n=1:length(motion_on) % get rid of last trigger?
            numtr = numtr+1;
            total_numtr = total_numtr+1;
            allTrig(numtr) = trigs(motion_on(n));
            
            total_RT_data(total_numtr,1) = s;
            total_RT_data(total_numtr,2) = f;
            total_RT_data(total_numtr,3) = numtr;
            total_RT_data(total_numtr,4) = n;
            
            if ismember(trigs(motion_on(n)),targcodes(1,:)) % any left patch targcode.
                total_RT_data(total_numtr,5) = 1;
            else
                total_RT_data(total_numtr,5) = 2;
            end
            
            if ismember(trigs(motion_on(n)),targcodes(:,1)) % ITI 1.
                total_RT_data(total_numtr,6) = 1;
            elseif ismember(trigs(motion_on(n)),targcodes(:,2)) % ITI 2.
                total_RT_data(total_numtr,6) = 2;
            else
                total_RT_data(total_numtr,6) = 3;
            end
            
            try % change this?
                if trigs(motion_on(n)+1)==12
                    allrespLR(numtr) = 1;
                    allRT(numtr) = stimes(motion_on(n)+1)-stimes(motion_on(n));
                    block_count(numtr) = f;
                    total_RT_data(total_numtr,7) = 1;
                    total_RT_data(total_numtr,8) = (stimes(motion_on(n)+1)-stimes(motion_on(n)))*1000/fs;
                    total_RT_data(total_numtr,9) = 1; % correct.
                else
                    allrespLR(numtr) = 0;
                    allRT(numtr) = 0;
                    block_count(numtr) = f;
                    total_RT_data(total_numtr,7) = 0;
                    total_RT_data(total_numtr,8) = 0;
                    total_RT_data(total_numtr,9) = 3; % no_response.
                end
            catch ME
                %                 ME
                %                 figure
                %                 plot(trigs)
                %                 title(['Subject ',allsubj{s},', Block ',num2str(f)])
                %                 disp(['Weird trigger in block: ',num2str(f),' at ',num2str(n)])
                %                 disp(length(motion_on))
                %                 a = trigs(motion_on);
                %                 figure
                %                 plot(trialCond)
                %                 title(['Subject ',allsubj{s},', Block ',num2str(f)])
                %                 hold on
                %                 plot(a-101,'r')
                %                 keyboard
                allrespLR(numtr) = 3;
                allRT(numtr) = 0;
                block_count(numtr) = f;
                total_RT_data(total_numtr,7) = 0;
                total_RT_data(total_numtr,8) = 0;
                total_RT_data(total_numtr,9) = 4; % weird trig.
            end
        end
        
        blockdiv = floor(length(trial_start+1:total_numtr)/2);
        total_RT_data(trial_start+1:trial_start+blockdiv,10) = 1;
        total_RT_data(trial_start+blockdiv+1:end,10) = 2;
        
        intra_block_temp = total_RT_data(trial_start+1:end,10)';
        intra_block_count = [intra_block_count,intra_block_temp];
    end
    
    % 1 = lower left, 2 = lower right
    for patch = 1:2
        for i = 1:3
            for block = 1:2
                conds1{s,patch,i,block} = find(allTrig==targcodes(patch,i) & allrespLR==1 & allRT>rtlim(1)*fs & allRT<rtlim(2)*fs & intra_block_count==block);
                RTs1{s,patch,i,block} = allRT(conds1{s,patch,i,block})*1000/fs;
            end
        end
    end
    
    allRT_subject_filt = zeros(1,length(allRT));
    allRT_subject = allRT([conds1{s,:,:,:}])*1000/fs;
    allRT_zscores = zscore(log(allRT_subject));
    allRT_subject_filt([conds1{s,:,:,:}]) = allRT_zscores;
    
    for patch = 1:2
        for i = 1:3
            for block = 1:2
                conds{s,patch,i,block} = find(allTrig==targcodes(patch,i) & allrespLR==1 & allRT>rtlim(1)*fs & allRT<rtlim(2)*fs & intra_block_count==block & ...
                    allRT_subject_filt>-3 & allRT_subject_filt<3);
                RTs{s,patch,i,block} = allRT(conds{s,patch,i,block})*1000/fs;
            end
            total_conds{s,patch,i} = find(allTrig==targcodes(patch,i));
        end
    end
    
    disp(['Subject ',allsubj{s},' Total Valid Trials: ',num2str(length([conds{s,:,:,:}])),' = ',num2str(round(100*length([conds{s,:,:,:}])/(18*16))),'%'])
    disp(['Subject ',allsubj{s},' Total Left Trials: ',num2str(length([conds{s,1,:,:}])),' = ',num2str(round(100*length([conds{s,1,:,:}])/length([total_conds{s,1,:,:}]))),'%'])
    disp(['Subject ',allsubj{s},' Total Right Trials: ',num2str(length([conds{s,2,:,:}])),' = ',num2str(round(100*length([conds{s,2,:,:}])/length([total_conds{s,2,:,:}]))),'%'])
    
    RT_index(s) = (mean([RTs{s,1,:,:}])-mean([RTs{s,2,:,:}]))/((mean([RTs{s,1,:,:}])+mean([RTs{s,2,:,:}]))/2);
    RT_left(s)=mean([RTs{s,1,:,:}]);
    RT_right(s)=mean([RTs{s,2,:,:}]);
    
    for block = 1:2
        RT_index_blocks(s,block) = (mean([RTs{s,1,:,block}])-mean([RTs{s,2,:,block}]))/((mean([RTs{s,1,:,block}])+mean([RTs{s,2,:,block}]))/2);
    end
    for ITI = 1:3
        RT_index_ITIs(s,ITI) = (mean([RTs{s,1,ITI,:}])-mean([RTs{s,2,ITI,:}]))/((mean([RTs{s,1,ITI,:}])+mean([RTs{s,2,ITI,:}]))/2);
    end
    for block = 1:2
        for ITI = 1:3
            RT_index_ITI_blocks(s,ITI,block) = (mean([RTs{s,1,ITI,block}])-mean([RTs{s,2,ITI,block}]))/((mean([RTs{s,1,ITI,block}])+mean([RTs{s,2,ITI,block}]))/2);
        end
    end
    disp('---------------------------------------------')
    disp(['RT Index: ',num2str(RT_index(s))])
    disp('---------------------------------------------')
end
disp(['Mean RT index: ',num2str(mean(RT_index))])
[h2,p2,ci,stats] = ttest(RT_index);
disp(['T-test results: ',num2str(h2),'. p = ',num2str(p2)])

disp(['Number of left biased: ',num2str(length(find(RT_index<=-0.005)))])
disp(['Number of no bias: ',num2str(length(find(RT_index>-0.005 & RT_index<0.005)))])
disp(['Number of right biased: ',num2str(length(find(RT_index>=0.005)))])

final_column = [RT_index_ITI_blocks(:,1,1),RT_index_ITI_blocks(:,2,1),RT_index_ITI_blocks(:,3,1), ...
    RT_index_ITI_blocks(:,1,2),RT_index_ITI_blocks(:,2,2),RT_index_ITI_blocks(:,3,2)]; % ITI, Block, Vert

% RT_index2 = RT_index([1:21,26:33]);
% disp(['Mean RT index: ',num2str(mean(RT_index2))])
% [h2,p2,ci,stats] = ttest(RT_index2);
% disp(['T-test results: ',num2str(h2),'. p = ',num2str(p2)])

figure
bar(RT_index)
figure
bar(zscore(RT_index))
% ITI = 1, Block = 1, Vert = 1
% ITI = 2, Block = 1, Vert = 1
% ITI = 3, Block = 1, Vert = 1
% ITI = 1, Block = 2, Vert = 1
% ITI = 2, Block = 2, Vert = 1
% ITI = 3, Block = 2, Vert = 1

% close all
% for s = 1:length(allsubj)
%     figure
%     plot(upper_RT_index_blocks(s,:)), hold on
%     plot(lower_RT_index_blocks(s,:),'r')
%     title(allsubj{s})
% end

subject_folder=subject_folder'; open subject_folder
RT_index=RT_index'; open RT_index
RT_left=RT_left'; open RT_left
RT_right=RT_right'; open RT_right

save('RT_temp.mat')