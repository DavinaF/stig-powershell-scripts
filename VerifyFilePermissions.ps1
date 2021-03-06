#define the directory
$path = 'C:\Test'

#define the username; for domain accounts use 'DOMAIN\Username'
$username = 'BUILTIN\Users'

#loop through the files in the directory to look for the removed user
ForEach($file in Get-ChildItem $path){
$childPath = $path + "\" + $file.name
$access = (Get-Acl $childPath).Access | where { $_.IdentityReference -like $username}
if ($access.IdentityReference -like $username)
{ "Error: The username " + $username + " was found in " + $childPath}
else
{"No problem"}
}

#set the account to check was added 
$addedAccount = 'BUILTIN\Administrators'

#loop through the files in the directory to look for the added user
ForEach($file in Get-ChildItem $path){
$childPath = $path + "\" + $file.name
$access = (Get-Acl $childPath).Access | where { $_.IdentityReference -like $addedAccount}
if ($access.IdentityReference -like $addedAccount)
{ "No problem"}
else
{"Error: The username " + $addedAccount + " was found in " + $childPath}
}

