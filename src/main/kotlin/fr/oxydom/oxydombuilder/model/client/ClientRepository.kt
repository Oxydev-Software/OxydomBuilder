package fr.oxydom.oxydombuilder.model.client

import org.springframework.data.repository.CrudRepository

interface ClientRepository : CrudRepository<Client, Long> {
    fun findByLastName(name: String): List<Client>
}