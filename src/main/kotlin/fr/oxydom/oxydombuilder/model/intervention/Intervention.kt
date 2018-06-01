package fr.oxydom.oxydombuilder.model.intervention

import fr.oxydom.oxydombuilder.model.commercial.Commercial
import fr.oxydom.oxydombuilder.model.project.Project
import java.time.ZonedDateTime
import javax.persistence.*

@Entity
@Table(name = "intervention")
data class Intervention(
        val date : ZonedDateTime,
        @OneToOne
        val project: Project,
        @OneToOne
        val commercial: Commercial,
        @Id @GeneratedValue
        val id: Long? = null
)