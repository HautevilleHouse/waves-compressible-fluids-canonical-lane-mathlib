import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace WavesCompressibleFluidsCanonicalLaneLean

-- spatial dimension 3 using Fin 3 → ℝ
abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

-- compressible fluid state: density, velocity, energy
structure FluidState where
  density : ScalarField
  velocity : VectorField
  energy : ScalarField

-- operators for compressible flow
structure CompressibleFluidOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField
  pressure : ScalarField → ScalarField  -- equation of state
  stressTensor : VectorField → VectorField

-- primitive (trivial) operators
def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

def primitiveOperators : CompressibleFluidOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  pressure := fun _ => zeroScalarField
  stressTensor := fun u => u
}

structure CompressibleFlow where
  state : FluidState
  viscosity : ℝ
  operators : CompressibleFluidOperators

def primitiveFlow : CompressibleFlow := {
  state := {
    density := zeroScalarField
    velocity := zeroVectorField
    energy := zeroScalarField
  }
  viscosity := 1
  operators := primitiveOperators
}

-- conservation laws
def MassConservation (F : CompressibleFlow) : Prop :=
  F.operators.timeDerivative F.state.density =
    zeroScalarField

def MomentumConservation (F : CompressibleFlow) : Prop :=
  F.operators.timeDerivative F.state.velocity =
    F.operators.laplacian F.state.velocity

def EnergyConservation (F : CompressibleFlow) : Prop :=
  F.operators.timeDerivative F.state.energy =
    F.operators.laplacian F.state.energy

def CompressibleNavierStokesClosed (F : CompressibleFlow) : Prop :=
  MassConservation F ∧ MomentumConservation F ∧ EnergyConservation F

theorem primitive_mass_conservation_checked :
    MassConservation primitiveFlow := rfl

theorem primitive_momentum_conservation_checked :
    MomentumConservation primitiveFlow := rfl

theorem primitive_energy_conservation_checked :
    EnergyConservation primitiveFlow := rfl

theorem primitive_compressible_navier_stokes_closed_checked :
    CompressibleNavierStokesClosed primitiveFlow := by
  exact And.intro primitive_mass_conservation_checked
    (And.intro primitive_momentum_conservation_checked primitive_energy_conservation_checked)

end HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean
end HautevilleHouse
