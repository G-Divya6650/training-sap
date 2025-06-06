const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { Books, Buyers } = this.entities;

    const northWindService = await cds.connect.to('NorthWind');

    this.on('READ', 'Customers', async req => {
        return northWindService.run(req.query);
    })

    this.before('CREATE',Books, async req => {
        console.log(req.data)

        req.data.createdAt = new Date();

        const existingBooks = await SELECT.one.from(Books).where({ bookName: req.data.bookName });
        console.log('existingBooks',existingBooks);

        //for(let book of existingBooks) {
        if(existingBooks){
            if(existingBooks.bookName == req.data.bookName) {
                req.reject(406, `The Book ${req.data.bookName} already exists.`);
                // req.reject(406, `The Book ` +  req.data.bookName + ` already exists.`);
            }
        }    
    
    }); 
    this.on('sell', Books, async req => {
         console.log('********* Executing Action Sell *********')
         //console.log(req)
         // console.log(req.data)
         const id = req.params[0].ID;
         console.log("ID value =", id)
          let vBook = await SELECT.one.from(Books).where({ID: id});
          console.log('vBook', vBook);
         
         let netCopies = vBook.noOfCopies - req.data.noOfCopies;
         
         await UPDATE(Books).set({noOfCopies: netCopies}).where({ID: id});
 
        await INSERT.into(Buyers).entries({
           firstName: req.data.firstName,
           lastName: req.data.lastName,
           noOfCopies: req.data.noOfCopies,
           to_book_ID: id // assign the Book Id to to_book_ID in Buyers Entity to link the record
      });

   });

   this.after('CREATE', Books, async (data, req) => {
        console.log(' ********* Create *********')
        // console.log(req, data)
        req.notify({
           type: 'Success',
           message: `A New Book "${data.bookName}" was created successfully!`
        });
     })
       
});