// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

contract FundBank {
    
    uint totalBankBalance = 0;

    function getBankBalance() public view returns (uint) {
        return totalBankBalance;
    }

    mapping (address => uint) balance;
    mapping (address => uint) depositTime;

    function addBalance() public payable returns (bool) {
        balance[msg.sender] = msg.value;
        totalBankBalance = totalBankBalance + msg.value;
        depositTime[msg.sender] = block.timestamp;

        return true;
    }

    function getBalance(address userAddress) public view returns (uint) {
        uint capital = balance[userAddress];
        uint timeElapsed = block.timestamp - depositTime[userAddress];
        return capital + uint((capital * 10 * timeElapsed) / (100 * 365 * 24 * 60 * 60 ));
    }

    function withdraw() public payable returns (bool) {
    address payable withdrawToAddress = payable(msg.sender);
    uint amountToTransfer = getBalance(msg.sender);

    // Re-entrancy guard
    balance[msg.sender] = 0;
    totalBankBalance = totalBankBalance - amountToTransfer;

    (bool sent, ) = withdrawToAddress.call{value: amountToTransfer}("");
    require(sent, "Transaction failed");

    return true;
}

    function addMoneyToBankContract() public payable {
        totalBankBalance = totalBankBalance + msg.value;
    }

    receive() external payable{
    }
}