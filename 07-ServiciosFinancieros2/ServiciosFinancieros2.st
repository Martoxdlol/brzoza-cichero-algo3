!classDefinition: #PortfolioTest category: 'ServiciosFinancieros2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 11/29/2021 18:55:37'!
test12PortfolioCanNotIncludeItself

	| simplePortfolio |
	
	simplePortfolio := Portfolio new.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 0 equals: simplePortfolio accountsSize. ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros2'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #ReportsTests category: 'ServiciosFinancieros2'!
TestCase subclass: #ReportsTests
	instanceVariableNames: 'pepeAccount juanAccount tomasAccount fulanoPortfolio menganoPortfolio verifiyingReport verifiyingLine'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!ReportsTests methodsFor: 'testing private' stamp: 'TC 6/14/2022 13:46:44'!
assertLine: aLineString
	self assert: ((verifiyingReport show at: verifiyingLine) = aLineString).
	verifiyingLine _ verifiyingLine + 1.! !

!ReportsTests methodsFor: 'testing private' stamp: 'TC 6/14/2022 13:46:44'!
setReport: aReport
	verifiyingLine _ 1.
	verifiyingReport _ aReport.! !


!ReportsTests methodsFor: 'setUp' stamp: 'TC 6/14/2022 13:46:44'!
setUp
	pepeAccount _ ReceptiveAccount named: 'Cuenta de Pepe'.
	juanAccount _ ReceptiveAccount named: 'Cuenta de Juan'.
	tomasAccount _ ReceptiveAccount named: 'Cuenta de Tomas'.
	fulanoPortfolio _ Portfolio named: 'Portfolio de Fulano'.
	menganoPortfolio _ Portfolio named: 'Portfolio de mengano'.
	! !


!classDefinition: #AccountReportTest category: 'ServiciosFinancieros2'!
ReportsTests subclass: #AccountReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!AccountReportTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:26:32'!
test01ReportForEmptyAccountBalanceZero
	self setReport: (AccountSummaryReport from:  ReceptiveAccount new).
	self assertLine: 'Balance = 0 * pesos'.! !

!AccountReportTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:29:05'!
test02ReportFromReceptiveAccountWithATransaction
	Deposit register: (100 * peso) on: pepeAccount .
	
	self setReport: (AccountSummaryReport from: pepeAccount).
	
	self assertLine: 'Depósito por 100 * pesos'.
	self assertLine: 'Balance = 100 * pesos'.
! !

!AccountReportTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:29:01'!
test03ReportFromReceptiveAccountWithTransactions
	Deposit register: (100 * peso) on: pepeAccount.
	Deposit register: (100 * peso) on: pepeAccount.
	
	self setReport: (AccountSummaryReport from: pepeAccount).
	
	self assertLine: 'Depósito por 100 * pesos'.
	self assertLine: 'Depósito por 100 * pesos'.
	self assertLine: 'Balance = 200 * pesos'.
! !

!AccountReportTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:30:12'!
test04ReportFromReceptiveAccountWithWithdraw
	Withdraw register: (100 * peso) on: pepeAccount .
	self setReport: (AccountSummaryReport from: pepeAccount).
	self assertLine: 'Extracción por 100 * pesos'.
	self assertLine: 'Balance = -100 * pesos'.
! !

!AccountReportTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:32:31'!
test05ReportFromReceptiveAccountWithTransfer
	Transfer amount: (100 * peso) from: pepeAccount to: juanAccount .
	
	self setReport: (AccountSummaryReport from: pepeAccount).
	self assertLine: 'Salida por transferencia de 100 * pesos'.
	self assertLine: 'Balance = -100 * pesos'.
	
	self setReport: (AccountSummaryReport from: juanAccount).
	self assertLine: 'Entrada por transferencia de 100 * pesos'.
	self assertLine: 'Balance = 100 * pesos'.! !

!AccountReportTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:33:39'!
test06ReportFromReceptiveAccountInAPortfolio
	| portfolio |
	portfolio _ Portfolio with: pepeAccount.
	self setReport: (AccountSummaryReport from:  portfolio).
	
	self assertLine: 'Balance = 0 * pesos'
	! !

!AccountReportTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:34:12'!
test07ReportFromReceptiveAccountInAPortfolioWithATransaction
	| portfolio |
	portfolio _ Portfolio with: pepeAccount.
	Deposit register: (100 * peso) on: pepeAccount .
	
	self setReport: (AccountSummaryReport from: portfolio).
	
	self assertLine: 'Depósito por 100 * pesos'.
	self assertLine: 'Balance = 100 * pesos'.
	! !

!AccountReportTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:34:57'!
test08ReportFromReceptiveAccountInAPortfolioWithMultipleATransaction
	| portfolio |
	portfolio _ Portfolio with: pepeAccount.
	Deposit register: (100 * peso) on: pepeAccount .
	Withdraw register: (40 * peso) on: pepeAccount .
	
	self setReport: (AccountSummaryReport from: portfolio).
	
	self assertLine: 'Depósito por 100 * pesos'.
	self assertLine: 'Extracción por 40 * pesos'.
	self assertLine: 'Balance = 60 * pesos'.
	! !


!classDefinition: #NetTransferReportTest category: 'ServiciosFinancieros2'!
ReportsTests subclass: #NetTransferReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!NetTransferReportTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:36:34'!
test01ReportForEmptyAccountBalanceZero
	self setReport: (NetTransferReport from: pepeAccount).
	self assertLine: 'Balance = 0 * pesos'.! !

!NetTransferReportTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:38:39'!
test02ReportWithATransfer
	Transfer amount: (100 * peso) from: pepeAccount to: juanAccount.
	
	self setReport: (NetTransferReport from: pepeAccount).
	self assertLine: 'Salida por transferencia de 100 * pesos'.
	self assertLine: 'Balance = -100 * pesos'.
	
	self setReport: (NetTransferReport from: juanAccount).
	self assertLine: 'Entrada por transferencia de 100 * pesos'.
	self assertLine: 'Balance = 100 * pesos'.! !

!NetTransferReportTest methodsFor: 'tests' stamp: 'TC 6/15/2022 18:57:47'!
test03ReportIgnoreNotTransferTransaction
	Transfer amount: (100 * peso) from: pepeAccount to: juanAccount.
	Deposit register: (200 * peso) on: pepeAccount .
	
	self setReport: (NetTransferReport from: pepeAccount).
	self assertLine: 'Salida por transferencia de 100 * pesos'.
	self assertLine: 'Balance = -100 * pesos'.
! !

!NetTransferReportTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:41:24'!
test04ReportWithMultipleTransfers
	Transfer amount: (100 * peso) from: pepeAccount to: juanAccount.
	Transfer amount: (300 * peso) from: juanAccount to: pepeAccount.
	
	self setReport: (NetTransferReport from: pepeAccount).
	self assertLine: 'Salida por transferencia de 100 * pesos'.
	self assertLine: 'Entrada por transferencia de 300 * pesos'.
	self assertLine: 'Balance = 200 * pesos'.
	
	self setReport: (NetTransferReport from: juanAccount).
	self assertLine: 'Entrada por transferencia de 100 * pesos'.
	self assertLine: 'Salida por transferencia de 300 * pesos'.
	self assertLine: 'Balance = -200 * pesos'.! !

!NetTransferReportTest methodsFor: 'tests' stamp: 'VB 6/15/2022 15:35:24'!
test05ReportForEmptyPortfolioBalanceZero
	self setReport: (NetTransferReport from: fulanoPortfolio).
	self assertLine: 'Balance = 0 * pesos'.! !

!NetTransferReportTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:46:20'!
test06ReportWithATransferInAPortfolio
	| portfolio |
	portfolio _ Portfolio with: pepeAccount with: juanAccount.
	Transfer amount: (100 * peso) from: pepeAccount to: juanAccount.
	
	self setReport: (NetTransferReport from: portfolio).
	self assertLine: 'Salida por transferencia de 100 * pesos'.
	self assertLine: 'Entrada por transferencia de 100 * pesos'.
	self assertLine: 'Balance = 0 * pesos'.
	! !


