// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery
{
    address public manager;
    address payable[]  public participants;

    constructor ()
    {
        /* manager deploy this contract (authority to manger)*/
        manager=msg.sender; //global variable 

    }

    //transfer some ammount of ether in our contract from Participeant
    //reci() only one time you can use this function
    receive() external payable
    {
        //registered participant address when they trnsfter ammount 
        // we can set value of you have 2 ether the you can participant in the lottery

        require(msg.value==1 ether);
        participants.push( payable( msg.sender));
    }

    function getBalence() public view returns(uint)
    {

        //we give this authorization to our manager to view the balnce
        require(msg.sender==manager);
        return address(this).balance;
    }

    //function for selecting random participants
    function random() public view returns(uint)
    {
        //hashing algorithm 
      return  uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));

    }

    //manager select the winner 
    //returns()address we check here
    function selectWinner() public
    {
        require(msg.sender==manager); //cause manger will selct the winner
        require(participants.length>=3);


        //we select the index from the dynamic array
        uint r=random(); //radom element length is huge
        address payable winner;
        uint index=r % participants.length; //it give length of the array dynamic array above
        winner=participants[index];
        
        winner.transfer(getBalence());
        participants=new address payable[](0);   //change the dynamic array size to 0start thesecong round of the lottery()



    }
}
