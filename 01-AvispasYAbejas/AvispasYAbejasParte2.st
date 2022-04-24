!classDefinition: #AvispaLara category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #AvispaLara
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaLara class' category: 'AvispasYAbejasParte2'!
AvispaLara class
	instanceVariableNames: ''!

!AvispaLara class methodsFor: 'as yet unclassified' stamp: 'TC 4/24/2022 13:37:34'!
intentarReproducirse
	HabitatDeAvispas cantidadDeHuevosDeAvispas > 0 ifTrue: [
	 	HabitatDeAvispas agregarUnHuevoDeLara.
		HabitatDeAvispas eliminarUnHuevo.	
	].! !


!classDefinition: #AvispaOriana category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #AvispaOriana
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaOriana class' category: 'AvispasYAbejasParte2'!
AvispaOriana class
	instanceVariableNames: ''!

!AvispaOriana class methodsFor: 'as yet unclassified' stamp: 'TC 4/24/2022 15:34:32'!
intentarReproducirse
	HabitatDeAvispas cantidadDeOrugas > 0 ifTrue: [
	 	HabitatDeAvispas agregarUnHuevoDeOrianaOOrnella.
		HabitatDeAvispas eliminarUnaOruga.			
	].
! !


!classDefinition: #AvispaOrnella category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #AvispaOrnella
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaOrnella class' category: 'AvispasYAbejasParte2'!
AvispaOrnella class
	instanceVariableNames: ''!

!AvispaOrnella class methodsFor: 'as yet unclassified' stamp: 'TC 4/24/2022 15:35:47'!
intentarReproducirse
	HabitatDeAvispas cantidadDeOrugas > 0 ifTrue: [
	 	HabitatDeAvispas agregarUnHuevoDeOrianaOOrnella.
		HabitatDeAvispas eliminarUnaOruga.			
	].! !


!classDefinition: #AvispaPolly category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #AvispaPolly
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaPolly class' category: 'AvispasYAbejasParte2'!
AvispaPolly class
	instanceVariableNames: ''!

!AvispaPolly class methodsFor: 'as yet unclassified' stamp: 'TC 4/24/2022 13:29:42'!
intentarReproducirse
	HabitatDeAvispas cantidadDePolillas > 0 ifTrue: [
	 	HabitatDeAvispas agregarUnHuevoDePolly.
		HabitatDeAvispas eliminarUnaPolilla.			
	].! !


!classDefinition: #HabitatDeAvispas category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #HabitatDeAvispas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HabitatDeAvispas class' category: 'AvispasYAbejasParte2'!
HabitatDeAvispas class
	instanceVariableNames: 'cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella cantidadDeHuevosConLaFirmaGeneticaDePolly cantidadDeHuevosConLaFirmaGeneticaDeLara cantidadDeOrugas cantidadDePolillas'!

!HabitatDeAvispas class methodsFor: 'ControlDeOrugas' stamp: 'TC 4/21/2022 19:53:20'!
agregarUnaOruga
	cantidadDeOrugas := cantidadDeOrugas + 1.! !

!HabitatDeAvispas class methodsFor: 'ControlDeOrugas' stamp: 'TC 4/21/2022 19:55:15'!
cantidadDeOrugas
	^cantidadDeOrugas! !

!HabitatDeAvispas class methodsFor: 'ControlDeOrugas' stamp: 'TC 4/21/2022 19:57:24'!
eliminarUnaOruga
	cantidadDeOrugas := cantidadDeOrugas - 1.! !

!HabitatDeAvispas class methodsFor: 'ControlDeOrugas' stamp: 'TC 4/21/2022 19:50:10'!
ponerOrugasEnCero
	cantidadDeOrugas := 0.! !


!HabitatDeAvispas class methodsFor: 'ControlDePolillas' stamp: 'TC 4/21/2022 20:15:58'!
agregarUnaPolilla
	cantidadDePolillas := cantidadDePolillas + 1.! !

!HabitatDeAvispas class methodsFor: 'ControlDePolillas' stamp: 'TC 4/21/2022 20:15:02'!
cantidadDePolillas
	^cantidadDePolillas! !

!HabitatDeAvispas class methodsFor: 'ControlDePolillas' stamp: 'TC 4/21/2022 20:15:40'!
eliminarUnaPolilla
	cantidadDePolillas := cantidadDePolillas - 1.! !

