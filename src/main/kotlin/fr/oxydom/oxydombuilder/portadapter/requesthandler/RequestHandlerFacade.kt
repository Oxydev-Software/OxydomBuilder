package fr.oxydom.oxydombuilder.portadapter.requesthandler

import fr.oxydom.oxydombuilder.portadapter.manager.ClientManager
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component

@Component
class RequestHandlerFacade {
    @Autowired
    lateinit var  clientManager: ClientManager

    fun createClient(clientJson: String) : String = clientManager.create(clientJson)
    fun findClientById(id: Long) : String = clientManager.findClientById(id)
}