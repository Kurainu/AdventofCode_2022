$part1_example = Get-Content -Path .\input\part1.example -Raw
$part1_input = Get-Content -Path .\input\part1.input -Raw



function Solution_example {
    $groups = $part1_example.Split("`r`n`r`n")

    $sums = $groups |ForEach-Object {($_ | ForEach-Object {Invoke-Expression $_} | Measure-Object -Sum).Sum }

    ($sums | Measure-Object -Maximum).Maximum

}

function Solution_input {
    $groups = $part1_input.Split("`r`n`r`n")

    $sums = $groups |ForEach-Object {($_ | ForEach-Object {Invoke-Expression $_} | Measure-Object -Sum).Sum }

    ($sums | Measure-Object -Maximum).Maximum

}

Write-Host "Output Example Part1: $(Solution_example)"
Write-Host "Output Input   Part1: $(Solution_input)"