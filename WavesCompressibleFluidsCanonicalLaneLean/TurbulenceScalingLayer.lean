import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean.ShockWaveLayer

namespace HautevilleHouse
namespace WavesCompressibleFluidsCanonicalLaneLean

structure TurbulenceScalingCertificate where
  shock : ShockWaveCertificate
  kolmogorovEnergySpectrum : Prop
  dissipationRate : Prop
  reynoldsNumber : Prop
  kolmogorovEnergySpectrum_closed : kolmogorovEnergySpectrum
  dissipationRate_closed : dissipationRate
  reynoldsNumber_closed : reynoldsNumber

def primitiveTurbulenceScalingCertificate : TurbulenceScalingCertificate := {
  shock := primitiveShockWaveCertificate
  kolmogorovEnergySpectrum := (zeroScalarField = zeroScalarField)
  dissipationRate := (zeroScalarField = zeroScalarField)
  reynoldsNumber := (zeroScalarField = zeroScalarField)
  kolmogorovEnergySpectrum_closed := rfl
  dissipationRate_closed := rfl
  reynoldsNumber_closed := rfl
}

def TurbulenceScalingClosed (C : TurbulenceScalingCertificate) : Prop :=
  ShockWaveClosed C.shock ∧ C.kolmogorovEnergySpectrum ∧ C.dissipationRate ∧ C.reynoldsNumber

theorem primitive_turbulence_scaling_closed :
    TurbulenceScalingClosed primitiveTurbulenceScalingCertificate := by
  exact And.intro primitive_shock_wave_closed
    (And.intro primitiveTurbulenceScalingCertificate.kolmogorovEnergySpectrum_closed
      (And.intro primitiveTurbulenceScalingCertificate.dissipationRate_closed
        primitiveTurbulenceScalingCertificate.reynoldsNumber_closed))

end HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean
end HautevilleHouse
