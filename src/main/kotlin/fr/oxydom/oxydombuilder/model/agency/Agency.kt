package fr.oxydom.oxydombuilder.model.agency

import fr.oxydom.oxydombuilder.model.provider.Provider
import javax.persistence.*

@Entity
@Table(name = "agency")
data class Agency(
        val phone : String,
        val code : String,
        val adress : String,
        val city : String,
        val country : String,
        @ManyToMany
        val providers : MutableList<Provider> = mutableListOf(),
        @Id @GeneratedValue
        val id: Long? = null
)