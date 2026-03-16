# ch2

## Install
```bash
$ npm install
```

## History
```bash
$ cd ~/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2/
$ npm test

> fizz-buzz@1.0.0 test /Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2
> mocha



  0 passing (1ms)

# change if to it on test/index.js
$ npm test

> fizz-buzz@1.0.0 test /Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2
> mocha



  fizzbuzz
    1) returns FizzBuzz when value is divisible by 15
    2) returns Fizz when value is divisible by 3
    3) returns Buzz when value is divisible by 5
    4) returns the value when value is not divisible by 3 or 5


  0 passing (4ms)
  4 failing

  1) fizzbuzz
       returns FizzBuzz when value is divisible by 15:
     TypeError: fizzbuzz is not a function
      at Context.<anonymous> (test/index.js:6:16)
      at processImmediate (internal/timers.js:456:21)

  2) fizzbuzz
       returns Fizz when value is divisible by 3:
     TypeError: fizzbuzz is not a function
      at Context.<anonymous> (test/index.js:10:16)
      at processImmediate (internal/timers.js:456:21)

  3) fizzbuzz
       returns Buzz when value is divisible by 5:
     TypeError: fizzbuzz is not a function
      at Context.<anonymous> (test/index.js:14:16)
      at processImmediate (internal/timers.js:456:21)

  4) fizzbuzz
       returns the value when value is not divisible by 3 or 5:
     TypeError: fizzbuzz is not a function
      at Context.<anonymous> (test/index.js:18:16)
      at processImmediate (internal/timers.js:456:21)



npm ERR! Test failed.  See above for more details.

# change module.export to module.exports on index.js
$ npm test

> fizz-buzz@1.0.0 test /Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2
> mocha



  fizzbuzz
    ✓ returns FizzBuzz when value is divisible by 15
    ✓ returns Fizz when value is divisible by 3
    ✓ returns Buzz when value is divisible by 5
    ✓ returns the value when value is not divisible by 3 or 5


  4 passing (4ms)

$ npm install --save-dev eslint @cybozu/eslint-config prettier

$ touch .eslintrc.js
$ npm run lint

> fizz-buzz@1.0.0 lint /Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2
> eslint .


Oops! Something went wrong! :(

ESLint: 7.7.0

Error: ESLint configuration in .eslintrc.js is invalid:
        - Unexpected top-level property "extemds".

    at validateConfigSchema (/Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2/node_modules/eslint/lib/shared/config-validator.js:261:15)
    at ConfigArrayFactory._normalizeConfigData (/Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2/node_modules/eslint/lib/cli-engine/config-array-factory.js:626:9)
    at ConfigArrayFactory.loadInDirectory (/Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2/node_modules/eslint/lib/cli-engine/config-array-factory.js:496:33)
    at CascadingConfigArrayFactory._loadConfigInAncestors (/Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2/node_modules/eslint/lib/cli-engine/cascading-config-array-factory.js:355:46)
    at CascadingConfigArrayFactory.getConfigArrayForFile (/Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2/node_modules/eslint/lib/cli-engine/cascading-config-array-factory.js:276:18)
    at FileEnumerator._iterateFilesRecursive (/Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2/node_modules/eslint/lib/cli-engine/file-enumerator.js:431:49)
    at _iterateFilesRecursive.next (<anonymous>)
    at FileEnumerator.iterateFiles (/Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2/node_modules/eslint/lib/cli-engine/file-enumerator.js:287:49)
    at iterateFiles.next (<anonymous>)
    at CLIEngine.executeOnFiles (/Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2/node_modules/eslint/lib/cli-engine/cli-engine.js:751:48)
npm ERR! code ELIFECYCLE
npm ERR! errno 2
npm ERR! fizz-buzz@1.0.0 lint: `eslint .`
npm ERR! Exit status 2
npm ERR! 
npm ERR! Failed at the fizz-buzz@1.0.0 lint script.
npm ERR! This is probably not a problem with npm. There is likely additional logging output above.

npm ERR! A complete log of this run can be found in:
npm ERR!     /Users/kota.oue/.npm/_logs/2020-08-15T03_14_25_499Z-debug.log

# modify TYPO in .eslintrc.js
$ npm run lint

> fizz-buzz@1.0.0 lint /Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2
> eslint .


/Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2/.eslintrc.js
  2:3  error  Delete `··`                                            prettier/prettier
  3:3  error  Delete `··`                                            prettier/prettier
  4:1  error  Replace `········mocha:·true` with `····mocha:·true,`  prettier/prettier
  5:1  error  Replace `····}` with `··},`                            prettier/prettier
  6:3  error  Insert `⏎`                                             prettier/prettier

/Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2/index.js
   2:3  error  Delete `··`                     prettier/prettier
   3:5  error  Delete `····`                   prettier/prettier
   4:1  error  Replace `····` with `··`        prettier/prettier
   6:1  error  Delete `··`                     prettier/prettier
   7:1  error  Delete `····`                   prettier/prettier
   8:3  error  Delete `··`                     prettier/prettier
  10:1  error  Delete `··`                     prettier/prettier
  11:1  error  Replace `········` with `····`  prettier/prettier
  12:3  error  Delete `··`                     prettier/prettier
  14:1  error  Delete `··`                     prettier/prettier
  15:3  error  Insert `⏎`                      prettier/prettier

/Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2/test/index.js
   5:3  error  Delete `··`               prettier/prettier
   6:5  error  Delete `····`             prettier/prettier
   7:3  error  Delete `··`               prettier/prettier
   9:1  error  Replace `····` with `··`  prettier/prettier
  10:5  error  Delete `····`             prettier/prettier
  11:3  error  Delete `··`               prettier/prettier
  13:1  error  Replace `····` with `··`  prettier/prettier
  14:5  error  Delete `····`             prettier/prettier
  15:3  error  Delete `··`               prettier/prettier
  17:1  error  Replace `····` with `··`  prettier/prettier
  18:5  error  Delete `····`             prettier/prettier
  19:3  error  Delete `··`               prettier/prettier
  20:4  error  Insert `⏎`                prettier/prettier

✖ 29 problems (29 errors, 0 warnings)
  29 errors and 0 warnings potentially fixable with the `--fix` option.

npm ERR! code ELIFECYCLE
npm ERR! errno 1
npm ERR! fizz-buzz@1.0.0 lint: `eslint .`
npm ERR! Exit status 1
npm ERR! 
npm ERR! Failed at the fizz-buzz@1.0.0 lint script.
npm ERR! This is probably not a problem with npm. There is likely additional logging output above.

npm ERR! A complete log of this run can be found in:
npm ERR!     /Users/kota.oue/.npm/_logs/2020-08-15T03_16_25_853Z-debug.log

$ npm run lint

> fizz-buzz@1.0.0 lint /Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions/ch2
> eslint .

$ npm run test

> fizz-buzz@1.0.0 test /Users/kota.oue/ghq/github.com/kotaoue/PracticeForGitHubActions
> nyc --reporter=html --reporter=text mocha



  fizzbuzz
    ✓ returns FizzBuzz when value is divisible by 15
    ✓ returns Fizz when value is divisible by 3
    ✓ returns Buzz when value is divisible by 5
    ✓ returns the value when value is not divisible by 3 or 5


  4 passing (3ms)

----------|---------|----------|---------|---------|-------------------
File      | % Stmts | % Branch | % Funcs | % Lines | Uncovered Line #s 
----------|---------|----------|---------|---------|-------------------
All files |     100 |      100 |     100 |     100 |                   
 index.js |     100 |      100 |     100 |     100 |                   
----------|---------|----------|---------|---------|-------------------
```
