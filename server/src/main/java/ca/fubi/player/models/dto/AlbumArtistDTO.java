package ca.fubi.player.models.dto;

import java.util.Set;

import ca.fubi.player.models.Album;
import ca.fubi.player.models.Artist;

public class AlbumArtistDTO {
    private Album album;
    private Set<Artist> artists;

    public AlbumArtistDTO() {
		// TODO Auto-generated constructor stub
	}
    
    public AlbumArtistDTO(Album album, Set<Artist> artists){
    	this.setAlbum(album);
    	this.setArtists(artists);
    }
    
    public Album getAlbum() {
		return album;
	}
    
    public void setAlbum(Album album) {
		this.album = album;
	}
    
    public Set<Artist> getArtists() {
		return artists;
	}
    
    public void setArtists(Set<Artist> artists) {
		this.artists = artists;
	}
}