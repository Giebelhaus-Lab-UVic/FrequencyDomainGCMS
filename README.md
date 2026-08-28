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
* ****: . 
* **plt**: Optional; binary input (0/1) to indicate plotting (1) or no plotting (1) of peak. Default set to 1.
* **bwstop**: Optional; binary input (0/1) to indicate peak decomposition (1) or no peak decomposotion (0). Default set to 0.
* **bwlow**:
* **exp**:
* **

### 2.2 Outputs
* **out_table**: Table consisting of peak paramaters: Major axis length, Minor axis length, Orientation angle, Skew magnitude, Skew(x), Skew(y), Major B/A raio, Minor B/A 
