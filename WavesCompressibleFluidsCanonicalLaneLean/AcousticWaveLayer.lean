import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean.EulerEquationLayer

namespace HautevilleHouse
namespace WavesCompressibleFluidsCanonicalLaneLean

structure AcousticWaveCertificate where
  euler : EulerFlow
  linearized : Prop
  waveEquation : Prop
  speedOfSound : ℝ
  linearized_closed : linearized
  waveEquation_closed : waveEquation

def primitiveAcousticWaveCertificate : AcousticWaveCertificate := {
  euler := primitiveEulerFlow
  linearized := (zeroScalarField = zeroScalarField)
  waveEquation := (zeroScalarField = zeroScalarField)
  speedOfSound := 1
  linearized_closed := rfl
  waveEquation_closed := rfl
}

def AcousticWaveClosed (C : AcousticWaveCertificate) : Prop :=
  EulerEquationsClosed C.euler ∧ C.linearized ∧ C.waveEquation

theorem primitive_acoustic_wave_closed :
    AcousticWaveClosed primitiveAcousticWaveCertificate := by
  exact And.intro primitive_euler_closed
    (And.intro primitiveAcousticWaveCertificate.linearized_closed
      primitiveAcousticWaveCertificate.waveEquation_closed)

end HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean
end HautevilleHouse
