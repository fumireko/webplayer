package ca.fubi.player.song;

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

import ca.fubi.player.album.AlbumRepository;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600, allowCredentials = "true")
@RestController
@RequestMapping("/api/songs")
public class SongController {
	
	@Autowired
	private SongRepository songRepo;
	
	@Autowired
	private AlbumRepository albumRepo;
	
	@GetMapping("/")
	public ResponseEntity<List<Song>> getSongs(){
		return ResponseEntity.ok(songRepo.findAll());
	}
	
	@GetMapping("/{id}")
	public ResponseEntity<Optional<Song>> getSongById(@PathVariable Long id){
		if(id != null) {
			
			Optional<Song> s = songRepo.findById(id);
			
			if(s.isEmpty())
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(s);
		}
		else return ResponseEntity.badRequest().build();
	}
	
	@GetMapping("/title")
	public ResponseEntity<List<Song>> getSongById(@RequestParam(name = "value", required = true) String title){
		if(title != null) {
			
			List<Song> s = songRepo.findByTitle(title);
			
			if(s.isEmpty())
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(s);
		}
		else return ResponseEntity.badRequest().build();
	}
	
	@GetMapping("/album")
	public ResponseEntity<List<Song>> getSongByAlbumID(@RequestParam(name = "value", required = true) Long id){
		if(id != null) {
			
			List<Song> s = songRepo.findByAlbum(albumRepo.findById(id).get());
			
			if(s.isEmpty())
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(s);
		}
		else return ResponseEntity.badRequest().build();
	}
	
	@PostMapping("/")
	public ResponseEntity<?> createSong(@RequestBody Song s){
		try { return ResponseEntity.ok(songRepo.save(s)); }
		catch (Exception e) { return ResponseEntity.internalServerError().body(e.toString()); }
	}
	
	@PutMapping("/{id}")
	public ResponseEntity<Song> updateSong(@PathVariable Long id, @RequestBody Song update){
		Optional<Song> s = songRepo.findById(id);
		if(s.isPresent()) {
			Song song = s.get();
			song.setTitle(update.getTitle());
			song.setAlbum(update.getAlbum());
			song.setLength(update.getLength());
			song.setPlaylists(update.getPlaylists());
			
			return ResponseEntity.ok(songRepo.save(song));
		}
		else return ResponseEntity.notFound().build();
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Optional<Song>> deleteSong(@PathVariable Long id){
		if(id != null) {
			
			Optional<Song> s = songRepo.findById(id);
			
			if(s.isPresent()) {
				songRepo.deleteById(id);
				return ResponseEntity.ok().build();
			}
			else return ResponseEntity.notFound().build();
		}
		else return ResponseEntity.badRequest().build();
	}
}
