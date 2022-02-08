let rec _compress = ( ~count=1: int, text) =>
  switch text {
  | list{} => ""
  | list{a} => count > 0 ? Belt.Int.toString(count) ++ a : a
  | list{a, b, ...other} => {
  	let canCompress = a === b
    (canCompress ? "" : (count > 0 ? Belt.Int.toString(count) ++ a : a))
    ++ _compress(list{b, ...other}, ~count = canCompress? count + 1 : 1)
  }
}

let compress = text => {
  let array = Js.Array2.fromMap(Js.String.castToArrayLike(text), x => x)
  _compress(Belt.List.fromArray(array))
}
assert (
  compress(
   "AAABBAAC"
  ) === "3A2B2A1C"
)