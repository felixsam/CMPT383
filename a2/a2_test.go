//Felix Sam

package a2

import(
"os"
"testing"
//"reflect"
"fmt"
)

func TestReadFile(t *testing.T){
	fmt.Println()
	fmt.Println()
	fmt.Println()
	fmt.Println("Testing the read File function: ")
	// Testing the read File function
	os.Args = []string{"cmd","input.json"}
	testJSON := ReadFile()

	test1Actual :=`{"s":[2, 3], "a < b && a >= c":true}`

	if testJSON != test1Actual{
		t.Errorf("Reading File failed: actual result is %s: , Expected Result is: %s",testJSON, test1Actual)
	}
}

func TestTOKEN(t *testing.T){

	fmt.Println()
	fmt.Println()
	fmt.Println()
	fmt.Println()
	fmt.Println("Testing the scan function: ")


	//Testing the scan function
	os.Args = []string{"cmd","input.json"}
	data := ReadFile()

	test1 := scan(data)
	//test1Actual := make([]Token,2)
	//Test1Compare := reflect.DeepEqual(test1,test1Actual)


	//Prettyprint test
	fmt.Println()
	fmt.Println()
	fmt.Println()
	fmt.Println()
	fmt.Println("Printing Tokens in the order they come in: ")
	for _, t := range test1 {
        fmt.Println(t)
    }

 	//Test full token pretty print: will be HTML
	fmt.Println()
	fmt.Println()
	fmt.Println()
	fmt.Println()
    fmt.Println("Testing PrettyPrint: ")
    prettyPrint(test1)


	fmt.Println()
	fmt.Println()
	fmt.Println()
	fmt.Println()
	/*
	if (Test1Compare != true){
		t.Errorf("Testing TOKEN FAILED: \n")
		//fmt.Println("Test data appears as: ", test1)
		//fmt.Println("Actual Data should be: ", test1Actual)
	}*/
 
}