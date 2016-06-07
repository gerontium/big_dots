%--EEG output file renamer--
%IMPORTANT: Before using this script, it is recommended to run FileHiearchyChecker
% to evaluate wrong file names. Understand FileHiearchyChecker script
%instructions first, will make this one easier to use :)


%This script allows you to rename EEG output files from a **BrainProducts**
%(tm) system. The ones with extension .EEG, .VMRK and .VHDR.
%Because of the .VHDR and .VRMK files internal cross references,
%Renaming the files through the usual way will result in error.
%This code change the file names and the internal references
%allowing them to work properly. Also, it generates a Name Change Log
%into the main folder in case of any concern.


%Lets takes as an example a DirectionDots experiment data folder hierarchy
%and its respective files. There is a main folder (DirectionDots_data),
%folders for each subject data (DD1M, DD2M, DD3M...) and EEG output
%files for each experiment block (DD1M1.vhdr, DD1M2.vmrk and DD1M2.eeg...).
%One can save files with wrong name; for instance, put the name DD2M2eeg.egg
%instead of DD2M2.egg.

%Example of folders cointaining a wrong name for the second subject in the
%second block.

%DirectionDots_data
%  | - DD1M
%       | - DD1M1.vhdr
%       | - DD1M1.vmrk
%       | - DD1M1.eeg
%       | - DD1M2.vhdr
%       | - DD1M2.vmrk
%       | - DD1M2.eeg
%  | - DD2M
%       | - DD2M1.vhdr
%       | - DD2M1.vmrk
%       | - DD2M1.eeg
%       | - DD2M2eeg.vhdr  < - wrong name
%       | - DD2M2eeg.vmrk  < - wrong name
%       | - DD2M2eeg.eeg   < - wrong name



%To solve such problem, just list the wrongnames in the wrongnames variable
%below, and the RESPECTIVE rightnames in the rightnames variable below.
%WARNING: Pay attention to the main folder
%(i.e. the file directory, this must be listed correctly).
% Also wrongnames and rightnames should not have file extension at the end.



%Cleaning routine
clear
clc
close all

%----SET PARAMETERS HERE----
path = 'S:\R-MNHS-SPP\Bellgrove-data\4. Dan Newman\Participant Folders_new\';

subject_folder = {'279M_FT','234M_SW','484M_AI','453M_LB'};
%Insert here the main folder
%for example 'G:\DirectionDots_data\DD2M\', the script will search
%for mistakes in this folder.

for s=1:length(subject_folder)
    datafolder = 'G:\DirectionDots_data\DD2M\';
    
    
    %Insert here the wrong names (no file extension needed !) as a list (cell)
    %for example {'DDM2eeg','DD2M3.eg'}
    wrongnames={'FT34M1eeg','SW5010', 'AI58MS1', 'AI58MS2', 'AI58MS3', 'AI58MS4',...
        'AI58MS5', 'AI58MS6', 'AI58MS7', 'AI58MS8', 'AI58MS9', 'AI58MS10',...
        'AI58MS11', 'AI58MS12','AI58MS13', 'AI58MS14', 'AI58MS15', 'AI58MS16',...
        'LB59M12','LB59M12b'};
    
    %Insert here the right names (no file extension needed !, again ? - Yes, again !)
    % as a list (cell).
    %for example {'DDM2','DD2M3'}
    rightnames={'FT34M1','SW50M10','AI58M1', 'AI58M2', 'AI58M3', 'AI58M4',...
        'AI58M5', 'AI58M6', 'AI58M7', 'AI58M8', 'AI58M9', 'AI58M10',...
        'AI58M11', 'AI58M12','AI58M13', 'AI58M14', 'AI58M15', 'AI58M16',...
        'LB59M11','LB59M12'}; %
    %----MAIN SCRIPT----
    
    
    %---CREATE NAME CHANGING LOG FILE ---
    logfid=fopen([datafolder 'NameChangeLog.txt'],'w');
    
    %Write the Mainfolder in name changing log file
    fprintf(logfid,'Mainfolder: %s \n\n',datafolder);
    
    %Correct name for each wrong named file
    for k=1:length(wrongnames)
        
        %---WRONGFILE READING---
        
        %-VHDR-%
        %wrongfile
        wrongfile_vhdr=[wrongnames{k} '.vhdr'];
        
        %open wrong file
        wrongfid_vhdr=fopen([datafolder wrongfile_vhdr],'r');
        
        %Read first part of the file, before mistaken names
        firstpart=fread(wrongfid_vhdr,134,'uint8');
        
        %jump wrong name part of the file
        fseek(wrongfid_vhdr,length(wrongnames{k})+4+13+length(wrongnames{k})+5,'cof');
        
        
        %Read second part of the file, after mistaken names
        secondpart=fread(wrongfid_vhdr,inf,'uint8');
        
        %Close wrongfile
        fclose(wrongfid_vhdr);
        
        %-VMRK-%
        wrongfile_vmrk=[wrongnames{k} '.vmrk'];
        
        %open wrong file
        wrongfid_vmrk=fopen([datafolder wrongfile_vmrk],'r');
        
        %Read first part of the file, before mistaken names
        firstpart_vmrk=fread(wrongfid_vmrk,96,'uint8');
        
        %jump wrong name part of the file
        fseek(wrongfid_vmrk,length(wrongnames{k})+4+2,'cof');
        
        %Read second part of the file, after mistaken names
        secondpart_vmrk=fread(wrongfid_vmrk,inf,'uint8');
        
        %Close wrongfile
        fclose(wrongfid_vmrk);
        
        
        %---RIGHTFILE WRITING---
        
        %-VHDR-%
        %Create right file
        rightfid_vhdr=fopen([datafolder rightnames{k} '.vhdr'],'wb');
        
        %Write first part of the file
        fwrite(rightfid_vhdr,firstpart,'uint8');
        
        %Concatenate right names
        string_vhdr=[rightnames{k} '.eeg' char([13,10]) 'MarkerFile=' rightnames{k} '.vmrk'];
        fwrite(rightfid_vhdr,string_vhdr,'schar');
        
        %Write second part of the file
        fwrite(rightfid_vhdr,secondpart,'uint8');
        
        %Close right file
        fclose(rightfid_vhdr);
        
        
        %-VMRK-%
        %Create right file
        rightfid_vmrk=fopen([datafolder rightnames{k} '.vmrk'],'wb');
        
        %Write first part of the file
        fwrite(rightfid_vmrk,firstpart_vmrk,'uint8');
        
        %Concatenate right names
        string_vmrk=[rightnames{k} '.eeg' char([13,10])];
        fwrite(rightfid_vmrk,string_vmrk,'schar');
        
        %Write second part of the file
        fwrite(rightfid_vmrk,secondpart_vmrk,'uint8');
        
        %Close right file
        fclose(rightfid_vmrk);
        
        %---RENAMING EEG FILE---
        movefile([datafolder wrongnames{k} '.eeg'],[datafolder rightnames{k} '.eeg']);
        
        %---DELETING OLD FILES---
        delete([datafolder wrongnames{k} '.vhdr']);
        delete([datafolder wrongnames{k} '.vmrk']);
        
        
        %write name changes in the log file
        fprintf(logfid,'%s to %s\n',wrongnames{k},rightnames{k});
        
        
        
    end
end
fprintf('Done !\n');

%Close Name change log file
fclose(logfid);



