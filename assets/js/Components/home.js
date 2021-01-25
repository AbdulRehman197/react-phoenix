import React from "react";
import { v4 as uuidv4 } from "uuid";

class Home extends React.Component {
  constructor(props) {
    super();
    this.state = {
      value: "",
      list: [],
      edit: false,
      key: "",
    };
  }
  componentDidMount = () => {
    this.reloadData();
  };
  reloadData = () => {
    fetch("/get_todo", {
      method: "POST",
    })
      .then((resp) => {
        return resp.json();
      })
      .then((res) => {
        if (res.msg) {
          alert(res.msg);
        } else {
          console.log("Total Records:",res.list);
          // let convertedList = res.list.map((item) => {
          //   return Object.assign({}, item);
          // });
          // this.setState({ list: convertedList });
        }
      });
  }
  onChange = (evt) => {
    this.setState({ value: evt.target.value });
  };
  handleAddTodo = (id,value) => {
    // if(!this.state.value){
    //   alert("Empty Fields are not allowed!");
    //   return
    // }
    let key = this.state.edit ? this.state.key : id;
    fetch("/add", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ data: value?value:this.state.value, id: key }),
    })
      .then((resp) => {
        return resp.json();
      })
      .then((res) => {
        // this.handleAddTodo(uuidv4(),uuidv4());
        // let list = this.state.list;
        // let index = list.findIndex((item)=>{
        //   return item[0] == key;
        // })
        // if(index >= 0){
        //   list[index][1] = this.state.value;
        // }else{
        //   list.push({0: id, 1: this.state.value})
        // }
        // this.setState({ value: "", edit: false, list: list });
        // alert(res.msg);
        return
      })
      .catch(()=>{
        this.handleAddTodo(uuidv4(),uuidv4())
      });
  };

  handleEdit = (key, value) => {
    this.setState({
      value: value,
      edit: true,
      key: key,
    });
  };

  handleDelete = (key) => {
    fetch("/delete_todo", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ id: key }),
    })
      .then((resp) => {
        return resp.json();
      })
      .then((res) => {
        let newList = this.state.list.filter((item) => {
          return item[0] != key;
        });
        this.setState({ list: newList });
        alert(res.msg);
      });
  };

  handleAddDumpTodo = () => {
 
      // for (let index = 0; index < 1;) {
        this.handleAddTodo(uuidv4(),uuidv4());
        
      // }
  
  }

  handleFind = () => {
    let record = this.state.value;
    fetch("/find_record", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ id: record }),
    })
      .then((resp) => {
        return resp.json();
      })
      .then((res) => {
        console.log(res);
      });
  }

  render() {
    return (
      <>
        <div style={{ marginTop: 5, marginLeft: 5 }}>
          <input value={this.state.value} onChange={this.onChange} />
        </div>
        <div style={{ marginLeft: 5 }}>
          <button onClick={() => this.handleAddTodo(uuidv4())}>add</button>
        </div>
        <div style={{ marginLeft: 5 }}>
          <button onClick={this.handleAddDumpTodo}>add dump data</button>
        </div>
        <div style={{ marginLeft: 5 }}>
          <button onClick={this.reloadData}>reload data</button>
        </div>
        <div style={{ marginLeft: 5 }}>
          <button onClick={this.handleFind}>find record</button>
        </div>
        <div style={{ marginTop: 20, marginLeft: 5 }}>
          {this.state.list.map((item) => {
            return (
              <div style={{ display: "flex", paddingLeft: 10 }} key={item[0]}>
                <div style={{ marginRight: 20, marginBottom: 10 }}>
                  {item[1]}
                </div>
                <div
                  onClick={() => this.handleEdit(item[0], item[1])}
                  style={{ color: "blue", marginRight: 20, cursor: "pointer" }}
                >
                  Edit
                </div>
                <div
                  onClick={() => this.handleDelete(item[0])}
                  style={{ color: "red", marginRight: 20, cursor: "pointer" }}
                >
                  Delete
                </div>
              </div>
            );
          })}
        </div>
      </>
    );
  }
}

export default Home;
