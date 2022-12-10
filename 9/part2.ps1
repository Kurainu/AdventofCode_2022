$part1_example = Get-Content -Path .\input\part2.example
$part1_input = Get-Content -Path .\input\part2.input

$mapboundary = 2000
# function Fill_square {
#     for ($y = 0; $y -lt $mapboundary; $y++) {
#         for ($x = 0; $x -lt $mapboundary; $x++) {
#             $map[$y,$x] = "."
#         }
#     }
# }

function Print_square {
    for ($y = 0; $y -lt $mapboundary; $y++) {
        $row = ""
        for ($x = 0; $x -lt $mapboundary; $x++) {
            $row += "$($map[$y,$x])"
        }
        $row
    }
    
}


function Move_tail {
    param (
        $tailnum,
        $ty,
        $tx,
        $hx,
        $hy,
        $direction
    )

    if ($ty -eq $Hy -and ($Tx+2) -eq $Hx) {
        #If head is two steps right from tail
        $map[$Ty,$Tx] = "."
        $Tx+=1
        # $map[$Ty,$Tx] = "T"
        $tailsteps["$($tailnum)_$($direction)_$($count)_$($i)_w/o_distance_u_$([guid]::NewGuid())"]= "$Ty-$Tx"
    }elseif ($ty -eq $Hy -and ($Tx-2) -eq $Hx) {
        #If head is two steps left from tail
        $map[$Ty,$Tx] = "."
        $Tx-=1
        # $map[$Ty,$Tx] = "T"
        $tailsteps["$($tailnum)_$($direction)_$($count)_$($i)_w/o_distance_u_$([guid]::NewGuid())"]= "$Ty-$Tx"
    }elseif ($tx -eq $Hx -and ($Ty-2) -eq $Hy) {
        #If head is two steps up from tail
        $map[$Ty,$Tx] = "."
        $Ty-=1
        # $map[$Ty,$Tx] = "T"
        $tailsteps["$($tailnum)_$($direction)_$($count)_$($i)_w/o_distance_u_$([guid]::NewGuid())"]= "$Ty-$Tx"
    }elseif ($tx -eq $Hx -and ($Ty+2) -eq $Hy) {
        #If head is two steps down from tail
        $map[$Ty,$Tx] = "."
        $Ty+=1
        # $map[$Ty,$Tx] = "T"
        $tailsteps["$($tailnum)_$($direction)_$($count)_$($i)_w/o_distance_u_$([guid]::NewGuid())"]= "$Ty-$Tx"
    }

    $distance = [math]::Floor([math]::Sqrt([math]::Pow(($Ty-$Hy),2) + [math]::Pow(($tx-$Hx),2)))
    if ($distance -eq 2 -and ($Ty -ne $Hy -or $Tx -ne $Hx)) {
        switch ($direction) {
            "R" {
                $map[$Ty,$Tx] = "."
                
                if ($tx -lt $hx) {
                    $Tx+=1
                }else {
                    $Tx-=1
                }
                
                if ($ty -lt $hy) {
                    $Ty+=1
                }else {
                    $Ty-=1
                }
                
                # $map[$Ty,$Tx] = "T"        
                $tailsteps["$($tailnum)_$($direction)_$($count)_$($i)_w/o_distance_u_$([guid]::NewGuid())"]= "$Ty-$Tx"
            }
            "L" {
                $map[$Ty,$Tx] = "."
                
                if ($tx -lt $hx) {
                    $Tx+=1
                }else {
                    $Tx-=1
                }
                
                if ($ty -lt $hy) {
                    $Ty+=1
                }else {
                    $Ty-=1
                }
                
                # $map[$Ty,$Tx] = "T"
                $tailsteps["$($tailnum)_$($direction)_$($count)_$($i)_w/o_distance_u_$([guid]::NewGuid())"]= "$Ty-$Tx"
            }
            "U" {
                $map[$Ty,$Tx] = "."
                
                if ($tx -lt $hx) {
                    $Tx+=1
                }else {
                    $Tx-=1
                }
                
                if ($ty -lt $hy) {
                    $Ty+=1
                }else {
                    $Ty-=1
                }
                
                # $map[$Ty,$Tx] = "T"
                $tailsteps["$($tailnum)_$($direction)_$($count)_$($i)_w/o_distance_u_$([guid]::NewGuid())"]= "$Ty-$Tx"
            }
            "D" {
                $map[$Ty,$Tx] = "."
                
                if ($tx -lt $hx) {
                    $Tx+=1
                }else {
                    $Tx-=1
                }
                
                if ($ty -lt $hy) {
                    $Ty+=1
                }else {
                    $Ty-=1
                }
                
                # $map[$Ty,$Tx] = "T"
                $tailsteps["$($tailnum)_$($direction)_$($count)_$($i)_w/o_distance_u_$([guid]::NewGuid())"]= "$Ty-$Tx"
            }
        }
    }
    return $Ty, $Tx
}


