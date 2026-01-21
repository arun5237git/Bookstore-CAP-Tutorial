const cds = require('@sap/cds')

module.exports = class BookstoreService extends cds.ApplicationService {
  init() {

    const { Books } = cds.entities('BookstoreService')

    this.after('READ', Books, async (books, req) => {
      // Idea is to give doscout of 8% for books having genre code as SE(Software Engineering)
      for( const book of books){  //Loop around entire books entity and pass it to work area variable book
        if(book.genre_code === 'SE') {
          book.price = book.price * 0.8 //Update price
        }
      }
    })
    return super.init()
  }
}
