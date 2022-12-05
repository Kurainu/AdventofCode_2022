$part1_example = Get-Content -Path .\input\part1.example
$part1_input = Get-Content -Path .\input\part1.input



function Fill_Stack {
    Param(
    [Parameter(Mandatory=$false)]
    [Switch]$example
    )

    if ($example) {
        [System.Collections.Stack]$1 = @()
        [System.Collections.Stack]$2 = @()
        [System.Collections.Stack]$3 = @()

        $1.Push("Z")
        $1.Push("N")
        $2.Push("M")
        $2.Push("C")
        $2.Push("D")
        $3.Push("P")
        return $1,$2,$3

    }else {
        [System.Collections.Stack]$1 = @()
        [System.Collections.Stack]$2 = @()
        [System.Collections.Stack]$3 = @()
        [System.Collections.Stack]$4 = @()
        [System.Collections.Stack]$5 = @()
        [System.Collections.Stack]$6 = @()
        [System.Collections.Stack]$7 = @()
        [System.Collections.Stack]$8 = @()
        [System.Collections.Stack]$9 = @()

        $1.Push("N")
        $1.Push("D")
        $1.Push("M")
        $1.Push("Q")
        $1.Push("B")
        $1.Push("P")
        $1.Push("Z")
        
        $2.Push("C")
        $2.Push("L")
        $2.Push("Z")
        $2.Push("Q")
        $2.Push("M")
        $2.Push("D")
        $2.Push("H")
        $2.Push("V")
        
        $3.Push("Q")
        $3.Push("H")
        $3.Push("R")
        $3.Push("D")
        $3.Push("V")
        $3.Push("F")
        $3.Push("Z")
        $3.Push("G")
        
        $4.Push("H")
        $4.Push("G")
        $4.Push("D")
        $4.Push("F")
        $4.Push("N")
        
        $5.Push("N")
        $5.Push("F")
        $5.Push("Q")
        
        $6.Push("D")
        $6.Push("Q")
        $6.Push("V")
        $6.Push("Z")
        $6.Push("F")
        $6.Push("B")
        $6.Push("T")
        
        $7.Push("Q")
        $7.Push("M")
        $7.Push("T")
        $7.Push("Z")
        $7.Push("D")
        $7.Push("V")
        $7.Push("S")
        $7.Push("H")
        
        $8.Push("M")
        $8.Push("G")
        $8.Push("F")
        $8.Push("P")
        $8.Push("N")
        $8.Push("Q")
        
        $9.Push("B")
        $9.Push("W")
        $9.Push("R")
        $9.Push("M")

        return $1,$2,$3,$4,$5,$6,$7,$8,$9 

    }
}

function Solution_example {
    $message = ""
    $1,$2,$3 = Fill_Stack -example

    foreach ($line in $part1_example) {
        $null, $count, $from, $to = ($line | Select-String -Pattern "move (\d+) from (\d) to (\d)" -AllMatches).Matches.Groups.Value

        for ($i = 1; $i -le $count; $i++) {
            $src = Get-Variable -Name $from -ValueOnly
            $dst = Get-Variable -Name $to -ValueOnly
            $dst.Push($src.Pop())
        }
    }

    for ($i = 1; $i -le 3 ; $i++) {
        $stack = Get-Variable -Name $i -ValueOnly
        $message += $stack.Peek()
    }
    return $message
}

function Solution_input {
    $message = ""
    $1,$2,$3,$4,$5,$6,$7,$8,$9  = Fill_Stack

    foreach ($line in $part1_input) {
        $null, $count, $from, $to = ($line | Select-String -Pattern "move (\d+) from (\d) to (\d)" -AllMatches).Matches.Groups.Value

        for ($i = 1; $i -le $count; $i++) {
            $src = Get-Variable -Name $from -ValueOnly
            $dst = Get-Variable -Name $to -ValueOnly
            $dst.Push($src.Pop())
        }
    }

    for ($i = 1; $i -le 9 ; $i++) {
        $stack = Get-Variable -Name $i -ValueOnly
        $message += $stack.Peek()
    }
    return $message
}

Write-Host "Output Example Part1: $(Solution_example)"
Write-Host "Output Input   Part1: $(Solution_input)"