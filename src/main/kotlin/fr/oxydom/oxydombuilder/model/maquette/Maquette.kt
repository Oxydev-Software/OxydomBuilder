package fr.oxydom.oxydombuilder.model.maquette

import fr.oxydom.oxydombuilder.model.project.Project
import fr.oxydom.oxydombuilder.model.tva.Tva
import java.time.ZonedDateTime
import javax.persistence.*

@Entity
@Table(name = "maquette")
data class Maquette(
        val libelle: String,
        val code : String,
        val invoiceNumber : String,
        val creationDate : ZonedDateTime,
        val limitValidityDate : ZonedDateTime,
        val estimatedWorkDuration : Int,
        val status : String,
        @OneToOne
        val tva : Tva,
        @OneToOne
        val projet : Project,
        val comment : String?,
        @Id @GeneratedValue
        val id: Long? = null
)