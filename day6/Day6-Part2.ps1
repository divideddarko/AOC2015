$lightingArray  = [ordered]@{}

1 .. 1000 | % {
    $x = $_
    1 .. 1000 | % {
        $lightingArray.Add("$($x):$($_)", 0)
    }
}

$Day6Input = Get-Content "C:\Users\sbarton25\OneDrive - DXC Production\Documents\PowerShell\Advent of Code\AOC2015\inputs\Day6.txt"

$Day6Input | % {
    if ($_ -match "toggle"){
        $a = $_ -replace "toggle", "a toggle"
    } else {
        $a = $_
    }

    $toggle = ($a -split " ")[1]
    $sx = ($a -replace ",", " " -split " ")[2]
    $sy = ($a -replace ",", " " -split " ")[3]
    $ex = ($a -replace ",", " " -split " ")[5]
    $ey = ($a -replace ",", " " -split " ")[6]

    "toggle $($toggle)"

    switch ($toggle){
        "off"{
            "Turn off"

            $sx .. $ex | % {
                $currentX = $_
                $sy .. $ey | % {
                    $currentvalue = $lightingArray.Item("$($currentX):$($_)")

                    if ($($currentvalue -1) -lt 0){
                        $LightingArray.set_item("$($currentX):$($_)", 0)
                    } else {
                        $LightingArray.set_item("$($currentX):$($_)", $($currentvalue -1))
                    }
                }
            }
         }
        "toggle"{
            "toggle"

            $sx .. $ex | % {
                $currentX = $_
                $sy .. $ey | % {
                    $currentvalue = $lightingArray.Item("$($currentX):$($_)")
                    $LightingArray.Set_Item("$($currentX):$($_)", $($currentvalue + 2))
                }
            }
        }
        "on"{
            "turn on"
            $sx .. $ex | % {
                $currentX = $_
                $sy .. $ey | % {
                    $currentvalue = $lightingArray.item("$($currentX):$($_)")
                    $LightingArray.set_item("$($currentX):$($_)", $($currentvalue + 1))
                }
            }
        }
    }
}

$q = 0
$lightingarray.values | ForEach-Object {
    $q = $_ + $q
}