!classDefinition: #PortfolioDetailedTreePrinterTest category: 'ServiciosFinancieros2'!
ReportsTests subclass: #PortfolioDetailedTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:50:32'!
test01ReportEmptyPortfolio
	self setReport: (PortfolioDetailedTreePrinter from: fulanoPortfolio).
	self assertLine: (fulanoPortfolio name).! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:50:28'!
test02ReportPortfolioWithAccount
	| portfolio | 
	portfolio _ Portfolio named: 'Portfolio de Pipe' with: pepeAccount .
	
	self setReport: (PortfolioDetailedTreePrinter from: portfolio).
	
	self assertLine: 'Portfolio de Pipe'.
	self assertLine: '    Cuenta de Pepe'.
	self assertLine: '        Balance = 0 * pesos'.
	self assertLine: '    Balance = 0'.
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:54:09'!
test03ReportPortfolioWithAccountWithATransaction
	| portfolio | 
	portfolio _ Portfolio named: 'Portfolio de Pipe' with: pepeAccount .
	Deposit register: (100 * peso) on: pepeAccount.
	
	self setReport: (PortfolioDetailedTreePrinter from: portfolio).
	
	self assertLine: 'Portfolio de Pipe'.
	self assertLine: '    Cuenta de Pepe'.
	self assertLine: '        Depósito por 100 * pesos'.
	self assertLine: '        Balance = 100 * pesos'.
	self assertLine: '    Balance = 100 * pesos'.
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:59:20'!
test04ReportPortfolioWithAccountWithATransactionInAPortfolio
	| portfolio portfolio2 | 
	portfolio2 _ Portfolio named: 'Portfolio de Pipe' with: pepeAccount.
	portfolio _ Portfolio named: 'Portfolio principal' with: portfolio2.
	Deposit register: (100 * peso) on: pepeAccount.
	
	self setReport: (PortfolioDetailedTreePrinter from: portfolio).
	
	self assertLine: 'Portfolio principal'.
	self assertLine: '    Portfolio de Pipe'.
	self assertLine: '        Cuenta de Pepe'.
	self assertLine: '            Depósito por 100 * pesos'.
	self assertLine: '            Balance = 100 * pesos'.
	self assertLine: '        Balance = 100 * pesos'.
	self assertLine: '    Balance = 100 * pesos'.
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/14/2022 16:18:39'!
test05ReportPortfolioWithMultiplePortfoliosWithAccountWithTransaction
	| portfolioPrincipal portfolio1 portfolio2 | 
	
	portfolio1 _ Portfolio named: 'Portfolio de Pipe' with: pepeAccount.
	portfolio2 _ Portfolio named: 'Portfolio de Franco' with: juanAccount .
	portfolioPrincipal _ Portfolio named: 'Portfolio principal' with: portfolio1 with: portfolio2.
	
	Deposit register: (100 * peso) on: pepeAccount.
	Withdraw register: (200 * peso) on: juanAccount .
	
	self setReport: (PortfolioDetailedTreePrinter from: portfolioPrincipal).
	
	self assertLine: 'Portfolio principal'.
	self assertLine: '    Portfolio de Pipe'.
	self assertLine: '        Cuenta de Pepe'.
	self assertLine: '            Depósito por 100 * pesos'.
	self assertLine: '            Balance = 100 * pesos'.
	self assertLine: '        Balance = 100 * pesos'.
	self assertLine: '    Portfolio de Franco'.
	self assertLine: '        Cuenta de Juan'.
	self assertLine: '            Extracción por 200 * pesos' .
	self assertLine: '            Balance = -200 * pesos'.
	self assertLine: '        Balance = -200 * pesos+0'.
	self assertLine: '    Balance = -100 * pesos'.
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/15/2022 19:38:43'!
test06ReportPortfolioWithAccountPortfolioWithAccount
	| portfolioPrincipal portfolio1 |
	
	portfolio1 _ Portfolio named: 'Portfolio de Pipe' with: pepeAccount.
	portfolioPrincipal _ Portfolio named: 'Portfolio principal' with: portfolio1 with: juanAccount.
	
	self setReport: (PortfolioDetailedTreePrinter from: portfolioPrincipal).
	
	self assertLine: 'Portfolio principal'.
	self assertLine: '    Portfolio de Pipe'.
	self assertLine: '        Cuenta de Pepe'.
	self assertLine: '            Balance = 0 * pesos'.
	self assertLine: '        Balance = 0'.
	self assertLine: '    Cuenta de Juan'.
	self assertLine: '        Balance = 0 * pesos'.
	self assertLine: '    Balance = 0'.
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/15/2022 19:37:46'!
test07ReportPortfolioWithAccountPortfolioWithAccountWithTransactions
	| portfolioPrincipal portfolio1 | 
	
	portfolio1 _ Portfolio named: 'Portfolio de Pipe' with: pepeAccount.
	portfolioPrincipal _ Portfolio named: 'Portfolio principal' with: portfolio1 with: juanAccount.
	
	Deposit register: (100 * peso) on: pepeAccount.
	Deposit register: (200 * peso) on: juanAccount.
	
	self setReport: (PortfolioDetailedTreePrinter from: portfolioPrincipal).
	
	self assertLine: 'Portfolio principal'.
	self assertLine: '    Portfolio de Pipe'.
	self assertLine: '        Cuenta de Pepe'.
	self assertLine: '            Depósito por 100 * pesos'.
	self assertLine: '            Balance = 100 * pesos'.
	self assertLine: '        Balance = 100 * pesos'.
	self assertLine: '    Cuenta de Juan'.
	self assertLine: '        Depósito por 200 * pesos'.
	self assertLine: '        Balance = 200 * pesos'.
	self assertLine: '    Balance = 300 * pesos'.
	! !


