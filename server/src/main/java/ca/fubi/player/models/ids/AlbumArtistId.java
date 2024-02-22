package ca.fubi.player.models.ids;

import java.io.Serializable;
import jakarta.persistence.*;

@Embeddable
public class AlbumArtistId implements Serializable {
    @Column(name = "fk_album")
    private Long albumId;

    @Column(name = "fk_artist")
    private Long artistId;

    public AlbumArtistId() {}
    
    public AlbumArtistId(Long albumId, Long artistId) {
    	this.setAlbumId(albumId);
    	this.setArtistId(artistId);
    }
    
    public Long getAlbumId() {
		return albumId;
	}
    
    public void setAlbumId(Long albumId) {
		this.albumId = albumId;
	}
    
    public Long getArtistId() {
		return artistId;
	}
    
    public void setArtistId(Long artistId) {
		this.artistId = artistId;
	}
}
