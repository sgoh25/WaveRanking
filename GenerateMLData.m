% [2-Funct] Generate data files containing features and corresponding labels (for each signal)

function GenerateMLData(headerFile, featuresDir, signalsDir, numFile)

% Run feature extraction for Wave# data
for n = 1:numFile
    waveName = sprintf('Wave%d.txt',n-1);
    FeatureExtract(fullfile(signalsDir,waveName), headerFile, featuresDir, n-1);
end

end
