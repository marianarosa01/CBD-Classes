countNumPhonesCountry = function () {
        
    cursor = db.phones.aggregate([{ $group: { _id: "$components.country", indicativosNacionais: { $sum: 1 } } } ]);
    while (cursor.hasNext()) {
        lista = cursor.next();
        print(`Country: ${lista._id} Nº of phone numbers: ${lista.indicativosNacionais}.`);
    }
}
