// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FeeCollector{
    address public owner;
    uint256 public balance;

    constructor(){
        owner = msg.sender; //kontratı çağıran kişiyi tutuyoruz.
    }

    receive() payable external {
        balance += msg.value; //miktarı tutuyoruz (WEI cinsinde)
    }

    //@dev -- Bu fonksiyon kontrat adresinde biriken tokenları kendi kişisel hesabımıza veya başka bir hesaba çekmeye yarar.
    function withdraw(uint amount, address payable destAddr) public {
        require(msg.sender == owner, "Only owner can withdraw!"); //Sadece kontrat sahibi bu fonksiyonu çağırabilir.
        require(amount <= balance, "Insufficient funds!"); //Çekeceğimiz miktar toplam bakiyeden büyük olmamalıdır.

        destAddr.transfer(amount); //Verilen adrese miktarı gönderir.
        balance -= amount; 
    }
}