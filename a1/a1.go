//Felix Sam

package a1

import(
"bufio"
"os"
"strconv"
"errors"
"reflect"
"math"
"strings"
"fmt"
)


/****************************    QUESTION 1    ****************************/
//From https://www.thepolyglotdeveloper.com/2015/04/determine-if-a-number-is-prime-using-javascript/
func countPrimes(n int) int {
	var count = 0 
	//Check all integers greater than 1
	if (n > 1){
		//Check each integer to see if it is prime
		// Increase the count if it is prime
		for i := 2; i <= n ; i++{
			if (isPrime(i)){
				count++
			}
		}
	}
	return count
}

//From https://www.thepolyglotdeveloper.com/2015/04/determine-if-a-number-is-prime-using-javascript/
func isPrime(number int) bool{
	//check if each number is divisible by other numbers
	// If it is, then it isn't prime
	for i := 2; i < number; i++{
		if (number % i == 0){
			return false
		}
	}
	return true;
}


/****************************    QUESTION 2    ****************************/

func countStrings(filename string) map[string]int {
	// From https://www.dotnetperls.com/file-go
	//"We can get each word separately as a string with the Scan() and Text() methods."
    f, _ := os.Open(filename)
    scanner := bufio.NewScanner(f)

    // Set the Split method to ScanWords.
    scanner.Split(bufio.ScanWords)

    //Create an empty map to store each different String
    MapStrings := make(map[string]int)

    // Scan all words from the file.
    // If the word exists, raise the count
    // Else add the word to the Map
    for scanner.Scan() {
        word := scanner.Text()
        // From https://stackoverflow.com/questions/2050391/how-to-check-if-a-map-contains-a-key-in-go
        // "To test for presence in the map without worrying about the actual value,"
        // "you can use the blank identifier, a simple underscore (_)"

        if _, ok := MapStrings[word]; ok {
        	MapStrings[word]++
        }else{
        	MapStrings[word] = 1
        }
    }
    return MapStrings
}


/****************************    QUESTION 3    ****************************/

type Time24 struct {
    hour, minute, second uint8
}
// 0 <= hour < 24
// 0 <= minute < 60
// 0 <= second < 60


func equalsTime24(a Time24, b Time24) bool{

	//Check that the hour, minute and seconds match for both a and b
	//If it does then it is equal, else it is false
	if (a.hour == b.hour && a.minute == b.minute && a.second == b.second){
		return true
	}else {
		return false
	}
}

func lessThanTime24(a Time24, b Time24) bool{
	//First check the hour 
	if (a.hour < b.hour){
		return true
	}else if (a.hour > b.hour){					//Hour is greater so A must be greater
		return false
	}else if (a.minute < b.minute){				//Check the minute if hour is the same
			return true
		}else if (a.minute > b.minute){
			return false
		}else if (a.second < b.second){			//Check the second if hour and minute is the same
				return true
			}else if (a.second > b.second){
				return false
			}else{							//Both times are equal so a is not strictly less than b
					return false
				}

}

func (t Time24) String() string{
	// From https://www.dotnetperls.com/convert-go
	// For how to convert a int to a string
	
	//make a blank string
	result:= ""

	//Check if Hour is greater than 9 else it needs a leading 0

	if (t.hour > 9){
		result = result + strconv.Itoa(int(t.hour)) + ":"
	}else{
		result = result + "0" + strconv.Itoa(int(t.hour)) + ":"
	}

	//Then check if minute is greater than 9 else it needs a leading 0

	if (t.minute > 9){
		result = result + strconv.Itoa(int(t.minute)) + ":"
	}else{
		result = result + "0" + strconv.Itoa(int(t.minute)) + ":"
	}

	//Then check if second is greater than 9 else it needs a leading 0

	if (t.second > 9){
		result = result + strconv.Itoa(int(t.second))
	}else{
		result = result + "0" + strconv.Itoa(int(t.second))
	}		
	return result
}

func (t Time24) validTime24() bool{
	if (t.hour >= 0 && t.hour < 24 && t.minute >= 0 && t.minute < 60 && t.second >= 0 && t.second < 60){
		return true
	}else{
		return false
	}
}

