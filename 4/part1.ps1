$part1_example = Get-Content -Path .\input\part1.example
$part1_input = Get-Content -Path .\input\part1.input

function Solution_example {
    $count = 0 
    foreach ($line in $part1_example) {
        $flag = $false

        $left, $right = $line.Split(',')

        $left = $left.Replace("-","..") | Invoke-Expression

        $right = $right.Replace("-","..") | Invoke-Expression

        if (($right | Where-Object {$left -notcontains $_}).Count -eq 0) { $flag = $true }

        if (($left | Where-Object {$right -notcontains $_}).Count -eq 0) { $flag = $true }

        if ($flag) {
            $count++
        }
    }
    $count
}

function Solution_input {
    $count = 0 
    foreach ($line in $part1_input) {
        $flag = $false

        $left, $right = $line.Split(',')

        $left = $left.Replace("-","..") | Invoke-Expression

        $right = $right.Replace("-","..") | Invoke-Expression

        if (($right | Where-Object {$left -notcontains $_}).Count -eq 0) { $flag = $true }

        if (($left | Where-Object {$right -notcontains $_}).Count -eq 0) { $flag = $true }

        if ($flag) {
            $count++
        }
    }
    $count
}

Write-Host "Output Example Part1: $(Solution_example)"
Write-Host "Output Input   Part1: $(Solution_input)"