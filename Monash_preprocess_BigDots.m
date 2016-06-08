% clear
% close all
% clc
% subject_folder = {'DD1M'};
% allsubj = {'DD1M'};
% 
% s = 1;
% blocks = [1:12];
% badchans = [];% POz was crap for the first few trials
% path_temp = 'C:\Users\loughnge\Documents\Motion direction exp\New Direction Experiment\Participants\'; 
% 
% clear paths files matfiles ET_files ET_matfiles; k=0;
% for n=1:length(blocks)
%     k=k+1;
%     paths{k} = [path_temp subject_folder{s} '\'];
%     files{k} = [allsubj{s} num2str(blocks(n)) '.vhdr'];    
%     matfiles{k} = [path_temp subject_folder{s} '\' allsubj{s} num2str(blocks(n)) '.mat'];
%     ET_files{k}=[path_temp 'SamplesAndEvents_combined\' allsubj{s} num2str(blocks(n)) '.asc'];
%     ET_matfiles{k} = [path_temp subject_folder{s} '\' allsubj{s} num2str(blocks(n)) '_ET.mat'];
% end

% for i = 1:length(conditiondescrip)
%     disp(conditiondescrip{i})
% end
% Trigger 1: coherence 30, motion dir 90, ITI 2.125, patch 1
% Trigger 2: coherence 30, motion dir 60, ITI 2.125, patch 1
% Trigger 3: coherence 30, motion dir 30, ITI 2.125, patch 1
% Trigger 4: coherence 30, motion dir 0, ITI 2.125, patch 1
% Trigger 5: coherence 30, motion dir 90, ITI 2.125, patch 2
% Trigger 6: coherence 30, motion dir 60, ITI 2.125, patch 2
% Trigger 7: coherence 30, motion dir 30, ITI 2.125, patch 2
% Trigger 8: coherence 30, motion dir 0, ITI 2.125, patch 2
% Trigger 9: coherence 30, motion dir 90, ITI 2.975, patch 1
% Trigger 10: coherence 30, motion dir 60, ITI 2.975, patch 1
% Trigger 11: coherence 30, motion dir 30, ITI 2.975, patch 1
% Trigger 12: coherence 30, motion dir 0, ITI 2.975, patch 1
% Trigger 13: coherence 30, motion dir 90, ITI 2.975, patch 2
% Trigger 14: coherence 30, motion dir 60, ITI 2.975, patch 2
% Trigger 15: coherence 30, motion dir 30, ITI 2.975, patch 2
% Trigger 16: coherence 30, motion dir 0, ITI 2.975, patch 2
% Trigger 17: coherence 30, motion dir 90, ITI 3.825, patch 1
% Trigger 18: coherence 30, motion dir 60, ITI 3.825, patch 1
% Trigger 19: coherence 30, motion dir 30, ITI 3.825, patch 1
% Trigger 20: coherence 30, motion dir 0, ITI 3.825, patch 1
% Trigger 21: coherence 30, motion dir 90, ITI 3.825, patch 2
% Trigger 22: coherence 30, motion dir 60, ITI 3.825, patch 2
% Trigger 23: coherence 30, motion dir 30, ITI 3.825, patch 2
% Trigger 24: coherence 30, motion dir 0, ITI 3.825, patch 2
% Trigger 25: coherence 60, motion dir 90, ITI 2.125, patch 1
% Trigger 26: coherence 60, motion dir 60, ITI 2.125, patch 1
% Trigger 27: coherence 60, motion dir 30, ITI 2.125, patch 1
% Trigger 28: coherence 60, motion dir 0, ITI 2.125, patch 1
% Trigger 29: coherence 60, motion dir 90, ITI 2.125, patch 2
% Trigger 30: coherence 60, motion dir 60, ITI 2.125, patch 2
% Trigger 31: coherence 60, motion dir 30, ITI 2.125, patch 2
% Trigger 32: coherence 60, motion dir 0, ITI 2.125, patch 2
% Trigger 33: coherence 60, motion dir 90, ITI 2.975, patch 1
% Trigger 34: coherence 60, motion dir 60, ITI 2.975, patch 1
% Trigger 35: coherence 60, motion dir 30, ITI 2.975, patch 1
% Trigger 36: coherence 60, motion dir 0, ITI 2.975, patch 1
% Trigger 37: coherence 60, motion dir 90, ITI 2.975, patch 2
% Trigger 38: coherence 60, motion dir 60, ITI 2.975, patch 2
% Trigger 39: coherence 60, motion dir 30, ITI 2.975, patch 2
% Trigger 40: coherence 60, motion dir 0, ITI 2.975, patch 2
% Trigger 41: coherence 60, motion dir 90, ITI 3.825, patch 1
% Trigger 42: coherence 60, motion dir 60, ITI 3.825, patch 1
% Trigger 43: coherence 60, motion dir 30, ITI 3.825, patch 1
% Trigger 44: coherence 60, motion dir 0, ITI 3.825, patch 1
% Trigger 45: coherence 60, motion dir 90, ITI 3.825, patch 2
% Trigger 46: coherence 60, motion dir 60, ITI 3.825, patch 2
% Trigger 47: coherence 60, motion dir 30, ITI 3.825, patch 2
% Trigger 48: coherence 60, motion dir 0, ITI 3.825, patch 2

%% CSD
% E = textread('C:\Program Files\MATLAB\R2015b\toolbox\CSDtoolbox\chans64_monash.asc','%s');
% M = ExtractMontage('C:\Program Files\MATLAB\R2015b\toolbox\CSDtoolbox\10-5-System_Mastoids_EGI129.csd',E);  % reading in the montage for the CSD toolbox
% MapMontage(M);
% pause(1)
% [G3,H3] = GetGH(M);

%%
targcodes = [101:148];

fs = 500; % new sample rate

ts = -0.2*fs:1.500*fs;
t = ts*1000/fs;

BLint = [-200 0];   % baseline interval in ms
default_response_time = 1.400;

ERP_samps = length(ts);

nchan = 64;

%% Filters
LPFcutoff_35Hz=35;       % Low Pass Filter cutoff
LPFcutoff_20Hz=20;       % Low Pass Filter cutoff
LPFcutoff_8Hz=8;       % Low Pass Filter cutoff

HPFcutoff=0.01;       % High Pass Filter cutoff
[H_HP1,G_HP1]=butter(4,(0.5*2)/fs,'high');   % 0.5 Hz low cutoff
[H_HP2,G_HP2]=butter(4,(HPFcutoff*2)/fs,'high');   % 0.25 Hz low cutoff

LPF = 1;    % 1 = low-pass filter the data, 0=don't.
HPF = 0;

%%
ARchans = [1:64];  % just the ones we care about, and RH opposite LH to be symmetric
% % ARchans([17,22,28,32,41,46]) = []; % if we want to get rid of needless
% % channels, but bear in mind find will find with incorrect index, would
% % need to check...

artifth = 100;
artifchans=[];  % keep track of channels on which the threshold is exceeded, causing trial rejection

chanlocs_TCD = readlocs('cap64.loc');
% chanlocs_TCD = rmfield(chanlocs_TCD,{'sph_theta_besa','sph_phi_besa'});
chanlocs_Monash = readlocs('actiCAP64_ThetaPhi.elp','filetype','besa'); %DN for actiCAP
% chanlocs_Monash = rmfield(chanlocs_Monash,{'type','sph_radius'});
% chanlocs_Monash = orderfields(chanlocs_Monash,chanlocs_TCD);
% chanlocs_Monash = [chanlocs_Monash,chanlocs_TCD(47)];
chanlocs = chanlocs_Monash;

numtr=0; rejected_trials = 0; artif_ET_trials = 0; respHand = [];
allRT=[]; allrespLR=[]; allTrig=[]; targMotion = []; allblock_count = [];
erp_LPF_8Hz = []; erp_LPF_35Hz = []; erp_LPF_8Hz_CSD = []; erp_LPF_35Hz_CSD = []; ET_trials = [];

for f=1:length(files)
    disp(f)
    EEG = pop_loadbv(paths{f},files{f});
    loadbvSK_DN % this takes 65 channels, haven't quite worked this out yet wrt combining with TCD data
    EEG = letterkilla_old(EEG); %DN: removes the letters that Brain Products appends to the triggers
    EEG.data = double(EEG.data(1:nchan,:));
    
    load(matfiles{f},'trialCond','par');
    trialCond = trialCond+100;
    if par.responsehand==1, resp_trig = 12; non_resp_trig = 13; else resp_trig = 13; non_resp_trig = 12; end

    if ~exist(ET_matfiles{f}, 'file') %DN: if ET matfile NOT been saved        
        FixEyelinkMessages %then calculate and save it now
    end   
    
    numev = length(EEG.event);
    % Fish out the event triggers and times
    clear trigs stimes
    for i=1:numev
        trigs(i)=EEG.event(i).type;
        stimes(i)=round(EEG.event(i).latency);
    end
        
    % interpolate bad channels
    if ~isempty(badchans)
        EEG.chanlocs = chanlocs;
        EEG=eeg_interp(EEG,[badchans],'spherical');
    end
    
    % ET stuff
    load(ET_matfiles{f}) %DN: load the ET mat file
    %Add an extra 4 rows into the EEG struct - 'TIME'    
    %'GAZE_X' 'GAZE_Y' 'AREA'. This will add these as extra channels onto %EEG.data. So the final channel is the pupil area (i.e. diameter):   
    EEG_temp = pop_importeyetracker(EEG,ET_matfiles{f},[first_event ...
        last_event],[1:4] ,{'TIME' 'GAZE_X' 'GAZE_Y' 'AREA'},0,1,0,1);
    close
    ET_data = EEG_temp.data([nchan+1:nchan+4],:);
%     scres = 1280 x 1024: 640,512 is middle
%     temp = ET_data([2,3],[stimes(1):end]); ET_data_mean(1) = mean(temp(1,find(temp(1,:)>0)),2); ET_data_mean(2) = mean(temp(2,find(temp(2,:)>0)),2);
%     ET_data(2,find(ET_data(2,:)>0)) = ET_data(2,find(ET_data(2,:)>0))-ET_data_mean(1)+640;
%     ET_data(3,find(ET_data(3,:)>0)) = ET_data(3,find(ET_data(3,:)>0))-ET_data_mean(2)+512;
    clear EEG_temp
    pause(1)
    
    EEG_LPF_8Hz = EEG;
    EEG_LPF_35Hz = EEG;
    % First LP Filter
    if LPF
        EEG_LPF_8Hz.data = eegfilt(EEG_LPF_8Hz.data,fs,0,LPFcutoff_8Hz); 
        EEG_LPF_35Hz.data = eegfilt(EEG_LPF_35Hz.data,fs,0,LPFcutoff_35Hz); 
    end
        
    if HPF 
        EEG_LPF_8Hz.data = double(EEG_LPF_8Hz.data(1:nchan,:));
        EEG_LPF_35Hz.data = double(EEG_LPF_35Hz.data(1:nchan,:));
        EEG_LPF_8Hz.data = filtfilt(H_HP2,G_HP2,EEG_LPF_8Hz.data')';
        EEG_LPF_35Hz.data = filtfilt(H_HP2,G_HP2,EEG_LPF_35Hz.data')';
        disp('HPF finished')
    end
    
    % average-reference the whole continuous data (safe to do this now after interpolation):
    EEG_LPF_8Hz.data = EEG_LPF_8Hz.data - repmat(mean(EEG_LPF_8Hz.data(:,:),1),[nchan,1]);
    EEG_LPF_35Hz.data = EEG_LPF_35Hz.data - repmat(mean(EEG_LPF_35Hz.data(:,:),1),[nchan,1]);
    EEG = EEG_LPF_35Hz;
%     pop_eegplot(EEG,1,0,0);
%     keyboard
    
    targtrigs = [];
    for n=1:length(trigs)
        if any(targcodes(:)==trigs(n))
            targtrigs = [targtrigs n];
        end
    end
    
    if trigs(targtrigs(end))==trialCond(1)
        motion_on = targtrigs(1:end); % GL: indices of trigs when motion on. get rid of last trig, it was a repeat
    else
        motion_on = targtrigs;
    end
        
    for n=1:length(motion_on)
        clear ep_LPF_8Hz ep_LPF_35Hz ep_LPF_8Hz_CSD ep_LPF_35Hz_CSD
        locktime = stimes(motion_on(n));
        if motion_on(n)<length(trigs)
            if trigs(motion_on(n)+1)==resp_trig
                response_time = stimes(motion_on(n)+1)-locktime; % time in samples from beginning of motion to response.
                response_time = floor(response_time);
                if response_time>default_response_time*fs
                    response_time = default_response_time*fs;
                end
            else
                response_time = default_response_time*fs;
            end
        else
            response_time = default_response_time*fs;
        end
        try
            ep_LPF_8Hz = EEG_LPF_8Hz.data(:,locktime+ts);   % chop out an epoch
            ep_LPF_35Hz = EEG_LPF_35Hz.data(:,locktime+ts);
            ep_ET = ET_data(:,locktime+ts);
        catch
            disp('EEG ended too soon2')
            numtr = numtr+1;
            allTrig(numtr) = 0;
            targMotion(numtr) = 0;
            allblock_count(numtr) = f;
            allrespLR(numtr) = 0;
            allRT(numtr) = 0;
            respHand(numtr) = 0;
            
            erp_LPF_8Hz(:,:,numtr) = zeros(nchan,ERP_samps);
            erp_LPF_35Hz(:,:,numtr) = zeros(nchan,ERP_samps);
            erp_LPF_8Hz_CSD(:,:,numtr) = zeros(nchan,ERP_samps);
            erp_LPF_35Hz_CSD(:,:,numtr) = zeros(nchan,ERP_samps);
            ET_trials(:,:,numtr) = zeros(4,ERP_samps);
            
            rejected_trials = rejected_trials+1;
            %             keyboard
            continue;
        end
        BLamp = mean(ep_LPF_8Hz(:,find(ts==-0.2*fs):find(ts==0*fs)),2); % record baseline amplitude (t<0) for each channel, ONLY FOR ART REJECT
        ep_LPF_8Hz = ep_LPF_8Hz - repmat(BLamp,[1,length(t)]); % baseline correction
        
        BLamp = mean(ep_LPF_35Hz(:,find(ts==-0.2*fs):find(ts==0*fs)),2); % record baseline amplitude (t<0) for each channel, ONLY FOR ART REJECT
        ep_LPF_35Hz = ep_LPF_35Hz - repmat(BLamp,[1,length(t)]);
        
        ep_test = [find(ts<=(response_time+0.1*fs))];
        if isempty(ep_test)
            disp('Empty epoch for art rejection')
            keyboard
        end
        
        artifchans_thistrial = ARchans(find(max(abs(ep_LPF_35Hz(ARchans,find(ts<=(response_time+0.1*fs)))),[],2)>artifth));
        artifchans = [artifchans artifchans_thistrial];
        
        % scres = 1280 x 1024: 640,512 is middle
%         artif_ET = find(ep_ET(2,find(ts<=(response_time+0.1*fs)))<640-200 | ep_ET(2,find(ts<=(response_time+0.1*fs)))>640+200);
            
%         if length(artif_ET)>0
%             artif_ET_trials = artif_ET_trials + 1
% %             figure
% %             plot(squeeze(ep_ET(2,:)),squeeze(ep_ET(3,:))), hold on
% %             line([640-200,640+200],[512-200,512-200])
% %             line([640-200,640+200],[512+200,512+200])
% %             line([640-200,640-200],[512-200,512+200])
% %             line([640+200,640+200],[512+200,512-200])
% %             set(gca,'xlim',[0 1280],'ylim',[0 1024])
% %             title(['Trial ',num2str(n)])
% %             pause(1)
% %             figure
% %             plot(t,squeeze(ep_ET(2,:)))
% %             keyboard
%         end
        
        if length(artifchans_thistrial) > 0 %| length(artif_ET)>0
%             figure, plot(ep_LPF_35Hz(artifchans_thistrial(1),:))
%             keyboard
%             figure, plot(ep_art_reject(artifchans_thistrial,:)'); %keyboard
            numtr = numtr+1;
            allTrig(numtr) = 0;
            targMotion(numtr) = 0;
            allblock_count(numtr) = f;
            allrespLR(numtr) = 0;
            allRT(numtr) = 0;
            respHand(numtr) = 0;
            
            erp_LPF_8Hz(:,:,numtr) = zeros(nchan,ERP_samps);
            erp_LPF_35Hz(:,:,numtr) = zeros(nchan,ERP_samps);
            erp_LPF_8Hz_CSD(:,:,numtr) = zeros(nchan,ERP_samps);
            erp_LPF_35Hz_CSD(:,:,numtr) = zeros(nchan,ERP_samps);
            ET_trials(:,:,numtr) = zeros(4,ERP_samps);
            
            rejected_trials = rejected_trials+1
            continue ;
        end   % artifact rejection (threshold test)
            
        ep_LPF_8Hz = double(ep_LPF_8Hz);
        ep_LPF_35Hz = double(ep_LPF_35Hz);
        
        ep_LPF_8Hz_CSD = CSD(ep_LPF_8Hz,G3,H3);
        ep_LPF_35Hz_CSD = CSD(ep_LPF_35Hz,G3,H3);
        
        numtr = numtr+1;
        erp_LPF_8Hz(:,:,numtr) = ep_LPF_8Hz;
        erp_LPF_35Hz(:,:,numtr) = ep_LPF_35Hz;
        erp_LPF_8Hz_CSD(:,:,numtr) = ep_LPF_8Hz_CSD;
        erp_LPF_35Hz_CSD(:,:,numtr) = ep_LPF_35Hz_CSD;
        ET_trials(:,:,numtr) = ep_ET(:,:);
        
        allTrig(numtr) = trigs(motion_on(n));
        targMotion(numtr) = par.target_motion;
        allblock_count(numtr) = f;
        respHand(numtr) = par.responsehand;
        try % change this
            if trigs(motion_on(n)+1)==resp_trig
                allrespLR(numtr) = 1; % NB: allrespLR here means correct/incorrect button.
                allRT(numtr) = stimes(motion_on(n)+1)-stimes(motion_on(n));
            elseif trigs(motion_on(n)+1)==non_resp_trig % they pressed the wrong button
                allrespLR(numtr) = 2;
                allRT(numtr) = stimes(motion_on(n)+1)-stimes(motion_on(n));
            else
                allrespLR(numtr) = 3; % no response, to mark it out from artifact trials.
                allRT(numtr) = 0;
            end
        catch
            allrespLR(numtr) = 0;
            allRT(numtr) = 0;
        end
    end
end

% load(['C:\Users\loughnge\Documents\Motion direction exp\New Direction Experiment\Participants\DD13M\DD13MDD_erp'],'artifchans','allRT')
% figure;
% hist(artifchans,[1:64]); title([num2str(length(find(allRT==0))) ' artifacts'])

figure;
hist(artifchans,[1:nchan]); title([allsubj{s} ': ' num2str(rejected_trials) ' artifacts = ',num2str(round(100*(rejected_trials/length(allRT)))),'%']) % s from runafew
disp([allsubj{s},' number of trials: ',num2str(length(find(allRT)))])

[counts,centers] = hist(artifchans,[1:nchan]);
figure;
topoplot(counts,chanlocs,'plotchans',[1:nchan],'electrodes','numbers');
title(subject_folder{s})
pause(1)

for i = 1:64
    disp([num2str(i) ' = ' chanlocs_Monash(1,i).labels])
end

counter = 1;
counter2 = 1;
for elec_Monash = 1:64
    yesser = 0;
    for elec_TCD = 1:64
        if strcmp(chanlocs_TCD(1,elec_TCD).labels,chanlocs_Monash(1,elec_Monash).labels)
            order_TCD(counter) = elec_TCD;
            order_Monash(counter) = elec_Monash;
            counter = counter+1;
            yesser = 1;
        end
    end
    if yesser==0
        unmatched_elecs_Monash(counter2) = elec_Monash;
        counter2 = counter2+1;
    end
end
% tester = zeros(64,1);
% figure
% topoplot(tester,chanlocs_Monash,'maplimits', ...
%     [min(tester)  max(tester)],'electrodes','numbers');
% figure
% topoplot(tester,chanlocs_Monash,'maplimits', ...
%     [min(tester)  max(tester)],'electrodes','labels');

erp_LPF_8Hz_TCD = single(zeros(size(erp_LPF_8Hz)));
erp_LPF_8Hz_TCD(order_TCD,:,:) = erp_LPF_8Hz(order_Monash,:,:);
erp_LPF_8Hz = erp_LPF_8Hz_TCD;

erp_LPF_35Hz_TCD = single(zeros(size(erp_LPF_35Hz)));
erp_LPF_35Hz_TCD(order_TCD,:,:) = erp_LPF_35Hz(order_Monash,:,:);
erp_LPF_35Hz = erp_LPF_35Hz_TCD;
    
erp_LPF_8Hz_CSD_TCD = single(zeros(size(erp_LPF_8Hz_CSD)));
erp_LPF_8Hz_CSD_TCD(order_TCD,:,:) = erp_LPF_8Hz_CSD(order_Monash,:,:);
erp_LPF_8Hz_CSD = erp_LPF_8Hz_CSD_TCD;

erp_LPF_35Hz_CSD_TCD = single(zeros(size(erp_LPF_35Hz_CSD)));
erp_LPF_35Hz_CSD_TCD(order_TCD,:,:) = erp_LPF_35Hz_CSD(order_Monash,:,:);
erp_LPF_35Hz_CSD = erp_LPF_35Hz_CSD_TCD;

note = 'Trials not eliminated by eyetracker yet';
reorganised = 1;
save([path_temp subject_folder{s} '\' allsubj{s} 'DD_erp'],'erp_LPF_8Hz','erp_LPF_35Hz','erp_LPF_8Hz_CSD','erp_LPF_35Hz_CSD', ...
    'allRT','allrespLR','allTrig','targMotion','respHand','allblock_count','artifchans','t','ET_data','ET_trials','note','reorganised')
return;