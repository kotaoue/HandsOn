import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

// 02-1 を 代入文を使用しない形に書き換えたもの
// 02-1 の課題 1 = for なので、再帰に書き換える
// 02-1 の課題 2 = 配列への代入文なので、配列のコピーを作成する

class Sieve {
    static List<Integer> primesUpTo(int upTo) {
        return getPrimes(
                computeSieve(
                        makeSieve(Math.max(upTo, 1)),
                        0),
                new ArrayList<>(),
                0);
    }

    private static boolean[] makeSieve(int upTo) {
        boolean[] sieve = new boolean[upTo + 1];
        Arrays.fill(sieve, false);
        sieve[0] = sieve[1] = true;
        return sieve;
    }

    private static boolean[] computeSieve(boolean[] sieve, int n) {
        if (n >= sieve.length) {
            return sieve;
        }
        if (!sieve[n]) {
            return computeSieve(markMultiples(sieve, n, 2), n + 1);
        } else {
            return computeSieve(sieve, n + 1);
        }
    }

    private static boolean[] markMultiples(boolean[] sieve, int prime, int m) {
        int multiple = prime * m;
        if (multiple >= sieve.length) {
            return sieve;
        } else {
            boolean[] markedSieve = Arrays.copyOf(sieve, sieve.length);
            markedSieve[multiple] = true;
            return markMultiples(markedSieve, prime, m + 1);
        }
    }

    public static List<Integer> getPrimes(boolean[] sieve, List<Integer> primes, int n) {
        if (n >= sieve.length) {
            return primes;
        } else if (!sieve[n]) {
            var newPrimes = new ArrayList<>(primes);
            newPrimes.add(n);
            return getPrimes(sieve, newPrimes, n + 1);
        } else {
            return getPrimes(sieve, primes, n + 1);
        }
    }
}
