!classDefinition: #AccountTransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #AccountTransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransferTest methodsFor: 'tests' stamp: 'TC 6/7/2022 18:24:12'!
test01CanDoATransferAndBalanceIsOk

	| cliente1 cliente2 |
	cliente1 := ReceptiveAccount new.
	cliente2 := ReceptiveAccount new.
	WireTransfer register: 100 * peso from: cliente1 to: cliente2.
	self assert: (cliente1 balance) equals: (-100 * peso).
	self assert: (cliente2 balance) equals: (100 * peso).
! !

!AccountTransferTest methodsFor: 'tests' stamp: 'TC 6/7/2022 18:24:56'!
test02CannotTransferNegativeValue

	| cliente1 cliente2 |
	cliente1 := ReceptiveAccount new.
	cliente2 := ReceptiveAccount new.
	self
		should: [WireTransfer register: -100 * peso from: cliente1 to: cliente2.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = (WireTransfer valueMustBeGreaterThan0Description)]
! !

!AccountTransferTest methodsFor: 'tests' stamp: 'TC 6/7/2022 18:25:11'!
test03CannotTransferZeroValue

	| cliente1 cliente2 |
	cliente1 := ReceptiveAccount new.
	cliente2 := ReceptiveAccount new.
	self
		should: [WireTransfer register: 0 * peso from: cliente1 to: cliente2.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = (WireTransfer valueMustBeGreaterThan0Description)]
! !

!AccountTransferTest methodsFor: 'tests' stamp: 'TC 6/7/2022 18:26:52'!
test04CannotTransferToYourself

	| cliente1 |
	cliente1 := ReceptiveAccount new.
	self
		should: [WireTransfer register: 100 * peso from: cliente1 to: cliente1.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = (WireTransfer cannotTransferToYourselfDescription )]
! !

!AccountTransferTest methodsFor: 'tests' stamp: 'TC 6/7/2022 18:27:35'!
test05CanAccessContrapartTransactionFromTransferOnReceptiveAccount
	
	| cliente1 cliente2 emitterTransaction receiverTransaction |
	cliente1 := ReceptiveAccount new.
	cliente2 := ReceptiveAccount new.
	WireTransfer register: 100 * peso from: cliente1 to: cliente2.
	emitterTransaction _ cliente1 transactions at: 1.
	receiverTransaction _ cliente2 transactions at: 1.
	self assert: (emitterTransaction contrapart = receiverTransaction).
	self assert: (receiverTransaction contrapart = emitterTransaction)! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'Tests' stamp: 'TC 6/7/2022 16:18:56'!
test01PortfolioBalanceIsTheSumOfElements
	| portfolio account1 account2 |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new. 
	Deposit register: (100 * peso) on: account1.
	Deposit register: (100 * peso) on: account2.
	portfolio _ Portfolio new.
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	self assert: (portfolio balance = (200 * peso)).! !

!PortfolioTest methodsFor: 'Tests' stamp: 'TC 6/7/2022 16:18:56'!
test02PorfolioCanHavePortfoliosAsElements
	| portfolio1 portfolio2 account1 account2 |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new. 
	Deposit register: (100 * peso) on: account1.
	Deposit register: (100 * peso) on: account2.
	portfolio1 _ Portfolio new.
	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.
	portfolio2 _ Portfolio new.
	portfolio2 addAccount: portfolio1.
	self assert: (portfolio2 balance = (200 * peso))! !

!PortfolioTest methodsFor: 'Tests' stamp: 'VB 6/8/2022 14:43:14'!
test03PortfolioHasTransaction
	| portfolio transaction account |
	account _ ReceptiveAccount new.
	transaction _ Deposit register: (100 * peso) on: account.
	portfolio _ Portfolio new.
	portfolio addAccount: account.
	self assert: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'Tests' stamp: 'VB 6/8/2022 14:43:22'!
