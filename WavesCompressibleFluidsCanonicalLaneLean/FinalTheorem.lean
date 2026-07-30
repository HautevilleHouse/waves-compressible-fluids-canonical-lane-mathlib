import WintersProtoCompressibleFluids.GateLemmas

namespace HautevilleHouse
namespace WavesCompressibleFluidsCanonicalLaneLean

def ConstrainedWavesCompressibleFluidsClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_waves_compressible_fluids_endgame (A : AdmissibleClass) :
    ConstrainedWavesCompressibleFluidsClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end WavesCompressibleFluidsCanonicalLaneLean
end HautevilleHouse