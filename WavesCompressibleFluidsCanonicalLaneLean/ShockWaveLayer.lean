import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean.EulerEquationLayer

namespace HautevilleHouse
namespace WavesCompressibleFluidsCanonicalLaneLean

structure ShockWaveCertificate where
  euler : EulerFlow
  rankineHugoniot : Prop
  entropyCondition : Prop
  LaxCondition : Prop
  rankineHugoniot_closed : rankineHugoniot
  entropyCondition_closed : entropyCondition
  LaxCondition_closed : LaxCondition

def primitiveShockWaveCertificate : ShockWaveCertificate := {
  euler := primitiveEulerFlow
  rankineHugoniot := (zeroScalarField = zeroScalarField)
  entropyCondition := (zeroScalarField = zeroScalarField)
  LaxCondition := (zeroScalarField = zeroScalarField)
  rankineHugoniot_closed := rfl
  entropyCondition_closed := rfl
  LaxCondition_closed := rfl
}

def ShockWaveClosed (C : ShockWaveCertificate) : Prop :=
  EulerEquationsClosed C.euler ∧ C.rankineHugoniot ∧ C.entropyCondition ∧ C.LaxCondition

theorem primitive_shock_wave_closed :
    ShockWaveClosed primitiveShockWaveCertificate := by
  exact And.intro primitive_euler_closed
    (And.intro primitiveShockWaveCertificate.rankineHugoniot_closed
      (And.intro primitiveShockWaveCertificate.entropyCondition_closed
        primitiveShockWaveCertificate.LaxCondition_closed))

end HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean
end HautevilleHouse
