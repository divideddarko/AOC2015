<#INPUT
    123 -> af // 1111011
    456 -> y // 111001000
    af AND y -> d
    af OR y -> e
    af LSHIFT 2 -> f
    y RSHIFT 2 -> g
    NOT af -> h
    NOT y -> i

65535

    OUTPUT
    d: 72
    e: 507
    f: 492
    g: 114
    h: 65412
    i: 65079
    x: 123
    y: 456

    Reorder how we loop through the values, look to assign the data values first - c and b.
    Then do leftshift and rightshift, followed by NOT then AND / ORs



    Check to make sure both values have a numeric association, if it does incriment a count,
    when count -eq to the number of input lines then exit out of loop else look through contents
#>

Set-Location "C:\users\divid\documents\powershell\Advent of Code\2015\inputs"
$CodeInput = Get-Content "Day7.txt" | Sort-Object

$puzzleInput = @{ }

$CodeInput | ForEach-Object {
    $AlphaLocationValue = $($_ -split "-> ")[1]
    $puzzleInput.Add($_, $AlphaLocationValue)
}
# Output Array
$ResultsArray = @{ }

do {
    $puzzleInput.GetEnumerator() | Sort-Object Value | Select-Object Key -ExpandProperty Key | ForEach-Object {
        $AlphaLocationValue = $($_ -split "-> ")[1]

        # get the operator and inputs
        if ($_ -match "( AND | OR | LSHIFT | RSHIFT )") {
            $op = ($_ -split "( AND | OR | LSHIFT | RSHIFT )")[1]

            $inputOne = ($_ -split "( AND | OR | LSHIFT | RSHIFT )")[0]
            $inputTwo = ($_ -split "( AND | OR | LSHIFT | RSHIFT )" -split (" -> "))[2]

            if ($inputOne -match "[a-z]") {
                if ($ResultsArray.ContainsKey($inputOne)) {
                    $inputOneValue = $ResultsArray.Item($inputOne)
                } else {
                    $inputOneValue = $null
                }
            } else {
                $inputOneValue = $inputOne
            }

            if ($inputTwo -match "[a-z]") {
                if ($ResultsArray.ContainsKey($inputTwo)) {
                    $inputTwoValue = $ResultsArray.Item($inputTwo)
                } else {
                    $inputTwoValue = $null
                }
            } else {
                $inputTwoValue = $inputTwo
            }


        } elseif ($_ -match "NOT ") {
            $op = ($_ -split " ")[0]
            $inputOne = ($_ -split " ")[1]

            if ($inputOne -match "[a-z]") {
                if ($ResultsArray.ContainsKey($inputOne)) {
                    $inputOneValue = $ResultsArray.Item($inputOne)
                } else {
                    $inputOneValue = $null
                }
            } else {
                $inputOneValue = $inputOne
            }
        } else {

            $updateValue = ($_ -split " ")[0]

            if ($updateValue -match "[0-9]") {
                $inputOneValue = $updateValue
            } else {
                if ($ResultsArray.ContainsKey($updateValue)) {
                    $inputOneValue = $resultsarray.item($updateValue)
                } else {
                    $inputOneValue = $null
                }
            }
            $op = $null
        }

        $ci = $_

        #if (($op -match "NOT ") -or ($op -eq $null -and $inputOneValue -match "[0-9]") -or ($inputOneValue -match "[0-9]" -and $inputTwoValue -match "[0-9]")) {
        if (($op -eq $null -and $inputOneValue -match "[0-9]") -or ($op -match "(NOT)" -and $inputOneValue -match "[0-9]") -or ($op -match "( AND | OR | LSHIFT | RSHIFT )" -and $inputOneValue -match "[0-9]" -and $inputTwoValue -match "[0-9]")) {

            Write-Host "$($ci) /// $($op) - $($inputOneValue) : $($inputTwoValue)" -ForegroundColor Green
            switch ($op) {
                " AND " {
                    $q = $inputOneValue -band $inputTwoValue
                    if (!$ResultsArray.ContainsKey($AlphaLocationValue)) {
                        $ResultsArray.Add($AlphaLocationValue, $q)

                        Write-Host "$($ci) /// $($op) - $($inputOneValue) : $($inputTwoValue)" -ForegroundColor Green
                    }
                }
                " OR " {
                    $q = $inputOneValue -bor $inputTwoValue
                    if (!$ResultsArray.ContainsKey($AlphaLocationValue)) {
                        $ResultsArray.Add($AlphaLocationValue, $q)

                        Write-Host "$($ci) /// $($op) - $($inputOneValue) : $($inputTwoValue)" -ForegroundColor Green
                    }
                }
                " LSHIFT " {
                    $q = $inputOneValue -shl $inputTwoValue
                    if (!$ResultsArray.ContainsKey($AlphaLocationValue)) {
                        $ResultsArray.Add($AlphaLocationValue, $q)

                        Write-Host "$($ci) /// $($op) - $($inputOneValue) : $($inputTwoValue)" -ForegroundColor Green
                    }
                }
                " RSHIFT " {
                    $q = $inputOneValue -shr $inputTwoValue
                    if (!$ResultsArray.ContainsKey($AlphaLocationValue)) {
                        $ResultsArray.Add($AlphaLocationValue, $q)

                        Write-Host "$($ci) /// $($op) - $($inputOneValue) : $($inputTwoValue)" -ForegroundColor Green
                    }
                }
                "NOT" {
                    $q = (65535 - $($inputOneValue))
                    if (!$ResultsArray.ContainsKey($AlphaLocationValue)) {
                        $ResultsArray.Add($AlphaLocationValue, $q)
                        Write-Host "$($ci) /// $($op) - $($inputOneValue) : $($inputTwoValue)" -ForegroundColor Green
                    }
                }
                Default {
                    if (!$ResultsArray.ContainsKey($AlphaLocationValue)) {
                        $ResultsArray.Add($AlphaLocationValue, $updateValue)
                        Write-Host "$($ci) ///  $($inputOneValue)" -ForegroundColor Green
                    }
                }
            }

            $puzzleInput.Remove($ci)

            Write-Host "Removed: $($ci)"
        }

    }
    Write-Host "($($ResultsArray.Count) / $($CodeInput.Count))" -ForegroundColor Blue
} until ($puzzleInput.Count -eq 0)

Write-Host "A: " -NoNewline
Write-Host "$ResultsArray.Item('a')" -ForegroundColor Green