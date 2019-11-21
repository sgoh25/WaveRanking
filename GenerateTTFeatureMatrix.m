% [3-Funct] Generate train/test feature matrix to be used in ML evaluation (after GenerateMLData)

function GenerateTTFeatureMatrix(mainDir, featuresDir, numFile, testWave)

% Go to features directory
cd(featuresDir)

% Define feature matrix for train and test Waves
features_train = [];
features_test = [];

% Run feature matrix formation
for num = 1:numFile      
    % Load data from feature files (%d is the Wave #)
    featureFile = sprintf('features%d.csv', num-1);
    featureData = csvread(sprintf(fullfile(featuresDir,featureFile)));
    
    % If current Wave # is test wave, save to test matrix
    if (num-1 == testWave) 
        features_test = featureData;
    else
        % Vertically concatenate to form features_train matrix (if not test wave)
        features_train = vertcat(features_train, featureData);
    end

end

% Save features_train matrix to csv file
trainFeatureFile = fullfile(featuresDir,'features_train.csv');
if isfile(trainFeatureFile)
    delete(trainFeatureFile); % If file already exists, delete and make new one
end
csvwrite(trainFeatureFile, features_train);

% Save features_test matrix to csv file
testFeatureFile = fullfile(featuresDir,'features_test.csv');
if isfile(testFeatureFile)
    delete(testFeatureFile); % If file already exists, delete and make new one
end
csvwrite(testFeatureFile, features_test);
cd(mainDir)

end
