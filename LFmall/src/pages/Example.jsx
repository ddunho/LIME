import { useEffect } from "react";
import api from "../api/axios";

function Example() {
  useEffect(() => {
    api.get("/example").then(res => {
      console.log(res.data);
    });
  }, []);

  return <div>{JSON.stringify(data)}</div>;
}

export default Example;
