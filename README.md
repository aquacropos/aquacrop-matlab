# aquacrop-matlab
AquaCrop-OS: Matlab and Octave implementation of FAO AquaCrop model

## About

![AquaCropOS_Logo](https://user-images.githubusercontent.com/80771515/182115011-5eb88387-496f-4fbb-ae69-e27ea60873be.png)

AquaCrop-OS is a free, open-source implementation of AquaCrop, a crop water productivity model developed by the Food and Agriculture Organization of the United Nations (FAO). AquaCrop-OS is coded in Matlab and Octave, and was developed by Dr Tim Foster at University of Manchester. The model was originally released in August 2016.

AquaCrop-OS simulates yield response to water for multiple crop types and environmental conditions, and is designed specifically for regions where water is a critical limiting factor in crop production. AquaCrop-OS is intended for use by both scientists and practitioners, and requires minimal data inputs in comparison with most other crop models.

AquaCrop-OS introduces several new innovative features on top of those provided by the base GUI and PlugIn versions of the FAO AquaCrop model, including:
- Support for multiple operating systems (Windows, Macintosh OS X and Linux).
- Capacity to run parallel model simulations to reduce run times of computationally intensive tasks.
- Easy linkage with other models via the Open Modelling Interface to support water policy analysis.

More information about AquaCrop-OS (Matlab and Octave versions) can be found [here](https://doi.org/10.1016/j.agwat.2016.11.015).

## Current Version - v2

The most recent release (v2.0) of aquacrop-matlab implements version 6.0 of the FAO AquaCrop model, with the exception of fertility stress, salinity stress, and weed management. These features will be added in a future release. 

## Getting Started 

To obtain the aquacrop-matlab source code, you can download a copy of the files from this repository and extract the files to a directory on your machine. Alternatively, you can clone this repository onto your own machine if you wish. The code has been tested up to version 2020b of Matlab and version 6.1.0 of Octave.

Once downloaded and extracted, open either Matlab or Octave and navigate the current folder to the directory containing the model source code (`./AquaCrop/Code`). You will then need to follow the instructions provided in the reference manual (`./AquaCrop/Manual`) to setup and run the model. This manual file also provides example scripts for both single and parallel simulation runs. 
