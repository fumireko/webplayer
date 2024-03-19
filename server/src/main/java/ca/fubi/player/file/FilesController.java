package ca.fubi.player.file;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600, allowCredentials = "true")
@RestController
@RequestMapping("/files")
public class FilesController {
	
	@Autowired
	FilesStorageService storageService;
	
	@PostMapping("/upload/{id}")
	public ResponseEntity<?> uploadFile(@RequestParam("file") MultipartFile file, @PathVariable Long id){
		try {
			storageService.save(file);
			return ResponseEntity.ok().body("Upload success: " + file.getOriginalFilename());
		} catch (Exception e) {
			return ResponseEntity.internalServerError().body("Could not upload file " + file.getName() + ", " + e.getMessage());
		}
	}
	
	@GetMapping("/")
	public ResponseEntity<List<FileInfo>> getAllFiles(){
		List<FileInfo> f = storageService.loadAll().map(path -> {
			return new FileInfo(path.getFileName().toString(), MvcUriComponentsBuilder.fromMethodName(FilesController.class, "getFile", path.getFileName().toString()).build().toString());
		}).collect(Collectors.toList());
		return ResponseEntity.ok().body(f);
	}
	
	@GetMapping("/{filename:.+}")
	@ResponseBody
	public ResponseEntity<Resource> getFile(@PathVariable String filename){
		Resource file = storageService.load(filename);
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getFilename() + "\"").body(file);
	}
}
