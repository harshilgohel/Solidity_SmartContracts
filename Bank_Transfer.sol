/*The purpose of this contract is to make a bank transfer transaction which includes 
deposit, withdraw and transferring to another bank account functions.
*/




pragma solidity ^0.8.0;

contract CustomBank{
    mapping(address => uint256) private balances;

//Add the details in the log with indexing
    event Transfer_Log(address indexed from, address indexed to, uint256 amount); 
    

//Deposite in Bank Account from wallet

    function deposit() public payable {
        require(msg.value > 0, "Amount should be greater than zero");
        balances[msg.sender] += msg.value;
    }

//Withdraw from bank account to wallet
    function withdraw(uint256 amount) public {
        require(amount > 0, "Amount should be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

//Transfering from one bank account to the different bank account
    function transfer(address to, uint256 amount) public {
        require(amount > 0, "Amount should be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer_Log(msg.sender, to, amount);
    }

//Checking bank balance
    function getBalance(address account) public view returns (uint256) {
        return balances[account];
    }
}
