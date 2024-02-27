package ca.fubi.player.models.ids;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.*;

@Embeddable
public class AlbumArtistId implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	@Column(name = "fk_album")
    private Long albumId;

    @Column(name = "fk_artist")
    private Long artistId;

    public AlbumArtistId() {}
    
    public AlbumArtistId(Long albumId, Long artistId) {
    	this.setAlbumId(albumId);
    	this.setArtistId(artistId);
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;

        AlbumArtistId that = (AlbumArtistId) obj;

        if (!Objects.equals(albumId, that.albumId)) return false;
        return Objects.equals(artistId, that.artistId);
    }

    @Override
    public int hashCode() {
        int result = albumId != null ? albumId.hashCode() : 0;
        result = 31 * result + (artistId != null ? artistId.hashCode() : 0);
        return result;
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