!classDefinition: #PortfolioTreePrinterTest category: 'ServiciosFinancieros2'!
ReportsTests subclass: #PortfolioTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/14/2022 13:54:49'!
test01ReportEmptyPortfolio
	self setReport: (PortfolioTreePrinter from: fulanoPortfolio).
	self assertLine: (fulanoPortfolio name).! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:48:22'!
test02ReportPortfolioWithAccount
	| portfolio | 
	portfolio _ Portfolio named: 'Portfolio de Pipe' with: pepeAccount .
	
	self setReport: (PortfolioTreePrinter from: portfolio).
	
	self assertLine: 'Portfolio de Pipe'.
	self assertLine: '    Cuenta de Pepe'.! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/14/2022 13:46:11'!
test03ReportPortfolioWithMultipleAccounts
	| portfolio | 
	portfolio _ Portfolio named: 'Portfolio de Franco' with: pepeAccount with: juanAccount.
	
	self setReport: (PortfolioTreePrinter from: portfolio).
	
	self assertLine: 'Portfolio de Franco'.
	self assertLine: '    Cuenta de Pepe'.
	self assertLine: '    Cuenta de Juan'.! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/14/2022 13:53:43'!
test04ReportPortfolioIgnoreTransactions
	| portfolio | 
	Deposit register: 100 on: pepeAccount. 
	portfolio _ Portfolio named: 'Portfolio de Fulano' with: pepeAccount.
	
	self setReport: (PortfolioTreePrinter from: portfolio).
	
	self assertLine: 'Portfolio de Fulano'.
	self assertLine: '    Cuenta de Pepe'.! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/14/2022 13:46:11'!
test05ReportPortfolioWithPortfolio
	| portfolio  | 
	portfolio _ Portfolio named: 'Portfolio de Franco' with: fulanoPortfolio.
	
	self setReport: (PortfolioTreePrinter from: portfolio).
	
	self assertLine: 'Portfolio de Franco'.
	self assertLine: '    Portfolio de Fulano'.
! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/14/2022 13:56:02'!
test06ReportPortfolioWithPortfolioWithAccount
	| portfolio portfolio2 | 
	portfolio2 _ Portfolio named: 'Portfolio de Juan' with: pepeAccount .
	portfolio _ Portfolio named: 'Portfolio de Fulano' with: portfolio2.
	
	self setReport: (PortfolioTreePrinter from: portfolio).
	
	self assertLine: 'Portfolio de Fulano'.
	self assertLine: '    Portfolio de Juan'.
	self assertLine: '        Cuenta de Pepe'.! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/14/2022 14:00:36'!
