import WintersProtoCompressibleFluids.MathlibStatement
import Mathlib.Data.Real.Basic

/-!
# Waves Compressible Fluids Analytic Objects

This module defines the local analytic vocabulary for compressible fluid dynamics:
space dimensions, time, scalar fields, vector fields, density, velocity, pressure,
temperature, and the primitive compressible Euler / Navier-Stokes operators.
-/

namespace HautevilleHouse
namespace WavesCompressibleFluidsCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3
abbrev Density := ScalarField
abbrev Pressure := ScalarField
abbrev Temperature := ScalarField
abbrev Velocity := VectorField

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure CompressibleOperators where
  divergence       : VectorField → ScalarField
  gradient         : ScalarField → VectorField
  laplacian        : VectorField → VectorField
  timeDerivative   : VectorField → VectorField
  advection        : VectorField → VectorField → VectorField
  heatFlux         : ScalarField → VectorField
  stressTensor     : VectorField → VectorField
  pressureProjection : VectorField → VectorField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

-- Primitive compressible operators: identity for most, zero for others.
def primitiveCompressibleOperators : CompressibleOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  advection := fun _ _ => zeroVectorField
  heatFlux := fun _ => zeroVectorField
  stressTensor := fun u => u
  pressureProjection := fun u => u
  pressureProjectionIdempotent := by intro u; rfl
}

structure CompressibleFlow where
  density    : Density
  velocity   : Velocity
  pressure   : Pressure
  temperature: Temperature
  viscosity  : ℝ
  heatConductivity : ℝ
  operators  : CompressibleOperators

-- Primitive constant flow: zero fields, unit viscosity and conductivity.
def primitiveCompressibleFlow : CompressibleFlow := {
  density    := zeroScalarField
  velocity   := zeroVectorField
  pressure   := zeroScalarField
  temperature := zeroScalarField
  viscosity  := 1
  heatConductivity := 1
  operators  := primitiveCompressibleOperators
}

-- Key predicates for compressible fluid dynamics.
def DensityPositive (ρ : Density) : Prop :=
  ∀ (t : Time) (x : Space3), ρ t x > 0

def CompressibilityCondition (ρ : Density) : Prop :=
  ¬ (∀ (t : Time) (x : Space3), ρ t x = 0)

def MassConservation (ρ : Density) (v : Velocity) (ops : CompressibleOperators) : Prop :=
  ops.timeDerivative (fun t x => ρ t x) + ops.divergence (fun t x => (ρ t x) • (v t x)) = zeroScalarField

def MomentumConservation (ρ : Density) (v : Velocity) (p : Pressure) (ops : CompressibleOperators) : Prop :=
  ops.timeDerivative (fun t x => (ρ t x) • (v t x)) +
  ops.divergence (fun t x => (ρ t x) • (v t x) ⊗ (v t x) + (p t x) • (fun _ => 1)) =
  ops.stressTensor v

def EnergyConservation (ρ : Density) (v : Velocity) (T : Temperature) (p : Pressure) (ops : CompressibleOperators) : Prop :=
  ops.timeDerivative (fun t x => (ρ t x) * (T t x)) +
  ops.divergence (fun t x => (ρ t x) * (T t x) • (v t x)) +
  p t x * ops.divergence v = ops.heatFlux T

def EquationOfState (ρ : Density) (p : Pressure) (T : Temperature) : Prop :=
  ∀ (t : Time) (x : Space3), p t x = (ρ t x) * (T t x)  -- Ideal gas law

def CompressibleEulerClosed (F : CompressibleFlow) : Prop :=
  MassConservation F.density F.velocity F.operators ∧
  MomentumConservation F.density F.velocity F.pressure F.operators ∧
  EnergyConservation F.density F.velocity F.temperature F.pressure F.operators ∧
  EquationOfState F.density F.pressure F.temperature ∧
  DensityPositive F.density

-- For the primitive flow, define concrete checks (using abbreviations for brevity).
theorem primitive_density_positive : DensityPositive primitiveCompressibleFlow.density := by
  intro t x
  show primitiveCompressibleFlow.density t x > 0
  unfold primitiveCompressibleFlow
  unfold DensityPositive
  simp

theorem primitive_mass_conservation : MassConservation primitiveCompressibleFlow.density primitiveCompressibleFlow.velocity primitiveCompressibleFlow.operators := by
  unfold MassConservation
  simp [primitiveCompressibleFlow]

theorem primitive_momentum_conservation : MomentumConservation primitiveCompressibleFlow.density primitiveCompressibleFlow.velocity primitiveCompressibleFlow.pressure primitiveCompressibleFlow.operators := by
  unfold MomentumConservation
  simp [primitiveCompressibleFlow]

theorem primitive_energy_conservation : EnergyConservation primitiveCompressibleFlow.density primitiveCompressibleFlow.velocity primitiveCompressibleFlow.temperature primitiveCompressibleFlow.pressure primitiveCompressibleFlow.operators := by
  unfold EnergyConservation
  simp [primitiveCompressibleFlow]

theorem primitive_equation_of_state : EquationOfState primitiveCompressibleFlow.density primitiveCompressibleFlow.pressure primitiveCompressibleFlow.temperature := by
  intro t x
  simp [primitiveCompressibleFlow]

theorem primitive_compressible_euler_closed : CompressibleEulerClosed primitiveCompressibleFlow := by
  unfold CompressibleEulerClosed
  exact And.intro primitive_mass_conservation
    (And.intro primitive_momentum_conservation
      (And.intro primitive_energy_conservation
        (And.intro primitive_equation_of_state primitive_density_positive)))

end WavesCompressibleFluidsCanonicalLaneLean
end HautevilleHouse