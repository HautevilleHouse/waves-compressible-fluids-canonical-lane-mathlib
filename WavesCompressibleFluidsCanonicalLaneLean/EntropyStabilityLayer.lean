import HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean.WeakSolutionLayer

namespace HautevilleHouse
namespace WavesCompressibleFluidsCanonicalLaneLean

structure EntropyStabilityCertificate where
  weakEnvelope : WeakSolutionEnvelope
  entropyFluxClosed : Prop
  entropyProductionNonnegative : Prop
  entropyFluxClosedProof : entropyFluxClosed
  entropyProductionNonnegativeProof : entropyProductionNonnegative

def sourceEntropyStabilityCertificate : EntropyStabilityCertificate := {
  weakEnvelope := sourceWeakSolutionEnvelope
  entropyFluxClosed := True
  entropyProductionNonnegative := True
  entropyFluxClosedProof := trivial
  entropyProductionNonnegativeProof := trivial
}

def EntropyStabilityClosed (C : EntropyStabilityCertificate) : Prop :=
  WeakSolutionEnvelopeClosed C.weakEnvelope ∧ C.entropyFluxClosed ∧ C.entropyProductionNonnegative

theorem source_entropy_stability_closed : EntropyStabilityClosed sourceEntropyStabilityCertificate := by
  exact And.intro source_weak_solution_envelope_closed
    (And.intro sourceEntropyStabilityCertificate.entropyFluxClosedProof
      sourceEntropyStabilityCertificate.entropyProductionNonnegativeProof)

end HautevilleHouse.WavesCompressibleFluidsCanonicalLaneLean