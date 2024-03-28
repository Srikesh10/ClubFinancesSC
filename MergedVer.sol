// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ClubFinancials {
    address public owner;

    struct Record {
        uint256 amount;
        string sourceOrPurpose;
    }

    mapping(address => Record[]) public earningsRecords;
    mapping(address => Record[]) public expenditureRecords;

    uint256 public expenditureLimit; // Financial Fair Play expenditure limit

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }

    constructor(uint256 _expenditureLimit) {
        owner = msg.sender; // Set the deployer's address as the initial owner
        expenditureLimit = _expenditureLimit; // Set the initial expenditure limit
    }

    // Function for football clubs to record earnings
    function recordEarnings(uint256 _amount, string memory _source) public onlyOwner {
        // Validate inputs
        require(_amount > 0, "Earnings amount must be greater than zero");
        
        // Record earnings data on the blockchain
        earningsRecords[msg.sender].push(Record(_amount, _source));
        
        // Emit an event to notify external systems
        emit EarningsRecorded(msg.sender, _amount, _source);
    }

    // Function for football clubs to record expenditures
    function recordExpenditure(uint256 _amount, string memory _purpose) public onlyOwner {
        // Validate inputs
        require(_amount > 0, "Expenditure amount must be greater than zero");

        // Validate compliance with Financial Fair Play rules
        require(getTotalExpenditure(msg.sender) + _amount <= expenditureLimit, "Expenditure exceeds Financial Fair Play limit");
        
        // Record expenditure data on the blockchain
        expenditureRecords[msg.sender].push(Record(_amount, _purpose));
        
        // Emit an event to notify external systems
        emit ExpenditureRecorded(msg.sender, _amount, _purpose);
    }

    // Function to get total earnings recorded by a club
    function getTotalEarnings(address _clubAddress) public view returns (uint256 totalEarnings) {
        Record[] storage earnings = earningsRecords[_clubAddress];
        for (uint256 i = 0; i < earnings.length; i++) {
            totalEarnings += earnings[i].amount;
        }
    }

    // Function to get total expenditure recorded by a club
    function getTotalExpenditure(address _clubAddress) public view returns (uint256 totalExpenditure) {
        Record[] storage expenditures = expenditureRecords[_clubAddress];
        for (uint256 i = 0; i < expenditures.length; i++) {
            totalExpenditure += expenditures[i].amount;
        }
    }

    // Function to get all earnings and expenditures recorded by the owner
    function getRecordings() public view onlyOwner returns (Record[] memory, Record[] memory) {
        return (earningsRecords[msg.sender], expenditureRecords[msg.sender]);
    }

    // Function to update the expenditure limit (only callable by the contract owner)
    function updateExpenditureLimit(uint256 _newLimit) public onlyOwner {
        expenditureLimit = _newLimit;
    }

    // Event emitted when earnings are recorded
    event EarningsRecorded(address indexed clubAddress, uint256 amount, string source);

    // Event emitted when expenditures are recorded
    event ExpenditureRecorded(address indexed clubAddress, uint256 amount, string purpose);
}
