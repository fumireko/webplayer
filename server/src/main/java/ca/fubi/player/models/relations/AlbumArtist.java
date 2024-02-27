package ca.fubi.player.models.relations;

import ca.fubi.player.models.Album;
import ca.fubi.player.models.Artist;
import ca.fubi.player.models.ids.AlbumArtistId;
import jakarta.persistence.*;

@Entity
@Table(name = "tb_albums_artist")
public class AlbumArtist {
    
	@EmbeddedId
    private AlbumArtistId id;

    @ManyToOne
    @MapsId("albumId")
    @JoinColumn(name = "fk_album")
    private Album album;

    @ManyToOne
    @MapsId("artistId")
    @JoinColumn(name = "fk_artist")
    private Artist artist;

    public AlbumArtist() {}
    
    public AlbumArtist(Album album, Artist artist) {
    	this.setAlbum(album);
    	this.setArtist(artist);
    	this.id = new AlbumArtistId(album.getId(), artist.getId());
	}

    public AlbumArtistId getId() {
		return id;
	}
    
    public void setId(AlbumArtistId id) {
		this.id = id;
	}
    
    public Album getAlbum() {
		return album;
	}
    
    public void setAlbum(Album album) {
		this.album = album;
	}
    
    public Artist getArtist() {
		return artist;
	}
    
    public void setArtist(Artist artist) {
		this.artist = artist;
	}
}
