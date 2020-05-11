$lightingArray  = [ordered]@{}

1 .. 1000 | % {
    $x = $_
    1 .. 1000 | % {
        $lightingArray.Add("$($x):$($_)", 0)
    }
}

$Day6Input = Get-Content "C:\Users\sbarton25\OneDrive - DXC Production\Documents\PowerShell\Advent of Code\inputs\Day6.txt"

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
                    $LightingArray.set_item("$($currentX):$($_)", 0)
                }
            }
         }
        "toggle"{
            "toggle"

            $sx .. $ex | % {
                $currentX = $_

                $sy .. $ey | % {
                    if($LightingArray.Contains("$($currentX):$($_)")) {
                        $currentLightState = $lightingArray.Item("$($currentX):$($_)")

                        if($currentLightState -eq 1){
                            $LightingArray.Set_Item("$($currentX):$($_)", 0)
                        } else {
                            $LightingArray.Set_Item("$($currentX):$($_)", 1)
                        }
                    }
                }
            }
        }
        "on"{
            "turn on"
            $sx .. $ex | % {
                $currentX = $_
                $sy .. $ey | % {
                    $LightingArray.set_item("$($currentX):$($_)", 1)
                }
            }
        }
    }
}

$lightingarray.values | ForEach-Object {
    if ($_ -match 1) {
         $i++
    }
}

Write-host "Total on: $($i)"