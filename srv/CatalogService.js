module.exports = cds.service.impl(async function(){

    const {POs, EmployeeSet} = this.entities;

    //generic handler - developer get flexibility to attach their 
    //own code on top of what CAPM already offers
    this.before(['CREATE','PATCH'], EmployeeSet, (req) => {
        if(parseFloat(req.data.salaryAmount) >= 1000000){
            req.error(500, "Hey amigo, we cannot support salary over a million");
        }
    });


    this.on('boost', async(req) => {
        console.log('aa gaya');
        
        try {
            const ID = req.params[0];
            //start a db transaction
            const tx = cds.tx(req);
            //CDS Query Language - communicate to DB in agnostic manner
            await tx.update(POs).with({
                GROSS_AMOUNT: { '+=' : 20000 }
            }).where(ID);
        } catch (error) {
            return "Error " + error.toString();
        }

    });

    this.on('largestOrder', async(req) => {
        console.log('aa gaya');
        
        try {
            //Start a new DB transaction
            const tx = cds.tx(req);
            //Read the PO with highest gross amount
            //Read orders desc by gross + get the first record
            const recordData = tx.read(POs).orderBy({
                GROSS_AMOUNT: 'desc'
            }).limit(1);

            return recordData;

        } catch (error) {
            return "Error " + error.toString();
        }

    });

    this.on('getOrderStatus', async(req, res) => {
        return {
            "OVERALL_STATUS": "N"
        };
    });

});