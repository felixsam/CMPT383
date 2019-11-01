//Felix Sam

package a1

import(
"testing"
"reflect"
)


/****************************    QUESTION 1    ****************************/

func TestCountPrimes(t *testing.T) {

	//Test Valid Input n = 2
	test1 := countPrimes(2)
	if test1 != 1 {
		t.Errorf("Expected result is 1, Actual Result is : %d", test1)
	}

	// Test large n
	test2 := countPrimes(10000)

	if test2 != 1229 {
		t.Errorf("Expected result is 1229, Actual Result is : %d", test2)
	}

	//Test negative n
	test3 := countPrimes(-6)

	if test3 != 0 {
		t.Errorf("Expected result is 0, Actual Result is : %d", test3)
	}

	
	//Test when n = 0
	test4 := countPrimes(0)

	if test4 != 0 {
		t.Errorf("Expected result is 0, Actual Result is : %d", test4)
	}
	
	//Test when n = 1
	test5 := countPrimes(1)

	if test5 != 0 {
		t.Errorf("Expected result is 0, Actual Result is : %d", test5)
	}	

}

/****************************    QUESTION 2    ****************************/

func TestCountStrings(t *testing.T) {

// From https://stackoverflow.com/questions/24534072/how-to-compare-struct-slice-map-are-equal
// Used to compare two maps to see if they are equal

//Test if 'The' and 'the' are treated differently
test1 := countStrings("test1.txt")
test1Actual := map[string]int{"The":1, "the":1, "big":3, "dog":1, "ate":1, "apple":1}

Test1Compare := reflect.DeepEqual(test1,test1Actual)
if (Test1Compare != true){
		t.Errorf("Result does not match txt file: Expected Map {The:1, the:1, big:3, dog:1, ate:1, apple:1} ")
	}

//Test empty txt file
test2 := countStrings("test2.txt")
test2Actual := map[string]int{}

Test2Compare := reflect.DeepEqual(test2,test2Actual)
if Test2Compare != true{
		t.Errorf("Result does not match txt file: Expected Empty Map")
	}

}

/****************************    QUESTION 3    ****************************/

func TestEqualsTime24(t *testing.T) {

	a:= Time24{0,0,0}
	b:= Time24{0,0,0}
	c:= Time24{23,59,59}

	//Test when a and b are equal
	Test1 := equalsTime24(a,b)
	if Test1 != true {
		t.Errorf("Time should be equal for a and b, both are 00:00:00 ")
	}


	//Test when b and c are not equal
	Test2 := equalsTime24(b,c)
	if Test2 != false{
		t.Errorf("Time should not be equal for b and c, b is 00:00:00 and c is 23:59:59")
	}

}

func TestLessThanTime24(t *testing.T) {

	a:= Time24{0,0,0}
	b:= Time24{0,0,0}
	c:= Time24{23,59,59}

	//Test when a and b are equal
	Test1 := lessThanTime24(a,b)
	if Test1 != false {
		t.Errorf("a and b both are 00:00:00 and are equal, should be false")
	}

	//Test when b < c , result is true
	Test2 := lessThanTime24(b,c)
	if Test2 != true{
		t.Errorf("b is 00:00:00 which is less than c 23:59:59 , result should be true")
	}

	//Test when c > b , result should be false
	Test3 := lessThanTime24(c,b)
	if Test3 != false{
		t.Errorf("c (23:59:59) is greater than b (00:00:00) , result should be false")
	}

}

func TestTimeString(t *testing.T) {

	a:= Time24{9,9,10}

	Test1 := a.String()

	//Test with hour and minute = 9 and second > 9
	if (Test1 != "09:09:10"){
		t.Errorf("Expected 09:09:10 , actual result is %s ", Test1)
	}

	//Test with hour ,minute and second = 0
	b:= Time24{0,0,0}

	Test2 := b.String()

	if (Test2 != "00:00:00"){
		t.Errorf("Expected 00:00:00 , actual result is %s ", Test2)
	}
}

func TestValidTime24(t *testing.T) {

	a:= Time24{5,39,8}
	// Test for valid input
	Test1 := a.validTime24()

	if (Test1 != true){
		t.Errorf("A Time24{5,39,8} is a valid Time, TestValidTime24 should return true")
	}


	// Test for time = 0 for hour minute and seconds
	b:= Time24{0,0,0}

	Test2 := b.validTime24()

	if (Test2 != true){
		t.Errorf("B Time24{0,0,0} is a valid Time, TestValidTime24 should return true")
	}


	//Test for invalid input, when minute > 60
	c:= Time24{0,61,0}

	Test3 := c.validTime24()

	if (Test3 != false){
		t.Errorf("C Time24{0,61,0} is not a valid Time, TestValidTime24 should return false")
	}

}

