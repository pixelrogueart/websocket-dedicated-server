import styles from './HeaderContent.css';

export default function HeaderContent() {
    return (
        <div className="contentContainer">
            <nav className='navIcons'>
                <a href="https://instagram.com/pixelrogueart" className="iconLink"><img src="/icons/icons8-instagram.svg" alt="Instagram"/></a>
                <a href="https://tumblr.com/pixelrogueart" className="iconLink"><img src="/icons/icons8-tumblr.svg" alt="Tumblr"/></a>
                <a href="https://twitter.com/pixelrogueart" className="iconLink"><img src="/icons/icons8-twitter.svg" alt="Twitter"/></a>
                <a href="https://github.com/pixelrogueart" className="iconLink"><img src="/icons/icons8-github.svg" alt="GitHub"/></a>
                <a href="https://discord.gg/Q9VMwds4tX" className="iconLink"><img src="/icons/icons8-discord.svg" alt="Discord"/></a>
            </nav>
        </div>
    );
}
