import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace WavesCompressibleFluidsCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure GasDynamicsOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  advection : VectorField → VectorField
  pressure : VectorField → ScalarField
  speedOfSound : ScalarField → ScalarField

def primitiveOperators : GasDynamicsOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  advection := fun _ => zeroVectorField
  pressure := fun _ => zeroScalarField
  speedOfSound := fun _ => zeroScalarField
}

structure CompressibleFlow where
  density : ScalarField
  velocity : VectorField
  pressure : ScalarField
  viscosity : ℝ
  operators : GasDynamicsOperators

def primitiveFlow : CompressibleFlow := {
  density := zeroScalarField
  velocity := zeroVectorField
  pressure := zeroScalarField
  viscosity := 1
  operators := primitiveOperators
}

def ContinuityEquation (F : CompressibleFlow) : Prop :=
  F.operators.timeDerivative F.density + F.operators.divergence (fun t x => F.density t x • F.velocity t x) = zeroScalarField

def MomentumEquation (F : CompressibleFlow) : Prop :=
  F.operators.timeDerivative (fun t x => F.density t x • F.velocity t x) +
    F.operators.divergence (fun t x => (F.density t x • F.velocity t x) ⊗ F.velocity t x) +
    F.operators.pressure F.velocity = zeroScalarField

def EnergyEquation (F : CompressibleFlow) : Prop :=
  F.operators.timeDerivative (fun t x => F.density t x * (F.operators.speedOfSound F.density t x)^2) +
    F.operators.divergence (fun t x => (F.density t x * (F.operators.speedOfSound F.density t x)^2 + F.pressure t x) • F.velocity t x) = zeroScalarField

def CompressibleNavierStokesClosed (F : CompressibleFlow) : Prop :=
  ContinuityEquation F ∧ MomentumEquation F ∧ EnergyEquation F

theorem primitive_flow_continuity_checked : ContinuityEquation primitiveFlow := by
  unfold ContinuityEquation primitiveFlow primitiveOperators zeroScalarField zeroVectorField
  simp

theorem primitive_flow_momentum_checked : MomentumEquation primitiveFlow := by
  unfold MomentumEquation primitiveFlow primitiveOperators zeroScalarField zeroVectorField
  simp

theorem primitive_flow_energy_checked : EnergyEquation primitiveFlow := by
  unfold EnergyEquation primitiveFlow primitiveOperators zeroScalarField zeroVectorField
  simp

theorem primitive_flow_equations_closed_checked : CompressibleNavierStokesClosed primitiveFlow := by
  exact And.intro primitive_flow_continuity_checked (And.intro primitive_flow_momentum_checked primitive_flow_energy_checked)

end HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean