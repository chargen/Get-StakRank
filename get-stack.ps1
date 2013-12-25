<#
.SYNOPSIS
Stacks csv/tsv input by frequency of occurence. Header and delimiter may be passed as arguments.
.DESCRIPTION
Get-Stack.ps1 takes a separated values input file, the user may specify the delimiter and header just
as with import-csv, if not specified csv is assumed with the first row assumed to be the header row. 
The user specifies the fields by which to stack the data, defaulting in ascending order, creating a 
table where less frequently occuring items bubble up, if mutliple fields are provided as an argument,
those fields in combination will be paired or tupled.

If you don't know the fields and you're frequently working with various separated values files, 
https://github.com/davehull/Get-Fields.ps1, may be useful.

.PARAMETER Path
Specifies the path to the separated values file.
.PARAMETER LiteralPath
Specifies the literal path to the separated values file.
.PARAMETER Delimiter
Specifies the single character delimiter.
.PARAMETER Header
Specifies header values for the delimited file.
.PARAMETER Asc
Specifies output should be in ascending order, default.
.PARAMETER Desc
Specifies output should be in descending order.
.PARAMETER Key
Data should be sorted by the key.
.PARAMETER Value
Data should be sorted by the value.
.PARAMETER Fields
Specifies the field or fields to rank.
.Parameter ShowFields
Causes the script to return the field names.
.EXAMPLE
Get-Stack -Path .\autouns.tsv -delimiter "`t" -Asc -Key
#>

[CmdletBinding()]
Param(
    [Parameter(ParameterSetName='Path',Mandatory=$True,Position=0)]
        [string]$Path,
    [Parameter(ParameterSetName='LitPath',Mandatory=$True,Position=0)]
        [string]$LiteralPath,
    [Parameter(Mandatory=$False)]
        [char]$Delimiter=",",
    [Parameter(Mandatory=$False)]
        [string]$Header,
    [Parameter(Mandatory=$False)]
        [switch]$Desc=$False,
    [Parameter(Mandatory=$False)]
        [switch]$Key=$False,
    [Parameter(Mandatory=$True)]
        [array]$fields
)

switch ($PSCmdlet.ParameterSetName) {
    Path { 
        if ($Header.Length -gt 0) {
            $Data = Import-Csv -Path $Path -Delimiter $Delimiter -Header $Header
        } else {
            $Data = Import-Csv -Path $Path -Delimiter $Delimiter
        }
    }
    LitPath {
        if ($Header.Length -gt 0) {
            $Data = Import-Csv -LiteralPath $Path -Delimiter $Delimiter -Header $Header
        } else {
            $Data = Import-Csv -LiteralPath $Path -Delimiter $Delimiter
        }
    }
}
