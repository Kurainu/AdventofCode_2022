$part1_example = Get-Content -Path .\input\part1.example
$part1_input = Get-Content -Path .\input\part1.input

$mapboundary = 4000


# function Fill_square {
#     for ($y = 0; $y -lt $mapboundary; $y++) {
#         for ($x = 0; $x -lt $mapboundary; $x++) {
#             $map[$y,$x] = 0
#         }
#     }
# }

function Print_square {
    for ($y = 0; $y -lt $mapboundary; $y++) {
        $row = ""
        for ($x = 0; $x -lt $mapboundary; $x++) {
            $row += "$($map[$y,$x]) "
        }
        $row
    }
    
}


function Solution_example {
    $map = New-Object 'object[,]' $mapboundary,$mapboundary
    # Fill_square
    $tailsteps = [ordered]@{}
    $Hy = ($mapboundary /2)
    $Hx = ($mapboundary /2)
    $Ty = ($mapboundary /2)
    $Tx = ($mapboundary /2)
    $tailsteps["Startpos"] = "$Ty-$Tx"
         
    foreach ($line in $part1_example) {
        $direction,$count = $line.split(" ")
        for ($i = 1; $i -le ($count); $i++) {
            if ($direction -eq "R") {
                # Head
                $map[$Hy,$Hx] = "0"
                $Hx+=1
                $map[$Hy,$Hx] = "H"
            }elseif ($direction -eq "L") {
                # Head
                $map[$Hy,$Hx] = "0"
                $Hx-=1
                $map[$Hy,$Hx] = "H"
            }elseif ($direction -eq "D") {
                #Head
                $map[$Hy,$Hx] = "0"
                $Hy+=1
                $map[$Hy,$Hx] = "H"
            }elseif ($direction -eq "U") {
                #Head
                $map[$Hy,$Hx] = "0"
                $Hy-=1
                $map[$Hy,$Hx] = "H"
            }

            if ($ty -eq $Hy -and ($Tx+2) -eq $Hx) {
                #If head is two steps right from tail
                $map[$Ty,$Tx] = "0"
                $Tx+=1
                $map[$Ty,$Tx] = "T"
                $tailsteps["$($direction)_$($count)_$($i)_w/o_distance_r_$([guid]::NewGuid())"]= "$Ty-$Tx"
            }elseif ($ty -eq $Hy -and ($Tx-2) -eq $Hx) {
                #If head is two steps left from tail
                $map[$Ty,$Tx] = "0"
                $Tx-=1
                $map[$Ty,$Tx] = "T"
                $tailsteps["$($direction)_$($count)_$($i)_w/o_distance_l_$([guid]::NewGuid())"]= "$Ty-$Tx"
            }elseif ($tx -eq $Hx -and ($Ty-2) -eq $Hy) {
                #If head is two steps up from tail
                $map[$Ty,$Tx] = "0"
                $Ty-=1
                $map[$Ty,$Tx] = "T"
                $tailsteps["$($direction)_$($count)_$($i)_w/o_distance_u_$([guid]::NewGuid())"]= "$Ty-$Tx"
            }elseif ($tx -eq $Hx -and ($Ty+2) -eq $Hy) {
                #If head is two steps down from tail
                $map[$Ty,$Tx] = "0"
                $Ty+=1
                $map[$Ty,$Tx] = "T"
                $tailsteps["$($direction)_$($count)_$($i)_w/o_distance_d_$([guid]::NewGuid())"]= "$Ty-$Tx"
            }

            $distance = [math]::Floor([math]::Sqrt([math]::Pow(($Ty-$Hy),2) + [math]::Pow(($tx-$Hx),2)))
            if ($distance -eq 2 -and ($Ty -ne $Hy -or $Tx -ne $Hx)) {
                switch ($direction) {
                    "R" {
                        $map[$Ty,$Tx] = "0"
                        
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
                        
                        $map[$Ty,$Tx] = "T"        
                        $tailsteps["$($direction)_$($count)_$($i)_w_distance_r_$([guid]::NewGuid())"] = "$Ty-$Tx"
                    }
                    "L" {
                        $map[$Ty,$Tx] = "0"
                        
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
                        
                        $map[$Ty,$Tx] = "T"
                        $tailsteps["$($direction)_$($count)_$($i)_w_distance_l_$([guid]::NewGuid())"] = "$Ty-$Tx"
                    }
                    "U" {
                        $map[$Ty,$Tx] = "0"
                        
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
                        
                        $map[$Ty,$Tx] = "T"
                        $tailsteps["$($direction)_$($count)_$($i)_w_distance_u_$([guid]::NewGuid())"] = "$Ty-$Tx"
                    }
                    "D" {
                        $map[$Ty,$Tx] = "0"
                        
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
                        
                        $map[$Ty,$Tx] = "T"
                        $tailsteps["$($direction)_$($count)_$($i)_w_distance_d$([guid]::NewGuid())"] = "$Ty-$Tx"
                    }
                }
            }

            # "------- $direction - $count"
            # Print_square
        }
    }

    $tailsteps

}

