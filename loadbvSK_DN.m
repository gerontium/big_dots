% General code for brain vision data files: It (a) extracts
% triggers & stimes, (b) adds a reference channel, (c) assigns channel
% locations, (d) interpolates bad channels, (e) re-references and lists electrode
% labels in "elab"
% NOTE: It's a SCRIPT, not a function, so you have to define the following
% elsewhere, and then just call "loadbvSK"
% 1) ref  (reference channel(s), e.g. "1" for eletrode 1 or "1:65" for average reference)
% 2) chanlocs (should be from a .loc file, e.g. JBhead64_sym.loc)
% 3) badchans (channels to be interpolated)

ref=1:65; %(reference channel(s), e.g. "1" for eletrode 1 or "1:65" for average reference)
detrend_data=1;% detrend between DCCs?

postDCCint = 1000;   % how many samples after DCC is EEG rubbish?

% all stimulus codes start with 'S '...
% It seems the first couple of triggers can be other stuff, like 'boundary' and 'actiCap not connected'
% extract the trigger values and times of occurrence
kdcc=0; dccT = [];
clear trigs stimes
k=0;
for n=1:length(EEG.event)
    typestr = EEG.event(n).type;
    codestr = EEG.event(n).code;
    if ~isempty(strmatch('S',typestr))
        k=k+1;
        trigs(k) = str2num(typestr(2:end));
        stimes(k) = EEG.event(n).latency;
    elseif ~isempty(strmatch('DC',codestr))
        kdcc=kdcc+1;
        dccT(kdcc)=EEG.event(n).latency;
    end
end

% get rid of diode triggers:
% if exist('diodetrig')
%     if takeoutdiodetrigs
%         stimes(find(trigs==diodetrig))=[];
%         trigs(find(trigs==diodetrig))=[];
%     end
% end

% if stimes(end)+EEG.srate*2 <size(EEG.data,2)
%     EEG.data(:,stimes(end)+EEG.srate*2:end)=[]; % get rid of any extra EEG beyond 2s after last trigger (subject might move or jump or dance)
% end

EEG.data(nchan:end,:)=[];
EEG.data(end+1,:)=0;  % add the extra referrence chanel and add zeros for reference channel
EEG.nbchan = nchan;
EEG.chanlocs = chanlocs(1:nchan);

% % For the 2-s of data following any DCC, set to alternating +/- 1000 so that it doesn't cause lots of channels
% % to be detected as saturated ones, but at the same time any artifact rejection criterion will chuck those trials out
for d=1:length(dccT)
    time_to_end = size(EEG.data,2)-dccT(d);
    if time_to_end<postDCCint
        EEG.data(:,dccT(d)+[1:time_to_end])=repmat(1000*cos([1:time_to_end]*pi),[size(EEG.data,1),1]);
    else
        EEG.data(:,dccT(d)+[1:postDCCint])=repmat(1000*cos([1:postDCCint]*pi),[size(EEG.data,1),1]);
    end
end

% chans2interp = badchans;
% 
% sat_chans = [];
% if exist('amp_saturation')
%     % if an amplifier saturation value was specified, then go through channels and interpolate ones that saturated during the task
%     sat_chans = find(max(abs(EEG.data(:,stimes(1):stimes(end))),[],2)>amp_saturation);
%     disp(['channels saturated: ' num2str(sat_chans')]);
%     chans2interp = unique([badchans sat_chans']);
% end
% 
% % Interpolate the bad channels identified in an earlier step
% if ~isempty(chans2interp)
%     EEG=eeg_interp(EEG,chans2interp,'spherical');
%     disp(['Interpolated channels ' num2str(chans2interp)])
% end

% detrend between DCCs?
if detrend_data
    startT = max(stimes(1)-postDCCint-EEG.srate,-postDCCint);   % go one second back from first stimulus trigger
    DetrendBoundaries = [startT dccT(find(dccT>startT)) size(EEG.data,2)];
    % make a detrended version
    detrdata = EEG.data;
    for n=1:length(DetrendBoundaries)-1
        interval = DetrendBoundaries(n)+postDCCint+1:DetrendBoundaries(n+1);
        if ~isempty(interval)
            detrdata(:,interval) = detrend(detrdata(:,interval)')';
        end
    end
    if detrend_data==1
        chans2detrend = [1:size(EEG.data,1)]';
    elseif detrend_data==2
        % only detrend the channels that benefit from it, in terms of a
        % reduction of stdev by at least 25%:
        chans2detrend = find(std(detrdata,[],2)<0.75*std(EEG.data,[],2));
    end
    EEG.data(chans2detrend,:) = detrdata(chans2detrend,:);
end

% % Re-reference the EEG data:
% if exist('ref'),
%     if ~isempty(ref)
%         EEG.data = EEG.data-repmat(mean(EEG.data(ref,:),1),[nchan,1]); %DN: Moved these last sections to outside the script
%     end
% end

% for q=1:nchan-1
%     elab{q} = EEG.chanlocs(q).labels;
% end
% elab{nchan}='FCz';
