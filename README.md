# FequencyDomainGCMS
## Shaelyn B. Christie<sup>1</sup>, Robin J. Abel<sup>2</sup>, Maryam Shakourisalim<sup>3</sup>, James J. Harynuk<sup>2</sup>, and Ryland T. Giebelhaus<sup>1</sup>
### <sup>1</sup> Department of Chemistry, University of Victoria, Victoria, Canada
### <sup>2</sup> Department of Chemistry, University of Alberta, Edmonton, Canada.
### <sup>3</sup> Department of Mechanical Engineering, University of Victoria, Canada
#### rgiebelhaus@uvic.ca

## 1.0 About
These files encode for an algorithm produced in MATLAB R2025a that enhances and denoises GC×GC-TOFMS data in the frequency domain. Frequencies associated with electrical contributions can be notched out using a Butterworth band-stop filter, and high noise-associated frequencies can be removed using a Butterworth lowpass filter. An exponential distribution can be fitted to the data in the frequency domain to raise low, chemical feature-associated frequencies and smooth high, noise-associated frequencies. The aforementioned operations can be applied in isolation or in any combination. Chromatograms are input as data structures containing spectral data, number of scans, sampling frequency, and modulation period. 

## 2.0 Use
Download coding files from repository and unzip. Use fftMain.m to apply desired operations. 

### 2.1 Inputs
* **dataIn**: Data structure containing the following fieldnames: : Rate, sampling frequency (spectra per second); Spec, an *M*×*N* spectrum matrix where *M* is scans and *N* is masses; numScans, number of scans; and ModPeriod, the modulation period.
* **plt**:  Binary input (0/1) to indicate plotting (1) or no plotting (0) of peak.
* **bwstop**: Optional; binary input (0/1) to indicate application of band-stop filter (1). Default 0.
* **bwlow**: Optional; binary input (0/1) to indicate application of lowpass filter (1). Default 0.
* **exp**: Optional; binary input (0/1) to indicate application of exponential fit (1). Default 0.
* **width**: Optional; width of notches to be filtered. Required only for band-stop filter, default empty.
* **notches** Optional; list of frequencies to be notched. Required only for band-stop filter, default empty.
* **stop_ordr** Optional; order of band-stop filter. Required only for band-stop filter, default empty.
* **low_ordr** Optional; order of lowpass filter. Required only for lowpass filter, default empty.
* **cutoff** Optional; frequency of which to remove all frequencies above. Required only for lowpass filter, default empty.

### 2.2 Outputs
* **dataOut**: Data structure in same form as input containing cleaned data.
