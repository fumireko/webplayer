package ca.fubi.player.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import ca.fubi.player.models.Playlist;
import java.util.List;
import ca.fubi.player.models.User;



@Repository
public interface PlaylistRepository extends JpaRepository<Playlist, Long> {
	Optional<Playlist> findById(Long id);
	Optional<Playlist> findByName(String name);
	List<Playlist> findByUser(User user);
}
