const getSignature = async (userKey) => {
    const url = `http://localhost:8002/signature?user_key=${userKey}`;
    const headers = {
        'Content-Type': 'application/json'
    };
    const response = await fetch(url, {
        method: 'GET',
        headers
    });
    return response.json();
};

export {
    getSignature
};
