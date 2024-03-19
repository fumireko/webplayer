package ca.fubi.player.playlist;

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

import ca.fubi.player.song.Song;
import ca.fubi.player.song.SongRepository;
import ca.fubi.player.user.User;
import ca.fubi.player.user.UserRepository;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600, allowCredentials = "true")
@RestController
@RequestMapping("/api/playlists")
public class PlaylistController {
	@Autowired
	private PlaylistRepository playlistRepo;
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private SongRepository songRepo;
	
	@GetMapping("/")
	public ResponseEntity<List<Playlist>> getPlaylists(){
		return ResponseEntity.ok(playlistRepo.findAll());
	}
	
	@GetMapping("/{id}")
	public ResponseEntity<Optional<Playlist>> getPlaylistById(@PathVariable Long id){
		if(id != null) {
			
			Optional<Playlist> p = playlistRepo.findById(id);
			if(p.isEmpty())
			 	 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(p);
		}
		else return ResponseEntity.badRequest().build();
	}
	
	@GetMapping("/name")
	public ResponseEntity<Optional<Playlist>> getPlaylistByName(@RequestParam(name = "value", required = true) String name){
		if(name != null) {
			
			Optional<Playlist> p = playlistRepo.findByName(name);
			if(p.isEmpty())
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(p);
		}
		else return ResponseEntity.badRequest().build();
	}
	
	
	@GetMapping("/user/{id}")
	public ResponseEntity<List<Playlist>> getPlaylistsByUserId(@PathVariable Long userId){
		if(userId != null) {
			
			User u = userRepo.findById(userId).get();
			List<Playlist> p = playlistRepo.findByUser(u);
			if(p.isEmpty())
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(p);
		}
		else return ResponseEntity.badRequest().build();
	}
	
	@GetMapping("/user")
	public ResponseEntity<List<Playlist>> getPlaylistsByUser(@RequestBody User user){
		if(user != null) {
			
			List<Playlist> p = playlistRepo.findByUser(user);
			if(p.isEmpty())
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(p);
		}
		else return ResponseEntity.badRequest().build();
	}
	
	@PostMapping("/")
	public ResponseEntity<?> createPlaylist(@RequestBody Playlist p){
		try { return ResponseEntity.ok(playlistRepo.save(p)); }
		catch (Exception e) { return ResponseEntity.internalServerError().body(e.toString()); } 
	}
	
	@PutMapping("/{id}")
	public ResponseEntity<Playlist> updatePlaylist(@PathVariable Long id, @RequestBody Playlist update){
	    return playlistRepo.findById(id)
	            .map(playlist -> {
	                playlist.setName(update.getName());
	                playlist.setUser(update.getUser());
	                playlist.setSongs(update.getSongs());
	                return ResponseEntity.ok(playlistRepo.save(playlist));
	            })
	            .orElse(ResponseEntity.notFound().build());
	}

	@PutMapping("/{id}/add-song/{songId}")
	public ResponseEntity<Playlist> addSongToPlaylist(@PathVariable Long id, @PathVariable Long songId) {
	    if(id != null && songId != null) {
	        Optional<Playlist> playlistOptional = playlistRepo.findById(id);
	        Optional<Song> songOptional = songRepo.findById(songId);
	        
	        if(playlistOptional.isPresent() && songOptional.isPresent()) {
	            Playlist playlist = playlistOptional.get();
	            playlist.getSongs().add(songOptional.get());
	            return ResponseEntity.ok(playlistRepo.save(playlist));
	        } else {
	            return ResponseEntity.notFound().build();
	        }
	    } else {
	        return ResponseEntity.badRequest().build();
	    }
	}

	@PutMapping("/{id}/remove-song/{songId}")
	public ResponseEntity<Playlist> removeSongFromPlaylist(@PathVariable Long id, @PathVariable Long songId) {
	    if(id != null && songId != null) {
	        Optional<Playlist> playlistOptional = playlistRepo.findById(id);
	        Optional<Song> songOptional = songRepo.findById(songId);
	        
	        if(playlistOptional.isPresent() && songOptional.isPresent()) {
	            Playlist playlist = playlistOptional.get();
	            playlist.getSongs().remove(songOptional.get());
	            return ResponseEntity.ok(playlistRepo.save(playlist));
	        } else {
	            return ResponseEntity.notFound().build();
	        }
	    } else {
	        return ResponseEntity.badRequest().build();
	    }
	}
	
	@DeleteMapping("/{id}")
	public ResponseEntity<Optional<Playlist>> deletePlaylist(@PathVariable Long id){
		if(id != null) {
			
			Optional<Playlist> p = playlistRepo.findById(id);
			
			if(p.isPresent()) {
				playlistRepo.deleteById(id);
				return ResponseEntity.ok().build();
			}
			else return ResponseEntity.notFound().build();
		}
		else return ResponseEntity.badRequest().build();
	}
	
}
