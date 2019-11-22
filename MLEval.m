% [4-Funct] Train and test/evaluate ML models using generated data (after GenerateFeatureMatrix)

function waveRank = MLEval(featuresDir)

% Check if features_train file exists, return error and exit if not
trainFeatureFile = fullfile(featuresDir,'features_train.txt');
testFeatureFile = fullfile(featuresDir,'features_test.txt');
if ~isfile(trainFeatureFile)
    fprintf('Error: The feature_train.csv file does not exist.\n');
    return; % Exit the script
end

% Load data from features_train file
trainFeatureData = load(trainFeatureFile);
testFeatureData = load(testFeatureFile);

% Form feature/label matrices for ML evaluation
features = trainFeatureData(:,1:size(trainFeatureData,2)-1);
labels = trainFeatureData(:,size(trainFeatureData,2));
test_features = testFeatureData(:,1:size(testFeatureData,2)-1);
test_label = testFeatureData(:,size(testFeatureData,2));

% Train Multi-Class SVM (ECOC) model
mcSvmMdl = fitcecoc(features, labels);

% Test ML model - generate predicted label and NegLoss values
[~,NegLoss] = predict(mcSvmMdl, test_features);

% Sort NegLoss indices - smallest NegLoss (abs val) = higher ranking
[~,index] = sort(NegLoss, 'descend');

% Map indices to Wave # (rank Waves)
rank = index;
for i = 1:length(index)
    if index(i) <= test_label
        % Decrement index if less than/equal to test Wave #
        rank(i) = rank(i)-1;
    end
end
waveRank = rank; % Output

end
