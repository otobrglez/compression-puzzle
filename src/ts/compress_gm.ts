namespace Puzzle {
  type ToStr<T> = Extract<T, string>;
  type ToStrArr<T> = Extract<T, string[]>;

  type Length<T extends any[]> = T['length'];

  type Result<TCurrent extends string[]> = TCurrent

  type FirstChar<T extends string> = T extends `${infer A}${infer _}` ? A : never;

  type Join<T extends string[]> = T extends [infer Head, ...infer Tail]
      ? `${ToStr<Head>}${Join<ToStrArr<Tail>>}`
      : '';

  type CompressString<TInput extends string, TResult extends Result<string[]> = Result<['']>> =
      TInput extends `${infer Head}${infer Tail}`
          ? Head extends FirstChar<Tail>
              ? CompressString<Tail, Result<[...TResult, Head]>>
              : [`${Length<TResult>}${Head}`, ...CompressString<Tail, Result<['']>>]
          : [];

  export type Compress<TInput extends string> = Join<CompressString<TInput>>;
}

type ToCompress = 'AAABBAAC'
type Result = Puzzle.Compress<ToCompress>;

// 'assert'
// will report an error to `tsc` if the value assigned to `_assert` doesn't match
// the type Result
// Example: error TS2322: Type ''3A2B2A1C'' is not assignable to type ''3A2B2A2C''.
const _assert: Result = '3A2B2A1C'
