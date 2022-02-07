use std::fmt::Write;
use std::iter;

fn compress(input: &str) -> String {
    let mut chars = input.chars().peekable();
    let mut output = String::new();

    while let Some(ch) = chars.next() {
        let count = iter::from_fn(|| chars.next_if_eq(&ch)).count();
        write!(output, "{}{}", count + 1, ch).ok();
    }

    output
}

#[test]
fn test_simple() {
    assert_eq!(compress("AAABBAAC"), "3A2B2A1C");
}
