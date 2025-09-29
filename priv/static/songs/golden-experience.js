setcpm(108/4)

const kit = "RolandTR707";

const drums = stack(
  sound("bd sd bd sd").bank(kit),
  sound("[hh hh hh]*4").bank(kit).gain(.1)
)

const bass = note("<[c2 d2] [c2 d2] [eb2 f2] [[ab2 ~ ab1] [~ ab1 ab1] bb1 bb1]>")
  .struct("[ x ~ x ] [ ~ x x ] [x ~ x] [~ x ~]")
  .layer(
    (x) => x.sound("gm_fretless_bass"),
    (x) => x.sound("sine").add(note("-12, -11.90")),
  );

const piano =note("<[g4 bb4 eb5 d5] [f5 eb5 bb4 c5] [g4 bb4 eb5 d5] [f5 [eb5 _ ab5] g5 f5]>")
  .sound("piano")
  .room(0.5)

const countermelody = n("[3 ~ 5]*4")
  .scale("<[C3:Minor D3:Diminished] [Eb3:Major F3:Minor] [Eb3:Major F3:Minor] [Ab3:Major Bb3:Major]>")
  .scaleTranspose("<-1>")
  .sound("piano")
  .room(0.5)
  .gain(.25)


$:arrange(
  [4, stack(drums, bass)],
  [4, stack(drums, bass, countermelody)],
  [8, stack(drums, bass, countermelody, piano)]
)
