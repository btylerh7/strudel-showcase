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
piano: n("1,3,5")
  .scale(chords)
  .struct("<x(5,8) x(4,8)>")
  .scaleTranspose("<-1>")
  .sound("piano")
  .room(.15)
  .velocity(.5)

bass: note(bassline)
  .sound("gm_acoustic_bass, gm_fretless_bass:0.5")
  .struct("x*8")
  .gain(1.25)

melody: cat(
  n("1 2 3 5 _ 5 3 2"),
  n("1 2 3 5 _ 5 3 2"),
  n("5 7 6 5 _ 5 6 3"),
  n("1 2 3 5 1 2 3 5")
)
.sound("piano")
.scale(chords)
.scaleTranspose("<-1>")


