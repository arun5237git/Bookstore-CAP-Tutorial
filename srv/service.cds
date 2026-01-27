using {tutorial.db as db} from '../db/schema'; //Create alias db so that we can use the entities that are created in schema.cds in db folder

service BookstoreService {
    entity Books      as projection on db.Books
        actions {
            action addStock(); //Custom action bound to Books Entity
            action changePublishDate(newDate: Date); // Change published date
            //Side effects to refresh page when stock & status code is updated using custom action
            @(Common.SideEffects: {TargetProperties: [
                'status_code',
                'stock'
            ]})

            //If you want to update whole entity based on custom action without refreshing page
            // @(Common.SideEffects: {TargetEntities: ['in']})

            // Change Status with custom dropdown based on Status. These annotations are copied from annotations.cds
            action changeStatus( @(Common: {
                                     ValueListWithFixedValues: true,
                                     Label                   : 'Available Status',
                                     ValueList               : {
                                         $Type         : 'Common.ValueListType',
                                         CollectionPath: 'BookStatus',
                                         Parameters    : [{
                                             $Type            : 'Common.ValueListParameterInOut',
                                             LocalDataProperty: newStatus,
                                             ValueListProperty: 'code',
                                         }, ],
                                     },

                                 }) newStatus: String);
        };


    entity Authors    as projection on db.Authors;
    entity Chapters   as projection on db.Chapters;
    entity BookStatus as projection on db.BookStatus;
    entity GenresVH   as projection on db.Genres;
}

annotate BookstoreService.Books with @odata.draft.enabled;
