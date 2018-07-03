require('babel-register');
require('babel-polyfill');

module.exports = {
    // See <http://truffleframework.com/docs/advanced/configuration>
    // to customize your Truffle configuration!
    networks: {
        dev: {
            host: "localhost",
            port: 8545,
            network_id: "*", // Match any network id
            gas: 7000000
        },
        rinkeby: {
            host: "localhost", // Connect to geth on localhost
            port: 8545,
            from: "0x329fE1d35FFE409bA2E0DFFF99D57555CA656EB4", //run transaction from this address
            network_id: 4,
            gas: 4612388 // Gas limit used for deploys
        }
    },

    mocha: {
        useColors: true
    },
    solc: {
        optimizer: {
            enabled: true,
            runs: 200
        }
    }
};