test04PortfolioDoesNotHasTransactionFromOtherPortfolio
	| portfolio1 portfolio2 transaction account |
	account _ ReceptiveAccount new.
	transaction _ Deposit register: (100 * peso) on: account.
	portfolio1 _ Portfolio new.
	portfolio1 addAccount: account.
	portfolio2 _ Portfolio new.
	self deny: (portfolio2 hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'Tests' stamp: 'VB 6/8/2022 14:43:28'!
test05TransactionsFromAccountInPortfolio
	| portfolio account1 transaction |
	account1 _ ReceptiveAccount new. 
	transaction _ Deposit register: (100 * peso) on: account1.
	portfolio _ Portfolio new.
	portfolio addAccount: account1.
	self assert: (((portfolio transactionsFrom: account1) at: 1) = transaction).! !

!PortfolioTest methodsFor: 'Tests' stamp: 'VB 6/8/2022 14:43:37'!
test06TransactionsFromAccountNotInPortfolio
	| portfolio account1 account2 |
	account1 _ ReceptiveAccount new. 
	Deposit register: (100 * peso) on: account1.
	portfolio _ Portfolio new.
	portfolio addAccount: account1.
	account2 _ ReceptiveAccount new.
	self assert: (((portfolio transactionsFrom: account2) size) = 0).! !

!PortfolioTest methodsFor: 'Tests' stamp: 'VB 6/8/2022 14:43:44'!
test07PortfolioCannotAddTheSameAccountTwice
	| portfolio account1 |
	account1 _ ReceptiveAccount new.
	portfolio _ Portfolio new.
	portfolio addAccount: account1.
	self
		should: [portfolio addAccount: account1.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = (Portfolio errorAddingElementDescription )].! !

!PortfolioTest methodsFor: 'Tests' stamp: 'VB 6/8/2022 14:43:51'!
test08PortfolioCanNotAddAnAccountAlreadyIncludedInAPreviouslyAddedPortfolio
	| portfolio1 portfolio2 account1 |
	account1 _ ReceptiveAccount new.
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio2 addAccount: account1.
	portfolio1 addAccount: portfolio2.
	self
		should: [portfolio1 addAccount: account1]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = (Portfolio errorAddingElementDescription )].
! !

!PortfolioTest methodsFor: 'Tests' stamp: 'VB 6/8/2022 14:44:00'!
test09PortfolioCanNotIncludeItself
	| portfolio |
	portfolio _ Portfolio new.
	self
		should: [portfolio addAccount: portfolio]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = (Portfolio errorAddingElementDescription )].
! !

!PortfolioTest methodsFor: 'Tests' stamp: 'VB 6/8/2022 14:44:07'!
test10PortfolioCannotAddItemThatIsAlreadyOnAParentPortfolio
	| portfolio1 portfolio2 cuenta |
	cuenta _ ReceptiveAccount new.
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio1 addAccount: cuenta.
	portfolio1 addAccount: portfolio2.

	self
		should: [portfolio2 addAccount: cuenta]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = (Portfolio errorAddingElementDescription )].
! !

!PortfolioTest methodsFor: 'Tests' stamp: 'VB 6/8/2022 14:44:13'!
test11AccountCanBeOnMoreThanOnePortfolio
	| portfolio1 portfolio2 account |
	
	
	
	account _ ReceptiveAccount new.
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio1 addAccount: account.
	portfolio2 addAccount: account.

	self assert: (portfolio1 isOrContains: account).
	self assert: (portfolio2 isOrContains: account).
! !

!PortfolioTest methodsFor: 'Tests' stamp: 'VB 6/8/2022 14:44:19'!
test12CannotAddAccountIfAnyParentPortfolioTreeHasItAlready
	| portfolioTop1 portfolioTop2 portfolioCommon account |
	
	account _ ReceptiveAccount new.
	portfolioTop1 _ Portfolio new.
	portfolioTop2 _ Portfolio new.
	portfolioCommon _ Portfolio new.
	
	portfolioTop1 addAccount: account.
	portfolioTop1 addAccount: portfolioCommon.
	portfolioTop2 addAccount: portfolioCommon.
	
	self
		should: [portfolioCommon addAccount: account]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = (Portfolio errorAddingElementDescription )].
! !

!PortfolioTest methodsFor: 'Tests' stamp: 'VB 6/8/2022 14:44:30'!
test13CannotAddPortfolioToAPortfolioWithAAccountInCommon
	| portfolio1 portfolio2 account |
	
	account _ ReceptiveAccount new.
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	
	portfolio1 addAccount: account.
	portfolio2 addAccount: account.
	
	self
		should: [portfolio1 addAccount: portfolio2.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = (Portfolio errorAddingElementDescription )].
! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TC 6/2/2022 21:02:02'!
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


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'main protocol' stamp: 'TC 6/7/2022 16:24:33'!
value
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'valueOrigin'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'TC 6/7/2022 19:30:39'!
initializeFor: aValueOrigin

	valueOrigin := aValueOrigin ! !


