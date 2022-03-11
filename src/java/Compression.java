package compression;

import java.util.Arrays;
import java.util.Objects;
import java.util.function.Function;
import java.util.function.Supplier;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * @author peter.levart (at) gmail.com
 * @author ales.justin (at) gmail.com
 */
public class Compression {

    // using IntStream.reduce

    public static String compress1(String input) {
        return compress1(input.chars());
    }

    public static String compress1parallel(String input) {
        return compress1(input.chars().parallel());
    }

    private static String compress1(IntStream chars) {
        var countCharArray = chars
            .mapToObj(c -> new int[]{1, c})
            .reduce((nc1, nc2) -> {
                if (nc1[nc1.length - 1] == nc2[1]) {
                    var ncr = Arrays.copyOf(nc1, nc1.length + nc2.length - 2);
                    ncr[nc1.length - 2] += nc2[0];
                    System.arraycopy(nc2, 2, ncr, nc1.length, nc2.length - 2);
                    return ncr;
                } else {
                    var ncr = Arrays.copyOf(nc1, nc1.length + nc2.length);
                    System.arraycopy(nc2, 0, ncr, nc1.length, nc2.length);
                    return ncr;
                }
            })
            .orElseThrow(() -> new IllegalArgumentException("Empty string"));

        return IntStream
            .range(0, countCharArray.length / 2)
            .mapToObj(i -> countCharArray[i + i] + String.valueOf((char) countCharArray[i + i + 1]))
            .collect(Collectors.joining());
    }

    // simple iterative

    public static String compress2(String input) {
        var res = new StringBuilder();
        int n = 0;
        int c = -1;
        for (int i = 0; i < input.length(); i++) {
            int nc = input.charAt(i);
            if (c == nc) {
                n++;
            } else {
                if (c >= 0) {
                    res.append(n).append((char) c);
                }
                c = nc;
                n = 1;
            }
        }
        if (n > 0) {
            res.append(n).append((char) c);
        }
        return res.toString();
    }

    // another IntStream.reduce with pure functions (immutable state)

    public static String compress3(String input) {
        return compress3(input.chars());
    }

    public static String compress3parallel(String input) {
        return compress3(input.chars().parallel());
    }

    private static String compress3(IntStream chars) {
        return chars
            .mapToObj(CountChar::single)
            .reduce(CountChar::join)
            .orElseThrow(() -> new IllegalArgumentException("Empty input"))
            .toString();
    }

    sealed interface CountChar permits CountChar.Single, CountChar.Double {

        int firstCount();

        char firstCh();

        int lastCount();

        char lastCh();

        CountChar addLastCount(int count);

        CountChar removeFirst();

        CountChar append(CountChar other);

        default CountChar join(CountChar other) {
            if (this.lastCh() == other.firstCh()) {
                return this.addLastCount(other.firstCount()).append(other.removeFirst());
            } else {
                return this.append(other);
            }
        }

        static CountChar single(int c) {
            return new CountChar.Single(1, (char) c);
        }

        record Single(int firstCount, char firstCh) implements CountChar {

            @Override
            public int lastCount() {
                return firstCount;
            }

            @Override
            public char lastCh() {
                return firstCh;
            }

            @Override
            public CountChar addLastCount(int count) {
                return new CountChar.Single(lastCount() + count, firstCh);
            }

            @Override
            public CountChar removeFirst() {
                return null;
            }

            @Override
            public CountChar append(CountChar other) {
                return other == null ? this : new Double(this, other);
            }

            @Override
            public String toString() {
                return firstCount + String.valueOf(firstCh);
            }
        }

        record Double(CountChar first, CountChar last) implements CountChar {
            @Override
            public int firstCount() {
                return first.firstCount();
            }

            @Override
            public char firstCh() {
                return first.firstCh();
            }

            @Override
            public int lastCount() {
                return last.lastCount();
            }

            @Override
            public char lastCh() {
                return last.lastCh();
            }

            @Override
            public CountChar addLastCount(int count) {
                return new CountChar.Double(first, last.addLastCount(count));
            }

            @Override
            public CountChar removeFirst() {
                var shortenedFirst = first.removeFirst();
                return shortenedFirst == null ? last : new Double(shortenedFirst, last);
            }

            @Override
            public CountChar append(CountChar other) {
                return other == null ? this : new Double(this, other);
            }

            @Override
            public String toString() {
                return first + String.valueOf(last);
            }
        }
    }

    // using IntStream.collect with arrays

    public static String compress4(String input) {
        return compress(input.chars(), ArrayCompressedChars::new);
    }

