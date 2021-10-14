# Bulk import users to ActiveDirectory from .csv file

Import-Csv file.csv | ForEach-Object {
    New-ADUser -SamAccountName $_.SAMAccountName -Name ($_.FirstName + " " + $_.LastName) -GivenName $_.FirstName -Surname $_.LastName -EmployeeID $_.EmployeeID -Title $_.Title -StreetAddress $_.StreetAddress -City $_.City -PostalCode $_.PostalCode -State $_.State -Department $_.Department -EmailAddress $_.Email -OfficePhone $_.PhoneNumber  -Path "CN=users,DC=YOURDOMAIN,DC=com" -Enabled $true -ChangePasswordAtLogon $true -AccountPassword (ConvertTo-SecureString -AsPlainText 'Pa$$w0rd' -Force)}