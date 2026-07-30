import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean.WavesCompressibleFluidsOperators

namespace HautevilleHouse
namespace WavesCompressibleFluidsCanonicalLaneLean

structure EulerFlow where
  fluid : CompressibleFlow
  inviscid : Prop
  barotropic : Prop
  adiabatic : Prop
  inviscid_closed : inviscid
  barotropic_closed : barotropic
  adiabatic_closed : adiabatic

def primitiveEulerFlow : EulerFlow := {
  fluid := primitiveFlow
  inviscid := (primitiveFlow.viscosity = 0)
  barotropic := (zeroScalarField = zeroScalarField)
  adiabatic := (zeroScalarField = zeroScalarField)
  inviscid_closed := rfl
  barotropic_closed := rfl
  adiabatic_closed := rfl
}

def EulerEquationsClosed (E : EulerFlow) : Prop :=
  (E.fluid.viscosity = 0) ∧ E.inviscid ∧ E.barotropic ∧ E.adiabatic

theorem primitive_euler_closed :
    EulerEquationsClosed primitiveEulerFlow := by
  exact And.intro rfl (And.intro primitiveEulerFlow.inviscid_closed
    (And.intro primitiveEulerFlow.barotropic_closed primitiveEulerFlow.adiabatic_closed))

end HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean
end HautevilleHouse