    public static String compress4parallel(String input) {
        return compress(input.chars().parallel(), ArrayCompressedChars::new);
    }

    // using IntStream.collect with linked list

    public static String compress5(String input) {
        return compress(input.chars(), LinkedCompressedChars::new);
    }

    public static String compress5parallel(String input) {
        return compress(input.chars().parallel(), LinkedCompressedChars::new);
    }

    private static String compress(IntStream chars, Supplier<? extends CompressedChars> ccSupplier) {
        return chars
            .collect(
                ccSupplier,
                CompressedChars::append,
                CompressedChars::append
            )
            .toString();
    }

    interface CharAppendable {
        default void append(int ch) {
            append((char) ch, 1);
        }

        void append(char ch, int count);
    }

    interface CompressedChars extends CharAppendable {
        default void append(CompressedChars other) {
            other.forEach(this);
        }

        void forEach(CharAppendable sink);

        static String toString(CompressedChars cc) {
            var sb = new StringBuilder();
            cc.forEach((ch, count) -> sb.append(count).append(ch));
            return sb.toString();
        }
    }

    static class ArrayCompressedChars implements CompressedChars {
        char[] chars = new char[8];
        int[] counts = new int[8];
        int len = 0;

        @Override
        public void append(char ch, int count) {
            if (len > 0 && chars[len - 1] == ch) {
                counts[len - 1] += count;
            } else {
                if (len >= chars.length) {
                    chars = Arrays.copyOf(chars, chars.length * 2);
                    counts = Arrays.copyOf(counts, counts.length * 2);
                }
                chars[len] = ch;
                counts[len] = count;
                len++;
            }
        }

        @Override
        public void forEach(CharAppendable sink) {
            for (int i = 0; i < len; i++) {
                sink.append(chars[i], counts[i]);
            }
        }

        @Override
        public String toString() {
            return CompressedChars.toString(this);
        }
    }

    static class LinkedCompressedChars implements CompressedChars {
        private char ch;
        private int count;
        private LinkedCompressedChars next, last;

        @Override
        public void append(char ch, int count) {
            if (last == null) {
                this.ch = ch;
                this.count = count;
                this.last = this;
            } else if (last.ch == ch) {
                last.count += count;
            } else {
                (last = last.next = new LinkedCompressedChars()).append(ch, count);
            }
        }

        @Override
        public void forEach(CharAppendable sink) {
            for (var lcs = this; lcs != null; lcs = lcs.next) {
                sink.append(lcs.ch, lcs.count);
            }
        }

        @Override
        public void append(CompressedChars other) {
            if (other instanceof LinkedCompressedChars linkedCC) {
                if (last == null) {
                    this.ch = linkedCC.ch;
                    this.count = linkedCC.count;
                    this.next = linkedCC.next;
                    this.last = linkedCC.last;
                } else if (last.ch == linkedCC.ch) {
                    last.count += linkedCC.count;
                    if (linkedCC.next != null) {
                        last.next = linkedCC.next;
                        last = linkedCC.last;
                    }
                } else {
                    last.next = linkedCC;
                    last = linkedCC.last;
                }
            } else {
                CompressedChars.super.append(other);
            }
        }

        @Override
        public String toString() {
            return CompressedChars.toString(this);
        }
    }

    // simple straight fwd solution

    public static String compress6(String input) {
        String result = "";
        int n = 0;
        char[] chars = input.toCharArray();
        char prev = chars[0];
        for (char c : chars) {
            if (c != prev) {
                result += n;
                result += prev;
                n = 0;
                prev = c;
            }
            n++;
        }
        result += n;
        result += prev;
        return result;
    }

    // tests

    private static void test(Function<String, String> compressFn) {
        test("ABCDE", "1A1B1C1D1E", compressFn);
        test("ABBCCCDDDDEEEEE", "1A2B3C4D5E", compressFn);
        test("AAABCCCDEEE", "3A1B3C1D3E", compressFn);
    }

    private static void test(String plain, String expectedCompressed, Function<String, String> compressFn) {
        var compressed = compressFn.apply(plain);
        System.out.println(plain + " -> " + compressed);
        if (!Objects.equals(expectedCompressed, compressed)) {
            throw new AssertionError("Expected `" + expectedCompressed + "` but got `" + compressed + "`");
        }
    }

    public static void main(String[] args) {
        test(Compression::compress1);
        test(Compression::compress1parallel);
        test(Compression::compress2);
        test(Compression::compress3);
        test(Compression::compress3parallel);
        test(Compression::compress4);
        test(Compression::compress4parallel);
        test(Compression::compress5);
        test(Compression::compress5parallel);
        test(Compression::compress6);
    }
}