test07ReportPortfolioWithMultiplePortfolioWithAccount
	| portfolio portfolio2 portfolio3 | 
	
	portfolio2 _ Portfolio named: 'Portfolio de Juan' with: pepeAccount.
	portfolio3 _ Portfolio named: 'Portfolio de Tomas' with: tomasAccount.
	
	portfolio _ Portfolio named: 'Portfolio de Fulano' with: portfolio2 with: portfolio3.
	
	self setReport: (PortfolioTreePrinter from: portfolio).
	
	self assertLine: 'Portfolio de Fulano'.
	self assertLine: '    Portfolio de Juan'.
	self assertLine: '        Cuenta de Pepe'.
	self assertLine: '    Portfolio de Tomas'.
	self assertLine: '        Cuenta de Tomas'.! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/14/2022 15:00:49'!
test08ReportPortfolioWithAccountAndPortfolioWithAccount
	| portfolio portfolio2 | 
	portfolio2 _ Portfolio named: 'Portfolio de Juan' with: pepeAccount .
		
	portfolio _ Portfolio named: 'Portfolio de Fulano' with: portfolio2 with: tomasAccount .
	
	self setReport: (PortfolioTreePrinter from: portfolio).
	
	self assertLine: 'Portfolio de Fulano'.
	self assertLine: '    Portfolio de Juan'.
	self assertLine: '        Cuenta de Pepe'.
	self assertLine: '    Cuenta de Tomas'.! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'TC 6/14/2022 14:51:22'!
test09ReportPortfolioWithMultiplePortfolioWithMultipleAccounts
	| portfolio portfolio2 portfolio3 | 
	
	portfolio2 _ Portfolio named: 'Portfolio de Juan' with: pepeAccount with: juanAccount .
	portfolio3 _ Portfolio named: 'Portfolio de Tomas' with: tomasAccount with: (ReceptiveAccount named: 'Cuenta de Carlos').
	
	portfolio _ Portfolio named: 'Portfolio de Fulano' with: portfolio2 with: portfolio3.
	
	self setReport: (PortfolioTreePrinter from: portfolio).
	
	self assertLine: 'Portfolio de Fulano'.
	self assertLine: '    Portfolio de Juan'.
	self assertLine: '        Cuenta de Pepe'.
	self assertLine: '        Cuenta de Juan'.
	self assertLine: '    Portfolio de Tomas'.
	self assertLine: '        Cuenta de Tomas'.
	self assertLine: '        Cuenta de Carlos'.
	! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros2'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros2'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'TC 6/14/2022 09:15:28'!
name
	^name! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'private' stamp: 'TC 6/14/2022 09:10:18'!
setName: aString
	name _ aString ! !


!Account methodsFor: 'visitor' stamp: 'TC 6/14/2022 07:38:55'!
accept: aVisitor
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'ServiciosFinancieros2'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'as yet unclassified' stamp: 'TC 6/14/2022 09:10:54'!
named: aString
	^self new setName: aString.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'TC 6/14/2022 09:25:55'!
accounts
	^accounts ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'visitor' stamp: 'TC 6/14/2022 07:41:14'!
accept: aAccountVisitor 
	 ^aAccountVisitor visitPortfolio: self. ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'TC 6/14/2022 09:13:49'!
named: aString with: aAccount
	| account |	
	account _ self with: aAccount .
	account setName: aString .
	^account ! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'TC 6/14/2022 09:14:10'!
named: aString with: aAccount with: aSecondAccount
	| account |	
	account _ self with: aAccount with: aSecondAccount.
	account setName: aString.
	^account ! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'TC 6/14/2022 13:04:24'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'visitor' stamp: 'TC 6/14/2022 07:41:35'!
accept: aAccountVisitor 
	 ^aAccountVisitor visitReceptiveAccount: self. ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visitor' stamp: 'TC 6/13/2022 21:52:14'!
accept: aVisitor
	^self subclassResponsibility.! !


!classDefinition: #Deposit category: 'ServiciosFinancieros2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'visitor' stamp: 'TC 6/13/2022 21:45:55'!
accept: aTransactionVisitor 
	 ^aTransactionVisitor visitDeposit: self. ! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros2'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros2'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros2'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'visitor' stamp: 'TC 6/13/2022 21:46:16'!
