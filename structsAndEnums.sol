//SPDX-License-Identifier: guns blazing akimbo
pragma solidity ^0.8.1;
//Structs allow you to group data together, think of them as objects like you're used to in OOP
//Tidbit about 'memory' vs 'storage': 'memory' means that the respective data is loaded onto memory therefore, if it is modified, when the function is done executing, nothing will be saved
                                    //'storage' means that the respective data can be updated across the smart contract; changes are lingering
contract structs{
    struct Dog{
        string bark;
        uint size;
        bool tweaking;
        address owner;
    }
    Dog public doge;
    Dog[] public doges;
    mapping(address => Dog[]) public dogsByOwner;

    function breedingParty() external{
        Dog memory cujo = Dog(":OIFABL;isvb!!!!!", 4, true, address(0));//This is one way to initialize the values of a struct
        Dog memory clifford = Dog({tweaking:false, owner:address(1), bark:"rrrrrrrrrOOOOOOOOOOFFFFFFFFFFFF!", size:9});//This is another way to initialize the values of a struct
        Dog memory dmx = Dog({owner:msg.sender, size: type(uint).max, bark:"1, 2, X is coming for you...", tweaking:true});//This is basically the same as above but just rearranged
        //The proceeding line is yet another way to create a struct instance and then initialize the values for that respective struct instance
        Dog memory basicB;
        basicB.bark="grrr"; basicB.size=5; basicB.tweaking=false; basicB.owner=address(999);//You can put these on separate lines but I just didn't want to

        doges.push(cujo);//Just adding some created structs to the struct array
        doges.push(clifford);
        doges.push(dmx);
        doges.push(basicB);

        doges.push(Dog("standard issue bark", 5, false, address(5)));//This line creates a struct instance & appends it into an array all at once
        Dog storage _dog = doges[0];//Creates a new struct in slot 0 of the array
        _dog.bark="Excuse me. I am a civilized canine, I do not bark like the others. I can articulate my words even more effectively than you. Show some respect.";//This will uodate the struct in the array. As long as you identify the struct appropriately, it can be updated directly like this w/o having to mess around w/ array syntax & manipulation
        delete _dog.owner;//This will reset the address field for this struct to the default value (which happens to be the 0 address)
        delete doges[3];//This will reset all the fields for whatever struct is stored in this slot of the array (E.g., bark = "", size=0, tweaking=false, owner=address(0)
    }

    //Enums (short for Enumerable) are user-defined data types that restrict the variable to only have one of the predefined values
    
    enum Directions{//Various predefined values for this enum
        nowhere,//Default predifined value; if an enu is 'deleted', it will be set to this (0)
        up,//(1)
        down,//(2)
        left,//(3)
        right//(4)
    }
    Directions directions;//creates an instance of the enum
    struct direct{//struct composed of an enum value & a uint
        Directions directions;
        uint num;
    }
    direct[] public directs;//array of structs
    function get() external view returns(Directions){//gets the current value of the enum instance
        return directions;
    }
    function set(Directions _directions) external{//sets the current value of the enum instance to the user input
        directions = _directions;
    }
    function reset() external{//resets the current value of the enum instance to the default value (0)
        delete directions;
    }
}