func TestMinTime24(t *testing.T) {

	a:= Time24{1,1,1}
	b:= Time24{2,2,2}
	c:= Time24{23,44,33}
	d:= Time24{1,1,1}
	e:= Time24{15,50,22}
	f:= Time24{9,33,59}
	g:= Time24{2,2,2}

	TimeSlice := []Time24{a,b,c,d,e,f,g}

	//Testing for valid input for TestMinTime24
	Test1,Test1Error := minTime24(TimeSlice)

	if (Test1.hour != 1 || Test1.minute != 1 || Test1.second != 1){
		t.Errorf("Time is not the minimum expected {1,1,1}, Acutal result is {%d,%d,%d}", Test1.hour, Test1.minute, Test1.second)
	}

	if (Test1Error != nil){
		t.Errorf("Successful minTime24 should have no errors!")
	}

	//Testing when there is an empty time slice
	EmptyTimeSlice := []Time24{}

	Test2,Test2Error := minTime24(EmptyTimeSlice)

	if (Test2.hour != 0 || Test2.minute != 0 || Test2.second != 0){
		t.Errorf("Time Slice is empty , expected {0,0,0}, Acutal result is {%d,%d,%d}", Test2.hour, Test2.minute, Test2.second)
	}
	//There should be an error message 
	if (Test2Error.Error() != "The slice of []Time24 is Empty!"){
		t.Errorf("Error message does not match when calling minTime24(TimeSlice with invalid input) !")
	}

}

/****************************    QUESTION 4    ****************************/
func TestLinearSearch(t *testing.T) {


	// Test to find int in lst of int
	test1:= linearSearch(3,[]int{1,34,3,12,8})

	if ( test1 != 2){
		t.Errorf("Expected Index 2 , Actual Index is %d ", test1)
	}

	// Test to find string in lst of strings
	test2:= linearSearch("dog",[]string{"dog","cat","mouse","fish"})

	if ( test2 != 0 ){
		t.Errorf("Expected Index 0 , Actual Index is %d ", test2)
	}

	// Test to find int in empty lst
	test3:= linearSearch(1,[]int{})
	if ( test3 != -1 ){
		t.Errorf("Expected Index -1 (Empty List) , Actual Index is %d ", test3)
	}

	// Test to find string in empty lst
	test4:= linearSearch("dog",[]string{})
	if ( test4 != -1 ){
		t.Errorf("Expected Index -1 (Empty List) , Actual Index is %d ", test4)
	}

	// Test to search for string not found in lst
	test5:= linearSearch("dog",[]string{"moose","cat","mouse","fish"})

	if (test5 != -1){
		t.Errorf("Expected Index -1 (String not Found), Actual Index is %d" , test5)
	}

	// Test to search for int not found in lst
	test6:= linearSearch(5,[]int{1,34,3,12,8})

	if (test6 != -1){
		t.Errorf("Expected Index -1 (Int not Found), Actual Index is %d" , test6)
	}
}	


//Test cases that cause Panic
func TestLinearSearchPanic(t *testing.T) {
	//From https://stackoverflow.com/questions/31595791/how-to-test-panics
	//Use defer when panic occurs
	//Check for panic, throw error if it doesn't occur
	defer func(){
		if r := recover(); r == nil{
			t.Errorf("Test did not panic when linearSearch(x,lst) had different types for x and lst")
		}
	}()

	// Test to Search for Int in lst of Strings
	test1:= linearSearch(1,[]string{"dog","cat","mouse","fish"})
	if (test1 != -1){
		t.Errorf("Expected Index -1 (Finding an integer from lst of Strings), Actual Index is %d" , test1)
	} 

	// Test to Search for String in lst of Int
	test2:= linearSearch("dog",[]int{1,34,3,12,8})
	if (test2 != -1){
		t.Errorf("Expected Index -1 (Finding an String from lst of Int), Actual Index is %d" , test2)
	}


}
/****************************    QUESTION 5    ****************************/

func TestAllBitSeqs(t *testing.T) {

	//Test when n = 0
	test1:= allBitSeqs(0)
	test1Actual:= make([][]int,0)

	// From https://stackoverflow.com/questions/24534072/how-to-compare-struct-slice-map-are-equal
	// Used to compare two slices to see if they are equal
	Test1Compare := reflect.DeepEqual(test1,test1Actual)
	if (Test1Compare!=true){
		t.Errorf("AllBitSeqs(0) is incorrect, should return an empty slice")
	}

	//Test valid input
	test2:= allBitSeqs(3)
	test2Actual:= make([][]int,0)

	//Create 8 slices that contain the 2^3 = 8 bit sequences for n = 3
	//From https://www.dotnetperls.com/2d-go
	row1 := []int{0,0,0}
	row2 := []int{0,0,1}
	row3 := []int{0,1,0}
	row4 := []int{0,1,1}
	row5 := []int{1,0,0}
	row6 := []int{1,0,1}
	row7 := []int{1,1,0}
	row8 := []int{1,1,1}

	//Append the slices to test2Actual
	//From https://www.dotnetperls.com/2d-go
	test2Actual = append(test2Actual, row1)
	test2Actual = append(test2Actual, row2)
	test2Actual = append(test2Actual, row3)
	test2Actual = append(test2Actual, row4)
	test2Actual = append(test2Actual, row5)
	test2Actual = append(test2Actual, row6)
	test2Actual = append(test2Actual, row7)
	test2Actual = append(test2Actual, row8)

	Test2Compare := reflect.DeepEqual(test2,test2Actual)
	if (Test2Compare!=true){
		t.Errorf("AllBitSeqs(3) is incorrect, should return: %v" , test2Actual)
	}

}	