accept: aTransactionVisitor 
	 ^aTransactionVisitor visitTransferDepositLeg: self. ! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros2'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'visitor' stamp: 'TC 6/13/2022 21:46:34'!
accept: aTransactionVisitor 
	 ^aTransactionVisitor visitTransferWithdrawLeg: self. ! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'visitor' stamp: 'TC 6/13/2022 21:46:54'!
accept: aTransactionVisitor 
	 ^aTransactionVisitor visitWithdraw: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: 'ServiciosFinancieros2'!
Object subclass: #Report
	instanceVariableNames: 'lines tabs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Report methodsFor: 'initialization' stamp: 'TC 6/13/2022 20:53:58'!
initialize
	lines _ OrderedCollection new.
	tabs _ 0.! !


!Report methodsFor: 'compose' stamp: 'TC 6/13/2022 20:55:43'!
addLine: aLineString
	lines add: (self tabsString, aLineString).! !

!Report methodsFor: 'compose' stamp: 'TC 6/13/2022 20:59:11'!
addTab
	tabs _ tabs + 1.! !

!Report methodsFor: 'compose' stamp: 'TC 6/13/2022 21:00:02'!
lines
	^lines! !

!Report methodsFor: 'compose' stamp: 'TC 6/13/2022 20:59:19'!
removeTab
	tabs _ tabs - 1.
	! !


!Report methodsFor: 'private' stamp: 'TC 6/13/2022 20:57:16'!
tabsString
	| text |
	text _ ''.
	tabs timesRepeat: [ text _ text, '    ' ].
	^text.! !


!Report methodsFor: 'main protocol' stamp: 'TC 6/14/2022 07:59:30'!
show
	^lines! !


!classDefinition: #AccountSummaryReport category: 'ServiciosFinancieros2'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: 'account balance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!AccountSummaryReport methodsFor: 'compose' stamp: 'TC 6/14/2022 16:25:19'!
generate
	| descriptor |	
	descriptor _ TransactionDescriptor new.
	
	account transactions do: [ :aTransaction |
		self addLine: (aTransaction accept: descriptor).	
		balance _ aTransaction affectBalance: balance.
	].
	
	self addLine: ('Balance = ', (balance asString)).
	! !


!AccountSummaryReport methodsFor: 'initialization' stamp: 'TC 6/14/2022 08:30:40'!
initializeWith: aAccount
	account _ aAccount.
	balance _ 0 * peso.
	self generate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryReport class' category: 'ServiciosFinancieros2'!
AccountSummaryReport class
	instanceVariableNames: ''!

!AccountSummaryReport class methodsFor: 'as yet unclassified' stamp: 'TC 6/9/2022 21:40:34'!
from: aAccount
	^self new initializeWith: aAccount ! !


!classDefinition: #NetTransferReport category: 'ServiciosFinancieros2'!
Report subclass: #NetTransferReport
	instanceVariableNames: 'account balance descriptor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!NetTransferReport methodsFor: 'private' stamp: 'TC 6/14/2022 08:59:56'!
visitTransferLeg: aTransferLeg
	self addLine: (aTransferLeg accept: descriptor).
	balance _ aTransferLeg affectBalance: balance! !


!NetTransferReport methodsFor: 'visitor' stamp: 'TC 6/14/2022 08:49:31'!
visitDeposit: aDeposit! !

!NetTransferReport methodsFor: 'visitor' stamp: 'TC 6/14/2022 09:00:31'!
visitTransferDepositLeg: aDeposit
	self visitTransferLeg: aDeposit ! !

!NetTransferReport methodsFor: 'visitor' stamp: 'TC 6/14/2022 09:00:39'!
visitTransferWithdrawLeg: aWithdraw
	self visitTransferLeg: aWithdraw.! !

!NetTransferReport methodsFor: 'visitor' stamp: 'TC 6/14/2022 08:49:36'!
visitWithdraw: aDeposit! !


