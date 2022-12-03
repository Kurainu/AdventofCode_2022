$part1_example = Get-Content -Path .\input\part1.example
$part1_input = Get-Content -Path .\input\part1.input

$priorities = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

function Solution_example {
   
    $prioritysum = 0

    for ($i = 0; $i -lt $part1_example.Count; $i+=3) {
        $chunks = @()
        $chunks += @($part1_example[$i] -split '(\w{1})' -ne '' |Sort-Object -Unique -CaseSensitive)
        $chunks += @($part1_example[$i+1] -split '(\w{1})' -ne ''|Sort-Object -Unique -CaseSensitive)
        $chunks += @($part1_example[$i+2] -split '(\w{1})' -ne ''|Sort-Object -Unique -CaseSensitive)

        $item = ($chunks | Group-Object -CaseSensitive | Where-Object -Property Count -EQ -Value 3).name

        $prioritysum += $priorities.IndexOf($item) + 1
    }

    $prioritysum
}

function Solution_input {
    $prioritysum = 0

    for ($i = 0; $i -lt $part1_input.Count; $i+=3) {
        $chunks = @()
        $chunks += @($part1_input[$i] -split '(\w{1})' -ne '' |Sort-Object -Unique -CaseSensitive)
        $chunks += @($part1_input[$i+1] -split '(\w{1})' -ne ''|Sort-Object -Unique -CaseSensitive)
        $chunks += @($part1_input[$i+2] -split '(\w{1})' -ne ''|Sort-Object -Unique -CaseSensitive)

        $item = ($chunks | Group-Object -CaseSensitive | Where-Object -Property Count -EQ -Value 3).name

        $prioritysum += $priorities.IndexOf($item) + 1
    }

    $prioritysum
}

Write-Host "Output Example Part1: $(Solution_example)"
Write-Host "Output Input   Part1: $(Solution_input)"