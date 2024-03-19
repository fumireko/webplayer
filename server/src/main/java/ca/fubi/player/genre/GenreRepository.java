package ca.fubi.player.genre;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GenreRepository extends JpaRepository<Genre, Long>{
	Optional<Genre> findById(Long id);
	Optional<Genre> findByDescription(String description);
}
