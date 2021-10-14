# Change ActiveDirectory Users Password in a bulk
# Create an users.csv file with 02 columns; email and password.

Import-Module ActiveDirectory 

# Import the CSV
$csv = Import-Csv -Path .\users.csv

# Loop through all items in the CSV 
ForEach ($item In $csv) {

        # Get a line from the csv file
        $user_email = $item.email
        $user_password = ConvertTo-SecureString $item.password -AsPlainText -Force

        # Find the user using his email address
        $user_dn = Get-ADUser -Filter {mail -eq $user_email}

        Set-ADAccountPassword -Identity $user_dn -Reset -NewPassword $user_password
        Set-ADUser -Identity $user_dn -ChangePasswordAtLogon 1

        # Success, log it
        $changelog = "The password for USER $($user_email) was set."
        Write-Host $changelog
        $changelog | Out-File -Append .\changelog.txt
}