package fr.oxydom.oxydombuilder

import fr.oxydom.oxydombuilder.model.client.Client
import fr.oxydom.oxydombuilder.model.client.ClientRepository
import fr.oxydom.oxydombuilder.model.project.Project
import fr.oxydom.oxydombuilder.model.project.ProjectRepository
import fr.oxydom.oxydombuilder.portadapter.requesthandler.RequestHandlerFacade
import org.slf4j.LoggerFactory
import org.springframework.boot.CommandLineRunner
import org.springframework.boot.autoconfigure.ImportAutoConfiguration
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@SpringBootApplication
class OxydombuilderApplication {

    val log = LoggerFactory.getLogger(OxydombuilderApplication::class.java)
    @Bean
    fun init(clientRepository: ClientRepository, projectRepository: ProjectRepository, requestHandlerFacade: RequestHandlerFacade) = CommandLineRunner {
        val client = Client("Jack", "Bauer", "jackb@gmail.com", "42 quai mandet", "Toulouse", "France", "0606975545", "male")
        val project = Project(client)
        clientRepository.save(client)
        projectRepository.save(project)

        clientRepository.save(Client("Chloe", "Keller", "chloek@gmail.com", "27 rue banbelle", "Lyon", "France", "0612345678", "female"))
        clientRepository.save(Client("Maddie", "Jonson", "maddiej@gmail.com", "42 bd anget", "Bordeaux", "France", "0954586523", "female"))
        clientRepository.save(Client("Kim", "Jong", "kimj@gmail.com", "98 rue alphonse det", "LeMans", "France", "0687549645", "male"))
        clientRepository.save(Client("David", "Keller", "davidk@gmail.com", "78 bd daux finois", "Paris", "France", "0698564123", "male"))
        clientRepository.save(Client("Michelle", "Dessler", "michelled@gmail.com", "15 avenue diste", "Lille", "France", "0612457895", "female"))

        // fetch all clients
        log.info("Client found with findAll():")
        log.info("-------------------------------")
        clientRepository.findAll().forEach { log.info(it.toString()) }
        log.info("")

        // fetch an individual client by ID
        val customer = clientRepository.findById(1L)
        customer.ifPresent {
            log.info("Client found with findById(1L):")
            log.info("--------------------------------")
            log.info(it.toString())
            log.info("")
        }

        // fetch clients by last name
        log.info("Client found with findByLastName('Keller'):")
        log.info("--------------------------------------------")
        clientRepository.findByLastName("Keller").forEach { log.info(it.toString()) }
        log.info("")

        // fetch all project
        log.info("Project found with findAll():")
        log.info("-------------------------------")
        projectRepository.findAll().forEach { log.info(it.toString()) }
        log.info("")

        //Testing RequestHandler
        val clientJson =
                "{\"firstName\":\"Pierre\",\"lastName\":\"Rochas\",\"email\":\"jackb@gmail.com\",\"adress\":\"42 quai mandet\",\"city\":\"Toulouse\",\"country\":\"France\",\"phone\":\"0606975545\",\"gender\":\"male\"}"
        requestHandlerFacade.createClient(clientJson)
        val clientRetrieved = requestHandlerFacade.findClientById(8)
        log.info(clientRetrieved)

    }
}

fun main(args: Array<String>) {
    runApplication<OxydombuilderApplication>(*args)
}
