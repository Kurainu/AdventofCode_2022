$part1_example = Get-Content -Path .\input\part1.example
$part1_input = Get-Content -Path .\input\part1.input

$matrix = @{}
$matrix["A"] = @{"X" = "DRAW";"Y"="WIN";"Z"="LOSE"}
$matrix["B"] = @{"X" = "LOSE";"Y"="DRAW";"Z"="WIN"}
$matrix["C"] = @{"X" = "WIN";"Y"="LOSE";"Z"="DRAW"}


function Solution_example {
    $total_score = 0

    foreach ($line in $part1_example) {
        $round_score = 0

        $opponent,$self = $line.Split(" ")

        $result = $matrix[$opponent][$self]

        switch ($self) {
            "X" { $round_score += 1 }
            "Y" { $round_score += 2 }
            "Z" { $round_score += 3 }
        }

        switch ($result) {
            "WIN"  { $round_score += 6 }
            "DRAW" { $round_score += 3 }
            "LOSE" { $round_score += 0 }
        }

        $total_score += $round_score
    }

    $total_score
}

function Solution_input {
    $total_score = 0

    foreach ($line in $part1_input) {
        $round_score = 0

        $opponent,$self = $line.Split(" ")

        $result = $matrix[$opponent][$self]

        switch ($self) {
            "X" { $round_score += 1 }
            "Y" { $round_score += 2 }
            "Z" { $round_score += 3 }
        }

        switch ($result) {
            "WIN"  { $round_score += 6 }
            "DRAW" { $round_score += 3 }
            "LOSE" { $round_score += 0 }
        }

        $total_score += $round_score
    }

    $total_score

}

Write-Host "Output Example Part1: $(Solution_example)"
Write-Host "Output Input   Part1: $(Solution_input)"