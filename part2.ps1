$part1_example = Get-Content -Path .\input\part1.example
$part1_input = Get-Content -Path .\input\part1.input

$Root = [pscustomobject]@{Name = 'FileSystem Root'; Size = ''; Content = @(); Type = "Root"  }

$cwd = $Root


function Make_Dir($name) {
    $Directory = [pscustomobject]@{Name = $name; Size = ''; Content = @(); Parent = $cwd; Type = "Directory" }
    $cwd.Content += $Directory
}

function Change_Dir($name) {
    $dirname = $name.Replace("$ cd ", "")

    if ($dirname -eq "..") {
        $script:cwd = $cwd.Parent
        return
    }

    if ($cwd.Content | Where-Object { $_.Name -eq $dirname }) {
        $script:cwd = ($cwd.Content | Where-Object { $_.Name -eq $dirname })
    }
    else {
        Make_Dir($dirname)
        Change_Dir($dirname)        
    }
}

function Make_File($line) {
    $matches = ($line | Select-String -Pattern "(\d+)\s(.+)" -AllMatches)
    $size = $matches.Matches.Groups[1].Value
    $filename = $matches.Matches.Groups[2].Value

    $file = [pscustomobject]@{Name = $filename; Size = $size; Type = "File" }

    $cwd.Content += $file
    Recalc_size($file)
}

function Recalc_size($file) {
    while ($cwd.Type -ne "Root") {
        $sizesum = ($cwd.Content.Size | Measure-Object -Sum).Sum
        $cwd.Size = $sizesum
        $cwd = $cwd.Parent
    }
}

function Check_Directorys_Recurse($dir){

    foreach ($item in $dir.Content | Where-Object {$_.Type -eq "Directory"}) {
        if ($item.Size -le 100000) {
            $script:dirlist += $item
        }
        Check_Directorys_Recurse($item)
    }
}

function FunctionName {

    
}

function Get-Dirs($dir, $size) {
    foreach ($item in $dir.Content | Where-Object {$_.Type -eq "Directory"}) {
        if ($item.Size -gt $size) {
            $script:dirlist += $item
        }
        Get-Dirs -dir $item -size $size
    }

}
function Solution_example {

    $script:dirlist=@()

    $script:Root = [pscustomobject]@{Name = 'FileSystem Root'; Size = ''; Content = @(); Type = "Root"  }

    $script:cwd = $Root

    foreach ($line in $part1_example) {
        if ($line.StartsWith("$ ")) {
            $action = $line.Replace("$ ", "")

            if ($action.StartsWith("cd")) {
                Change_Dir($line)
            }
        }else {
            if ($line.StartsWith("dir")) {
                Make_Dir($line.Replace("dir ",""))
            }else {
                Make_File($line)
            }
        }
    }
   
    $unused = 70000000 - 30000000

    $freeup = $Root.Content.Size - $unused

    foreach ($item in $Root.Content | Where-Object {$_.Type -eq "Directory"}) {

        if ($item.Size -gt $freeup) {
            $script:dirlist += $item
        }
        Get-Dirs -dir $item -size $freeup
    }

    ($dirlist | Sort-Object -Property Size)[0].Size
}

function Solution_input {
    $script:dirlist=@()

    $script:Root = [pscustomobject]@{Name = 'FileSystem Root'; Size = ''; Content = @(); Type = "Root"  }

    $script:cwd = $Root

    foreach ($line in $part1_input) {
        if ($line.StartsWith("$ ")) {
            $action = $line.Replace("$ ", "")

            if ($action.StartsWith("cd")) {
                Change_Dir($line)
            }
        }else {
            if ($line.StartsWith("dir")) {
                Make_Dir($line.Replace("dir ",""))
            }else {
                Make_File($line)
            }
        }
    }
   
    $unused = 70000000 - 30000000

    $freeup = $Root.Content.Size - $unused

    foreach ($item in $Root.Content | Where-Object {$_.Type -eq "Directory"}) {

        if ($item.Size -gt $freeup) {
            $script:dirlist += $item
        }
        Get-Dirs -dir $item -size $freeup
    }

    ($dirlist | Sort-Object -Property Size)[0].Size}

Write-Host "Output Example Part1: $(Solution_example)"
Write-Host "Output Input   Part1: $(Solution_input)"