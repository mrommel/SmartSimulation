//
//  Simulations.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 24.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

public class Simulations {

	var population: Population
	var birthRate: BirthRate
	var mortalityRate: MortalityRate
	var health: Health
	var lifeSpan: LifeSpan
	var religiosity: Religiosity
	var happiness: Happiness
	var foodPrice: FoodPrice
	var grossDomesticProduct: GrossDomesticProduct
	var crimeRate: CrimeRate
	var povertyRate: Poverty
	var unemployment: Unemployment
	var education: Education
	var transportSpeed: TransportSpeed
    var racialTension: RacialTension
    var wages: Wages
    var equality: Equality
    
    // income
    var lowIncome: LowIncome
    var middleIncome: MiddleIncome
    var highIncome: HighIncome
    
    // hidden
    var terrorism: Terrorism

	var sims: [Simulation] = []

	init() {

		self.population = Population() // total number
		self.birthRate = BirthRate() // 0..1
		self.mortalityRate = MortalityRate() // 0..1
		self.health = Health()
		self.lifeSpan = LifeSpan()
		self.religiosity = Religiosity()
		self.happiness = Happiness()
		self.foodPrice = FoodPrice()
		self.grossDomesticProduct = GrossDomesticProduct()
		self.crimeRate = CrimeRate()
		self.povertyRate = Poverty()
		self.unemployment = Unemployment()
		self.education = Education()
		self.transportSpeed = TransportSpeed()
        
        self.lowIncome = LowIncome()
        self.middleIncome = MiddleIncome()
        self.highIncome = HighIncome()
        
        self.terrorism = Terrorism()
        self.racialTension = RacialTension()
        self.wages = Wages()
        self.equality = Equality()
	}

	func setup(with simulation: GlobalSimulation) {

		self.population.setup(with: simulation)
		self.birthRate.setup(with: simulation)
		self.mortalityRate.setup(with: simulation)
		self.health.setup(with: simulation)
		self.lifeSpan.setup(with: simulation)
		self.religiosity.setup(with: simulation)
		self.happiness.setup(with: simulation)
		self.foodPrice.setup(with: simulation)
		self.grossDomesticProduct.setup(with: simulation)
		self.crimeRate.setup(with: simulation)
		self.povertyRate.setup(with: simulation)
		self.unemployment.setup(with: simulation)
		self.education.setup(with: simulation)
		self.transportSpeed.setup(with: simulation)
        self.terrorism.setup(with: simulation)
        self.racialTension.setup(with: simulation)
        self.wages.setup(with: simulation)
        self.equality.setup(with: simulation)
        
        self.lowIncome.setup(with: simulation)
        self.middleIncome.setup(with: simulation)
        self.highIncome.setup(with: simulation)
	}

	func add(simulation: Simulation) {

		self.sims.append(simulation)
	}

	func calculate() {

		self.sims.forEach { $0.calculate() }
	}

	func push() {

		self.sims.forEach { $0.push() }
	}
}

extension Simulations: Sequence {

	public struct SimulationsIterator: IteratorProtocol {

		private var index = 0
		private let simulations: [Simulation]

		init(simulations: [Simulation]) {
			self.simulations = simulations
		}

        mutating public func next() -> Simulation? {
			let simulation = self.simulations[safe: index]
			index += 1
			return simulation
		}
	}

    public func makeIterator() -> SimulationsIterator {
		return SimulationsIterator(simulations: self.sims)
	}
}
