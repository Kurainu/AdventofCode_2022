$part1_example = Get-Content -Path .\input\part1.example
$part1_input = Get-Content -Path .\input\part1.input

$map = New-Object 'object[,]' 5,5

$visibletrees = @()

function Check_Top_Trees($posx,$posy){
    $treenum = $map[$posy,$posx]
    $visible = $true

    for ($i = 1; $i -le $posy; $i++) {
        $rowtocheck = ($posy-$i)
        if ($treenum -gt $map[$rowtocheck,$posx]) {
            $visible = $true
        }else {
            $visible = $false
            break
        }
    }

    $visible
}

function Check_Bottom_Trees($posx,$posy,$arraywidth){

    $treenum = $map[$posy,$posx]
    $visible = $true

    for ($i = 1; $i -le ($arraywidth-$posy); $i++) {
        $rowtocheck = ($posy+$i)
        if ($treenum -gt $map[$rowtocheck,$posx]) {
            $visible = $true
        }else {
            $visible = $false
            break
        }
    }

    $visible
}

function Check_Right_Trees($posx,$posy,$arraywidth){

    $treenum = $map[$posy,$posx]
    $visible = $true

    for ($i = 1; $i -le ($arraywidth-$posx); $i++) {
        $columntocheck = ($posx+$i)
        if ($treenum -gt $map[$posy,$columntocheck]) {
            $visible = $true
        }else {
            $visible = $false
            break
        }
    }

    $visible
}


function Check_Left_Trees($posx,$posy){
    $treenum = $map[$posy,$posx]
    $visible = $true

    for ($i = 1; $i -le $posx; $i++) {
        $columntocheck = ($posx-$i)
        if ($treenum -gt $map[$posy,$columntocheck]) {
            $visible = $true
        }else {
            $visible = $false
            break
        }
    }

    $visible

}

function Solution_example {
    $row = 0
    $column = 0
    
    #Fill Map with values
    foreach ($rowentry in $part1_example) {
        foreach ($columnentry in ($rowentry -split "(.)" -ne "")) {
            $script:map[$row,$column] = $columnentry  
            $column+=1
        }
        $column=0
        $row+=1
    }

    for ($row = 1; $row -lt 4; $row++) {
        for ($column = 1; $column -lt 4; $column++) {
            #Check for Trees Top if its visible
            if (Check_Top_Trees -posx $row -posy $column) {
                $script:visibletrees += "$row$column"
            }
            if (Check_Bottom_Trees -posx $row -posy $column -arraywidth 4) {
                $script:visibletrees += "$row$column"
            }
            if (Check_Left_Trees -posx $row -posy $column) {
                $script:visibletrees += "$row$column"
            }
            if (Check_Right_Trees -posx $row -posy $column -arraywidth 4) {
                $script:visibletrees += "$row$column"
            }
        }
    }

    $interior = ($visibletrees| Sort-Object -Unique).count
    $outer = 5+5+3+3

    $interior + $outer
}

function Solution_input {
    $script:map = New-Object 'object[,]' 99,99
    $script:visibletrees = @()
    $row = 0
    $column = 0
    
    #Fill Map with values
    foreach ($rowentry in $part1_input) {
        foreach ($columnentry in ($rowentry -split "(.)" -ne "")) {
            $script:map[$row,$column] = $columnentry  
            $column+=1
        }
        $column=0
        $row+=1
    }

    for ($row = 1; $row -lt 98; $row++) {
        for ($column = 1; $column -lt 98; $column++) {
            #Check for Trees Top if its visible
            if (Check_Top_Trees -posx $row -posy $column) {
                $script:visibletrees += "$row$column"
            }
            if (Check_Bottom_Trees -posx $row -posy $column -arraywidth 98) {
                $script:visibletrees += "$row$column"
            }
            if (Check_Left_Trees -posx $row -posy $column) {
                $script:visibletrees += "$row$column"
            }
            if (Check_Right_Trees -posx $row -posy $column -arraywidth 98) {
                $script:visibletrees += "$row$column"
            }
        }
    }

    $interior = ($visibletrees| Sort-Object -Unique).count
    $outer = 99*4-4
    $interior + $outer
}


Write-Host "Output Example Part1: $(Solution_example)"
Write-Host "Output Input   Part1: $(Solution_input)"