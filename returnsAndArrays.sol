//SPDX-License-Identifier: hmm
pragma solidity ^0.8.13;

contract idkMane{
    uint public z;
    //So apparently in solidity, you can return multiple vals at the same time & there are multiple ways to return vals
    //Each pf the following are valid and they do basically the same things
    function multReturns() public pure returns(uint, string memory){
        return (88, "shit, I can do this?");
    }
    function multReturnz() public pure returns(uint d, string memory f){
        d = 89;
        f = "damn, I really can do this";
    }
    function multReturn2() public pure returns(uint e, string memory g){
        return (90, "aint no way bruh");
    }
    function multReturn5() public pure returns(uint e, string memory g, bool t, address u){
        return (90, "damn, fr?", true, address(789));
    }
    function destrAssign()public pure {//Destructuring Assignment: You can use this syntax to return multiple values
        (uint d, string memory k) = multReturns();//This will return both values
        (, string memory f) = multReturnz();//This will return the second value
        (uint e, ) = multReturn2();//This will return the first value
        //Idk why the above lines will not produce any actual output, maybe figure it out later?
    }
    //Arrays can be fixed length or dynamic, w/ the operations insert/push, pop, get, update, delete, and length
    uint[] public arr1;//This is a dynamic array
    uint[5] public arr2;//This is a fixed length array
    uint[] public arr3 = [0,1,2,3];//This is a dynamic array that has been initialized, you can still add values to it
    uint[4] public arr4 = [1,2,3,4];//This is a fixed array that has been initialized, you can't add anymore values to it
    uint[6] public arr5 = [2,1,7,8];//This is a fixed array that has been initialized, you can still add more values to it
    
    function arrayOperations() external returns(uint[] memory){//You can only return arrays that have been copied into memory
        arr1.push(8);//Push increases the overall size of the array on dynamic arrays by adding to the end of the array
        arr2.length;//This just gets the length of the array
        arr3.pop();//This will remove the value at the end of the array. Doesn't really matter on dynamic arrays, but the size will decrease by 1 for a fixed array
        z=arr4[3];//This is how you get the value from a slot in an array
        arr5[5]=z;//This is how you update the value of a slot in an array
        delete arr1[9];//This is how you delete the value of a slot in an array, but it actually just sets the value in the specified slot to 0 and does not change the size of the array
        uint[] memory arr6= new uint[](791);//This creates an array in memory. Arrays in memory must be a fixed size and you cannot push nor pop them
        arr6[65*(564-168)*(1/36)] = z;//And this is just an extra complicated way to assign a value to index 715

        return arr6;//You can only return arrays that have been copied into memory
      //return arr4; This will not work because the array has not been copied into memory
        //Returning arrays is discouraged because the larger an array, the more gas will be used. Very large arrays can easuly use up all of the gas and render a function unusable
    }
    function actualDelete() external view returns(uint[] memory){
        uint[] memory arr7 = new uint[](arr5.length);//Creates a new array that's the same length as arr5 (and the new array gets copied into memory)
        for(uint i; i<arr5.length; i++){//Copies all values of arr5 into arr7
            arr7[i]=arr5[i];
        }
        uint j;
        while(j<arr7.length-1){//Shifts all values towards the start of the array
            arr7[j]=arr7[j+1];
            j++;
        }
        delete arr7[j+1];//sets the last value in the array to 0
        uint[] memory arr8 = new uint[](arr7.length-1);//Creates a new array that's one index smaller than the previously created one
        for(uint i; i<arr7.length-1; i++){//Copies all values of arr7 into arr8
            arr8[i]=arr7[i];
        }
        return arr8;
        //Hypothetically, this should work
        /*You can also do this to very efficiently remove an element from an array, however the order is not preserved
        Obviously some things have to be smoothed out for compilation reasons, but consider this as the PoC
        uint[] public arr;
        function remRem(uint index) public{
            arr[index]=arr[arr.length-1];
            arr.pop();
        }*/
    }
}