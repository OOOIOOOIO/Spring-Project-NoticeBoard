package com.SH.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.SH.domain.BoardDTO;
import com.SH.domain.PageDTO;
import com.SH.domain.SearchCriteria;
import com.SH.service.BoardService;
import com.SH.service.UserService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value = "/board/*")
@Log4j
public class BoardController {
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	
	@RequestMapping(value="/board_list", method = {RequestMethod.GET, RequestMethod.POST})
	public void board_list(SearchCriteria scri, Model model) {
		model.addAttribute("boardList", service.getList(scri));
		model.addAttribute("pageInfo", new PageDTO(service.getTotal(scri), scri));
		log.info("=======================board_get==== : " + service.getList(scri));	
		
	}
	
	@GetMapping(value="/board_regist")
	public void board_regist(@ModelAttribute("scri")SearchCriteria scri) {
		
	}
	
	
	@PostMapping(value="/board_regist")
	public String board_regist(@RequestParam("uploadFile") MultipartFile[] uploadFiles, BoardDTO board, RedirectAttributes ra) {
		
		// 업로드 경로
		String uploadFolder = "D:\\FileTestDownload";
		
		// 업로드 경로에 업로드 한 날짜 폴더 생성
		File uploadPath = new File(uploadFolder, getFolder());
		
		// 날짜로 된 폴더 만들기 yyyy/MM/dd 
		// mkdirs()는 만들고자 하는 폴더의 상위폴더가 없을 경우 상위 폴더까지 만들어준다.
		// mkdir()은 상위폴더가 없을 경우 생성에 실패한다.
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multi : uploadFiles) {
			log.info("========================업로드 파일 이름 : " + multi.getOriginalFilename() );
			log.info("========================업로드 파일 사이즈: " + multi.getSize() );
			
			
			String uploadFileName = multi.getOriginalFilename();
			log.info("+++++++++++sub 전전전 : " + uploadFileName);
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			log.info("+++++++++++sub 후후후 : " + uploadFileName);
		
			// 미리폴더안만들고 그냥 올릴 경우
//      	File saveFile = new File(uploadFolder, multi.getOriginalFilename()); // original은 사용자가 수정해서 올린 이름(다운받을 시 사용되는 이름)
			
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				multi.transferTo(saveFile); // 이것을 통해 파일을 저장한다.
			}
			catch(Exception e){
				log.info("===================파일 에러에러 : " +e.getMessage());
			}
		}
		
		service.regist(board);
		ra.addFlashAttribute("bn", board.getBoard_num());
		
		
		return "redirect:/board/board_list";
	}
	
	@GetMapping({"/board_get", "/board_modify"})
	public void board_get(@ModelAttribute("scri")SearchCriteria scri, Long board_num, Model model) {
		model.addAttribute("board", service.read(board_num));

	}
	@PostMapping(value="/board_modify")
	public String board_modify(BoardDTO board, SearchCriteria scri ,RedirectAttributes ra) {
		if(service.update(board) == 1) {
			ra.addFlashAttribute("mn", board.getBoard_num());
		}
		return "redirect:/board/board_list" + scri.getListLink();
	}
	
	@PostMapping(value="/board_remove")
	public String board_remove(Long board_num, SearchCriteria scri, RedirectAttributes ra) {
		if(service.delete(board_num) == 1) {
			ra.addFlashAttribute("rn", board_num);
		}
		return "redirect:/board/board_list" + scri.getListLink();
			
	}
	
	// 날짜로 폴더 만들어 주는 메소드
	private static String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 및 시간 원하는 포맷으로 출력
		Date date = new Date(); // 현재 날짜 및 시간!!
		String str = sdf.format(date); // 현재 날짜 및 시간을 위에 설정한 포맷으로 만들기
		
		return str.replace("-", File.separator); // "-"를 기준으로 폴더 하위로 쭉 만들기 yyyy-> mm->dd
				
	}
	
}
