import React from "react";

import { Login, Signup } from "components/Authentication";
import { PrivateRoute } from "components/commons";
import Dashboard from "components/Dashboard";
import Preferences from "components/Preferences";
import { CreateTask, ShowTask, EditTask } from "components/Tasks";
import DownloadReport from "components/Tasks/DownloadReport";
import { either, isEmpty, isNil } from "ramda";
import { Route, Switch, BrowserRouter as Router } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import { getFromLocalStorage } from "utils/storage";

const App = () => {
  const authToken = getFromLocalStorage("authToken");
  const isLoggedIn = !either(isNil, isEmpty)(authToken);

  return (
    <Router>
      <ToastContainer />
      <Switch>
        <Route exact component={EditTask} path="/tasks/:slug/edit" />
        <Route exact component={ShowTask} path="/tasks/:slug/show" />
        <Route exact component={CreateTask} path="/tasks/create" />
        <Route exact component={Signup} path="/signup" />
        <Route exact component={Login} path="/login" />
        <Route exact component={Preferences} path="/my/preferences" />
        <Route exact component={DownloadReport} path="/tasks/report" />;
        <PrivateRoute
          component={Dashboard}
          condition={isLoggedIn}
          path="/"
          redirectRoute="/login"
        />
      </Switch>
    </Router>
  );
};

export default App;
