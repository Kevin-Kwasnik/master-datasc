# Connect to Azure account and store the connection
Connect-AzAccount

# Function to download a file from Azure Storage Account
function Download-AzureFile {
    param(
        [string]$containerName,
        [string]$sourceFilePath,
        [string]$destinationFilePath
    )
    
    $container = Get-AzStorageContainer -Name $containerName
    if ($container) {
        $blobName = (Get-Item $sourceFilePath).Name
        $blob = Get-AzStorageBlob -Container $containerName -Blob $blobName -ErrorAction SilentlyContinue
        if ($blob) {
            Get-AzStorageBlobContent -Container $containerName -Blob $blobName -Destination $destinationFilePath -Force
            Write-Host "File downloaded to $destinationFilePath"
        } else {
            Write-Host "File does not exist in Azure Storage Account"
        }
    } else {
        Write-Host "Container $containerName does not exist in Azure Storage Account"
    }
}

# Function to upload a file to Azure Storage Account
function Upload-AzureFile {
    param(
        [string]$containerName,
        [string]$sourceFilePath
    )
    
    $container = Get-AzStorageContainer -Name $containerName
    if ($container) {
        Set-AzStorageBlobContent -Container $containerName -File $sourceFilePath -Blob (Split-Path -Leaf $sourceFilePath) -Force
        Write-Host "File uploaded to Azure Storage Account container $containerName"
    } else {
        Write-Host "Container $containerName does not exist in Azure Storage Account"
    }
}

# Function to wait for a file to be generated
function Wait-ForFile {
    param(
        [string]$filePath
    )
    
    while (-not (Test-Path -Path $filePath)) {
        Start-Sleep -Seconds 5
    }
}

# Parameters
param(
    [string]$FilePath1,
    [string]$FilePath2,
    [string]$FilePath3
)

# Check if the files exist and download them
Download-AzureFile -containerName "source-container" -sourceFilePath $FilePath1 -destinationFilePath "local-file1.csv"
Download-AzureFile -containerName "source-container" -sourceFilePath $FilePath2 -destinationFilePath "local-file2.csv"
Download-AzureFile -containerName "source-container" -sourceFilePath $FilePath3 -destinationFilePath "local-file3.csv"

# Call third party software
thirdparty.exe -file1 "local-file1.csv" -file2 "local-file2.csv" -file3 "local-file3.csv"

# Wait for the generated file
Wait-ForFile "generated-file.acg"

# Upload the generated file
Upload-AzureFile -containerName "output-container" -sourceFilePath "generated-file.acg"

# Generate and upload CSV files
# Replace these lines with your actual CSV generation code and uploading logic

# Verify file uploads
$uploadedFiles = @("generated-file.acg", "output-csv1.csv", "output-csv2.csv", "output-csv3.csv")
foreach ($file in $uploadedFiles) {
    $blob = Get-AzStorageBlob -Container "output-container" -Blob $file -ErrorAction SilentlyContinue
    if ($blob) {
        Write-Host "File $file uploaded to output-container"
    } else {
        Write-Host "File $file not found in output-container"
    }
}

# Move original files to a different folder
# Replace these lines with your actual file moving logic

# Verify file move
$originalFiles = @($FilePath1, $FilePath2, $FilePath3)
foreach ($file in $originalFiles) {
    $blob = Get-AzStorageBlob -Container "source-container" -Blob $file -ErrorAction SilentlyContinue
    if (-not $blob) {
        Write-Host "File $file moved to a different folder"
    } else {
        Write-Host "File $file still exists in source-container"
    }
}

# Delete original files from local machine
Remove-Item -Path $FilePath1, $FilePath2, $FilePath3 -Force

# Verify local file deletion
foreach ($file in $originalFiles) {
    if (-not (Test-Path -Path $file)) {
        Write-Host "File $file deleted from local machine"
    } else {
        Write-Host "File $file still exists on local machine"
    }
}

# Delete generated CSV files from local machine
Remove-Item -Path "local-file1.csv", "local-file2.csv", "local-file3.csv", "generated-file.acg" -Force

# Verify local file deletion
$localFilesToDelete = @("local-file1.csv", "local-file2.csv", "local-file3.csv", "generated-file.acg")
foreach ($file in $localFilesToDelete) {
    if (-not (Test-Path -Path $file)) {
        Write-Host "File $file deleted from local machine"
    } else {
        Write-Host "File $file still exists on local machine"
    }
}
