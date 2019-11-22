% [Funct] Function that extracts features for given data file and saves to corresponding features file

% void FeatureExtract(str dataFile, int label)
function FeatureExtract(dataFile, headerFile, featuresDir, label)

% Define variables
numWindows = 1;
featuresList = ["testWave","max","mean","median","skewness","std"];

% If Wave file does not exist, return error message and quit
if ~isfile(dataFile)
    fprintf('Error: The %s data file does not exist.\n', dataFile);
    % return;
end

% Read wave data and save to data variable array
data = csvread(dataFile);

% Read header file for features selection -> save to select array and mapping txt file
featureSelect = csvread(headerFile);
featureFile = 'waveFeatures.txt';
featureFileID = fopen(featureFile, 'w');
for i = 1:length(featureSelect)-1
    fprintf(featureFileID, '%s,%d\n', featuresList(i), featureSelect(i));
end
fclose(featureFileID);

% Open csv file for recording extracted features (named according to Wave #)
fileName = fullfile(featuresDir,sprintf('/features%d.txt', label));
fileID = fopen(fileName, 'w');

% Split data into windows (8)
stepSize = ceil(length(data)/numWindows);
index = 1;
for win = 1:numWindows
    % Check that data index not exceeded -> assign to max index if exceeded
    if (index-1)+stepSize > length(data)
        iStart = index;
        iEnd = length(data);
    else
        iStart = index;
        iEnd = (index-1)+stepSize;
    end

    % Compute current data segment
    currData = data(iStart:iEnd);

    % Exract features and write to text file
    features = [max(currData),mean(currData),median(currData),skewness(currData),std(currData)];
    for feat = 2:length(features)
        % Extract feature if selected in header file (skip first number = testWave)
        if featureSelect(feat) == 1
            fprintf(fileID, '%f,', features(feat));
        end
    end
    
    % Increment data index
    index = index + stepSize;
end

% Write label value (features for all windows = 1 row per trial)
fprintf(fileID, '%d', label);
fprintf(fileID, '\n');

% End recording of extracted feature for given output file
fclose(fileID);

end
