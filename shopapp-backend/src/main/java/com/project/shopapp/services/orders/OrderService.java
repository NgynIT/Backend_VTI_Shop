package com.project.shopapp.services.orders;

import com.project.shopapp.dtos.CartItemDTO;
import com.project.shopapp.dtos.OrderDTO;
import com.project.shopapp.dtos.OrderDetailDTO;
import com.project.shopapp.dtos.OrderWithDetailsDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.*;
import com.project.shopapp.repositories.OrderDetailRepository;
import com.project.shopapp.repositories.OrderRepository;
import com.project.shopapp.repositories.ProductRepository;
import com.project.shopapp.repositories.UserRepository;
import com.project.shopapp.responses.OrderResponse;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
@RequiredArgsConstructor
public class OrderService implements IOrderService {
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final OrderDetailRepository orderDetailRepository;

    private final ModelMapper modelMapper;

    @Override
    @Transactional
    public ResponseEntity<?> createOrder(OrderDTO orderDTO) {
        try {
            //tìm xem user'id có tồn tại ko
            User user = userRepository
                    .findById(orderDTO.getUserId()).orElse(null);
            if (Objects.isNull(user))
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Cannot find user with id: " + orderDTO.getUserId());
//                    .orElseThrow(() -> new DataNotFoundException("Cannot find user with id: " + orderDTO.getUserId()));
            //convert orderDTO => Order
            //dùng thư viện Model Mapper
            // Tạo một luồng bảng ánh xạ riêng để kiểm soát việc ánh xạ
            modelMapper.typeMap(OrderDTO.class, Order.class)
                    .addMappings(mapper -> mapper.skip(Order::setId));
            // Cập nhật các trường của đơn hàng từ orderDTO
            Order order = new Order();
            modelMapper.map(orderDTO, order);
            order.setUser(user);
            order.setOrderDate(LocalDate.now());//lấy thời điểm hiện tại
            order.setStatus(OrderStatus.PENDING);
            //Kiểm tra shipping date phải >= ngày hôm nay
            LocalDate shippingDate = orderDTO.getShippingDate() == null
                    ? LocalDate.now() : orderDTO.getShippingDate();
            if (shippingDate.isBefore(LocalDate.now())) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Date must be at least today !");
//                throw new DataNotFoundException("Date must be at least today !");
            }
            order.setShippingDate(shippingDate);
            order.setActive(true);//đoạn này nên set sẵn trong sql
            order.setTotalMoney(orderDTO.getTotalMoney());
            orderRepository.save(order);
            // Tạo danh sách các đối tượng OrderDetail từ cartItems
            List<OrderDetail> orderDetails = new ArrayList<>();
            if (orderDTO.getCartItems().isEmpty()) {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body("CartItems can not be empty!");
            }
            for (CartItemDTO cartItemDTO : orderDTO.getCartItems()) {
                // Tạo một đối tượng OrderDetail từ CartItemDTO
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrder(order);

                // Lấy thông tin sản phẩm từ cartItemDTO
                Long productId = cartItemDTO.getProductId();
                int quantity = cartItemDTO.getQuantity();

                // Tìm thông tin sản phẩm từ cơ sở dữ liệu (hoặc sử dụng cache nếu cần)
                Product product = productRepository.findById(productId).orElse(null);
                if (Objects.isNull(product))
                    return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Product not found with id: " + productId);
//                        .orElseThrow(() -> new DataNotFoundException("Product not found with id: " + productId));

                // Đặt thông tin cho OrderDetail
                orderDetail.setProduct(product);
                orderDetail.setNumberOfProducts(quantity);
                // Các trường khác của OrderDetail nếu cần
                orderDetail.setPrice(product.getPrice());

                // Thêm OrderDetail vào danh sách
                orderDetails.add(orderDetail);
            }

            // Lưu danh sách OrderDetail vào cơ sở dữ liệu
            orderDetailRepository.saveAll(orderDetails);
            return ResponseEntity.ok(OrderResponse.fromOrder(order));

        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @Transactional
    public Order updateOrderWithDetails(OrderWithDetailsDTO orderWithDetailsDTO) {
        modelMapper.typeMap(OrderWithDetailsDTO.class, Order.class)
                .addMappings(mapper -> mapper.skip(Order::setId));
        Order order = new Order();
        modelMapper.map(orderWithDetailsDTO, order);
        Order savedOrder = orderRepository.save(order);

        // Set the order for each order detail
        for (OrderDetailDTO orderDetailDTO : orderWithDetailsDTO.getOrderDetailDTOS()) {
            //orderDetail.setOrder(OrderDetail);
        }

        // Save or update the order details
        List<OrderDetail> savedOrderDetails = orderDetailRepository.saveAll(order.getOrderDetails());

        // Set the updated order details for the order
        savedOrder.setOrderDetails(savedOrderDetails);

        return savedOrder;
    }

    @Override
    public Order getOrder(Long id) {
        Order selectedOrder = orderRepository.findById(id).orElse(null);
        return selectedOrder;
    }

    @Override
    @Transactional
    public Order updateOrder(Long id, OrderDTO orderDTO)
            throws DataNotFoundException {
        orderDTO.setShippingDate(LocalDate.now());
        Order order = orderRepository.findById(id).orElseThrow(() ->
                new DataNotFoundException("Cannot find order with id: " + id));
        User existingUser = userRepository.findById(
                orderDTO.getUserId()).orElseThrow(() ->
                new DataNotFoundException("Cannot find user with id: " + id));
        // Tạo một luồng bảng ánh xạ riêng để kiểm soát việc ánh xạ
        modelMapper.typeMap(OrderDTO.class, Order.class)
                .addMappings(mapper -> mapper.skip(Order::setId));
        // Cập nhật các trường của đơn hàng từ orderDTO
        orderDTO.setShippingDate(order.getShippingDate());
        modelMapper.map(orderDTO, order);
        order.setUser(existingUser);
        return orderRepository.save(order);
    }

    @Override
    @Transactional
    public void deleteOrder(Long id) {
        Order order = orderRepository.findById(id).orElse(null);
        //no hard-delete, => please soft-delete
        if (order != null) {
            order.setActive(false);
            orderRepository.save(order);
        }
    }

    @Override
    public List<Order> findByUserId(Long userId) {
        return orderRepository.findByUserId(userId);
    }

    @Override
    public Page<Order> getOrdersByKeyword(String keyword, Pageable pageable) {
        return orderRepository.findByKeyword(keyword, pageable);
    }
}