!HabitatDeAvispas class methodsFor: 'ControlDePolillas' stamp: 'TC 4/21/2022 20:17:44'!
ponerPolillasEnCero
	cantidadDePolillas := 0.! !


!HabitatDeAvispas class methodsFor: 'ControlDeHuevos' stamp: 'TC 4/24/2022 13:37:48'!
agregarUnHuevoDeLara
	^cantidadDeHuevosConLaFirmaGeneticaDeLara := cantidadDeHuevosConLaFirmaGeneticaDeLara + 1.! !

!HabitatDeAvispas class methodsFor: 'ControlDeHuevos' stamp: 'TC 4/24/2022 15:34:32'!
agregarUnHuevoDeOrianaOOrnella
	^cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella := cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella + 1.! !

!HabitatDeAvispas class methodsFor: 'ControlDeHuevos' stamp: 'TC 4/21/2022 21:05:52'!
agregarUnHuevoDePolly
	^cantidadDeHuevosConLaFirmaGeneticaDePolly := cantidadDeHuevosConLaFirmaGeneticaDePolly + 1.! !

!HabitatDeAvispas class methodsFor: 'ControlDeHuevos' stamp: 'TC 4/24/2022 13:40:52'!
cantidadDeHuevosDeAvispas
	^cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella + cantidadDeHuevosConLaFirmaGeneticaDePolly + cantidadDeHuevosConLaFirmaGeneticaDeLara.! !

!HabitatDeAvispas class methodsFor: 'ControlDeHuevos' stamp: 'TC 4/24/2022 13:33:07'!
cantidadDeHuevosDeLara
	^ cantidadDeHuevosConLaFirmaGeneticaDeLara.! !

!HabitatDeAvispas class methodsFor: 'ControlDeHuevos' stamp: 'TC 4/24/2022 13:10:23'!
cantidadDeHuevosDeOrianaYOrnella
	^ cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella.! !

!HabitatDeAvispas class methodsFor: 'ControlDeHuevos' stamp: 'TC 4/24/2022 13:14:10'!
cantidadDeHuevosDePolly
	^ cantidadDeHuevosConLaFirmaGeneticaDePolly.! !

!HabitatDeAvispas class methodsFor: 'ControlDeHuevos' stamp: 'TC 4/24/2022 13:36:49'!
eliminarUnHuevo
	self cantidadDeHuevosDeOrianaYOrnella > 0 ifTrue: [
		cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella := cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella - 1.
		^self
	].
	self cantidadDeHuevosDePolly > 0 ifTrue: [
		cantidadDeHuevosConLaFirmaGeneticaDePolly := cantidadDeHuevosConLaFirmaGeneticaDePolly - 1.
		^self
	].! !

!HabitatDeAvispas class methodsFor: 'ControlDeHuevos' stamp: 'TC 4/24/2022 13:44:24'!
ponerHuevosEnCero
	cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella := 0.
	cantidadDeHuevosConLaFirmaGeneticaDePolly := 0.
	cantidadDeHuevosConLaFirmaGeneticaDeLara := 0.! !


!HabitatDeAvispas class methodsFor: '--** private fileout/in **--' stamp: 'TC 4/24/2022 15:36:27'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella := 0.
	cantidadDeHuevosConLaFirmaGeneticaDePolly := 0.
	cantidadDeHuevosConLaFirmaGeneticaDeLara := 0.
	cantidadDeOrugas := 0.
	cantidadDePolillas := 0.! !