func minTime24(times []Time24) (Time24, error){
	if len(times) == 0{
		// From https://blog.golang.org/error-handling-and-go on how to create an error message
		// If times is empty, then Time24{0, 0, 0} is returned, 
		// along with an error object with a helpful message.
		return Time24{0,0,0}, errors.New("The slice of []Time24 is Empty!")
	}else{
		//start at the beginning of the slice
		minTime := times[0]
		// Check each time in the slice and compare with the minTime
		// if that time is less than minTime, it becomes the new MinTime
		for i := 1; i< len(times); i++{
			if ( lessThanTime24(times[i],minTime) == true ){
				minTime = times[i]
			}
		}
		return minTime, nil
	}
}

/****************************    QUESTION 4    ****************************/
//From https://stackoverflow.com/questions/40409945/golang-function-with-multiple-input-types
//Use type interface{} for multiple input types
func linearSearch(x interface{}, lst interface{}) int {


	// Check Type of input x and lst
    // From https://stackoverflow.com/questions/19389629/golang-get-the-type-of-slice
    // Get the type of the inputs x and lst using reflect.TypeOf()
	if ( reflect.TypeOf(x) != reflect.TypeOf(lst).Elem() ){
		//From https://gobyexample.com/panic
		panic("Type of X and Type of lst Do not Match!")
	}

	//Use reflect.ValueOf() to get the values of the lst of type interface{}
	List := reflect.ValueOf(lst)

	//When the list is empty return -1
	if (List.Len() == 0 ){
		return -1
	}

	//From https://stackoverflow.com/questions/12753805/type-converting-slices-of-interfaces-in-go
	//Use Index(i).Interface() to access the value of the lst of type interface{}
	for i:= 0 ; i < List.Len(); i++ {
		if (List.Index(i).Interface() == x){
			return i
		}
	}

	//x is not found in lst
	//Return -1
	return -1
}


/****************************    QUESTION 5    ****************************/

func allBitSeqs(n int) [][]int {

	//For n <= 0 return empty [][]int
	if n<=0{
		return make([][]int,0)
	}

	//https://golang.org/pkg/math/
	//There are 2^n possible bit sequences for n
	sliceLen := math.Pow(2,float64(n))

	//Convert length to int instead of float64
	intLen := int(sliceLen)

	//Make a slice of 2^n length to hold the result
	sliceSeq := make([][]int,int(intLen))

	//The possible bit sequences for n is the same as the binary numbers from 0 to 2^n
	// With leading zeros if the binary number is not length n
	for i:= 0; i< intLen; i++{
		i64 := int64(i)


		//From https://stackoverflow.com/questions/13870845/converting-from-an-integer-to-its-binary-representation
		//Convert the number to its binary representation
		binaryRep := strconv.FormatInt(i64,2)

		//If the length of the string is not equal to n
		//Add leading zeros
		//Ex: binary number for 2 is 10 which becomes 010
		for i:=0; i< n; i++{
			if (len(binaryRep) != n){
				binaryRep = "0" + binaryRep
			}
		}

		//Make a new array to hold a bit sequence
		IntArray := make([]int,n)

		//Split the string into an array of chars
		//From https://stackoverflow.com/questions/18556693/slice-string-into-letters
		CharArray := strings.Split(binaryRep,"")

		//Convert the char array to an int array
		//https://stackoverflow.com/questions/24972950/go-convert-strings-in-array-to-integer

		for i:=0; i<n; i++{
			Letter := CharArray[i]
			ConvertedInt, err := strconv.Atoi(Letter)
				if err != nil{
					fmt.Println("Error with String Conversion")
				}
			//Put the converted char to the resulting Integer Array	
			IntArray[i] = ConvertedInt	
		} 

		//Put the integer array(a possible bit sequence) into the slice for all bit sequences
		sliceSeq[i] = IntArray
	}
	return sliceSeq
}

func isBitSeq(seq []int) bool {
    for _, b := range seq {
        if !(b == 0 || b == 1) {
            return false
        }
    }
    return true
}