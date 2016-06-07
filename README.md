# big_dots
Analysis scripts for Monash/Trinity Big Dots study

##Analysis Pipeline:

###In Matlab, run scripts to process raw eeg files:

(note: In future you can skip steps 1 and 2 because they were just for finding noisy eeg channeles, which will already have been found listed in 'runafew.m' for step 3)

1. 'getChannelVars_BigDots.m' - to extract a measure of electrode noise
2. 'Check4badchans_BigDots.m' - checks for noisy channeles, you manually list any noisy channeles in 'runafew_BL.m'
3. 'runafew_BigDots.m' - calls 'Dots_Discrete_Upper_Lower_ET.m' to extract ERP, Alpha, and Pupil Diameter epochs 



## License

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License</a>.