function Solution_example {
    $map = New-Object 'object[,]' $mapboundary,$mapboundary
    $tailsteps = [ordered]@{}
    $knots = @()
    
    $Hy = ($mapboundary/2)
    $Hx = ($mapboundary/2)
    $Ty = ($mapboundary/2)
    $Tx = ($mapboundary/2)

    $knots += ,@($Hy,$Hx)

    for ($i = 1; $i -lt 10; $i++) {
        $knots += , @($Ty,$Tx)
        $tailsteps["$($i)_Startpos"] = "$Ty-$Tx"
    }
         
    foreach ($line in $part1_example) {
        $direction,$count = $line.split(" ")
        for ($i = 1; $i -le ($count); $i++) {
            if ($direction -eq "R") {
                # Head
                $map[$knots[0][0],$knots[0][1]] = "."
                $knots[0][1]+=1
                $map[$knots[0][0],$knots[0][1]] = "H"
            }elseif ($direction -eq "L") {
                # Head
                $map[$knots[0][0],$knots[0][1]] = "."
                $knots[0][1]-=1
                $map[$knots[0][0],$knots[0][1]] = "H"
            }elseif ($direction -eq "D") {
                #Head
                $map[$knots[0][0],$knots[0][1]] = "."
                $knots[0][0]+=1
                $map[$knots[0][0],$knots[0][1]] = "H"
            }elseif ($direction -eq "U") {
                #Head
                $map[$knots[0][0],$knots[0][1]] = "."
                $knots[0][0]-=1
                $map[$knots[0][0],$knots[0][1]] = "H"
            }

            for ($ii = 0; $ii -lt ($knots.Count -1); $ii++) {
                $knots[($ii+1)][0],$knots[($ii+1)][1] = Move_tail -tailnum ($ii+1) -hy $knots[$ii][0] -hx $knots[$ii][1] -ty $knots[($ii+1)][0] -tx $knots[($ii+1)][1] -direction $direction
                $map[$knots[($ii+1)][0],$knots[($ii+1)][1]] = ($ii+1)
            }

        }
        # "------- $direction - $count"
        # Print_square | Out-File "test.txt" -Append
    }

    $9 = @()

    foreach($item in $tailsteps.Keys)
    {
        if($item.StartsWith("9_"))
        {
            $9 += $tailsteps[$item]
        }
    }

    ($9 | Sort-Object -Unique).count
}

function Solution_input {
    $map = New-Object 'object[,]' $mapboundary,$mapboundary
    $tailsteps = [ordered]@{}
    $knots = @()
    
    $Hy = ($mapboundary/2)
    $Hx = ($mapboundary/2)
    $Ty = ($mapboundary/2)
    $Tx = ($mapboundary/2)

    $knots += ,@($Hy,$Hx)

    for ($i = 1; $i -lt 10; $i++) {
        $knots += , @($Ty,$Tx)
        $tailsteps["$($i)_Startpos"] = "$Ty-$Tx"
    }
         
    foreach ($line in $part1_input) {
        $direction,$count = $line.split(" ")
        for ($i = 1; $i -le ($count); $i++) {
            if ($direction -eq "R") {
                # Head
                $map[$knots[0][0],$knots[0][1]] = "."
                $knots[0][1]+=1
                $map[$knots[0][0],$knots[0][1]] = "H"
            }elseif ($direction -eq "L") {
                # Head
                $map[$knots[0][0],$knots[0][1]] = "."
                $knots[0][1]-=1
                $map[$knots[0][0],$knots[0][1]] = "H"
            }elseif ($direction -eq "D") {
                #Head
                $map[$knots[0][0],$knots[0][1]] = "."
                $knots[0][0]+=1
                $map[$knots[0][0],$knots[0][1]] = "H"
            }elseif ($direction -eq "U") {
                #Head
                $map[$knots[0][0],$knots[0][1]] = "."
                $knots[0][0]-=1
                $map[$knots[0][0],$knots[0][1]] = "H"
            }

            for ($ii = 0; $ii -lt ($knots.Count -1); $ii++) {
                $knots[($ii+1)][0],$knots[($ii+1)][1] = Move_tail -tailnum ($ii+1) -hy $knots[$ii][0] -hx $knots[$ii][1] -ty $knots[($ii+1)][0] -tx $knots[($ii+1)][1] -direction $direction
                $map[$knots[($ii+1)][0],$knots[($ii+1)][1]] = ($ii+1)
            }

        }
        # "------- $direction - $count"
        # Print_square | Out-File "test.txt" -Append
    }

    $9 = @()

    foreach($item in $tailsteps.Keys)
    {
        if($item.StartsWith("9_"))
        {
            $9 += $tailsteps[$item]
        }
    }

    ($9 | Sort-Object -Unique).count
}

Write-Host "Output Example Part1: $(Solution_example)"
Write-Host "Output Input   Part1: $(Solution_input)"