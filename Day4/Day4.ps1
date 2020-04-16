function Get-DayFour {
    #part 1 - change match to '^0{5}'
    #part 2 - change match to '^0{6}'
    $inputstring = "iwrupvqb"
    $lowest = ""


    $algo = [System.Security.Cryptography.HashAlgorithm]::Create('MD5')

    1 .. 99999999 | ForEach-Object {

        $check = "$($inputstring)$($_)"

        $bytes = [System.Text.Encoding]::UTF8.GetBytes($check)
        $sb = New-Object System.Text.StringBuilder

        $algo.ComputeHash($bytes) | ForEach-Object {
            $null = $sb.Append($_.ToString("x2"))
        }

        if ($sb.ToString() -match '^0{6}') {
            "Found: $($sb.ToString()): $($_)"
            break
        }
    }
}