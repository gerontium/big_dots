clear
close all
clc

path_temp = 'D:\Participant Folders_new\'; %TCD Laptop
%%
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

%%

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

%% Get TCD subjects  

[~,txt,~] = xlsread([path_temp 'Dots Study_GER and DAN_TCD_info.xlsx']);

subj_strings = txt([3:end],1);
time_strings = txt([3:end],8);

for i = 1:length(time_strings)
    timestamp = time_strings{i};
    if sscanf(timestamp,'%d:')~=12
        if strcmp(timestamp(end-1:end),'am')
            subject_test_time_TCD(i) = sscanf(timestamp,'%d:');
        elseif strcmp(timestamp(end-1:end),'pm')
            subject_test_time_TCD(i) = sscanf(timestamp,'%d:')+12;
        end
    else
        subject_test_time_TCD(i) = sscanf(timestamp,'%d:');
    end
    subject_TCD{i} = subj_strings{i};
end

[~,txt,~] = xlsread([path_temp 'Dots Study_GER and DAN_new study_Monash_info.xlsx']);

subj_strings = txt([3:end],1);
time_strings = txt([3:end],8);

for i = 1:length(time_strings)
    timestamp = time_strings{i};
    if sscanf(timestamp,'%d:')~=12
        if strcmp(timestamp(end-1:end),'am')
            subject_test_time_Monash(i) = sscanf(timestamp,'%d:');
        elseif strcmp(timestamp(end-1:end),'pm')
            subject_test_time_Monash(i) = sscanf(timestamp,'%d:')+12;
        end
    else
        subject_test_time_Monash(i) = sscanf(timestamp,'%d:');
    end
    subject_Monash{i} = subj_strings{i};
end

test_times=[];
for s = 1:length(allsubj)
    if ismember(subject_folder{s},TCD_bigdots)
        for i = 1:length(subject_TCD)
            if strcmp(subject_TCD{i}([1:2]),allsubj{s})
                test_times(s) = subject_test_time_TCD(i);
            end
        end
    elseif ismember(subject_folder{s},Monash_bigdots)
        for i = 1:length(subject_Monash)
            if strcmp(subject_Monash{i},allsubj{s})
                test_times(s) = subject_test_time_Monash(i);
            end
        end
    end
end
save('test_times.mat','test_times');
return




%% old way, get file dates from computer but might be incorrect!!!
if ismember(subject_folder{s},TCD_bigdots)
    fileinfo = dir(files{1});
else
    fileinfo = dir([paths{1},files{1}]);
end
timestamp = fileinfo.date; timestamp = timestamp(end-7:end);
temp = sscanf(timestamp,'%d:');
if temp(1)>21 | temp(1)<9
    keyboard
end
if temp(2)>30
    subject_test_time(s) = temp(1)+1;
else
    subject_test_time(s) = temp(1);
end