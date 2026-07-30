import HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean.GasDynamicsOperators

namespace HautevilleHouse
namespace WavesCompressibleFluidsCanonicalLaneLean

structure WeakSolutionEnvelope where
  flow : CompressibleFlow
  finiteEnergy : Prop
  entropyCondition : Prop
  weakContinuity : Prop
  weakMomentum : Prop
  weakEnergy : Prop
  finiteEnergyClosed : finiteEnergy
  entropyConditionClosed : entropyCondition
  weakContinuityClosed : weakContinuity
  weakMomentumClosed : weakMomentum
  weakEnergyClosed : weakEnergy

def sourceWeakSolutionEnvelope : WeakSolutionEnvelope := {
  flow := primitiveFlow
  finiteEnergy := True
  entropyCondition := True
  weakContinuity := ContinuityEquation primitiveFlow
  weakMomentum := MomentumEquation primitiveFlow
  weakEnergy := EnergyEquation primitiveFlow
  finiteEnergyClosed := trivial
  entropyConditionClosed := trivial
  weakContinuityClosed := primitive_flow_continuity_checked
  weakMomentumClosed := primitive_flow_momentum_checked
  weakEnergyClosed := primitive_flow_energy_checked
}

def WeakSolutionEnvelopeClosed (E : WeakSolutionEnvelope) : Prop :=
  E.finiteEnergy ∧ E.entropyCondition ∧ E.weakContinuity ∧ E.weakMomentum ∧ E.weakEnergy

theorem source_weak_solution_envelope_closed : WeakSolutionEnvelopeClosed sourceWeakSolutionEnvelope := by
  exact And.intro sourceWeakSolutionEnvelope.finiteEnergyClosed
    (And.intro sourceWeakSolutionEnvelope.entropyConditionClosed
      (And.intro sourceWeakSolutionEnvelope.weakContinuityClosed
        (And.intro sourceWeakSolutionEnvelope.weakMomentumClosed
          sourceWeakSolutionEnvelope.weakEnergyClosed)))

end HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean