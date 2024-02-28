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
import ca.fubi.player.models.associations.AlbumArtist;
import ca.fubi.player.models.associations.AlbumArtistId;
import ca.fubi.player.models.dto.AlbumArtistDTO;
import ca.fubi.player.repository.AlbumArtistRepository;
import ca.fubi.player.repository.AlbumRepository;
import ca.fubi.player.repository.ArtistRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/albums")
public class AlbumController {
	
	@Autowired
	private ArtistRepository artistRepo;
	
	@Autowired
	private AlbumRepository albumRepo;
	
	@Autowired
	private AlbumArtistRepository albumArtistRepo;
	
	@GetMapping("/")
	public ResponseEntity<List<Album>> getAlbums(){
		return ResponseEntity.ok(albumRepo.findAll());
	}
	
	@GetMapping("/{id}")
	public ResponseEntity<Optional<Album>> getAlbumById(@PathVariable Long id){
		if(id != null) {
			
			Optional<Album> a = albumRepo.findById(id);
			
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
	
	/*
	@GetMapping("/artist")
	public ResponseEntity<List<Album>> getAlbumsByArtistID(@RequestParam(name = "value", required = true) Long artistId) {
		if(artistId != null) {
			
			Optional<Artist> a = artistRepo.findById(artistId);
			
			if(a.isEmpty()) 
				 return ResponseEntity.notFound().build();
			else return ResponseEntity.ok(
							albumRepo.findByArtist(a.get()).stream()
							.collect(Collectors.toList())
						);
		}
		else return ResponseEntity.badRequest().build();
	}*/
	
    @PostMapping("/")
    public ResponseEntity<?> createAlbum(@RequestBody Album rq) {
        try {
        	for(Artist a : rq.getArtists()) {;
        		a.addAlbum(rq);
        		artistRepo.save(a);
        	}
            
            return ResponseEntity.ok(albumRepo.save(rq));
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(e.toString());
        }
    }
	
	@PutMapping("/{id}")
	public ResponseEntity<Album> updateAlbum(@PathVariable Long id, @RequestBody Album update) {
	    Optional<Album> albumOptional = albumRepo.findById(id);
	    if (albumOptional.isPresent()) {
	        Album album = albumOptional.get();

	        album.setTitle(update.getTitle());
	        album.setImageUrl(update.getImageUrl());
	        album.setReleaseDate(update.getReleaseDate());
	        album.setArtists(update.getArtists());

	        for(Artist i : update.getArtists())
	        	artistRepo.save(i);
	        
	        return ResponseEntity.ok(albumRepo.save(album));
	    } else {
	        return ResponseEntity.notFound().build();
	    }
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
