package fr.oxydom.oxydombuilder.model.project

import fr.oxydom.oxydombuilder.model.client.Client
import javax.persistence.*

@Entity
@Table(name = "project")
data class Project(
        @ManyToOne
        @JoinColumn
        val client: Client? = null,
        @Id @GeneratedValue
        val id: Long? = null
)