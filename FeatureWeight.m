% [4-Funct] Perform manual weighting of features/predictors before ML training (after GenerateTTFeatureMatrix)

function FeatureWeight(headerFile, featuresDir)

% Obtain feature weights from header file
headerInfo = csvread(headerFile);
weights = headerInfo(1,2:length(headerInfo)-1);

% Multiply each weight by 10 (for proportions)
weights = weights*10;

% Load train/test feature files
trainFeatureFile = fullfile(featuresDir,'features_train.txt');
testFeatureFile = fullfile(featuresDir,'features_test.txt');
trainFeatureData = load(trainFeatureFile);
testFeatureData = load(testFeatureFile);

% Duplicate existing features in train/test feature files, according to weight proportions
trainLabels = trainFeatureData(:,size(trainFeatureData,2));
testLabels = testFeatureData(:,size(testFeatureData,2));
trainInfo = trainFeatureData(:,1:size(trainFeatureData,2)-1);
testInfo = testFeatureData(:,1:size(testFeatureData,2)-1);

for feat = 1:length(weights)
    % If weight > 0, perform manual weighting
    if weights(feat) > 0
        % Create added feature matrix
        addFeatTrain = repmat(trainInfo(:,feat),1,weights(feat));
        addFeatTest = repmat(testInfo(:,feat),1,weights(feat));

        % Append to end of train/test data matrix
        trainInfo = horzcat(trainInfo,addFeatTrain);
        testInfo = horzcat(testInfo,addFeatTest);
    else
        % If weight = 0, delete column
        trainInfo(:,feat) = [];
        testInfo(:,feat) = [];
    end
end

% Update train/test feature files with new feature data
newTrain = horzcat(trainInfo,trainLabels);
newTest = horzcat(testInfo,testLabels);

trainFeatureFile = fullfile(featuresDir,'features_train.txt');
if isfile(trainFeatureFile)
    delete(trainFeatureFile); % If file already exists, delete and make new one
end
csvwrite(trainFeatureFile, newTrain);

% Save features_test matrix to csv file
testFeatureFile = fullfile(featuresDir,'features_test.txt');
if isfile(testFeatureFile)
    delete(testFeatureFile); % If file already exists, delete and make new one
end
csvwrite(testFeatureFile, newTest);

end
