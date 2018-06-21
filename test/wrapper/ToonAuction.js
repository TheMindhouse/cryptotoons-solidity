import {ToonMinting} from "./ToonMinting";

export class ToonAuction extends ToonMinting {

    constructor(instance) {
        super(instance)
    }

    /**
     *
     * @param {string} address - address of a sale auction contract
     * @param options
     * @returns {Promise<void>}
     */
    setSaleAuctionAddress = async (address, options = {}) =>
        await this.wrapped.setSaleAuctionAddress(address, options)

    /**
     *
     * @param {number} toonId
     * @param {number} startingPrice
     * @param {number} endingPrice
     * @param {number} duration
     * @param options
     * @returns {Promise<void>}
     */
    createSaleAuction = async (toonId, startingPrice, endingPrice, duration, options = {}) =>
        await this.wrapped.createSaleAuction(toonId, startingPrice, endingPrice, duration, options)

}