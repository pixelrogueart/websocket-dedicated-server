"use client";
import Header from '../../components/essentials/Header';
import HeaderContent from '../../components/essentials/HeaderContent';
import Footer from '../../components/essentials/Footer';
import style from './page.css';
import { useState, useEffect } from 'react';
import axios from 'axios';

export const metadata = {
    title: 'PIXELROGUEART - CONFIRM EMAIL',
    description: 'Check out my art!',
};

function Confirm({ Component, pageProps }) {
    const [email, setEmail] = useState('');
    const [code, setCode] = useState('');
    const [message, setMessage] = useState('');

    const handleSubmit = async () => {
        try {
            const response = await axios.post(process.env.NEXT_PUBLIC_DATABASE_URL, 
                {
                email: email,
                code: code
            },{headers:{'Access-Control-Allow-Origin':'*'}}
            );

            setMessage(response.data.message);
        } catch (error) {
            console.log(error.response)
            setMessage('Failed to confirm email. Please try again.');
        }
    };

    return (
        <div className='pageContainer'>
            <div className='contentWrapper'>
                <Header />
                <HeaderContent />
                <div className='textHolder'>
                    <div className='emailMessage'>EMAIL CONFIRMATION</div>
                    <p className='retrievedMessage'>{message}</p> 
                    <input
                        type="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        placeholder="Enter your email"
                        className="inputField"
                    />
                    <input
                        type="text"
                        value={code}
                        onChange={(e) => setCode(e.target.value)}
                        placeholder="Enter confirmation code"
                        className="inputField"
                    />
                    <button onClick={handleSubmit} className="submitButton">Submit</button>
                </div>
            </div>
            <Footer />
        </div>
    );
}


export default Confirm;
