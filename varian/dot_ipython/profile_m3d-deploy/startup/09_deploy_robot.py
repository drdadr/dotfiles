import os
import contracts
from automation.automation_base import DeployUiRobot

host = os.getenv("DEPLOY_HOST") or "localhost"
port = os.getenv("DEPLOY_PORT") or "36080"

contracts.disable_all()
robot = DeployUiRobot()
robot.setHost(host=host, port=port, scheme="http")
try:
    robot.webdriver.maximize_window()
except Exception:
    pass
robot.logIn()
