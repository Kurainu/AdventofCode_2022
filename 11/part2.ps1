$part1_example = Get-Content -Path .\input\part1.example
$part1_input = Get-Content -Path .\input\part1.input


function Create_MonkeyList {
    param (
        [switch]$example
    )

    $Monkeys = @()

    if ($example) {
        $Monkeys += [pscustomobject]@{number = 0; items = [System.Collections.ArrayList]@(79,98);       Operation = '* 19';    Test = [pscustomobject]@{divide=23;true=2;false=3}; Inspections = 0}
        $Monkeys += [pscustomobject]@{number = 1; items = [System.Collections.ArrayList]@(54,65,75,74); Operation = '+ 6';     Test = [pscustomobject]@{divide=19;true=2;false=0}; Inspections = 0}
        $Monkeys += [pscustomobject]@{number = 2; items = [System.Collections.ArrayList]@(79,60,97);    Operation = '* $item'; Test = [pscustomobject]@{divide=13;true=1;false=3}; Inspections = 0}
        $Monkeys += [pscustomobject]@{number = 3; items = [System.Collections.ArrayList]@(74);          Operation = '+ 3';     Test = [pscustomobject]@{divide=17;true=0;false=1}; Inspections = 0}
    }else {
        $Monkeys += [pscustomobject]@{number = 0; items = [System.Collections.ArrayList]@(96,60,68,91,83,57,85);    Operation = '* 2';     Test = [pscustomobject]@{divide=17;true=2;false=5}; Inspections = 0}
        $Monkeys += [pscustomobject]@{number = 1; items = [System.Collections.ArrayList]@(75,78,68,81,73,99);       Operation = '+ 3';     Test = [pscustomobject]@{divide=13;true=7;false=4}; Inspections = 0}
        $Monkeys += [pscustomobject]@{number = 2; items = [System.Collections.ArrayList]@(69,86,67,55,96,69,94,85); Operation = '+ 6';     Test = [pscustomobject]@{divide=19;true=6;false=5}; Inspections = 0}
        $Monkeys += [pscustomobject]@{number = 3; items = [System.Collections.ArrayList]@(88,75,74,98,80);          Operation = '+ 5';     Test = [pscustomobject]@{divide=7; true=7;false=1};  Inspections = 0}
        $Monkeys += [pscustomobject]@{number = 4; items = [System.Collections.ArrayList]@(82);                      Operation = '+ 8';     Test = [pscustomobject]@{divide=11;true=0;false=2}; Inspections = 0}
        $Monkeys += [pscustomobject]@{number = 5; items = [System.Collections.ArrayList]@(72,92,92);                Operation = '* 5';     Test = [pscustomobject]@{divide=3; true=6;false=3};  Inspections = 0}
        $Monkeys += [pscustomobject]@{number = 6; items = [System.Collections.ArrayList]@(74,61);                   Operation = '* $item'; Test = [pscustomobject]@{divide=2; true=3;false=1};  Inspections = 0}
        $Monkeys += [pscustomobject]@{number = 7; items = [System.Collections.ArrayList]@(76,86,83,55);             Operation = '+ 4';     Test = [pscustomobject]@{divide=5; true=4;false=0};  Inspections = 0}
    }
    return $Monkeys
}

function Solution_example {

    $Monkeys = Create_MonkeyList -example

    $lcm = 1

    foreach ($item in $monkeys.test.divide) {
        $lcm *= $item
    }

    for ($i = 1; $i -le 10000; $i++) {
        foreach ($Monkey in $Monkeys) {
            # $Monkey.number
            foreach ($item in $Monkey.items.Clone()) {
                $Monkey.items.Remove($item)
                $item = "$item$($Monkey.Operation)" | Invoke-Expression
                $item = [System.Math]::Floor($item % $lcm)

                if ($item % $Monkey.Test.divide -eq 0) {
                    ($Monkeys | Where-Object -Property number -EQ -Value $Monkey.Test.true).items.Add($item) | out-null
                }else {
                    ($Monkeys | Where-Object -Property number -EQ -Value $Monkey.Test.false).items.Add($item) | out-null
                }

                $Monkey.Inspections += 1
            }
        }

    }

    $top2 = $Monkeys | Sort-Object -Descending -Property Inspections | Select-Object -First 2
    return $top2[0].Inspections * $top2[1].Inspections
}

function Solution_input {
    $Monkeys = Create_MonkeyList

    $lcm = 1

    foreach ($item in $monkeys.test.divide) {
        $lcm *= $item
    }

    for ($i = 1; $i -le 10000; $i++) {
        foreach ($Monkey in $Monkeys) {
            # $Monkey.number
            foreach ($item in $Monkey.items.Clone()) {
                $Monkey.items.Remove($item)
                $item = "$item$($Monkey.Operation)" | Invoke-Expression
                $item = [System.Math]::Floor($item % $lcm)
                # $item = [System.Math]::Floor($item/3)

                if ($item % $Monkey.Test.divide -eq 0) {
                    ($Monkeys | Where-Object -Property number -EQ -Value $Monkey.Test.true).items.Add($item) | out-null
                }else {
                    ($Monkeys | Where-Object -Property number -EQ -Value $Monkey.Test.false).items.Add($item) | out-null
                }

                $Monkey.Inspections += 1
            }
        }
    }

    $top2 = $Monkeys | Sort-Object -Descending -Property Inspections | Select-Object -First 2
    return $top2[0].Inspections * $top2[1].Inspections
}


Write-Host "Output Example Part1: $(Solution_example)"
Write-Host "Output Input   Part1: $(Solution_input)"