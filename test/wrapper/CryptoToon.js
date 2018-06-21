import {ToonAuction} from "./ToonAuction";

const BigNumber = require('bignumber.js');

export class CryptoToon extends ToonAuction {

    constructor(instance) {
        super(instance)
    }

    /**
     *
     * @param {number} toonId
     * @returns {Promise<{genes: BigNumber, birthTime: BigNumber, owner: string}>}
     */
    getToonInfo = async (toonId) => {
        let result = await this.wrapped.getToonInfo(toonId);
        return {
            genes: result[0],
            birthTime: result[1],
            owner: result[2]
        };
    };

}