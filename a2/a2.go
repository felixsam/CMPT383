//Felix Sam

package main

import (
"os"
"fmt"
"io/ioutil"
"unicode"
"strings"
)

//From Chapter 2 Notes http://www.cs.sfu.ca/CourseCentral/383/tjd/syntaxAndEBNF.html
const (
    //
    // kinds of tokens
    //
    LEFT_BRACE  = iota // LEFT_BRACE = 0, increases by 1 for each const down
    RIGHT_BRACE        
    STRING
    VARIABLE
    COLON
    NUMBER
    BOOLEAN
    COMMA
    LEFT_BRACKET
    RIGHT_BRACKET
    AMP
    GREATER_THAN
    LESS_THAN
    EQUALS
)

//From Chapter 2 Notes http://www.cs.sfu.ca/CourseCentral/383/tjd/syntaxAndEBNF.html
type Token struct {
    kind   int
    lexeme string // the string representing the token, e.g. "345" or "("
}

//From Chapter 2 Notes http://www.cs.sfu.ca/CourseCentral/383/tjd/syntaxAndEBNF.html
// Map for Tokens
var kindName = map[int]string{
    LEFT_BRACE:  "LEFT_BRACE",
    RIGHT_BRACE: "RIGHT_BRACE",
    STRING: "STRING",
    VARIABLE:        "VARIABLE",
    NUMBER:       "NUMBER",
    COLON:  "COLON",
    BOOLEAN: "BOOLEAN",
    COMMA: "COMMA",
    LEFT_BRACKET: "LEFT_BRACKET",
    RIGHT_BRACKET: "RIGHT_BRACKET",
    AMP: "AMP",
    GREATER_THAN: "GREATER_THAN",
    LESS_THAN: "LESS_THAN",
    EQUALS: "EQUALS",
}




/***********************************    Json Input Reader    ***********************************/

//From https://stackoverflow.com/questions/35080109/golang-how-to-read-input-filename-in-go
//Reading Input filename using os.Args
func ReadFile() string{
	if len(os.Args) < 1 {
        fmt.Println("Usage : " + os.Args[0] + " file name")
        os.Exit(1)
    }

    file, err := ioutil.ReadFile(os.Args[1])
    if err != nil {
        fmt.Println("Cannot read the file")
        os.Exit(1)
    }

    return string(file)
}


//From Chapter 2 Notes http://www.cs.sfu.ca/CourseCentral/383/tjd/syntaxAndEBNF.html
func (t Token) String() string {
    return kindName[t.kind] + " " + t.lexeme
}


//From Chapter 2 Notes http://www.cs.sfu.ca/CourseCentral/383/tjd/syntaxAndEBNF.html
// Tests if c is a whitespace character.
func isWhitespace(c byte) bool {
    return c == ' ' || c == '\t' || c == '\n' || c == '\r'
}





