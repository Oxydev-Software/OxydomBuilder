package fr.oxydom.oxydombuilder.model.module

import fr.oxydom.oxydombuilder.model.gamme.Gamme
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Table

@Entity
@Table(name="module")
open
data class Module (
        val libelle : String,
        val price : Float,
        val lenght : Float,
        val width : Float,
        val thickness : Float,
        val valid : Boolean,
        val gamme : Gamme?,
        val comment : String?,
        @Id @GeneratedValue
        val id: Long? = null
)