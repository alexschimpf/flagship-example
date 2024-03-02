from fastapi import FastAPI, APIRouter
from pydantic import BaseModel
from flagship import Flagship
from fastapi.middleware.cors import CORSMiddleware


FLAGSHIP_HOST = 'localhost'
FLAGSHIP_PORT = 8001
PROJECT_ID = 1
PRIVATE_KEY = '754a019a9f7c4a832ceaf2c83f50d40dffc1e018ac6635129f1ed5c1b5f18901'


class Signature(BaseModel):
    signature: str


router = APIRouter()


@router.get('/signature', response_model=Signature)
def get_signature(user_key: str):
    # Note: If you are only using the SDK only to generate a signature,
    # some of these constructor args are not actually used (e.g. host and port).
    flagship = Flagship(
        host=FLAGSHIP_HOST,
        project_id=PROJECT_ID,
        user_key=user_key,
        private_key=PRIVATE_KEY,
        port=FLAGSHIP_PORT
    )
    signature = flagship.generate_signature()

    return Signature(
        signature=signature
    )


app = FastAPI(
    title='Flagship Example API',
    version='1.0',
    swagger_ui_parameters={'defaultRowsExpandDepth': -1}
)
app.include_router(router)
app.add_middleware(
    CORSMiddleware,
    allow_origins=['http://localhost:3001'],
    allow_credentials=True,
    allow_methods=['*'],
    allow_headers=['*'],
)