!classDefinition: #PruebasReproduccionDeAvispas category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #PruebasReproduccionDeAvispas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasReproduccionDeAvispas class' category: 'AvispasYAbejasParte2'!
PruebasReproduccionDeAvispas class
	instanceVariableNames: ''!

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'TC 4/21/2022 19:16:59'!
test01EnElInicioDeLosTiemposNoHayHuevos	
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:44'!
test02CuandoOrianaLaAvispaSeReproducePorPrimeraVezDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:11'!
test03CadaVezQueOrianaSeReproduceDejaUnHuevoMas
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOriana intentarReproducirse.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 2.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:53'!
test04ParaDejarUnHuevoOrianaLaAvispaReduceLaPoblacionDeUnaOrugaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaOrugaMas.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:13:43'!
test05ParaDejarUnHuevoOrianaLaAvispaDecrementaEnUnoLaPoblacionDeOrugasDelHabitat
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaDosOrugasMas.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:13:22'!
test06CuandoNoHayOrugasOrianaLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:24'!
test07CuandoOrnellaLaAvispaSeReproduceDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:18'!
test08ParaDejarUnHuevoOrnellaLaAvispaReduceLaPoblacionDeUnaOrugaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaOrugaMas.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:11'!
test09CuandoNoHayOrugasOrnellaLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:46'!
test10CuandoPollyLaAvispaSeReproduceDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:40'!
test11ParaDejarUnHuevoPollyLaAvispaReduceLaPoblacionDeUnaPolillaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaPolillaMas.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDePolillas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:36'!
test12ParaDejarUnHuevoPollyLaAvispaDecrementaEnUnoLaPoblacionDePolillasDelHabitat
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaDosPolillasMas.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDePolillas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:30'!
test13CuandoNoHayPolillasPollyLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:15:06'!
test14CuandoOrianaLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:15:02'!
test15CuandoOrianaLaAvispaAunNoSeReprodujoNoTieneHuevosConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:14:58'!
test16CuandoPollyLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDePolly isEqualTo: 1.
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:14:54'!
test17CuandoOrnellaLaAvispaSeReproduceDejaUnHuevoConLaMismaFirmaGeneticaQueOriana
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOrnella isEqualTo: 1.
	Assert 
		that: self cantidadDeHuevosConLaFirmaGeneticaDeOrnella  
		isEqualTo: self cantidadDeHuevosConLaFirmaGeneticaDeOriana! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:27'!
test18CuandoLaraLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOrnella intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeLara isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:22'!
test19CuandoLaraLaAvispaSeReproduceLeSacaElHuevoAOtraAvispa
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOriana intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:18'!
test20CuandoLaraLaAvispaSeReproduceLeSacaElHuevoAPolly
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaPolly intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDePolly isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:12'!
test21CuandoLaraLaAvispaNoTieneRecursosNoDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
		
	self laAvispaLara intentarReproducirse.
		
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeLara isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'TC 4/24/2022 13:40:16'!
cantidadDeHuevosConLaFirmaGeneticaDeLara
	^self habitat cantidadDeHuevosDeLara.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'TC 4/24/2022 13:09:53'!
cantidadDeHuevosConLaFirmaGeneticaDeOriana
	^self habitat cantidadDeHuevosDeOrianaYOrnella.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'TC 4/24/2022 13:16:07'!
cantidadDeHuevosConLaFirmaGeneticaDeOrnella
	^self habitat cantidadDeHuevosDeOrianaYOrnella.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'TC 4/24/2022 13:14:29'!
cantidadDeHuevosConLaFirmaGeneticaDePolly
	^self habitat cantidadDeHuevosDePolly.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'TC 4/24/2022 13:29:42'!
habitat
	^HabitatDeAvispas! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'TC 4/21/2022 20:41:46'!
hacerQueElHabitatTengaLosRecursosSuficientes
	self queElHabitatTengaDosOrugasMas.
	self queElHabitatTengaDosPolillasMas.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'TC 4/24/2022 13:28:33'!
laAvispaLara
	^AvispaLara.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'TC 4/21/2022 19:30:55'!
laAvispaOriana
	^AvispaOriana! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'TC 4/21/2022 20:09:18'!
laAvispaOrnella
	^AvispaOrnella.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'TC 4/21/2022 20:16:20'!
laAvispaPolly
	^AvispaPolly.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'TC 4/21/2022 20:01:49'!
queElHabitatTengaDosOrugasMas
	self habitat agregarUnaOruga.
	self habitat agregarUnaOruga.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'TC 4/21/2022 20:34:21'!
queElHabitatTengaDosPolillasMas
	self habitat agregarUnaPolilla.
	self habitat agregarUnaPolilla.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'TC 4/21/2022 19:51:59'!
queElHabitatTengaUnaOrugaMas
	self habitat agregarUnaOruga.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'TC 4/21/2022 20:32:51'!
queElHabitatTengaUnaPolillaMas
	self habitat agregarUnaPolilla.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'TC 4/21/2022 20:18:08'!
retrocederElHabitatAlInicioDeLosTiempos
	self habitat ponerHuevosEnCero.
	self habitat ponerOrugasEnCero.
	self habitat ponerPolillasEnCero.! !

HabitatDeAvispas initializeAfterFileIn!