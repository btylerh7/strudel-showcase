// @title A Little Roll Never Hurt Anyone
// Twelve tone analysis https://www.youtube.com/watch?v=v0su7FiNLVg
// Please click link for even more fun. https://www.youtube.com/watch?v=dQw4w9WgXcQ
// @by Tyler

setcpm(110 / 4);
const drumBank = "linn9000"; // Actual drum machine used in song
const snare = "linn9000_sd, linn1m1_cp";
const drums = stack(
  sound("linn9000_bd*4"),
  sound(snare).struct("~ x ~ x ").room(0.5),
  sound("linn9000_tb").struct("<[[x x x x] x ~ ~] ~@7>").lpf(2000).room(0.7),
  sound("rolandtr707_rim")
    .struct("<[x [x x]] [x [x x]] [x [x x]] [x*4]>")
    .fast(4)
    .gain(0.5),
  sound(
    "[~ linn_oh] [~ [linn9000_hh linn9000_hh]] [~ linn_oh] <[~ linn_oh] [ ~ [linn9000_hh linn9000_hh]]>",
  ).gain(0.2),
  sound(
    "<[[~ tr707_oh] [~ [tr707_hh tr707_hh]] [tr707_hh tr707_oh] [ ~ tr707_oh]] [ [~ tr707_oh]!4]>",
  ).gain(0.1),
  sound(
    "[~ [perc:1 perc:2]] [perc:3 perc:1@2 perc:2] [perc:1 [perc:1 perc:2]] <[perc:3 perc:1@3] [[perc:3 perc:1] perc:3]>",
  ).bank(drumBank),
  sound("<[~]@7 [[~] [~ [ht*2]] [~ ht ht ht] [~ mt mt mt]]>")
    .bank("linn")
    .room(0.5),
);
const synth = note("<[db@3 eb@3 c@2] [eb@3 f@3 [ab gb f eb]@2 ]>")
  .sound("gm_string_ensemble_1:9, gm_synth_strings_1")
  .lpf(2500)
  .room(0.55)
  .add(note("24"))
  .legato(1.15)
  .gain(0.8);
const pad = note(
  "<[[gb3,bb3, db4]@3 [ab3, c4, eb4]@5] [[f3, ab3, c4, f4]@3 [bb3, db4, f4]@5]>",
)
  .sound("piano, square")
  .lpf(800)
  .gain(0.3);
const bass = note(`<
  [[eb2 [eb2 eb2]] [[~ c3] bb2] [ab2 ab2] [~ [eb2 ab2]]]
  [[f2 [f2 f2]] [[~ c3] bb2] [~ [bb2 bb2]] [bb2 c3@2 bb2]]
  [[eb2 [eb2 eb2]] [[~ c3] bb2] [ab2 ab2] [~ [eb2 ab2]]]
  [[f2 [f2 f2]] [[~ c3] bb2] [~ ab2] [db3 ab2@2 db3]]
  
>`)
  .sound("gm_acoustic_bass:2,z_sine")
  .clip(0.5)
  .add(note("-12, 0"));

const mainLoop = stack(bass, drums, pad, synth);
const introDrum = stack(
  sound("~ [ht ht ~ ~] [mt mt ~ mt] [lt lt ~ ~]")
    .bank("rolandtr707")
    .room(0.25)
    .jux(iter(8))
    .delay("0.25")
    .delayfeedback("0.5"),
  sound("linnlm1_sh")
    .struct("~ x x x")
    .attack(0.3)
    .lpf(3000)
    .release(1)
    .room(1),
);
$: arrange([1, introDrum], [16, mainLoop]);
