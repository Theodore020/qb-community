import axiosInstance from "@/utils/axiosInstance";


const categoryInfo = {
    getAllList(){
        return axiosInstance.get(`/categoryInfo/getAllList`);
    }
}

export default categoryInfo;