!Deposit methodsFor: 'main protocol' stamp: 'TC 6/2/2022 21:37:33'!
affectBalance: aBalance
	^aBalance + self value	! !

!Deposit methodsFor: 'main protocol' stamp: 'TC 6/7/2022 19:31:50'!
value
	^valueOrigin! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'TC 6/7/2022 19:29:43'!
for: aValueOrigin

	^ self new initializeFor: aValueOrigin ! !


!classDefinition: #TransferReception category: 'ServiciosFinancieros-Ejercicio'!
Deposit subclass: #TransferReception
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferReception methodsFor: 'main protocol' stamp: 'TC 6/7/2022 19:30:39'!
contrapart
	^valueOrigin emitterTransaction.! !

!TransferReception methodsFor: 'main protocol' stamp: 'TC 6/7/2022 19:31:45'!
value
	^valueOrigin value! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'valueOrigin'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'TC 6/7/2022 19:30:54'!
initializeFor: aValueOrigin

	valueOrigin := aValueOrigin ! !


!Withdraw methodsFor: 'main protocol' stamp: 'TC 6/2/2022 21:37:40'!
affectBalance: aBalance
	^aBalance - self value	! !

!Withdraw methodsFor: 'main protocol' stamp: 'TC 6/7/2022 19:31:39'!
value
	^valueOrigin! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'TC 6/7/2022 19:29:49'!
for: aValueOrigin

	^ self new initializeFor: aValueOrigin ! !


!classDefinition: #TransferEmission category: 'ServiciosFinancieros-Ejercicio'!
Withdraw subclass: #TransferEmission
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferEmission methodsFor: 'main protocol' stamp: 'TC 6/7/2022 19:30:54'!
contrapart
	^valueOrigin receiverTransaction.! !

!TransferEmission methodsFor: 'main protocol' stamp: 'TC 6/7/2022 19:30:54'!
value
	"Value es la transferencia"
	^valueOrigin value! !


!classDefinition: #BankAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #BankAccount
	instanceVariableNames: 'groups'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!BankAccount methodsFor: 'initializacion' stamp: 'TC 6/7/2022 17:43:29'!
initialize
	groups _ OrderedCollection new.! !


!BankAccount methodsFor: 'AccountsData' stamp: 'TC 6/6/2022 21:24:54'!
balance
	^self subclassResponsibility ! !

!BankAccount methodsFor: 'AccountsData' stamp: 'TC 6/7/2022 17:42:28'!
groups
	^groups.! !

!BankAccount methodsFor: 'AccountsData' stamp: 'TC 6/7/2022 19:42:15'!
hasRegistered
	^self subclassResponsibility. ! !

!BankAccount methodsFor: 'AccountsData' stamp: 'TC 6/7/2022 19:28:03'!
isLeading
	^groups size = 0! !


!BankAccount methodsFor: 'Portfolio' stamp: 'VB 6/8/2022 14:31:49'!
asignPortfolio: aPortfolio
	groups add: aPortfolio.! !


!BankAccount methodsFor: 'Lookup' stamp: 'TC 6/6/2022 21:29:04'!
isOrContains: aElement
	^self subclassResponsibility ! !

!BankAccount methodsFor: 'Lookup' stamp: 'VB 6/8/2022 14:37:39'!
leadingPortfolios
	| leadingPortfolios |
	leadingPortfolios _ OrderedCollection new.
	
	self isLeading ifTrue: [
		leadingPortfolios add: self
	] ifFalse: [
		groups do: [ :aPortfolio |
			leadingPortfolios addAll: aPortfolio leadingPortfolios. 
		]
	].
	^leadingPortfolios
! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
BankAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initializacion' stamp: 'TC 6/7/2022 18:10:35'!
initialize
	super initialize.
	accounts _ OrderedCollection new.
! !


!Portfolio methodsFor: 'Lookup' stamp: 'TC 6/7/2022 19:16:51'!
anyAccountIsOrIsContainedOn: aPortfolio
	^accounts detect: [ :aAccount | aPortfolio isOrContains: aAccount ] ifFound: [ :aElement | ^true] ifNone: [
		^aPortfolio = self.	
	].! !

!Portfolio methodsFor: 'Lookup' stamp: 'TC 6/7/2022 16:20:59'!
isOrContains: aAccountToFind
	^accounts detect: [ :aAccount | aAccount isOrContains: aAccountToFind ] ifFound: [ :aElement | ^true] ifNone: [
		^aAccountToFind = self.	
	].! !


