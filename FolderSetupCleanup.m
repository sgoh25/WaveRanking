% [1-Funct] Setup or clean up ExtractedFeatures folders (only need to do once)

function FolderSetupCleanup(featuresDir, featuresDirOld)

% Make ExtractedFeatures directory if does not exist
if ~isfolder(featuresDir)
    mkdir(featuresDir);
end

% Uncomment to save previously extracted features to Old directory
%{
% Clean up Old instances of ExtractedFeatures -> make ExtractedFeaturesOld folder if does not exist
if ~isfolder(featuresDirOld)
    mkdir(featuresDirOld);
end

% Check if ExtractedFeatures directory already exists -> if so, rename and move to Old folder
notCopied = true;
numCount = 1;
if isfolder(featuresDir)
    while notCopied
        efNum = fullfile(featuresDirOld,num2str(numCount));
        if ~isfolder(efNum)
            % Rename/move to next available folder number
            movefile(featuresDir, efNum)
            mkdir(featuresDir);
            notCopied = false;
        end
        numCount = numCount + 1;
    end
else
    mkdir(featuresDir);
end
%}

end