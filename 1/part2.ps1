$part2_example = Get-Content -Path ".\input\part2.example" -Raw
$part2_input = Get-Content -Path ".\input\part2.input" -Raw



function Solution_example {
    $groups = $part2_example.Split("`r`n`r`n")

    $sums = $groups |ForEach-Object {($_ | ForEach-Object {Invoke-Expression $_} | Measure-Object -Sum).Sum }

    ($sums | Sort-Object -Descending -Top 3 | Measure-Object -Sum).Sum
}

function Solution_input {
    $groups = $part2_input.Split("`r`n`r`n")

    $sums = $groups |ForEach-Object {($_ | ForEach-Object {Invoke-Expression $_} | Measure-Object -Sum).Sum }

    ($sums | Sort-Object -Descending -Top 3 | Measure-Object -Sum).Sum
}

Write-Host "Output Example Part2: $(Solution_example)"
Write-Host "Output Input   Part2: $(Solution_input)"