/***********************************    JSON SCANNER    ***********************************/
// Modified scan function from Chapter 2 Notes: 
// http://www.cs.sfu.ca/CourseCentral/383/tjd/syntaxAndEBNF.html
// scan(s) goes through s character-by-character, dividing it into tokens. The
// tokens are returned, in the order they appear in s, on result.
func scan(s string) (result []Token) {
    //find the length of the token slice
    n := len(s)
    for i := 0; i < n; {
        if isWhitespace(s[i]) {
            // ignore all whitespace
            i++
            for i < n && isWhitespace(s[i]) {
                i++
            }

        //STRING TOKEN
        //Check for presence of double quotation mark
        } else if rune(s[i]) == rune('"') {
            start := i 
            i++
            
            //go through string until quotation mark appears
            for i<n && rune(s[i]) != rune('"'){
                i++
            }
            if ( i<n && rune(s[i]) == rune('"')){
                i++
                if (i <n ){
                    STRING := Token{STRING, s[start:i]}
                    result = append(result, STRING)
                }

            }




        /************************** BOOLEAN TOKENS **************************/
        //BOOLEAN ' true '
        } else if s[i] == 't'{
            start := i
            // iterate until string reaches true
            // Or until it is no longer a letter or number
            for i < n && ( unicode.IsLetter(rune(s[i])) || unicode.IsDigit(rune(s[i])) ) && s[start:i] != "true" {
                i++
            }
            //if the string is true, append as a BOOLEAN token
            //Else the string is a variable token
            if (s[start:i] == "true"){
                BOOL := Token{BOOLEAN, s[start:i]}
                result = append(result, BOOL)
            }else{
                VAR := Token{VARIABLE, s[start:i]}
                result = append(result, VAR)
            }

        //BOOLEAN  ' false '
        } else if s[i] == 'f'{
            // iterate until string reaches true
            start := i
            for i < n && ( unicode.IsLetter(rune(s[i])) || unicode.IsDigit(rune(s[i])) ) && s[start:i] != "false" {
                i++
            }
            //if the string is false, append as a BOOLEAN token
            //Else the string is a variable token            
            if (s[start:i] == "false"){
                BOOL := Token{BOOLEAN, s[start:i]}
                result = append(result, BOOL)
            }else{
                VAR := Token{VARIABLE, s[start:i]}
                result = append(result, VAR)
            }

        //BOOLEAN ' null '
        } else if s[i] == 'n'{
            // iterate until string reaches true
            start := i
            for i < n && ( unicode.IsLetter(rune(s[i])) || unicode.IsDigit(rune(s[i])) ) && s[start:i] != "null" {
                i++
            }
            //if the string is null, append as a BOOLEAN token
            //Else the string is a variable token                   
            if (s[start:i] == "null"){
                BOOL := Token{BOOLEAN, s[start:i]}
                result = append(result, BOOL)
            }else{
                VAR := Token{VARIABLE, s[start:i]}
                result = append(result, VAR)
            }




        //NUMBER TOKEN
        //Check for presence of Digit or Negative Sign
        } else if unicode.IsDigit(rune(s[i])) || s[i] == '-' {
            // Mark the start of the Number
            start := i

            //If it is the negative sign move to the next digit
            if (s[i] == '-'){
                i++
            }
            //If a digit is present move to the next digit
            for i < n && unicode.IsDigit(rune(s[i])) {
                i++
            }
            //check for decimal
            if (s[i] == '.'){
                i++
                for i < n && unicode.IsDigit(rune(s[i])) {
                    i++
                }
            }
            //check for exponent
            if (s[i] == 'e' || s[i] == 'E'){
                i++
                //check for plus and minus sign
                if (s[i] == '+' || s[i] == '-'){
                    i++
                }
                //check for digits
                for i < n && unicode.IsDigit(rune(s[i])) {
                    i++
                }
            }


            num := Token{NUMBER, s[start:i]}
            result = append(result, num)

        
        //VARIABLE TOKEN
        //Variables must start as a letter
        } else if unicode.IsLetter(rune(s[i])) {
            // find the start and end of the string
            start := i
            for i<n && ( unicode.IsLetter(rune(s[i])) || unicode.IsDigit(rune(s[i])) ){
                i++
            }
            VAR := Token{VARIABLE, s[start:i]}
            result = append(result, VAR)


        //LEFT BRACE TOKEN ' { '
        } else if s[i] == '{' {
            result = append(result, Token{LEFT_BRACE, "{"})
            i++


        //RIGHT BRACE TOKEN ' } ' 
        } else if s[i] == '}' {
            result = append(result, Token{RIGHT_BRACE, "}"})
            i++

        //COLON TOKEN ' : '
        } else if s[i] == ':' {
            result = append(result, Token{COLON, ":"})
            i++

        //COMMA TOKEN ' , '
        } else if s[i] == ',' {
            result = append(result, Token{COMMA, ","})
            i++ 

        //LEFT BRACKET TOKEN ' [ '
        } else if s[i] == '[' {
            result = append(result, Token{LEFT_BRACKET, "["})
            i++

        //RIGHT BRACKET TOKEN  ' ] '
        } else if s[i] == ']' {
            result = append(result, Token{RIGHT_BRACKET, "]"})
            i++


        //AMP TOKEN ' & '
        } else if s[i] == '&' {
            result = append(result, Token{AMP, "&"})
            i++

        //GREATER THAN TOKEN ' > '
        } else if s[i] == '>' {
            result = append(result, Token{GREATER_THAN, ">"})
            i++ 

        //LESS THAN TOKEN ' < ' 
        } else if s[i] == '<' {
            result = append(result, Token{LESS_THAN, "<"})
            i++ 

        //EQUALS TOKEN ' = '
        } else if s[i] == '=' {
            result = append(result, Token{EQUALS, "="})
            i++

        } else {
            i++
        }
    } // end of for loop
    return result
}





