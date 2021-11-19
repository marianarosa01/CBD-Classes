sequencias = function() {


	let  numeros = db.phones.find({},{"display":  1}).toArray(); 
	let  seq = [] //resultado final

    for(let i=1; i < numeros.length; i++){
        let lista = [] //cada sequencia
        num_anterior = numeros[i-1].display.split("-")[1] 
        num_seguinte =  numeros[i].display.split("-")[1] 

        while(num_anterior == num_seguinte- 1){ 
            if(!lista.includes(num_anterior)) 
                lista.push(num_anterior)
            if(!lista.includes(num_seguinte))
                lista.push(num_seguinte)
            i++

            //proximos a serem avaliados
            num_anterior= numeros[i-1].display.split("-")[1]
            num_seguinte =  numeros[i].display.split("-")[1]
        }

        //se houver sequencia adicionar ao array final
        if(lista.length > 0)
            seq.push(lista)

    }
	return seq
}