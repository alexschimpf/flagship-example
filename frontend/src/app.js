import Flagship from 'flagship-sdk';
import React from 'react';
import { getSignature } from './api';
import './app.css';


function App() {
    // Normally this would be different for every user
    const userKey = '123';

    const flagshipRef = React.useRef(
        new Flagship(
            '127.0.0.1', 1, userKey, undefined, undefined, 8001
        )
    );

    const [isLoading, setLoading] = React.useState(true);
    const [signature, setSignature] = React.useState(undefined);
    const [userType, setUserType] = React.useState(1);

    // Set up Flagship object and load in initial feature flags.
    React.useEffect(() => {
        // Get Flagship signature from backend
        // This is needed to make requests to Flagship API
        getSignature(userKey).then((resp) => {
            setSignature(resp.signature);
        }).catch(e => {
            console.error(e);
        });
    }, [signature]);

    React.useEffect(() => {
        if (!signature) {
            return;
        }

        setLoading(true);

        // Reload feature flags when context changes
        flagshipRef.current.load(
            {
                user_type: parseInt(userType)
            },
            signature
        ).catch(e => {
            console.error(e);
        }).finally(() => {
            setLoading(false);
        });
    }, [signature, userType]);

    const onUserTypeChange = async (value) => {
        setUserType(value);
    };

    if (isLoading) {
        return (
            <div className='app'>
                <p>Loading...</p>
            </div>
        );
    }

    return (
        <div className='app'>
            <div className='context-section'>
                <p>What kind of user are you?</p>
                <select
                    value={userType}
                    onChange={(e) => onUserTypeChange(e.target.value)}
                >
                    <option value={1}>Normal</option>
                    <option value={2}>Cool</option>
                </select>
            </div>
            <div className='results'>
                {flagshipRef.current.isFeatureFlagEnabled('COOL_FEATURE') &&
                    <p className='new-feature'>Isn't this a cool new feature?</p>
                }
                {!flagshipRef.current.isFeatureFlagEnabled('COOL_FEATURE') &&
                    <p>Sorry, you don't get the cool new feature!</p>
                }
            </div>
        </div>
    );
}

export default App;
