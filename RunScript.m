% Wrapper script to run entire ML code process

% Reset all
clear all;
close all;
fclose all;

% Define directory paths and variables
mainDir = pwd;
featuresDir = fullfile(mainDir,'/ExtractedFeatures');
featuresDirOld = fullfile(mainDir,'/ExtractedFeaturesOld');
signalsDir = fullfile(mainDir,'/Signals');
headerFile = fullfile(signalsDir,'Header.txt');
numFile = 8;

% Define initial Signal dir file info
signalFiles = fullfile(signalsDir,'*.txt');
signalFileInfo = dir(signalFiles);

% Get most recent modification date
recentDate = signalFileInfo(1).datenum;
for n = 1:length(signalFileInfo)
    if signalFileInfo(n).datenum > recentDate
        recentDate = fileInfo(n).datenum;
    end
end

% Loop while checking modification date of Signal dir files
while true
    
    % Check modification date of all Signal files
    signalFileInfo = dir(signalFiles);
    for n = 1:length(signalFileInfo)
        if signalFileInfo(n).datenum > recentDate
            
            % Update most recent mod date
            recentDate = signalFileInfo(n).datenum;
            
            % Obtain test wave from Header file
            headerInfo = csvread(headerFile);
            testWave = headerInfo(1);
            
            % [5] Run entire ML code process
            RunML(testWave, headerFile, mainDir, featuresDir, featuresDirOld, signalsDir, numFile);
            disp('Wave Rank Updated');
            
            % FOR TESTING
            % Plot test Wave in subplot
            figure;
            wave = csvread(fullfile(signalsDir,sprintf('Wave%d.txt',testWave)));
            subplot(4,2,1);
            plot(wave);
            title(sprintf('Test Wave: Wave %d',testWave));

            % Plot ranked Waves in subplot
            waveRank = csvread('waveRank.txt');
            for rank = 1:length(waveRank)
                waveNum = waveRank(rank);
                wave = csvread(fullfile(signalsDir,sprintf('Wave%d.txt',waveNum)));
                subplot(4,2,rank+1);
                plot(wave);
                title(sprintf('Rank %d: Wave %d',rank,waveNum));
            end
            drawnow;
        end
    end
end
