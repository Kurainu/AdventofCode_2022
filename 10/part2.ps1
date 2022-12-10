$part1_example = Get-Content -Path .\input\part1.example
$part1_input = Get-Content -Path .\input\part1.input


function Solution_example {
    $counter = 0
    $list = @(1)
    
    $pos = 0
    $row = ""
    $image = @()
    $spritepos = @(0, 1, 2)

    foreach ($line in $part1_example) {
        if ($line -eq "noop") {
            $list += ($list[-1] + $value)
            $spritepos = @(($list[-1] - 1), ($list[-1]), ($list[-1] + 1))
            $value = 0
            continue
        }        
        
        if ($line.StartsWith("addx")) {
            $list += ($list[-1] + $value)         
            
            $spritepos = @(($list[-1] - 1), ($list[-1]), ($list[-1] + 1))

            $list += $list[-1]
            $action, $value = $line.Split(" ")
        }

    }
    
    foreach ($item in ($list | Select-Object -Skip 1)) {
        $spritepos = @(($item - 1), ($item), ($item + 1))
        
        
        if ($pos -in $spritepos) {
            $row += "#"
        }
        else {
            $row += " "
        }

        $pos += 1

        if ($pos -eq 40) {
            $image += $row
            $row = ""
            $pos = 0
        }
    }

    $image
}

function Solution_input {
    $counter = 0
    $list = @(1)
    
    $pos = 0
    $row = ""
    $image = @()
    $spritepos = @(0, 1, 2)

    foreach ($line in $part1_input) {
        if ($line -eq "noop") {
            $list += ($list[-1] + $value)
            $spritepos = @(($list[-1] - 1), ($list[-1]), ($list[-1] + 1))
            $value = 0
            continue
        }        
        
        if ($line.StartsWith("addx")) {
            $list += ($list[-1] + $value)         
            
            $spritepos = @(($list[-1] - 1), ($list[-1]), ($list[-1] + 1))

            $list += $list[-1]
            $action, $value = $line.Split(" ")
        }

    }
    
    foreach ($item in ($list | Select-Object -Skip 1)) {
        $spritepos = @(($item - 1), ($item), ($item + 1))
        
        
        if ($pos -in $spritepos) {
            $row += "#"
        }
        else {
            $row += " "
        }

        $pos += 1

        if ($pos -eq 40) {
            $image += $row
            $row = ""
            $pos = 0
        }
    }

    $image
}

Write-Host "Output Example Part2:"
Solution_example
Write-Host "Output Input   Part2:"
Solution_input