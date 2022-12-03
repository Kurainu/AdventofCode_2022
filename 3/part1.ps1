$part1_example = Get-Content -Path .\input\part1.example
$part1_input = Get-Content -Path .\input\part1.input

$priorities = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

function Solution_example {
   
    $prioritysum = 0

    foreach ($line in $part1_example) {
        $middle = $line.Length / 2 

        $left = $line[0..($middle -1)]
        $right = $line[$middle..$line.Length]

        $item =  (Compare-Object -ReferenceObject $left -DifferenceObject $right -ExcludeDifferent -CaseSensitive).inputobject | Sort-Object -Unique
        $prioritysum += $priorities.IndexOf($item) + 1
    }

    $prioritysum
}

function Solution_input {
    $prioritysum = 0

    foreach ($line in $part1_input) {
        $middle = $line.Length / 2 

        $left = $line[0..($middle -1)]
        $right = $line[$middle..$line.Length]

        $item =  (Compare-Object -ReferenceObject $left -DifferenceObject $right -ExcludeDifferent -CaseSensitive).inputobject | Sort-Object -Unique
        $prioritysum += $priorities.IndexOf($item) + 1
    }

    $prioritysum
}

Write-Host "Output Example Part1: $(Solution_example)"
Write-Host "Output Input   Part1: $(Solution_input)"