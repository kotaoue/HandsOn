const fs = require('fs');

function getInput(name) {
  return process.env[`INPUT_${name.toUpperCase().replace(/-/g, '_')}`] || '';
}

function setOutput(name, value) {
  const outputFile = process.env['GITHUB_OUTPUT'];
  if (outputFile) {
    fs.appendFileSync(outputFile, `${name}=${value}\n`);
  }
}

try {
  const nameToGreet = getInput('who-to-greet') || 'World';
  const jsonData = getInput('json-data');

  console.log(`Hello ${nameToGreet}!`);
  const time = (new Date()).toTimeString();
  setOutput('time', time);

  const message = jsonData
    ? `Hello ${nameToGreet}! Data: ${jsonData}`
    : `Hello ${nameToGreet}!`;
  setOutput('result-message', message);
  console.log(message);
} catch (error) {
  process.stdout.write(`::error::${error.stack || error.message}\n`);
  process.exit(1);
}