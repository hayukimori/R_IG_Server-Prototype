import uuid
from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.dialects.sqlite import BLOB


app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///main.db"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
db: SQLAlchemy = SQLAlchemy(app)


class Cube(db.Model):
    id = db.Column(
        db.String(36),
        primary_key=True,
        default=lambda: str(uuid.uuid4())
    )
    owner_id = db.Column(db.String(36), db.ForeignKey("user_profile.user_id"))
    position_x = db.Column(db.Float, nullable=False)
    position_y = db.Column(db.Float, nullable=False)
    position_z = db.Column(db.Float, nullable=False)
    size = db.Column(db.Integer, nullable=False)


class API:

    @app.route("/api/v1/cubes")
    def get_cubes():
        cubes = Cube.query.all()
        
        print(cubes)
        return jsonify([
            {
                "id": cube.id, 
                "owner_id": cube.owner_id, 
                "position_x": cube.position_x,
                "position_y": cube.position_y,
                "position_z": cube.position_z
            }
            for cube in cubes
        ])

if __name__ == "__main__":
    with app.app_context():
        db.create_all()
        
    app.run("0.0.0.0", port=8081, debug=True)