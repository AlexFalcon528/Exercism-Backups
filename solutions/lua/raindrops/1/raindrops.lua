return function(n)
    string = ""
    if(n % 3 == 0) then
        string = string .. "Pling"
    end
    if(n % 5 == 0) then
        string = string .. "Plang"
    end
    if(n % 7 == 0) then
        string = string .. "Plong"
    end
    if(string == "") then
        return tostring(n)
    else
        return string
    end
end