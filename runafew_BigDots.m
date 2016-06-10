%%% runafew
clear
close all
clc

%%
% path = 'S:\R-MNHS-SPP\Bellgrove-data\4. Dan Newman\Participant Folders_new\'; %Monash PC
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
%%

duds = []; % LK_07_04_14
single_participants = [77:80];

%%

allblocks = {[1:8,10:16], [1:9,11:16], [1:3,5:16], [1:2,4:16], [1:8,10:16], [1:16], [1:16], [1:5,7:16], [1:16], [1:9,11:16],...
    [1:3,5:16], [1:13], [4:16], [1:16], [1:16], [1:16], [1:16], [1:16], [1:16], [1:16],...
    [1:16], [1:16], [1:16], [2:16], [1:16], [1:16], [1:16], [1:16], [1:16], [1:16]...
    [1:16], [1:16], [1:16], [1:16], [1:16], [1:16], [1:16], [1:16], [1:16], [1:16]...
    [1:16], [1:16], [1:16], [1:16], [1:16], [1:16], [1:16], [1:16], [1:16], [1:16]...
    [1:16], [1:16], [1:16], [1:16], [1:16], [1:16], [1:16], [1:16], [1:16], [1:14,16]...
    [1:16], [1:16], [1:16], [1:16], [1:13,15,16], [1:16], [1:16], [1:7,9:16], [1:16], [1:16]...
    [1:16], [1:16], [1:16], [1:16], [1:13,15,16], [1:16], [1,3:16], [1:16], [1:16], [1:16]};

allbadchans = {[] % LK_07_04_14
    [15,43] % AR_08_04_14
    [6,15] % MH_14_04_14
    [4,44] % AA_15_04_14
    [1,4,44,63] % NT_16_04_14 *** 5
    [1,4,34,44,63] % OF_28_04_14
    [39,47,57] % RO_25_04_14
    [1,4,44] % PR_20_04_14
    [1,4,44] % AS_23_04_14
    [] % OM_07_05_14 *** 10
    [] % RM_06_05_14
    [] % SB_08_05_14
    [] % GW_09_05_14
    [] % OS_09_05_14
    [] % AC_13_05_14 *** 15
    [] % ND_16_05_14
    [] % SF_20_05_14
    [29,63] % TL_23_05_14
    [] % JC_23_05_14
    [] % EL_24_05_14 *** 20
    [] % SH_25_05_14 *** 21 END OF TCD SUBJECTS
    [] % 059M_HP
    [] % 093M_BR
    [11,15,22] % 036M_JK
    [] % 221M_SJ *** 25
    [8] % 068M_CB
    [26,59] % 301M_MO
    [5] % 118M_CS
    [59] % 265M_EZ
    [] % 291M_KS *** 30
    [] % 106M_NH
    [] % 302M_BS
    [] % 289M_AS
    [] % 303M_SA
    [] % 103M_JK *** 35
    [] % 314M_LK
    [] % 226M_SM
    [51] % 037M_JD
    [56] % 338M_SC
    [8,37] % 091M_SW *** 40
    [41,56] %  '134M_JM',
    [19,37,56] %'331M_CL',
    [19,59] %'108M_CY',
    [7] %'191M_DM',
    [45] %'243M_JB', ...
    [14,33,36,37,45] %  '136M_JC',
    [37,45] %'339M_YV',
    [22,30,45] %'353M_AT',
    [17,37,45] %'352M_MK',
    [45,47,55,64] %'061M_LG', ...
    [9,37] %  '235M_JM',
    [12,27,37,45] %'374M_PP',
    [45,32] %'325M_KR',
    [37,45,46] %'279M_FT',
    [10,19,37,43] %'114M_CS',
    [37,45] %'378M_MG', ...
    [28,45] %  '133M_DC',
    [1,37,45] %392M_PH',
    [9,20,33,37,45] %'186M_AF',
    [37,45] %'404M_RO',
    [37,45] %'147M_EB',
    [37,48] %'400M_ED',
    [45] %'398M_LO', ...
    [17,39,46] %  '384M_PD',
    [37,41,45,46] %'205M_LE',
    [2,22,37,45,46] %'328M_EW',
    [37,61] %'418M_AM',
    [7,37,45] %'189M_WM',
    [37,40,45] %'203M_VF',
    [35,37,39,45,32,46,49] %'234M_SW',...
    [37,45] %  '220M_NB',
    [1,2,33,36] %'377M_BL',
    [19,38,48,62] %'427M_SS',
    [10,22] %'414M_LA',
    [24] %'458M_AH',
    [12,42,29] %'439M_TM',...
    [12,13,47] %  '484M_AI',
    [12,47,22] %'453M_LB',
    [17] %'422M_MK',
    [46]};%'323M_CZ'

%%

if ~isempty(duds) && isempty(single_participants)
    subject_folder([duds]) = [];
    allsubj([duds]) = [];
    allblocks([duds]) = [];
    allbadchans([duds]) = [];
end

if ~isempty(single_participants)
    subject_folder = subject_folder([single_participants]);
    allsubj = allsubj([single_participants]);
    allblocks = allblocks([single_participants]);
    allbadchans = allbadchans([single_participants]);
end

%% CSD

E = textread('chans64.asc','%s');
M = ExtractMontage('10-5-System_Mastoids_EGI129.csd',E);  % reading in the montage for the CSD toolbox
% MapMontage(M);
[G_TCD,H_TCD] = GetGH(M);

E = textread('chans65_monash.asc','%s');
M = ExtractMontage('10-5-System_Mastoids_EGI129.csd',E);  % reading in the montage for the CSD toolbox
% MapMontage(M);
[G_monash,H_monash] = GetGH(M);

for s=1:length(allsubj)
    disp(allsubj{s})
    
    blocks = allblocks{s};
    badchans = allbadchans{s};
    clear paths files matfiles ET_files ET_matfiles; k=0;
    for n=1:length(blocks)
        k=k+1;
        if ismember(subject_folder{s},TCD_bigdots)
            files{k} = [path_temp subject_folder{s} '\' allsubj{s} '_' num2str(blocks(n)) '.bdf'];
            matfiles{k} = [path_temp subject_folder{s} '\' allsubj{s} '_' num2str(blocks(n)) '.mat'];
            ET_files{k}=[path_temp 'Samples_and_Events\' allsubj{s} '_' num2str(blocks(n)) '.asc'];
            ET_matfiles{k} = [path_temp subject_folder{s} '\' allsubj{s} '_' num2str(blocks(n)) '_ET.mat'];
        elseif ismember(subject_folder{s},Monash_bigdots)
            files{k} = [allsubj{s} num2str(blocks(n)) '.vhdr'];
            paths{k} = [path_temp subject_folder{s} '\'];
            matfiles{k} = [path_temp subject_folder{s} '\' allsubj{s} num2str(blocks(n)) '.mat'];
            ET_files{k}=[path_temp 'Samples_and_Events\' allsubj{s} num2str(blocks(n)) '.asc'];
            ET_matfiles{k} = [path_temp subject_folder{s} '\' allsubj{s} num2str(blocks(n)) '_ET.mat'];
        end
    end            
    
    if ismember(subject_folder{s},TCD_bigdots)
        G_CSD = G_TCD;
        H_CSD = H_TCD;
        TCD_preprocess_BigDots
    elseif ismember(subject_folder{s},Monash_bigdots)
        G_CSD = G_monash;
        H_CSD = H_monash;
        Monash_preprocess_BigDots
    end
end
