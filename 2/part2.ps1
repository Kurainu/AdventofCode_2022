$part2_example = Get-Content -Path .\input\part2.example
$part2_input = Get-Content -Path .\input\part2.input

$matrix = @{}
$matrix["A"] = @{"X" = "C";"Y"="A";"Z"="B"}
$matrix["B"] = @{"X" = "A";"Y"="B";"Z"="C"}
$matrix["C"] = @{"X" = "B";"Y"="C";"Z"="A"}


function Solution_example {
    $total_score = 0

    foreach ($line in $part2_example) {
        $round_score = 0

        $opponent,$self = $line.Split(" ")

        $result = $matrix[$opponent][$self]

        switch ($result) {
            "A" { $round_score += 1 }
            "B" { $round_score += 2 }
            "C" { $round_score += 3 }
        }

        switch ($self) {
            "Z"  { $round_score += 6 }
            "Y" { $round_score += 3 }
            "X" { $round_score += 0 }
        }

        $total_score += $round_score
    }

    $total_score
}

function Solution_input {
    $total_score = 0

    foreach ($line in $part2_input) {
        $round_score = 0

        $opponent,$self = $line.Split(" ")

        $result = $matrix[$opponent][$self]

        switch ($result) {
            "A" { $round_score += 1 }
            "B" { $round_score += 2 }
            "C" { $round_score += 3 }
        }

        switch ($self) {
            "Z"  { $round_score += 6 }
            "Y" { $round_score += 3 }
            "X" { $round_score += 0 }
        }

        $total_score += $round_score
    }

    $total_score
}

Write-Host "Output Example Part2: $(Solution_example)"
Write-Host "Output Input   Part2: $(Solution_input)"