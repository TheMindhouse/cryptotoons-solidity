export class ClockAuctionBase {

    constructor(instance) {
        this.wrapped = instance;
    }

    /**
     *
     * @param {string}address
     * @param options
     * @returns {Promise<void>}
     */
    addToonContract = async (address, options = {}) => await this.wrapped.addToonContract(address, options)

}