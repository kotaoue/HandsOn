import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Sieve {
    boolean[] isComposite;

    static List<Integer> primesUpTo(int upTo) {
        return (new Sieve(upTo)).getPrimes();
    }

    private Sieve(int upTo) {
        if (upTo < 1) {
            upTo = 1;
        }
        isComposite = new boolean[upTo + 1];
        Arrays.fill(isComposite, false);
        isComposite[0] = isComposite[1] = true;

        for (int i = 2; i < isComposite.length; i++) {
            if (!isComposite[i]) {
                for (int c = i + i; c < isComposite.length; c += i) {
                    isComposite[c] = true;
                }
            }
        }
    }

    public List<Integer> getPrimes() {
        ArrayList<Integer> primes = new ArrayList<>();
        for (int i = 0; i < isComposite.length; i++) {
            if (!isComposite[i]) {
                primes.add(i);
            }
        }
        return primes;
    }

    public static void main(String[] args) {
        int upTo = 30;
        if (args.length > 0) {
            upTo = Integer.parseInt(args[0]);
        }
        System.out.println(primesUpTo(upTo));
    }
}
