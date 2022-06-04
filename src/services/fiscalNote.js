import { apiAxios } from "@/config/index";

export const getFicalNote = async (data) => {
  return await apiAxios.post('/1/nfe/consulta/qr-code/', data);
};