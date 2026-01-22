
const cds = require('@sap/cds')
const { Books } = cds.entities('BookstoreService')
module.exports = class BookstoreService extends cds.ApplicationService {
  init() {

    //Custom action to add stock. This will invoke addStock
    this.on('addStock', Books, async (req) => {
      const bookId = req.params[0].ID //This will give the id of the line item clicked before clicking Add Stock Button
      await UPDATE(Books).set({ stock: { '+=': 1 } }).where({ ID: bookId })
    })

    //Custom action to change published date. This will invoke changePublishDate
    this.on('changePublishDate', Books, async (req) => {
      const bookId = req.params[0].ID //This will give the id of the Book
      //Since we added a parameter of type date, a popup will appear on screen to enter date when this button is clicked. The value
      // of the date selected will be available in data.    
      const newDate = req.data.newDate
      await UPDATE(Books).set({ publishedAt: newDate }).where({ ID: bookId }) //Update pUblished date from the user input date
    })

        //Custom action to change status. This will invoke changeStatus
    this.on('changeStatus', Books, async (req) => {
      const bookId = req.params[0].ID //This will give the id of the Book
      //A custom value help is displayed based on the annotations given in service.cds
      const newStatus = req.data.newStatus //newStatus is added in service.cds file as parameter
      await UPDATE(Books).set({ status_code: newStatus }).where({ ID: bookId }) //Update changeStatus from the user input date
    })

    this.after('READ', Books, async (books, req) => {
      // Idea is to give doscout of 8% for books having genre code as SE(Software Engineering)
      for (const book of books) {  //Loop around entire books entity and pass it to work area variable book
        if (book.genre_code === 'SE') {
          book.price = book.price * 0.8 //Update price
        }
      }
    })
    return super.init()
  }
}
