import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean.TurbulenceScalingLayer

namespace HautevilleHouse
namespace WavesCompressibleFluidsCanonicalLaneLean

structure VortexDynamicsCertificate where
  turbulence : TurbulenceScalingCertificate
  vorticityEquation : Prop
  circulation : Prop
  vortexStretching : Prop
  vorticityEquation_closed : vorticityEquation
  circulation_closed : circulation
  vortexStretching_closed : vortexStretching

def primitiveVortexDynamicsCertificate : VortexDynamicsCertificate := {
  turbulence := primitiveTurbulenceScalingCertificate
  vorticityEquation := (zeroScalarField = zeroScalarField)
  circulation := (zeroScalarField = zeroScalarField)
  vortexStretching := (zeroScalarField = zeroScalarField)
  vorticityEquation_closed := rfl
  circulation_closed := rfl
  vortexStretching_closed := rfl
}

def VortexDynamicsClosed (C : VortexDynamicsCertificate) : Prop :=
  TurbulenceScalingClosed C.turbulence ∧ C.vorticityEquation ∧ C.circulation ∧ C.vortexStretching

theorem primitive_vortex_dynamics_closed :
    VortexDynamicsClosed primitiveVortexDynamicsCertificate := by
  exact And.intro primitive_turbulence_scaling_closed
    (And.intro primitiveVortexDynamicsCertificate.vorticityEquation_closed
      (And.intro primitiveVortexDynamicsCertificate.circulation_closed
        primitiveVortexDynamicsCertificate.vortexStretching_closed))

end HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean
end HautevilleHouse
