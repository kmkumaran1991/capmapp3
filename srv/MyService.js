const cds = require('@sap/cds');
const { employees } = cds.entities("anubhav.db.master");
module.exports = (srv) => {
    
    srv.on('pokymon', req => `Hello ${req.data.name}`);

    srv.on('READ','ReadEmployeeSrv', async(req) => {

        ///Exmaple of hardcoded data
        // return {
        //     "ID": "2222-22",
        //     "nameFirst": "pikachu"
        // }

        ///Calling DB and adding extra logic
        const tx = await cds.tx(req);

        //Example 2: Read and manipulate data
        // var returndata = [];
        // var results = await tx.run(SELECT.from(employees).limit(5));
        // for (let i = 0; i < results.length; i++) {
        //     const element = results[i];
            
        //     element.nameMiddle = 'badhiya!'
        //     returndata.push(element);
        // }
        // return returndata;

        ///Example 3: working with conditions
        var whereCondition = req.data;
        if(whereCondition.hasOwnProperty("ID")){
            return await tx.run(SELECT.from(employees).where(whereCondition));
        }else{
            return await tx.run(SELECT.from(employees).limit(2).where({
                "sex": 'F'
            }));
        }

    });

}