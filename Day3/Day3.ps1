function Get-DayThree {
    Set-Location -Path "..\inputs\"
    #$TestInput = (Get-Content .\day3-test.txt).ToCharArray()
    $InputContent = (Get-Content .\day3.txt).ToCharArray()

    $x, $y, $q, $i, $finalCount = 0

    $t = 0

    $NewHouse = [ordered]@{ }
    $roboSanta = [ordered]@{ }

    # StartLocations
    $NewHouse.Add("X0:Y0", 0)
    $roboSanta.Add("X0:Y0", 0)

    $InputContent | ForEach-Object {
        if ($i % 2 -eq 0) {
            switch ($_) {
                ">" { $x++ }
                "<" { $x-- }
                "^" { $y++ }
                "v" { $y-- }
            }

            if ($NewHouse.Contains("X$($x):Y$($y)")) {
                $AddVal = $NewHouse.Item("X$($x):Y$($y)") + 1
                $NewHouse.Set_Item("X$($x):Y$($y)", $AddVal)
            } else {
                $NewHouse.Add("X$($x):Y$($y)", 1)
            }
        } else {
            switch ($_) {
                ">" { $q++ }
                "<" { $q-- }
                "^" { $t++ }
                "v" { $t-- }
            }

            if ($roboSanta.Contains("X$($q):Y$($t)")) {
                $AddVal = $roboSanta.Item("X$($q):Y$($t)") + 1
                $roboSanta.Set_Item("X$($q):Y$($t)", $AddVal)
            } else {
                $roboSanta.Add("X$($q):Y$($t)", 1)
            }
        }
        $i++
    }

    $NewHouse.keys | ForEach-Object {
        $a = $_
        $roboSanta.keys | ForEach-Object {
            if ($_ -eq $a) {
                $finalCount++
            }
        }
    }
    $z = $NewHouse.count + $roboSanta.Count - $finalCount

    "FinalCount $($z)"
}