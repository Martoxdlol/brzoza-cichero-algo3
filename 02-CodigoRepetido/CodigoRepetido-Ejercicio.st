!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'TC 4/30/2022 07:01:55'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assert: (self doSomethingNotTakeMoreThan: [ customerBook addCustomerNamed: 'John Lennon' ] time: 50).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TC 4/30/2022 07:02:36'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.

	self assert: (self doSomethingNotTakeMoreThan: [ customerBook removeCustomerNamed: paulMcCartney. ] time: 100).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TC 4/30/2022 07:54:56'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.


	self doAndExpectError: [customerBook addCustomerNamed: ''.]
	errorType: Error
	do: [:anError | anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.]
	do: [customerBook isEmpty.]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TC 4/30/2022 07:56:58'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self doAndExpectError: [customerBook removeCustomerNamed: 'Paul McCartney'.]
	errorType: NotFound
	 do: [customerBook numberOfCustomers = 1.]
	do: [customerBook includesCustomerNamed: johnLennon.]
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TC 4/30/2022 07:32:14'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: (self customerBookHasMembers: customerBook active: 0 suspended: 1 total: 1).
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TC 4/30/2022 07:33:08'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: (self customerBookHasMembers: customerBook active: 0 suspended: 0 total: 0).
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TC 4/30/2022 07:49:08'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self doAndExpectError: [ customerBook suspendCustomerNamed: 'Ringo Starr'.] 
	errorType: CantSuspend 
	do: [ customerBook numberOfCustomers = 1.]
		do: [customerBook includesCustomerNamed: johnLennon.]
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TC 4/30/2022 07:51:34'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self doAndExpectError: [customerBook suspendCustomerNamed: johnLennon .]
	errorType: CantSuspend
	do: [customerBook numberOfCustomers = 1.] 
	do: [customerBook includesCustomerNamed: johnLennon.]
	
! !


!CustomerBookTest methodsFor: 'private' stamp: 'TC 4/30/2022 07:28:17'!
customerBookHasMembers: customerBook active: activeCustomers suspended: suspendedCustomers total: customers
	^(activeCustomers = customerBook numberOfActiveCustomers) and: 
	(suspendedCustomers = customerBook numberOfSuspendedCustomers) and:
	(customers = customerBook numberOfCustomers).! !

!CustomerBookTest methodsFor: 'private' stamp: 'TC 4/30/2022 07:48:39'!
doAndExpectError: aClosure errorType: aError do: doClosure1 do: doClosure2
	^[ aClosure value.
	self fail. ]
	on: aError
	do: [ :anError |
		(doClosure1 valueWithPossibleArgument: anError) and: (doClosure2 valueWithPossibleArgument: anError). ].
	

! !

!CustomerBookTest methodsFor: 'private' stamp: 'TC 4/30/2022 07:00:34'!
doSomethingNotTakeMoreThan: aClosure time: maxMillisenconds
	| millisecondsBeforeRunning millisecondsAfterRunning |
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning) < (maxMillisenconds * millisecond)! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'TC 5/1/2022 06:42:10'!
removeCustomerNamed: aName 
	^active remove: aName
	ifAbsent: [
		suspended remove: aName
		ifAbsent: [
			NotFound signal.
		]
	]
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
