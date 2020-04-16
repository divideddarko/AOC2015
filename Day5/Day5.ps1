function Get-DayFive {
    # contains at least three vowels
    # at least one letter that appears twice in a row
    # does not contain the strings ab, cd, pq, or xy

    Set-Location -Path "..\inputs"
    $TestInput = Get-Content .\day5.txt
    $i = 0

    $TestInput | ForEach-Object {


        if ($_ -match ".*[aeiou].*[aeiou].*[aeiou].*") {
            $partA
            if ($_ -match "([a]{2}|[b]{2}|[c]{2}|[d]{2}|[e]{2}|[f]{2}|[g]{2}|[h]{2}|[i]{2}|[j]{2}|[k]{2}|[l]{2}|[m]{2}|[n]{2}|[o]{2}|[p]{2}|[q]{2}|[r]{2}|[s]{2}|[t]{2}|[u]{2}|[v]{2}|[w]{2}|[x]{2}|[y]{2}|[z]{2})") {
                $partB

                if ($_ -notmatch "ab" -and $_ -notmatch "cd" -and $_ -notmatch "pq" -and $_ -notmatch "xy") {
                    $partC
                } else {
                    Write-Host "double letters exist failed: $_" -ForegroundColor Red
                    return
                }
            } else {
                Write-Host "double letter failed: $_" -ForegroundColor Red
                return
            }
        } else {
            Write-Host "aeriou failed: $_" -ForegroundColor Red
            return
        }

        if ($partA && $partB && $partC) {
            $i++
            Write-Host "Success $($_)" -ForegroundColor Green
        }
    }

    "Total: $($i)"

}

function Get-DayFivePartTwo {
    # contains at least three vowels
    # at least one letter that appears twice in a row
    # does not contain the strings ab, cd, pq, or xy

    Set-Location -Path "..\inputs"
    $TestInput = Get-Content .\day5.txt
    $i = 0

    $TestInput | ForEach-Object {

        if ($_ -match "(.).\1") {
            $partB
        } else {
            Write-Host "not repeats twice $_" -ForegroundColor Red
            return
        }


        if ($_ -match "(..).*\1") {
            $partA
        } else {
            Write-Host "double letter failed: $_" -ForegroundColor Red
            return
        }


        if ($partA && $partB) {
            $i++
            Write-Host "Success $($_)" -ForegroundColor Green
        }
    }

    "Total: $($i)"

}