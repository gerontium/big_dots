# big_dots
Analysis scripts for Monash/Trinity Big Dots study

##Analysis Pipeline:

###In Matlab, run scripts to process raw eeg files:

(note: In future you can skip steps 1 to 3 because they were just for renaming incorrectly named files and finding noisy eeg channeles, which will already have been found and listed in 'runafew.m' for step 4)
1. 'EEGFileRenamer.m' - to rename the eeg data files of a few of the Monash participants for which some blocks were originally saved with incorect filename
2. 'getChannelVars_BigDots.m' - to extract a measure of electrode noise
3. 'Check4badchans_BigDots.m' - checks for noisy channeles, you manually list any noisy channeles in 'runafew_BL.m'
4. 'runafew_BigDots.m' - calls a scriot to extract RT as well as epochs for ERP, Alpha and Pupil Diameter 



## License

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License</a>.