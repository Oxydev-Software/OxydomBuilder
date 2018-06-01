package fr.oxydom.oxydombuilder.model.tva

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Table

@Entity
@Table(name = "tva")
data class Tva (
        val rate : Float,
        @Id @GeneratedValue
        val id: Long? = null
)