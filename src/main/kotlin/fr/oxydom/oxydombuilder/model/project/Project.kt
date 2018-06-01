package fr.oxydom.oxydombuilder.model.project

import fr.oxydom.oxydombuilder.model.client.Client
import javax.persistence.*

@Entity
@Table(name = "project")
data class Project(
        val libelle : String,
        val code : String,
        val status : String,
        @ManyToOne
        @JoinColumn
        val client: Client? = null,
        @Id @GeneratedValue
        val id: Long? = null
)