import WintersProtoCompressibleFluids.BridgeLemmas

namespace HautevilleHouse
namespace WavesCompressibleFluidsCanonicalLaneLean

def gateClosed (A : AdmissibleClass) : Prop :=
  A.endpointSatisfied ∨ A.remainderRecorded

theorem gate_from_admissible_class (A : AdmissibleClass) :
    gateClosed A := by
  exact A.gateWitness

end WavesCompressibleFluidsCanonicalLaneLean
end HautevilleHouse