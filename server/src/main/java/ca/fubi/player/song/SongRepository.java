package ca.fubi.player.song;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import ca.fubi.player.album.Album;

import java.util.List;



public interface SongRepository extends JpaRepository<Song, Long>{
	Optional<Song> findById(Long id);
	List<Song> findByTitle(String title);
	List<Song> findByAlbum(Album album);
}
