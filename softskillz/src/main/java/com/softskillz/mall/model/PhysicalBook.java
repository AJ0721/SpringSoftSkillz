package com.softskillz.mall.model;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;


@Entity
@Table(name = "physicalbook")
public class PhysicalBook {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "book_id")
    private Integer bookId;

    @ManyToOne
    @JoinColumn(name = "product_id", referencedColumnName = "product_id")
    private Product product;

    @Column(name = "book_title")
    private String bookTitle;

    @Column(name = "book_description")
    private String bookDescription;

    @Column(name = "book_author")
    private String bookAuthor;

    @Column(name = "book_isbn")
    private String bookIsbn;

    @Column(name = "book_price")
    private Integer bookPrice;

    @Column(name = "book_stock_quantity")
    private Integer bookStockQuantity;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Taipei")
    @Column(name = "book_publish_date")
    private LocalDateTime bookPublishDate;

    @Column(name = "book_image_url")
    private String bookImageUrl;
    
    // Constructor, getters and setters
        public PhysicalBook() {
        }
        
		public PhysicalBook(Integer bookId, Product product, String bookTitle, String bookDescription,
				String bookAuthor, String bookIsbn, Integer bookPrice, Integer bookStockQuantity,
				LocalDateTime bookPublishDate, String bookImageUrl) {
			this.bookId = bookId;
			this.product = product;
			this.bookTitle = bookTitle;
			this.bookDescription = bookDescription;
			this.bookAuthor = bookAuthor;
			this.bookIsbn = bookIsbn;
			this.bookPrice = bookPrice;
			this.bookStockQuantity = bookStockQuantity;
			this.bookPublishDate = bookPublishDate;
			this.bookImageUrl = bookImageUrl;
		}
		
		public Integer getBookId() {
			return bookId;
		}
		
		public void setBookId(Integer bookId) {
			this.bookId = bookId;
		}
		
		public Product getProduct() {
			return product;
		}
		
		public void setProduct(Product product) {
			this.product = product;
		}
		
		public String getBookTitle() {
			return bookTitle;
		}
		
		public void setBookTitle(String bookTitle) {
			this.bookTitle = bookTitle;
		}
		
		public String getBookDescription() {
			return bookDescription;
		}
		
		public void setBookDescription(String bookDescription) {
			this.bookDescription = bookDescription;
		}
		
		public String getBookAuthor() {
			return bookAuthor;
		}
		
		public void setBookAuthor(String bookAuthor) {
			this.bookAuthor = bookAuthor;
		}
		
		public String getBookIsbn() {
			return bookIsbn;
		}
		
		public void setBookIsbn(String bookIsbn) {
			this.bookIsbn = bookIsbn;
		}
		
		public Integer getBookPrice() {
			return bookPrice;
		}
		
		public void setBookPrice(Integer bookPrice) {
			this.bookPrice = bookPrice;
		}
		
		public Integer getBookStockQuantity() {
			return bookStockQuantity;
		}
		
		public void setBookStockQuantity(Integer bookStockQuantity) {
			this.bookStockQuantity = bookStockQuantity;
		}
		
		public LocalDateTime getBookPublishDate() {
			return bookPublishDate;
		}
		
		public void setBookPublishDate(LocalDateTime bookPublishDate) {
			this.bookPublishDate = bookPublishDate;
		}
		
		public String getBookImageUrl() {
			return bookImageUrl;
		}
		
		public void setBookImageUrl(String bookImageUrl) {
			this.bookImageUrl = bookImageUrl;
		}
		
		// toString
		@Override
		public String toString() {
			return "PhysicalBook [bookId=" + bookId + ", product=" + product + ", bookTitle=" + bookTitle
					+ ", bookDescription=" + bookDescription + ", bookAuthor=" + bookAuthor + ", bookIsbn=" + bookIsbn
					+ ", bookPrice=" + bookPrice + ", bookStockQuantity=" + bookStockQuantity + ", bookPublishDate="
					+ bookPublishDate + ", bookImageUrl=" + bookImageUrl + "]";
		}
}
