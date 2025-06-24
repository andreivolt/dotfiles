// Client-side functionality for the built HTML
export function initializeToc() {
  let activeId = '';
  
  function updateActiveToc() {
    // TOC data will be injected by the build process
    const toc = (window as any).__TOC_DATA__ || [];
    const headings = toc.map((item: any) => ({
      id: item.id,
      element: document.getElementById(item.id)
    })).filter((item: any) => item.element);

    const scrollPosition = window.scrollY + 100;

    let currentActiveId = '';
    for (const heading of headings) {
      if (heading.element && heading.element.offsetTop <= scrollPosition) {
        currentActiveId = heading.id;
      }
    }

    if (currentActiveId !== activeId) {
      const prevActive = document.querySelector('.toc-link.active');
      if (prevActive) prevActive.classList.remove('active');
      
      if (currentActiveId) {
        const newActive = document.querySelector(`a[href="#${currentActiveId}"]`);
        if (newActive) newActive.classList.add('active');
      }
      
      activeId = currentActiveId;
    }
  }

  function handleTocClick(e: Event) {
    e.preventDefault();
    const target = e.currentTarget as HTMLAnchorElement;
    const href = target.getAttribute('href');
    if (!href) return;
    
    const targetId = href.substring(1);
    const targetElement = document.getElementById(targetId);
    
    if (targetElement) {
      targetElement.scrollIntoView({
        behavior: 'smooth',
        block: 'start'
      });
    }
  }

  // Add click handlers to TOC links
  document.querySelectorAll('.toc-link').forEach(link => {
    link.addEventListener('click', handleTocClick);
  });

  window.addEventListener('scroll', updateActiveToc);
  window.addEventListener('load', updateActiveToc);
}

// Auto-initialize when DOM is ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initializeToc);
} else {
  initializeToc();
}