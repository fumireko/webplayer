package ca.fubi.player.artist;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Random;
import java.util.Set;
import java.util.stream.Collectors;

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

import ca.fubi.player.album.Album;
import ca.fubi.player.genre.Genre;
import ca.fubi.player.song.Song;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600, allowCredentials = "true")
@RestController
@RequestMapping("/api/artists")
public class ArtistController {
	@Autowired
	private ArtistRepository artistRepo;
	
	@GetMapping("/")
	public ResponseEntity<List<Artist>> getArtists(){
		for(Artist i : artistRepo.findAll()) {
			System.out.println("[DEBUG] /GET artists: " + i.getId());
		}
		return ResponseEntity.ok(artistRepo.findAll());
	}
	
	@GetMapping("/{id}")
	public ResponseEntity<Optional<Artist>> getArtistById(@PathVariable Long id){
		if(id != null) {
			Optional<Artist> a = artistRepo.findById(id);
			if(a.isEmpty())
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(a); 
		}
		else return ResponseEntity.badRequest().build();
	}
	
    @GetMapping("/{id}/songs")
    public ResponseEntity<List<Song>> getAllSongsOfArtist(@PathVariable Long id) {
        return artistRepo.findById(id)
            .map(artist -> ResponseEntity.ok(artist.getAlbums().stream()
                .flatMap(album -> album.getSongs().stream())
                .collect(Collectors.toList())))
            .orElse(ResponseEntity.notFound().build());
    }
	
	@GetMapping("/name")
	public ResponseEntity<Optional<Artist>> getArtistByName(@RequestParam(name = "value", required = true) String name){
		if(name != null) {
			Optional<Artist> a = artistRepo.findByName(name);
			if(a.isEmpty())
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(a);
		}
		else return ResponseEntity.badRequest().build();
	}
	
	@GetMapping("/countrycode")
	public ResponseEntity<List<Artist>> getArtistsByCountryCode(@RequestParam(name = "value", required = true) EnumCountry country){
		if(country != null) {
			List<Artist> a = artistRepo.findByCountryCode(country);
			if(a.isEmpty())
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(a);
		}
		else return ResponseEntity.badRequest().build();
	}
	
	@GetMapping("/genres")
	public ResponseEntity<List<Artist>> getArtistByGenre(@RequestBody Genre genre){
		if(genre != null) {
			List<Artist> a = artistRepo.findByGenres(genre);
			if(a.isEmpty())
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(a);
		}
		else return ResponseEntity.badRequest().build();
	}
	
	@PostMapping("/")
	public ResponseEntity<?> createArtist(@RequestBody Artist a){
		try { return ResponseEntity.ok(artistRepo.save(a)); }
		catch (Exception e) { return ResponseEntity.internalServerError().body(e.toString()); }
	}
	
	@PutMapping("/{id}")
	public ResponseEntity<Artist> updateArtist(@PathVariable Long id, @RequestBody Artist update){
	    return artistRepo.findById(id)
	            .map(artist -> {
	                artist.setName(update.getName());
	                artist.setDescription(update.getDescription());
	                artist.setCountryCode(update.getCountryCode());
	                artist.setGenres(update.getGenres());
	                artist.getAlbums().clear();
	                artist.getAlbums().addAll(update.getAlbums());
	                return ResponseEntity.ok(artistRepo.save(artist));
	            })
	            .orElse(ResponseEntity.notFound().build());
	}

	
	@DeleteMapping("/{id}")
	public ResponseEntity<Optional<Artist>> deleteArtist(@PathVariable Long id){
		if(id != null) {
			
			Optional<Artist> a = artistRepo.findById(id);
			
			if(a.isPresent()) {
				artistRepo.deleteById(id);
				return ResponseEntity.ok().build();
			}
			else return ResponseEntity.notFound().build();
		}
		else return ResponseEntity.badRequest().build();
	}
}
