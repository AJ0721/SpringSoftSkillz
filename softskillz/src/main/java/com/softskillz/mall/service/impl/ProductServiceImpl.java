package com.softskillz.mall.service.impl;

import com.softskillz.mall.exception.EntityNotFoundException;
import com.softskillz.mall.model.Product;
import com.softskillz.mall.repos.ProductRepository;
import com.softskillz.mall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * 商品服務的實現類，提供商品的增刪查改操作。
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;

    @Autowired
    public ProductServiceImpl(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    /**
     * 獲取所有商品列表。
     * @return 返回所有商品的列表。
     */
    @Override
    public List<Product> findAllProducts() {
        return productRepository.findAll();
    }

    /**
     * 根據商品ID獲取商品信息，如果商品不存在則拋出 EntityNotFoundException。
     * @param productId 商品的ID
     * @return 包含商品信息的Optional對象。
     */
    @Override
    public Optional<Product> findProductById(Integer productId) {
        return Optional.ofNullable(productRepository.findById(productId)
                .orElseThrow(() -> new EntityNotFoundException("Product", productId)));
    }

    /**
     * 新增商品信息。
     * @param product 商品對象
     * @return 儲存後的商品對象。
     */
    @Override
    public Product createProduct(Product product) {
        return productRepository.save(product);
    }

    /**
     * 更新指定ID的商品信息，如果商品不存在則拋出 EntityNotFoundException。
     * @param productId 商品ID
     * @param product 更新後的商品信息
     * @return 更新後的商品對象
     */
    @Override
    public Product updateProduct(Integer productId, Product product) {
        return productRepository.findById(productId)
                .map(existingProduct -> {
                    existingProduct.setProductName(product.getProductName());
                    existingProduct.setProductDescription(product.getProductDescription());
                    existingProduct.setProductPrice(product.getProductPrice());
                    existingProduct.setProductType(product.getProductType());
                    existingProduct.setProductStatus(product.getProductStatus());
                    existingProduct.setProductStock(product.getProductStock());
                    existingProduct.setProductTargetAudience(product.getProductTargetAudience());
                    existingProduct.setProductAuthorName(product.getProductAuthorName());
                    existingProduct.setProductISBN(product.getProductISBN());
                    existingProduct.setProductPublicationDate(product.getProductPublicationDate());
                    return productRepository.save(existingProduct);
                })
                .orElseThrow(() -> new EntityNotFoundException("Product", productId));
    }

    /**
     * 根據商品ID刪除商品，如果商品不存在則拋出 EntityNotFoundException。
     * @param productId 商品ID
     */
    @Override
    public void deleteProduct(Integer productId) {
        if (!productRepository.existsById(productId)) {
            throw new EntityNotFoundException("Product", productId);
        }
        productRepository.deleteById(productId);
    }

    /**
     * 分頁查詢商品，支持條件過濾。
     * @param spec 查詢條件
     * @param pageable 分頁參數
     * @return 符合條件的商品頁面
     */
    @Override
    public Page<Product> findProducts(Specification<Product> spec, Pageable pageable) {
        return productRepository.findAll(spec, pageable);
    }
}
