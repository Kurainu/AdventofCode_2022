$part1_example = Get-Content -Path .\input\part1.example
$part1_input = Get-Content -Path .\input\part1.input

function Solution_example {
    $cycle = 0
    $counter = 0
    $list = @(1)

    foreach ($line in $part1_example) {
        if ($line -eq "noop") {
            $list += ($list[-1]+$value)
            $value = 0
            continue
        }        
        
        if ($line.StartsWith("addx")) {
            $list += ($list[-1]+$value)
            $list += $list[-1]
            $action, $value = $line.Split(" ")
        }
    }

    foreach ($strengh in @(20,60,100,140,180,220)) {
        $counter += ($strengh * $list[$strengh])
    }

    $counter
}

function Solution_input {
    $cycle = 0
    $counter = 0
    $list = @(1)

    foreach ($line in $part1_input) {
        if ($line -eq "noop") {
            $list += ($list[-1]+$value)
            $value = 0
            continue
        }        
        
        if ($line.StartsWith("addx")) {
            $list += ($list[-1]+$value)
            $list += $list[-1]
            $action, $value = $line.Split(" ")
        }
    }

    foreach ($strengh in @(20,60,100,140,180,220)) {
        $counter += ($strengh * $list[$strengh])
    }

    $counter 
}

Write-Host "Output Example Part1: $(Solution_example)"
Write-Host "Output Input   Part1: $(Solution_input)"