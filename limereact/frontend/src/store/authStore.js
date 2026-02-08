import { create } from "zustand";
import { persist } from "zustand/middleware";
import axios from "axios";

const useAuthStore = create(
  persist(
    (set) => ({
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
    }),
    {
      name: "auth-storage", // localStorage에 저장될 키 이름
      // 선택사항: 특정 필드만 저장하고 싶다면
      partialize: (state) => ({
        isLogin: state.isLogin,
        user: state.user,
      }),
    }
  )
);

export default useAuthStore;