!Portfolio methodsFor: 'main protocol' stamp: 'TC 6/7/2022 16:20:04'!
accounts
	^accounts! !

!Portfolio methodsFor: 'main protocol' stamp: 'VB 6/8/2022 14:37:39'!
addAccount: aAccount

	self leadingPortfolios do: [ :aLeadingPortfolio |
		((aLeadingPortfolio isOrContains: aAccount) or: (aAccount anyAccountIsOrIsContainedOn: aLeadingPortfolio )) ifTrue: [
			self error: Portfolio errorAddingElementDescription
		] ifFalse: [
			accounts add: aAccount.
			aAccount asignPortfolio: self.
		].
	].

	! !

!Portfolio methodsFor: 'main protocol' stamp: 'TC 6/7/2022 16:19:42'!
balance
	^accounts inject: 0 into: [ :balance :aElement | aElement balance + balance ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'TC 6/7/2022 19:23:25'!
hasRegistered: aTransaction
	^accounts detect: [ 
		:aElement | aElement hasRegistered: aTransaction
	] ifFound: [ 
		:aFoundTransaction | ^true
	] ifNone: [ ^false ].! !

!Portfolio methodsFor: 'main protocol' stamp: 'TC 6/7/2022 19:38:43'!
transactionsFrom: aAccountToFind
	(self isOrContains: aAccountToFind) ifTrue: [
		^aAccountToFind transactions
	].
	^OrderedCollection new. 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'VB 6/7/2022 14:49:22'!
errorAddingElementDescription
	^'You can not add element twice or more. And you can not add the portfolio in itself'.! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
BankAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'TC 6/7/2022 18:10:43'!
initialize
	super initialize.
	transactions := OrderedCollection new.
	! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'TC 6/2/2022 21:38:11'!
balance
	^transactions inject: 0 into: [ :balance :aTransaction | aTransaction affectBalance: balance].	
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
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


!ReceptiveAccount methodsFor: 'Lookup' stamp: 'TC 6/7/2022 19:17:27'!
anyAccountIsOrIsContainedOn: aAccount
	^aAccount = self! !

!ReceptiveAccount methodsFor: 'Lookup' stamp: 'TC 6/7/2022 19:17:17'!
isOrContains: aElement
	^aElement = self! !


!classDefinition: #WireTransfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #WireTransfer
	instanceVariableNames: 'withdrawTransaction depositTransaction value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!WireTransfer methodsFor: 'initialization' stamp: 'TC 6/7/2022 15:54:08'!
initializeFor: aValue from: aAccountFrom to: aAccountTo
	aValue <= 0 ifTrue: [self error: (WireTransfer valueMustBeGreaterThan0Description) ].
	aAccountFrom = aAccountTo ifTrue: [self error: (WireTransfer cannotTransferToYourselfDescription ) ].
	value _ aValue.
	depositTransaction _ TransferReception register: self on: aAccountTo.
	withdrawTransaction _ TransferEmission register: self on: aAccountFrom.! !


!WireTransfer methodsFor: 'main protocol' stamp: 'TC 6/6/2022 20:14:11'!
emitterTransaction
	^withdrawTransaction 
	! !

!WireTransfer methodsFor: 'main protocol' stamp: 'TC 6/6/2022 20:14:22'!
receiverTransaction
	^depositTransaction 
	! !

!WireTransfer methodsFor: 'main protocol' stamp: 'TC 6/6/2022 20:11:33'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WireTransfer class' category: 'ServiciosFinancieros-Ejercicio'!
WireTransfer class
	instanceVariableNames: ''!

!WireTransfer class methodsFor: 'as yet unclassified' stamp: 'TC 6/4/2022 20:43:40'!
cannotTransferToYourselfDescription
	^ 'Cannot transfer to yourself'! !

!WireTransfer class methodsFor: 'as yet unclassified' stamp: 'TC 6/6/2022 20:10:29'!
register: aValue from: aAccountFrom to: aAccountTo
	self new initializeFor: aValue from: aAccountFrom to: aAccountTo.! !

!WireTransfer class methodsFor: 'as yet unclassified' stamp: 'TC 6/4/2022 20:38:50'!
valueMustBeGreaterThan0Description
	^ 'value must be greater than 0.'! !
