package fr.oxydom.oxydombuilder.model.client

import fr.oxydom.oxydombuilder.model.project.Project
import javax.persistence.*

@Entity
@Table(name = "client")
data class Client(
        val firstName: String,
        val lastName: String,
        val email: String,
        val adress: String,
        val city: String,
        val country: String,
        val phone: String,
        val gender: String,
        @OneToMany
        val projects: MutableList<Project> = mutableListOf(),
        val photo: String? = null,
        @Id @GeneratedValue
        val id: Long? = null)