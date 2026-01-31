package leap

is_leap_year :: proc(year: int) -> bool {
	// Implement this procedure.
    result: bool = false;
    if(year % 4 == 0){
        result = true;
    }
    if(year % 100 == 0){
        result = false;
    }
    if(year % 400 == 0){
        result = true;
    }
    
	return result
}
