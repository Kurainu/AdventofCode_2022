$part2_example = Get-Content -Path .\input\part2.example
$part2_input = Get-Content -Path .\input\part2.input


function Solution_example {
    foreach ($line in $part2_example) {
        $array = $line.ToCharArray()
        for ($i = 0; $i -lt $array.Count; $i++) {
            if (($array[$i..($i+13)] | Group-Object).Count -eq 14) {
                $i+14
                break
            }
        }
    }
}

function Solution_input {
    foreach ($line in $part2_input) {
        $array = $line.ToCharArray()
        for ($i = 0; $i -lt $array.Count; $i++) {
            if (($array[$i..($i+13)] | Sort-Object -Unique | Group-Object).Count -eq 14) {
                $i+14
                $array[$i..($i+13)]
                break
            }
        }
    }
}

Write-Host "Output Example Part2: $(Solution_example)"
Write-Host "Output Input   Part2: $(Solution_input)"