/***********************************    HTML Formatter/Printer    ***********************************/
// Modified Pretty Print function from http://www.cs.sfu.ca/CourseCentral/383/tjd/syntaxAndEBNF.html
// Prints the JSON file as a formatted HTML
// using fmt.Printf()
func HTMLPrint(tokens []Token) {

    //A counter to use in deciding how much to indent
    indenter := 0 

    //Prints a newline at beggining of HTML file
    fmt.Printf("\n")

    for key, t := range tokens {
        switch t.kind {

        /******************* THE 7 TOKENS THAT MUST BE COLORED *********************/


        //Case for LEFTBRACE Token ' { '
        //Uses the Color Purple 
        case LEFT_BRACE:


            //Printing opening span tag 
            fmt.Printf(`<span style="color:purple">`)

            //Add a break line if the previous token isn't a colon
            if ( (key-1) >= 0 && tokens[key-1].lexeme != string(":") ){
                fmt.Printf("<br>")
            }

            //The indenter
            //Create some indent with 4 &nbsp if there isn't a colon before it
            //From http://www.blooberry.com/indexdot/html/topics/indent.htm
            if ( (key-1)>=0 && indenter > 0 && tokens[key-1].lexeme != string(":") ){
                fmt.Printf(strings.Repeat("&nbsp",(indenter*4)))
            }


            //Printing the LEFT BRACE token on a seperate line
            fmt.Printf("%v" + "<br>", t.lexeme )

            //Printing the closing span tag and endline
            fmt.Print(`</span>` + "\n" )

            //Increase the indenter 
            indenter++


        //Case for RIGHTBRACE Token ' } '
        //Uses the same color as LEFTBRACE: purple
        case RIGHT_BRACE:

            //Printing opening span tag 
            fmt.Printf(`<span style="color:purple">`)
            //Print on a seperate line
            fmt.Printf("<br>")

            //RIGHT BRACE closes the content
            //decrease indenter
            if ( (key-1)>=0 && indenter > 0 ){
                indenter--
                fmt.Printf(strings.Repeat("&nbsp",(indenter*4)))
            }

            //Printing the RIGHT BRACE token
            fmt.Printf("%v", t.lexeme )

            //Add a break line if the next token isn't a comma
            if ( (key+1)< len(tokens) && tokens[key+1].lexeme != string(",") ){
                fmt.Printf("<br>")
            }

            //Printing the closing span tag and endline
            fmt.Print(`</span>` + "\n" )


        //Case for LEFTBRACKET OR RIGHT BRACKET "[" and "]"
        //Uses the Color Red
        case LEFT_BRACKET,RIGHT_BRACKET:

            //Printing opening span tag for LEFT or RIGHT BRACE
            fmt.Printf(`<span style="color:red">`)

            //Printing the LEFT OR RIGHT BRACKET token 
            //Using HTML <br>
            fmt.Printf( "%v", t.lexeme )


            //Printing the closing span tag and endline
            fmt.Print(`</span>` + "\n" )


        //Case for COLONS " : "
        //Uses the Color Orange
        case COLON:
            //Printing opening span tag
            fmt.Printf(`<span style="color:orange">`)

            //Printing the COLON token
            fmt.Printf("%v", t.lexeme)

            //Printing the closing span tag and end line
            fmt.Printf(`</span>` + "\n")


        //case for COMMA " , "
        //Uses the color Gray
        case COMMA:
           //Printing opening span tag
            fmt.Printf(`<span style="color:gray">`)

            //Indent the comma is it is before a LEFT BRACE { 
            if ( (key-1)>=0 && tokens[key-1].lexeme == string("{") ){ 
                fmt.Printf(strings.Repeat("&nbsp",(indenter*4)))
            }

            //Printing the COMMA token 
            fmt.Printf("%v", t.lexeme)

            //Breaks the line if comma is before or after a string or before right bracket
            //Tokens.kind == 2 is the token for STRING
            if ( (key-1)>=0 && tokens[key-1].lexeme == string("]") || 
                 (key+1) < len(tokens) && tokens[key+1].kind == 2 ||
                 (key-1)>=0 && tokens[key-1].kind == 2 ){

                 fmt.Printf("<br>")
                
            }
        
            //Printing the closing span tag and end line
            fmt.Printf(`</span>` + "\n")


        //Case for Booleans
        //Uses the color Pink
        case BOOLEAN:
           //Printing opening span tag
            fmt.Printf(`<span style="color:Pink">`)


            //Printing the BOOLEAN token
            fmt.Printf("%v", t.lexeme)

            //Printing the closing span tag and end line
            fmt.Printf(`</span>` + "\n")


        // Case for String Token
        // Uses the color green
        case STRING:

            //Create an empty string that will hold the properly formatted HTML string
            HTML_STRING := ""

            for i:=0;i < len(t.lexeme); i++{
                if string(t.lexeme[i]) == string('"'){
                    //replace "" with HTML &quot
                    HTML_STRING = HTML_STRING + "&quot;"
                    

                }else if string(t.lexeme[i]) == string(">") {
                    //replace > with HTML &gt
                    HTML_STRING = HTML_STRING + "&gt;"
                    

                }else if string(t.lexeme[i]) == string("<") {
                    //replace < with HTML &lt
                    HTML_STRING = HTML_STRING + "&lt;"
                    

                }else if string(t.lexeme[i]) == string("&") {
                    //replace & with HTML &amp
                    HTML_STRING = HTML_STRING + "&amp;"
                    

                }else if string(t.lexeme[i]) == string("'") {
                    //replace apostrophe with HTML &apos
                    HTML_STRING = HTML_STRING + "&apos;"

                }else if string(t.lexeme[i]) == string(`\`) {
                    tempstr := string(t.lexeme[i])
                    //color escape sequences as navy
                    if i+1 < len(t.lexeme) && strings.ContainsAny( string(t.lexeme[i+1]), "n & a & b & f & r & t & v & ' " ) {
                        i++
                        tempstr = tempstr + string(t.lexeme[i])
                    }
                    HTML_STRING = HTML_STRING + `<span style="color:navy">` + tempstr + `</span>`

                }else{
                    //append the character to our new string
                    HTML_STRING = HTML_STRING + string(t.lexeme[i])
                    
                }
            }

            //Modified String Completed
            //Adding HTML Span tags


            //Printing opening span tag
            fmt.Printf(`<span style="color:green">`)

            //Indenting the string
            //Tokens.kind == 2 is the token for STRING
            //Indents if token before it was '{'  , '}' , ',' or string token
            if ( (key-1)>=0 && tokens[key-1].lexeme == string("{") || 
                 (key-1)>=0 && tokens[key-1].lexeme == string("}") ||
                 (key-1)>=0 && tokens[key-1].lexeme == string(",") ||                 
                 (key-1)>=0 && tokens[key-1].kind == 2 ){

                fmt.Printf(strings.Repeat("&nbsp",(indenter*4)))
            }

            //Printing the modified string token
            fmt.Printf("%s", HTML_STRING)

            //Printing the ending span tag and endline
            fmt.Printf(`</span>` + "\n")
        



        //case for Number Token
        //Uses the color Blue
        case NUMBER:
            //prints opening span tag 
            fmt.Printf(`<span style="color:blue">`)

            //Prints the NUMBER token
            fmt.Printf("%v", t.lexeme)

            //prints closing span tag and endline
            fmt.Printf(`</span>` + "\n")



        //Case For " < " Token
        case LESS_THAN:
            //prints opening span tag 
            fmt.Printf(`<span>`)

            //replace < with &lt;
            fmt.Printf("&gt;")

            //prints closing span tag and endline
            fmt.Printf(`</span>` + "\n")


        //Case for " > " Token
        case GREATER_THAN:
            //prints opening span tag 
            fmt.Printf(`<span>`)

            //replace > with &gt;
            fmt.Printf("&lt;")

            //prints closing span tag and endline
            fmt.Printf(`</span>` + "\n")


        //case for " & " Token
        case AMP:
            //prints opening span tag 
            fmt.Printf(`<span>`)

            //replace & with &amp;
            fmt.Printf("&amp;")

            //prints closing span tag and endline
            fmt.Printf(`</span>` + "\n")


        //Default case:
        //No color
        default:
            //prints opening span tag 
            fmt.Printf(`<span>`)

            //prints the token
            fmt.Printf("%v", t.lexeme)

            //prints closing span tag and endline
            fmt.Printf(`</span>` + "\n")

        }
    } // for
    fmt.Println()
}




/***********************************    Main Function    ***********************************/
//Will scan input json
//And print the HTML formatted json in standard out
//Run the a2.go program as 'go run a2.go input.json > output.html'
//where input.json is the json file to be read
//and output.html is the html file to be created with formatted JSON
func main(){

    //Read the input json file as a string
    data := ReadFile()


    //Scan the input file and format it as a list of tokens
    ScannedData := scan(data)

    //Print Format for HTML DOCTYPE
    fmt.Printf("<!DOCTYPE html>\n" + "<html>\n" + "<body>\n")
                 

    //Print the JSON file formatted as HTML
    HTMLPrint(ScannedData)

    //Print closing tags for HTML DOCTYPE
    fmt.Printf("\n")
    fmt.Printf("</body>\n" + "</html>\n")

}
