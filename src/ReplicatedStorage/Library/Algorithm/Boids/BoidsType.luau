local BoidsType = {}

export type BoidSettings = {
	SeparationRadius: number,
	AlignmentRadius: number,
	CohesionRadius: number,
	BoundsCenter: Vector3,
	BoundsSize: Vector3,
	MaxSpeed: number,
	MinSpeed: number,
	MaxForce: number,
	SeparationWeight: number,
	AlignmentWeight: number,
	CohesionWeight: number,
	BoundsWeight: number,
	TargetWeight: number,
	WanderWeight: number,
	ObstacleWeight: number,
	ObstacleRadius: number,
	UpdateFrequency: number
}

export type Boid = {
	Part: Instance,
	Model: Instance?,
	Velocity: Vector3,
	Acceleration: Vector3,
	Settings: BoidSettings,
	Target: Vector3?,
	Update: (self: Boid, boids: {Boid}, dt: number) -> (),
	Separate: (self: Boid, boids: {Boid}) -> Vector3,
	Align: (self: Boid, boids: {Boid}) -> Vector3,
	Cohere: (self: Boid, boids: {Boid}) -> Vector3,
	Seek: (self: Boid, targetPos: Vector3) -> Vector3,
	StayInBounds: (self: Boid) -> Vector3,
	Wander: (self: Boid) -> Vector3,
	AvoidObstacles: (self: Boid) -> Vector3
}

export type BoidSystem = {
	Boids: {Boid},
	Settings: BoidSettings,
	Running: boolean,
	UpdateConnection: RBXScriptConnection?,
	AddBoid: (self: BoidSystem, part: Instance) -> Boid,
	CreateBoids: (self: BoidSystem, template: Instance, count: number, parentFolder: Instance?) -> {Boid},
	Start: (self: BoidSystem) -> (),
	Stop: (self: BoidSystem) -> (),
	SetTarget: (self: BoidSystem, targetPosition: Vector3) -> (),
	Clear: (self: BoidSystem) -> (),
	SetBounds: (self: BoidSystem, center: Vector3, size: Vector3) -> (),
	UpdateSettings: (self: BoidSystem, newSettings: {[string]: any}) -> ()
}

return BoidsType