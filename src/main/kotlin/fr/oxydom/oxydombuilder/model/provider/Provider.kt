package fr.oxydom.oxydombuilder.model.provider

import fr.oxydom.oxydombuilder.model.agency.Agency
import javax.persistence.*

@Entity
@Table(name = "provider")
data class Provider(
        val siretNumber : String,
        val name : String,
        val adress : String,
        val city : String,
        val country : String,
        val email : String,
        val telephone : String,
        @ManyToMany
        val agencies : MutableList<Agency> = mutableListOf(),
        @Id @GeneratedValue
        val id: Long? = null
)