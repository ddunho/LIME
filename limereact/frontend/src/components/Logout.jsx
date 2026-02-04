function LogoutModal({ isOpen, onClose, onLogout }) {
  if (!isOpen) return null;

  return (
    <div className="modal fade show" style={{ display: "block" }} role="dialog">
      <div className="modal-dialog" role="document">
        <div className="modal-content">
          
          <div className="modal-header">
            <h5 className="modal-title">Ready to Leave?</h5>
            <button className="close" onClick={onClose}>
              <span>&times;</span>
            </button>
          </div>

          <div className="modal-body">
            Select "Logout" below if you are ready to end your current session.
          </div>

          <div className="modal-footer">
            <button className="btn btn-secondary" onClick={onClose}>
              Cancel
            </button>
            <button className="btn btn-primary" onClick={onLogout}>
              Logout
            </button>
          </div>

        </div>
      </div>
    </div>
  );
}

export default LogoutModal;
