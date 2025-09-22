import React, { useEffect, useState } from "react";

export default function CallAnApiComponent() {
  const [data, setData] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);

  const getData = () => {
    setLoading(true)
    fetch("https://jsonplaceholder.typicode.com/posts")
      .then((data) => data.json())
      .then((jsonData) => setData(jsonData))
      .catch((error)=>setError(error))
      .finally(()=>{setLoading(false)})
  };

  useEffect(getData,[])
  return (
    <div>
      {/* <button
        onClick={() => {
          getData();
        }}
      >
        Load data
      </button> */}
      {
        error !=null && <>{error.message}</>
      }
      {
        loading && <>Loading...</>
      }
      {data.map((element) => (
        <div key={element.id}>{element.id} {element.title}</div>
      ))}
    </div>
  );
}
