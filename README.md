# WaveRanking

MATLAB code to rank channel waveforms. Ranking process uses machine learning algorithms and extracted features.

## Directories

The included directories are described below.

| Directory  | Description |
| ---------- | ----------- |
| `ExtractedFeatures` | Contains resulting txt files of extracted feature data |
| `Signals` | Channel waveforms to be ranked are imported here, includes `Header.txt` |


## Code

The included MATLAB scripts and functions are described below.

| File Name  | Description |
| ---------- | ----------- |
| `FeatureExtract.m` | Function that extracts features for given data file and saves to corresponding feature file |
| `FeatureWeight.m` | Function that performs manual weighting of features before ML training |
| `FolderSetupCleanup.m` | Function that sets up ExtractedFeatures folder |
| `GenerateMLData.m` | Function that generates data files containing features and corresponding labels for each waveform |
| `GenerateTTFeatureMatrix.m` | Function that generates training/testing feature matrix to be used in ML evaluation |
| `MLEval.m` | Function that trains and tests ML model using generated data |
| `RunML.m` | Function that runs the entire ML code process for given test waveform |
| `RunScript.m` | Wrapper script to run entire ML code process continuously |


## Usage

### Step 1

Import channel waveforms to the `Signals` directory, labelled in the form `Wave#.txt`. Include header file `Header.txt` to specify the test waveform number (0-7) and which features to enable/disable (1/0). Features can be weighted according to importance by manually assigning a value from 0-1, preferably in 0.1 increments, as an input to `Header.txt` following the test waveform number.

### Step 2

Run `RunScript.m` in MATLAB. This script will loop continuously until the user quits the program with CTRL+C. The wave ranking process will execute when any file in the `Signals` directory is modified.

### Step 3

The ranking process will update the `waveRank.txt` file with the updated waveform ranking, corresponding to the imported waveforms and information specified in `Header.txt`. The `waveFeatures.txt` file, which summarizes the information contained in `Header.txt`, will also be updated.
