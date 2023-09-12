import styles from './Header.css';
import Link from "next/link" 
export default function Header() {
    return (
        <div className="headerContainer">
            <Link href="../" className="logoAlt">PIXELROGUEART</Link>
            <nav className='navButtons'>
                <Link href="../" className="navLink">HOME</Link>
            </nav>
        </div>
    );
}
