import { useState, useEffect } from "react"
import axios from 'axios'

const useFetch =(url)=>{

    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);
    const [data, setData] = useState(null);

    const  getData =async()=>{
        try{
            setLoading(true);
            const response = await axios.get(url)
            setData(response.data)
        }catch(error){
            setError(error)
        }finally{
            setLoading(false);
        }
    }
    useEffect(()=>{
        getData();
    },[]);

    return [loading, data, error]
}
export default useFetch;