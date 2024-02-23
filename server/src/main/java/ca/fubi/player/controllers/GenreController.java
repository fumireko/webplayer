package ca.fubi.player.controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import ca.fubi.player.models.Genre;
import ca.fubi.player.models.Song;
import ca.fubi.player.repository.GenreRepository;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/genres")
public class GenreController {
	@Autowired
	private GenreRepository genreRepo;
	
	@GetMapping("/")
	public ResponseEntity<List<Genre>> getGenres(){
		return ResponseEntity.ok(genreRepo.findAll());
	}
	
	@GetMapping("/{id}")
	public ResponseEntity<Optional<Genre>> getGenreById(@PathVariable Long id){
		if(id != null) {
			
			Optional<Genre> g = genreRepo.findById(id);
			
			if(g.isEmpty())
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(g);
		}
		else return ResponseEntity.badRequest().build();
	}
	
	@GetMapping("/description")
	public ResponseEntity<Optional<Genre>> getGenreByDescription(@RequestParam(name = "value", required = true) String description){
		if(description != null) {
			
			Optional<Genre> g = genreRepo.findByDescription(description);
			
			if(g.isEmpty())
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(g);
		}
		else return ResponseEntity.badRequest().build();
	}
	
	@PostMapping("/")
	public ResponseEntity<?> createGenre(@RequestBody Genre g){
		try { return ResponseEntity.ok(genreRepo.save(g)); }
		catch (Exception e) { return ResponseEntity.internalServerError().body(e.toString()); }
	}
	
	@PutMapping("/{id}")
	public ResponseEntity<Genre> updateGenre(@PathVariable Long id, @RequestBody Genre update){
		Optional<Genre> g = genreRepo.findById(id);
		if(g.isPresent()) {
			Genre genre = g.get();
			genre.setDescription(update.getDescription());
			return ResponseEntity.ok(genreRepo.save(genre));
		}
		else return ResponseEntity.notFound().build();
	}
	
	@DeleteMapping("/{id}")
	public ResponseEntity<Optional<Genre>> deleteGenre(@PathVariable Long id){
		if(id != null) {
			
			Optional<Genre> g = genreRepo.findById(id);
			
			if(g.isPresent()) {
				genreRepo.deleteById(id);
				return ResponseEntity.ok().build();
			}
			else return ResponseEntity.notFound().build();
		}
		else return ResponseEntity.badRequest().build();
	}
}
