package fr.oxydom.oxydombuilder.portadapter.manager

import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import com.fasterxml.jackson.module.kotlin.readValue
import fr.oxydom.oxydombuilder.model.client.Client
import fr.oxydom.oxydombuilder.model.client.ClientRepository
import org.springframework.stereotype.Component
import org.springframework.web.bind.annotation.PathVariable

@Component
class ClientManager(val repository : ClientRepository) {
    val mapper = jacksonObjectMapper()

    fun findClientById(@PathVariable id : Long) : String {
        val client = repository.findById(id)
        if (client.isPresent) {
            return mapper.writeValueAsString(client.get())
        } else throw NoSuchElementException("There is no client matching id:" + id)
    }

    fun create(clientJson : String) : String {
        val client : Client = mapper.readValue(clientJson)
        repository.save(client)
        return mapper.writeValueAsString(client)
    }
}