!NetTransferReport methodsFor: 'compose' stamp: 'TC 6/14/2022 08:56:27'!
generate	
	account transactions do: [ :aTransaction |
		aTransaction accept: self.	
	].
	
	self addLine: ('Balance = ', (balance asString)).
	! !


!NetTransferReport methodsFor: 'initialization' stamp: 'TC 6/14/2022 16:25:19'!
initializeWith: aAccount
	account _ aAccount.
	balance _ 0 * peso.
	descriptor _ TransactionDescriptor new.
	self generate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NetTransferReport class' category: 'ServiciosFinancieros2'!
NetTransferReport class
	instanceVariableNames: ''!

!NetTransferReport class methodsFor: 'as yet unclassified' stamp: 'TC 6/11/2022 10:42:28'!
from: aAccount
	^self new initializeWith: aAccount ! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros2'!
Report subclass: #PortfolioTreePrinter
	instanceVariableNames: 'portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!PortfolioTreePrinter methodsFor: 'compose' stamp: 'TC 6/14/2022 09:15:49'!
generate
	portfolio accept: self.! !


!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'TC 6/14/2022 09:06:59'!
initializeWith: aPortfolio
	portfolio _ aPortfolio.
	self generate.! !


!PortfolioTreePrinter methodsFor: 'visitor' stamp: 'TC 6/14/2022 12:38:08'!
visitPortfolio: aPortfolio
	self addLine: aPortfolio name.
	self addTab.
	aPortfolio accounts do: [ :aAccount | 
		aAccount accept: self.	
	].
	self removeTab. 
	! !

!PortfolioTreePrinter methodsFor: 'visitor' stamp: 'TC 6/14/2022 12:38:04'!
visitReceptiveAccount: aReceptiveAccount
	self addLine: aReceptiveAccount name.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: 'ServiciosFinancieros2'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'as yet unclassified' stamp: 'TC 6/14/2022 09:06:43'!
from: aPortfolio
	^self new initializeWith: aPortfolio. ! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros2'!
PortfolioTreePrinter subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!PortfolioDetailedTreePrinter methodsFor: 'visitor' stamp: 'TC 6/14/2022 13:09:05'!
visitPortfolio: aPortfolio
	super visitPortfolio: aPortfolio.
	self addTab.
	self addBalance: (aPortfolio balance).
	self removeTab.! !

!PortfolioDetailedTreePrinter methodsFor: 'visitor' stamp: 'TC 6/14/2022 16:25:19'!
visitReceptiveAccount: aReceptiveAccount
	| balance descriptor |
	descriptor _ TransactionDescriptor new.
	balance _ 0 * peso.

	super visitReceptiveAccount: aReceptiveAccount.
	
	self addTab.

	aReceptiveAccount transactions do: [ :aTransaction |
		self addLine: (aTransaction accept: descriptor).	
		balance _ aTransaction affectBalance: balance.
	].
	self addBalance: balance.
	self removeTab.
! !


!PortfolioDetailedTreePrinter methodsFor: 'balance' stamp: 'TC 6/14/2022 10:05:50'!
addBalance: aBalance
	self addLine: ('Balance = ', (aBalance asString)).! !


!classDefinition: #TransactionDescriptor category: 'ServiciosFinancieros2'!
Object subclass: #TransactionDescriptor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransactionDescriptor methodsFor: 'visitor' stamp: 'TC 6/13/2022 21:49:46'!
visitDeposit: deposit
	^'Depósito por ', (deposit value asString)! !

!TransactionDescriptor methodsFor: 'visitor' stamp: 'TC 6/13/2022 21:50:11'!
visitTransferDepositLeg: depositLeg
	^'Entrada por transferencia de ', (depositLeg value asString)! !

!TransactionDescriptor methodsFor: 'visitor' stamp: 'TC 6/13/2022 21:54:16'!
visitTransferWithdrawLeg: withdrawLeg
	^'Salida por transferencia de ', (withdrawLeg value asString)! !

!TransactionDescriptor methodsFor: 'visitor' stamp: 'TC 6/13/2022 21:51:35'!
visitWithdraw: withdraw
	^'Extracción por ', (withdraw value asString)! !


!classDefinition: #Transfer category: 'ServiciosFinancieros2'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros2'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