function Solution_input {
    $map = New-Object 'object[,]' $mapboundary,$mapboundary
    # Fill_square
    $tailsteps = [ordered]@{}
    $Hy = ($mapboundary /2)
    $Hx = ($mapboundary /2)
    $Ty = ($mapboundary /2)
    $Tx = ($mapboundary /2)
    $tailsteps["Startpos"] = "$Ty-$Tx"
         
    foreach ($line in $part1_input) {
        $direction,$count = $line.split(" ")
        for ($i = 1; $i -le ($count); $i++) {
            if ($direction -eq "R") {
                # Head
                $map[$Hy,$Hx] = "0"
                $Hx+=1
                $map[$Hy,$Hx] = "H"
            }elseif ($direction -eq "L") {
                # Head
                $map[$Hy,$Hx] = "0"
                $Hx-=1
                $map[$Hy,$Hx] = "H"
            }elseif ($direction -eq "D") {
                #Head
                $map[$Hy,$Hx] = "0"
                $Hy+=1
                $map[$Hy,$Hx] = "H"
            }elseif ($direction -eq "U") {
                #Head
                $map[$Hy,$Hx] = "0"
                $Hy-=1
                $map[$Hy,$Hx] = "H"
            }

            if ($ty -eq $Hy -and ($Tx+2) -eq $Hx) {
                #If head is two steps right from tail
                $map[$Ty,$Tx] = "0"
                $Tx+=1
                $map[$Ty,$Tx] = "T"
                $tailsteps["$($direction)_$($count)_$($i)_w/o_distance_r_$([guid]::NewGuid())"]= "$Ty-$Tx"
            }elseif ($ty -eq $Hy -and ($Tx-2) -eq $Hx) {
                #If head is two steps left from tail
                $map[$Ty,$Tx] = "0"
                $Tx-=1
                $map[$Ty,$Tx] = "T"
                $tailsteps["$($direction)_$($count)_$($i)_w/o_distance_l_$([guid]::NewGuid())"]= "$Ty-$Tx"
            }elseif ($tx -eq $Hx -and ($Ty-2) -eq $Hy) {
                #If head is two steps up from tail
                $map[$Ty,$Tx] = "0"
                $Ty-=1
                $map[$Ty,$Tx] = "T"
                $tailsteps["$($direction)_$($count)_$($i)_w/o_distance_u_$([guid]::NewGuid())"]= "$Ty-$Tx"
            }elseif ($tx -eq $Hx -and ($Ty+2) -eq $Hy) {
                #If head is two steps down from tail
                $map[$Ty,$Tx] = "0"
                $Ty+=1
                $map[$Ty,$Tx] = "T"
                $tailsteps["$($direction)_$($count)_$($i)_w/o_distance_d_$([guid]::NewGuid())"]= "$Ty-$Tx"
            }

            $distance = [math]::Floor([math]::Sqrt([math]::Pow(($Ty-$Hy),2) + [math]::Pow(($tx-$Hx),2)))
            if ($distance -eq 2 -and ($Ty -ne $Hy -or $Tx -ne $Hx)) {
                switch ($direction) {
                    "R" {
                        $map[$Ty,$Tx] = "0"
                        
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
                        
                        $map[$Ty,$Tx] = "T"        
                        $tailsteps["$($direction)_$($count)_$($i)_w_distance_r_$([guid]::NewGuid())"] = "$Ty-$Tx"
                    }
                    "L" {
                        $map[$Ty,$Tx] = "0"
                        
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
                        
                        $map[$Ty,$Tx] = "T"
                        $tailsteps["$($direction)_$($count)_$($i)_w_distance_l_$([guid]::NewGuid())"] = "$Ty-$Tx"
                    }
                    "U" {
                        $map[$Ty,$Tx] = "0"
                        
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
                        
                        $map[$Ty,$Tx] = "T"
                        $tailsteps["$($direction)_$($count)_$($i)_w_distance_u_$([guid]::NewGuid())"] = "$Ty-$Tx"
                    }
                    "D" {
                        $map[$Ty,$Tx] = "0"
                        
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
                        
                        $map[$Ty,$Tx] = "T"
                        $tailsteps["$($direction)_$($count)_$($i)_w_distance_d$([guid]::NewGuid())"] = "$Ty-$Tx"
                    }
                }
            }

            # "------- $direction - $count"
            # Print_square
        }
    }

    $tailsteps
}

Write-Host "Output Example Part1: $(Solution_example)"
Write-Host "Output Input   Part1: $(Solution_input)"