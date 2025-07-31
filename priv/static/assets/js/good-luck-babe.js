setcpm(115 / 4);
const drums = stack(
  sound("bd [~ bd] bd ~"),
  sound("sd:2,cp").struct("~ x ~ <x [x x]>"),
  sound("hh*8").gain(0.75),
)
  .bank("RolandTR808")
  .room(0.05);
const pad = stack(
  n("<[1, 4, 5] [2,4,5] [1,3,5] [-1, 1, 3, 5]>")
    .struct("x*8")
    .scale("D4:major")
    .scaleTranspose("<-1>")
    .clip(0.25),
)
  .sound("z_sine, z_sawtooth")
  .lpf(800)
  .add(note("0, 0.15"))
  .postgain(0.75);

const bass = note("<g2 a2 d3 b2>")
  .struct("[x x ~ ~ ~ x x ~ ~ x]")
  .layer(
    (x) => x.sound("gm_fretless_bass"),
    (x) => x.sound("sine").add(note("-12, -11.90")),
  );

const lead = cat(
  n("3 ~ 3 2 3 5 ~ 2"),
  n("2 ~ 2 ~ 2 1 ~ 1"),
  n("3 ~ 3 ~ 3 2 ~ 1"),
  n("8 ~ 8 ~ 7 ~ 7 ~"),
)
  .scale("D4:major")
  .scaleTranspose("<-1>")
  .sound("z_sawtooth")
  .adsr("0.01:0.25:0.55:0.75")
  .lpf(2500)
  .add(note("0, 0.075"))
  .room(0.3);

$: arrange(
  // intro
  [2, drums],
  [4, stack(drums, pad, lead, bass)],
  // verse 1
  [8, stack(drums, pad, bass)],
  // prechorus 1
  [8, stack(drums, pad, bass)],
);
