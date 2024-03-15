package ca.fubi.player.controllers;

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

import ca.fubi.player.models.Album;
import ca.fubi.player.models.Artist;
import ca.fubi.player.repository.AlbumRepository;
import ca.fubi.player.repository.ArtistRepository;
import ca.fubi.player.repository.SongRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600, allowCredentials = "true")
@RestController
@RequestMapping("/api/albums")
public class AlbumController {
	
	@Autowired
	private ArtistRepository artistRepo;
	
	@Autowired
	private AlbumRepository albumRepo;
	
	@Autowired
	private SongRepository songRepo;
	
	@GetMapping("/")
	public ResponseEntity<List<Album>> getAlbums(){
		return ResponseEntity.ok(albumRepo.findAll());
	}
	
	@GetMapping("/{id}")
	public ResponseEntity<Optional<Album>> getAlbumById(@PathVariable Long id){
		if(id != null) {
			
			Optional<Album> a = albumRepo.findById(id);
			System.out.println("Size of songs array: " + a.get().getSongs().size());
			if(a.isEmpty())
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(a);
		}
		else return ResponseEntity.badRequest().build();
	}
	
	@GetMapping("/title")
	public ResponseEntity<Optional<Album>> getAlbumByTitle(@RequestParam(name = "value", required = true) String title){
		if(title != null) {
			
			Optional<Album> a = albumRepo.findByTitle(title);
			
			if(a.isEmpty()) 
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(a);
		}
		else return ResponseEntity.badRequest().build();
	}

	@GetMapping("/artist")
	public ResponseEntity<List<Album>> getAlbumsByArtistID(@RequestParam(name = "value", required = true) Long artistId) {
		if(artistId != null) {
			
			Optional<Artist> a = artistRepo.findById(artistId);
			
			if(a.isEmpty()) 
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(
							albumRepo.findByArtists(a.get()).stream()
							.collect(Collectors.toList())
						);
		}
		else return ResponseEntity.badRequest().build();
	}
	
	@PostMapping("/")
	public ResponseEntity<?> createAlbum(@RequestBody Album rq) {
	    try {
	        Album savedAlbum = albumRepo.save(rq);
	        savedAlbum.getArtists().forEach(artist -> {
	            artist.addAlbum(savedAlbum);
	            artistRepo.save(artist);
	        });
	        savedAlbum.getSongs().forEach(song -> {
	        	song.setAlbum(savedAlbum);
	        	songRepo.save(song);
	        });
	        return ResponseEntity.ok(savedAlbum);
	    } catch (Exception e) {
	        return ResponseEntity.internalServerError().body(e.toString());
	    }
	}

	@PutMapping("/{id}")
	public ResponseEntity<Album> updateAlbum(@PathVariable Long id, @RequestBody Album update) {
	    return albumRepo.findById(id)
	            .map(album -> {
	                album.setTitle(update.getTitle());
	                album.setImageUrl(update.getImageUrl());
	                album.setReleaseDate(update.getReleaseDate());
	                album.setArtists(update.getArtists());
	                update.getSongs().forEach(songRepo::save);
	                update.getArtists().forEach(artistRepo::save);
	                return ResponseEntity.ok(albumRepo.save(album));
	            })
	            .orElse(ResponseEntity.notFound().build());
	}

	
	@DeleteMapping("/{id}")
	public ResponseEntity<Optional<Album>> deleteAlbum(@PathVariable Long id){
		if(id != null) {
			
			Optional<Album> a = albumRepo.findById(id);
			
			if(a.isPresent()) {
				albumRepo.deleteById(id);
				return ResponseEntity.ok().build();
			}
			else return ResponseEntity.notFound().build();
		}
		else return ResponseEntity.badRequest().build();
	}
}
