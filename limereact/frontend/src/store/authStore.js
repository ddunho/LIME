import { create } from "zustand";
import axios from "axios";

const useAuthStore = create((set) => ({
  isLogin: false,
  user: null,
  loading: false,
  error: null,

  login: async ({ email, password }) => {
    set({ loading: true, error: null });

    try {
      const res = await axios.post("/user/login", {
        email,
        password,
      });

      if (res.data.success) {
        set({
          isLogin: true,
          user: res.data.user,
          loading: false,
        });
        console.log("login response:", res.data);
        return { success: true };
      } else {
        set({
          isLogin: false,
          user: null,
          loading: false,
          error: res.data.msg || "로그인 실패",
        });
        return { success: false };
      }
    } catch (e) {
      set({
        isLogin: false,
        user: null,
        loading: false,
        error: "서버 오류",
      });
      return { success: false };
    }
  },

  logout: async () => {
    try {
      await axios.post("/user/logout");
    } finally {
      set({
        isLogin: false,
        user: null,
        error: null,
      });
    }
  },
}));

export default useAuthStore;
