package ca.fubi.player.controllers;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ca.fubi.player.models.Playlist;
import ca.fubi.player.repository.PlaylistRepository;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/playlists")
public class PlaylistController {
	@Autowired
	private PlaylistRepository playlistRepo;
	
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
	
}
