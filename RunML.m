% [5-Funct] Run entire ML code process (for given test Wave)

function RunML(testWave, headerFile, mainDir, featuresDir, featuresDirOld, signalsDir, numFile)

% [1] Setup/cleanup feature folders
FolderSetupCleanup(featuresDir, featuresDirOld);

% [2] Generate data files containing features/labels for each signal
GenerateMLData(headerFile, featuresDir, signalsDir, numFile);

% [3] Generate train/test feature files (for given test Wave)
GenerateTTFeatureMatrix(mainDir, featuresDir, numFile, testWave);

% [4] Run ML evaluation (train/test) - obtain Wave ranking
waveRank = MLEval(featuresDir);

% Save wave ranking to txt file
rankFile = 'waveRank.txt';
fileID = fopen(rankFile, 'w');
for i = 1:length(waveRank)
    fprintf(fileID, '%d,', waveRank(i));
end
fclose(fileID);

end
