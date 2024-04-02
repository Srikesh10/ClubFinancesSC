<h1>**Club Financials Smart Contract**</h1>
This smart contract allows sports clubs to manage their financial data and ensure compliance with Financial Fair Play (FFP) rules using blockchain technology.

<h2>**How to Use**</h2>

<h3>**Deploy the Smart Contract**</h3>
* Deploy the ClubFinancials smart contract to the Ethereum blockchain.
* Set the initial governing authority address and the Financial Fair Play expenditure limit during deployment.

<h3>**Adding Financial Data**</h3>
* Use the 'reportFinancials' function to report financial data for your club.
* Provide the revenue and expenses as parameters to report financials.
* Ensure that your club is not already compliant before reporting financials.
* The contract automatically checks compliance based on reported financial data and the expenditure limit.

<h3>**Updating Expenditure Limit**</h3>
* Only the governing authority can update the expenditure limit using the updateExpenditureLimit function.
* Call this function with the new expenditure limit as a parameter to update.

<h3>**Other Functions**</h3>
getTotalEarnings: Get the total earnings recorded for a club.
getTotalExpenditure: Get the total expenditure recorded for a club.
isCompliant: Check if a club is compliant with FFP rules.

License
This project is licensed under the MIT License - see the LICENSE file for details.
