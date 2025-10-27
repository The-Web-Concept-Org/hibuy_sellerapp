class AppFunc {
  static String orderStatusLabel(String status) {
    switch (status) {
      case 'order_placed':
        return 'Order Placed';
      case 'pending':
        return 'Pending';
      case 'processing':
        return 'Processing';
      case 'shipped':
        return 'Shipped';
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      case 'returned':
        return 'Returned';
      case 'completed':
        return 'Completed';
      default:
        return 'Unknown Status';
    }
  }

  static String orderStatusInverse(String label) {
    switch (label) {
      case 'Order Placed':
        return 'order_placed';
      case 'Pending':
        return 'pending';
      case 'Processing':
        return 'processing';
      case 'Shipped':
        return 'shipped';
      case 'Delivered':
        return 'delivered';
      case 'Cancelled':
        return 'cancelled';
      case 'Returned':
        return 'returned';
      case 'Completed':
        return 'completed';
      default:
        return 'unknown';
    }
  }
}
