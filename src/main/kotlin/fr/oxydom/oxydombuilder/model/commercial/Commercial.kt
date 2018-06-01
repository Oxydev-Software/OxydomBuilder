package fr.oxydom.oxydombuilder.model.commercial

import fr.oxydom.oxydombuilder.model.project.Project
import javax.persistence.*

@Entity
@Table(name = "commercial")
data class Commercial(
        val firstName : String,
        val lastName : String,
        val email : String,
        val code : String,
        val telephone : String,
        val password : String,
        val commission : Float,
        @OneToMany
        val projects: MutableList<Project> = mutableListOf(),
        @Id @GeneratedValue
        val id: Long? = null
)