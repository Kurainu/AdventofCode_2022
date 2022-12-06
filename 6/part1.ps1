$part1_example = Get-Content -Path .\input\part1.example
$part1_input = Get-Content -Path .\input\part1.input


function Solution_example {
    foreach ($line in $part1_example) {
        $array = $line.ToCharArray()
        for ($i = 0; $i -lt $array.Count; $i++) {
            if (($array[$i..($i+3)] | Group-Object).Count -eq 4) {
                $i+4
                break
            }
        }
    }
}

function Solution_input {
    foreach ($line in $part1_input) {
        $array = $line.ToCharArray()
        for ($i = 0; $i -lt $array.Count; $i++) {
            if (($array[$i..($i+3)] | Sort-Object -Unique | Group-Object).Count -eq 4) {
                $i+4
                $array[$i..($i+3)]
                break
            }
        }
    }
}

Write-Host "Output Example Part1: $(Solution_example)"
Write-Host "Output Input   Part1: $(Solution_input)"