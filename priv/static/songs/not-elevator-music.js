const drumBank = "oberheimdmx"
setcpm(90/4)

const chords = "<Eb:major [Bb:minor,Db:major] Ab2:major [[Cb:major,Gb:major] [Db:major, Ab:major]]>"
const bassline = "<eb2 bb1 ab1 [cb2 db2]>"


drums: stack(
  sound("bd ~ <[bd ~ ~ bd] [bd!2]> ~").velocity(2),
  sound("~ <sd [sd ~@2 sd]> ~ sd").velocity(2).bank("linn9000"),
  sound("[hh:9, hh:3]*8").velocity(".75@4 5@1 .75@3 .75@4 5@1 .75@3").bank("yamaharm50")
)
  .postgain(.55)
  .room(.1)
const piano1 =n("1,3,5").struct("<x(5,8) x(4,8)>")
const piano2 =n("1,3,5").struct("x(2,8)")


piano: arrange(
  [8, silence],
  [8, piano1],
  [16, piano1],
  [16, piano2]
)
  .scale(chords)
  .scaleTranspose("<-1>")
  .sound("piano")
  .room(.15)
  .velocity(.5)

bass: note(bassline)
  .sound("gm_acoustic_bass, gm_fretless_bass:0.5")
  .struct("x*8")
  .gain(1.25)

const melody1 = cat(
  n("1 2 3 5 _ 5 3 2"),
  n("1 2 3 5 _ 5 3 2"),
  n("5 7 6 5 _ 5 6 3"),
  n("1 2 3 5 1 2 3 5")
)

const melody2 = cat(
  n("3 2 3 5 3 _ 2 _"),
  n("1 3 6 5 3 _ 2 _")
)

melody: arrange(
  [16, silence],
  [16, melody1],
  [16, melody2]
)
.sound("piano")
.scale(chords)
.scaleTranspose("<-1>")

const strings =  cat(
  n("1, 5, 8, 10"),
  n("1, 3, 5, 7"),
  n("1, 3, 5, 8"),
  n("3, 5, 8, 10")

)
strings: arrange(
  [16, silence],
  [16, silence],
  [16, strings]
)
  .struct("<x x x [x x]>")
  .scale("<Eb:major Bb:minor Ab:major [Cb4:major Db4:major]>")
  .sound("gm_string_ensemble_1")
  .scaleTranspose("<-1>")
  .lpf(3000)
  .velocity(0.5)
  .gain(1.25)
  .room(0.25)
