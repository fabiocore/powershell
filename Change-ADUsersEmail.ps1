# Bulk Change User Email and Add the Old Email as an Alias
# Create an users.csv file with 03 columns; SamAccountName, NewEmail, Alias. This file is optional, but you will need to change the script a bit.

Import-Module ActiveDirectory

$csv = Import-Csv -Path .\users.csv

ForEach ($item In $csv){

        # Get a line from csv file
        $sam_account = $item.SamAccountName
        $new_email = $item.NewEmail
        $alias = $item.Alias

        # Set attributes
        Set-ADUser -Identity $sam_account -EmailAddress $new_email
        Set-ADUser -Identity $sam_account -Add @{proxyAddresses=$alias}

        # Success, write to a log
        $changelog = "The USER $($sam_account) was set from $($alias) to $($new_email)"
        Write-Host $changelog
        $changelog | Out-File -Append .\changelog.txt

        Start-Sleep -Seconds 1.0
}