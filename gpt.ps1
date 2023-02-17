
$host.UI.RawUI.BackgroundColor = "Black"
$host.UI.RawUI.ForegroundColor = "Blue" # Set the terminal color to blue
$Host.UI.RawUI.WindowTitle = "GPT"
Clear-Host


while ($true) {

    $start_text = ""
    $input = Read-Host "$env:USERNAME " 

    $body = @{
        prompt      = $start_text+$input
        model       = "text-davinci-003"
        max_tokens  = 4000
        temperature = 0.9
        
    }
    
    $headers = @{
        'Content-Type'  = 'application/json'
        'Authorization' = "Bearer $env:OPENAI_API"
    }
    


    $jsonBody = $body | ConvertTo-Json  
    $connect = Invoke-WebRequest -Uri "https://api.openai.com/v1/completions" -Method POST -Body $jsonBody -Headers $headers -ContentType 'application/json'

    $response = $connect | ConvertFrom-Json | Select-Object -ExpandProperty choices | Select-Object -ExpandProperty text

    $response = $response.Remove(0, 2)

    Write-Host "gpt : $response" -foreground Green
}











