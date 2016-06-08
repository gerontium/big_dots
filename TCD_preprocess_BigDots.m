clear
close all
clc
subject_folder = {'AR_08_04_14'};
allsubj = {'AR'};

s = 1;
blocks = [1:16];
badchans = [15,43];
path_temp = 'D:\Participant Folders_new\';

clear files matfiles ET_files ET_matfiles; k=0;
for n=1:length(blocks)
    k=k+1;
    files{k} = [path_temp subject_folder{s} '\' allsubj{s} '_' num2str(blocks(n)) '.bdf'];
    matfiles{k} = [path_temp subject_folder{s} '\' allsubj{s} '_' num2str(blocks(n)) '.mat'];
    ET_files{k} = [path_temp 'Samples_and_Events\' allsubj{s} '_' num2str(blocks(n)) '.asc'];
    ET_matfiles{k} = [path_temp subject_folder{s} '\' allsubj{s} '_' num2str(blocks(n)) '_ET.mat'];
end

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

%% CSD

E = textread('chans64.asc','%s');
M = ExtractMontage('10-5-System_Mastoids_EGI129.csd',E);  % reading in the montage for the CSD toolbox
% MapMontage(M);
[G_CSD,H_CSD] = GetGH(M);

%% Time

targcodes = [101:106];
nchan = 64;

fs = 500; % new sample rate

ts = -0.5*fs:1.800*fs;
t = ts*1000/fs;

BL_time = [-100 0];   % baseline interval in ms
default_response_time = 1.700;

ERP_samps = length(ts);

%% Filters

LPFcutoff_35Hz=35;       % Low Pass Filter cutoff
LPFcutoff_8Hz=8;       % Low Pass Filter cutoff

HPFcutoff=0.1;       % High Pass Filter cutoff

LPF = 1;    % 1 = low-pass filter the data, 0=don't.
HPF = 0;

%% Artifact rejection

ARchans = [1:64];  % just the ones we care about, and RH opposite LH to be symmetric
artifth = 100;
artifchans=[];  % keep track of channels on which the threshold is exceeded, causing trial rejection

chanlocs = readlocs('cap64.loc');
chanlocs = chanlocs(1:nchan)';

%% Initialise
% # % Make sure all initialised
numtr=0;
allRT=[]; allrespLR=[]; allTrig=[]; allblock_count = [];
erp_LPF_8Hz = []; erp_LPF_35Hz = []; erp_LPF_8Hz_CSD = []; erp_LPF_35Hz_CSD = [];
artifchans_pretarg = []; artifchans_BL_resp = []; artifchans_resp = []; artifchans_1000ms = [];

%% Begin loop

for f=1:length(files)
    disp(f)
    filename=[files{f}];
    EEG = pop_biosig(filename, 'blockepoch', 'off','channels',[1:nchan]);
    EEG.data = double(EEG.data);
    
    load(matfiles{f},'trialCond','par');
    if par.cohLevels~=50
        disp(['Coh discrepancy: Coh = ',num2str(par.cohLevels)])
        keyboard
    end
    trialCond = trialCond+100;
    
    if ~exist(ET_matfiles{f}, 'file') %DN: if ET matfile NOT been saved        
        FixEyelinkMessages %then calculate and save it now 
    end   
    
    EEG2 = pop_resample(EEG,fs);
    resamp_data = [];
    for elec = 1:size(EEG.data,1)
        resamp_data(elec,:) = resample(EEG.data(elec,:),500,512,0);
    end
    EEG.data = resamp_data;
    EEG.pnts = EEG2.pnts;
    EEG.times = EEG2.times;
    EEG.srate = EEG2.srate;
    if size(resamp_data,2)~=EEG.pnts
        disp('Resample size mismatch')
        keyboard
    end
    
    numev = length(EEG2.event);
    % Fish out the event triggers and times
    clear trigs stimes
    for i=1:numev
        trigs(i)=EEG2.event(i).type;
        stimes(i)=round(EEG2.event(i).latency);
    end
    clear EEG2 % unnecessary now
        
    % interpolate bad channels
    if ~isempty(badchans)
        EEG.chanlocs = chanlocs;
        EEG=eeg_interp(EEG,[badchans],'spherical');
    end
    
    % ET stuff
    load(ET_matfiles{f}) %DN: load the ET mat file
    plotter = 1; % plot for now
    %Add an extra 4 rows into the EEG struct - 'TIME'    
    %'GAZE_X' 'GAZE_Y' 'AREA'. This will add these as extra channels onto %EEG.data. So the final channel is the pupil area (i.e. diameter):   
    EEG_temp = pop_importeyetracker(EEG,ET_matfiles{f},[first_event ...
        last_event],[1:4] ,{'TIME' 'GAZE_X' 'GAZE_Y' 'AREA'},0,1,0,plotter);
    
    ET_data = EEG_temp.data([nchan+1:nchan+4],:);
%     scres = 1280 x 1024: 640,512 is middle
%     temp = ET_data([2,3],[stimes(1):end]); ET_data_mean(1) = mean(temp(1,find(temp(1,:)>0)),2); ET_data_mean(2) = mean(temp(2,find(temp(2,:)>0)),2);
%     ET_data(2,find(ET_data(2,:)>0)) = ET_data(2,find(ET_data(2,:)>0))-ET_data_mean(1)+640;
%     ET_data(3,find(ET_data(3,:)>0)) = ET_data(3,find(ET_data(3,:)>0))-ET_data_mean(2)+512;
    clear EEG_temp
    pause(1)

    % Check fft for mains frequencies etc
%     ep = squeeze(EEG.data(31,:)); % time
%     nfft = size(ep,2);
%     fftx = abs(fft(ep,[],2))./(nfft/2);
%     fftx = fftx(:,1:ceil((nfft+1)/2));
%     freq_temp = (0:ceil((nfft+1)/2)-1)*fs/nfft;
%     figure, plot(freq_temp,fftx)

    % Get rid of mains frequency
    EEG = pop_eegfiltnew(EEG,49,51,[],1,0,0,0);
    EEG_LPF_8Hz = EEG; EEG_LPF_35Hz = EEG; clear EEG;
    
    % First LP Filter
    if LPF
        EEG_LPF_8Hz = pop_eegfiltnew(EEG_LPF_8Hz,0,LPFcutoff_8Hz,[]);
        EEG_LPF_35Hz = pop_eegfiltnew(EEG_LPF_35Hz,0,LPFcutoff_35Hz,[]);
    end

    % First HP Filter
    if HPF 
        EEG_LPF_8Hz = pop_eegfiltnew(EEG_LPF_8Hz,HPFcutoff,0,[]); % filter to 0.1Hz 
        EEG_LPF_35Hz = pop_eegfiltnew(EEG_LPF_35Hz,HPFcutoff,0,[]); % filter to 0.1Hz 
        disp('HPF finished')
    end
    
    % average-reference the whole continuous data (safe to do this now after interpolation and filtering):
    EEG_LPF_8Hz.data = EEG_LPF_8Hz.data - repmat(mean(EEG_LPF_8Hz.data(:,:),1),[nchan,1]);
    EEG_LPF_35Hz.data = EEG_LPF_35Hz.data - repmat(mean(EEG_LPF_35Hz.data(:,:),1),[nchan,1]);
    
    targtrigs = [];
    for n=1:length(trigs)
        if any(targcodes(:)==trigs(n))
            targtrigs = [targtrigs n];
        end
    end
    
    if trigs(targtrigs(end))==trialCond(1)
        motion_on = targtrigs(1:end-1); % GL: indices of trigs when motion on. get rid of last trig, it was a repeat
    else
        motion_on = targtrigs;
    end
        
    for n=1:length(motion_on)
        clear ep_LPF_8Hz ep_LPF_35Hz ep_LPF_8Hz_CSD ep_LPF_35Hz_CSD
        locktime = stimes(motion_on(n));
        if motion_on(n)<length(trigs)
            if trigs(motion_on(n)+1)==12
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
            
            erp_LPF_8Hz(:,:,numtr) = zeros(nchan,ERP_samps);
            erp_LPF_35Hz(:,:,numtr) = zeros(nchan,ERP_samps);
            erp_LPF_8Hz_CSD(:,:,numtr) = zeros(nchan,ERP_samps);
            erp_LPF_35Hz_CSD(:,:,numtr) = zeros(nchan,ERP_samps);
            ET_trials(:,:,numtr) = zeros(4,ERP_samps);
            
            continue;
        end
        
        BLamp = mean(ep_LPF_8Hz(:,find(t>=BL_time(1) & t<BL_time(2))),2); % record baseline amplitude for each channel, ONLY FOR ART REJECT
        ep_LPF_8Hz_BL = ep_LPF_8Hz - repmat(BLamp,[1,length(t)]);
        
        BLamp = mean(ep_LPF_35Hz(:,find(t>=BL_time(1) & t<BL_time(2))),2); % record baseline amplitude for each channel, ONLY FOR ART REJECT
        ep_LPF_35Hz_BL  = ep_LPF_35Hz - repmat(BLamp,[1,length(t)]);
        
        ep_test = [find(ts<=(response_time+0.1*fs))];
        if isempty(ep_test)
            disp('Empty epoch for art rejection')
            keyboard
        end
        
        artifchans_thistrial_pretarg = ARchans(find(max(abs(ep_LPF_35Hz_BL(ARchans,find(ts<=0))),[],2)>artifth));
        
        artifchans_thistrial_BL_resp = ARchans(find(max(abs(ep_LPF_35Hz_BL(ARchans,find(ts>=-0.1 & ts<=(response_time+0.1*fs)))),[],2)>artifth));
        artifchans_thistrial_resp = ARchans(find(max(abs(ep_LPF_35Hz_BL(ARchans,find(ts<=(response_time+0.1*fs)))),[],2)>artifth));
        
        artifchans_thistrial_1000ms = ARchans(find(max(abs(ep_LPF_35Hz_BL(ARchans,find(ts>=-0.1 & ts<=1))),[],2)>artifth));
        
        artifchans_pretarg = [artifchans_pretarg artifchans_thistrial_pretarg];
        artifchans_BL_resp = [artifchans_BL_resp artifchans_thistrial_BL_resp];
        artifchans_resp = [artifchans_resp artifchans_thistrial_resp];
        artifchans_1000ms = [artifchans_1000ms artifchans_thistrial_1000ms];
        
        # % what's 3 deg on screen?
        % scres = 1024 x 768: 512, 384 is middle
        artif_ET = find(ep_ET(2,find(ts<=(response_time+0.1*fs)))<512-70 | ep_ET(2,find(ts<=(response_time+0.1*fs)))>512+70);
            
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
            if trigs(motion_on(n)+1)==12
                allrespLR(numtr) = 1; % NB: allrespLR here means correct/incorrect button.
                allRT(numtr) = stimes(motion_on(n)+1)-stimes(motion_on(n));
            elseif trigs(motion_on(n)+1)==13 % they pressed the wrong button
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

figure;
hist(artifchans,[1:nchan]); title([allsubj{s} ': ' num2str(rejected_trials) ' artifacts = ',num2str(round(100*(rejected_trials/length(allRT)))),'%']) % s from runafew
disp([allsubj{s},' number of trials: ',num2str(length(find(allRT)))])

[counts,centers] = hist(artifchans,[1:nchan]);
figure;
topoplot(counts,chanlocs,'plotchans',[1:nchan],'electrodes','numbers');
title(subject_folder{s})
pause(1)

note = 'eyetrack was not used to eliminate trials';
save([path_temp subject_folder{s} '\' allsubj{s} 'DD_erp'],'erp_LPF_8Hz','erp_LPF_35Hz','erp_LPF_8Hz_CSD','erp_LPF_35Hz_CSD', ...
    'allRT','allrespLR','allTrig','targMotion','respHand','allblock_count','artifchans','t','ET_data','ET_trials','note')
return;