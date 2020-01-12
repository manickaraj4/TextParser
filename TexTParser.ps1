#Using Module ./TextQuery.psm1
class TextQuery{

    #[PSNoteProperty]$InputString =[PSNoteProperty]::new("InputString","")
    #[PSNoteProperty]$StartRegexPattern
    #[PSNoteProperty]$StopRegexPattern
    #[PSNoteProperty]$SelectRow
    #[PSNoteProperty]$SelectRegex
    
    static [System.Collections.Hashtable] ExecuteQuery($InputString,$InputObj){
        #Write-Host $InputString
        #Write-Host "*******************"
        $OutputHash = @{matches=@();correspondingsubquery=@{}}
        $Outputmatches = @()
        $SubQueryOutput = @{matches=@();correspondingsubquery=@{}}
        $Started = $False
        $SubQueryInput =@()
        foreach($line in $InputString){
            #Write-Host "Outside "+$line
            
            if ($line -match $InputObj.StartRegexPattern){
                $Started = $True
                
            }
            if ($line -match $InputObj.SelectRegex) {
                if ($Started){

                    #Write-Host $line
                    $Outputmatches+=$line.ToString()
                }  
            }
            if($line -match $InputObj.StopRegexPattern){
                $Started = $False
                
                
            }
            if ($Started){
                if ($InputObj.SubQuery){
                    #Write-Host "inside sub-query"
                        $SubQueryInput +=$line
                }

            }else {
                if ($InputObj.SubQuery){
                    #Write-Host $InputObj.SubQuery
                  $SubQueryOutput["matches"]+=[TextQuery]::ExecuteQuery($SubQueryInput,$InputObj.SubQuery)
                  $SubQueryInput = @()
                }
            }
            
            
           
       
            
        }
        $OutputHash.matches = $Outputmatches
        $OutputHash.correspondingsubquery = $SubQueryOutput
        return $OutputHash
    }


    
}

$a = Get-Content ./commands.txt 
$jsonf = Get-Content ./example_1.json | ConvertFrom-Json
#$query = [TextQuery]$jsonf
#$str = [PSNoteProperty]::new("InputString",$a)
$result = [TextQuery]::ExecuteQuery($a,$jsonf)
$resultstr = ConvertTo-Json $result -Depth 5
Write-Host $resultstr

