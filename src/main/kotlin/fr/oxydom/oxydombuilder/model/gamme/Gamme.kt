package fr.oxydom.oxydombuilder.model.gamme

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Table

@Entity
@Table(name = "gamme")
data class Gamme (
        val libelle : String,
        val bonusSet : Float,
        val bonusIndividual : Float,
        @Id @GeneratedValue
        val id: Long? = null
)