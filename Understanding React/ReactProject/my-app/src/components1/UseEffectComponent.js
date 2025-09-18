import React, { useEffect, useState } from "react";

const suggestionMaster = ["laptop", "mobile", "tablet"];

export default function UseEffectComponent() {
  const [recommendation, setRecommendation] = useState(suggestionMaster);
  const [search, setSearch] = useState("");

  useEffect(() => {
    setRecommendation(suggestionMaster.filter((elem) => elem.includes(search)));
  }, [search]);

  return (
    <div>
      <input value={search} onChange={(e) => setSearch(e.target.value)} />
      {recommendation.map((element,index) => (
        <div key={index}>{index}. {element}</div>
      ))}
    </div>
  );
}
