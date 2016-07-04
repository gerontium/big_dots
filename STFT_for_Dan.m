clear
close all
clc
chanlocs = readlocs('cap64.loc');

%% stim-locked erps
Fs=500;
ts = -0.3*Fs:1.7*Fs;
t = ts*1000/Fs;
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
    freq_temp_STFT = (0:ceil((nfft+1)/2)-1)*Fs/nfft;
    STFT_time(cc) = mean(t(tf));
    cc=cc+1;
end

%% Inside subject loop...

erp = randi(50,64,length(ts),50);

% STFT calculation
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
% STFT is chan x time x trial
STFT_mean = squeeze(mean(STFT,3));
figure
plottopo(STFT_mean(:,:),'chanlocs',chanlocs,'limits',[STFT_time(1) STFT_time(end) ...
    min(min(min(STFT_mean(:,:))))  max(max(max(STFT_mean(:,:))))], ...
    'title','STFT','ydir',1)