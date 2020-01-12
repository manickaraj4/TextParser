
class TextQuery{

    #[PSNoteProperty]$InputString =[PSNoteProperty]::new("InputString","")
    #[PSNoteProperty]$StartRegexPattern
    #[PSNoteProperty]$StopRegexPattern
    #[PSNoteProperty]$SelectRow
    #[PSNoteProperty]$SelectRegex
    
    static [String]ExecuteQuery($InputString,$InputObj){
        $OutputString = ""
        $Started = $False
        $Count = 0
        foreach($line in $InputString){
            if ($InputString -match $InputObj.StartRegexPattern){
                $Started = $True
            }elseif (condition) {
                
            }elseif (condition) {
                
            }
                I
        }
        return $OutputString
    }


    
}