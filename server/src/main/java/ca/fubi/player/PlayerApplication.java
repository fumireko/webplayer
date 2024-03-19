package ca.fubi.player;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import ca.fubi.player.file.FilesStorageService;
import jakarta.annotation.Resource;

@SpringBootApplication
public class PlayerApplication implements CommandLineRunner{

	@Resource
	FilesStorageService storageService;
	
	public static void main(String[] args) {
		SpringApplication.run(PlayerApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		storageService.deleteAll();
		storageService.init();
	}
}
