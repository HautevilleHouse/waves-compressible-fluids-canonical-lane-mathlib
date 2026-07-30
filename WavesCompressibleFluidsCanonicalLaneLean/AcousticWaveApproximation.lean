import HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean.GasDynamicsOperators

namespace HautevilleHouse
namespace WavesCompressibleFluidsCanonicalLaneLean

structure AcousticWaveData where
  backgroundDensity : ScalarField
  backgroundPressure : ScalarField
  perturbationDensity : ScalarField
  perturbationVelocity : VectorField
  soundSpeed : ℝ

def primitiveAcousticData : AcousticWaveData := {
  backgroundDensity := zeroScalarField
  backgroundPressure := zeroScalarField
  perturbationDensity := zeroScalarField
  perturbationVelocity := zeroVectorField
  soundSpeed := 1
}

def WaveEquation (A : AcousticWaveData) (F : CompressibleFlow) : Prop :=
  let c := A.soundSpeed
  F.operators.timeDerivative A.perturbationDensity +
    (fun t x => c^2 * F.operators.divergence A.perturbationVelocity t x) = zeroScalarField ∧
  F.operators.timeDerivative A.perturbationVelocity +
    (fun t x => (1 / A.backgroundDensity t x) * F.operators.gradient A.perturbationDensity t x) = zeroVectorField

def LinearizedAcousticApproximation (A : AcousticWaveData) (F : CompressibleFlow) : Prop :=
  WaveEquation A F

theorem primitive_acoustic_wave_equation_checked :
  WaveEquation primitiveAcousticData primitiveFlow := by
  unfold WaveEquation primitiveAcousticData primitiveFlow
  simp

theorem primitive_linearized_acoustic_approximation_checked :
  LinearizedAcousticApproximation primitiveAcousticData primitiveFlow := by
  unfold LinearizedAcousticApproximation
  exact primitive_acoustic_wave_equation_checked

end HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean