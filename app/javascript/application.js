import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', () => {  // Use turbo:load instead of DOMContentLoaded
    // Projects Search
    const searchInput = document.getElementById('search-input');
    const projectsList = document.getElementById('projects-list');

    if (searchInput) {
        searchInput.addEventListener('input', () => {
            const query = searchInput.value;

            if (query.trim() === "") {
                projectsList.innerHTML = '';
                projectsList.style.display = 'none';
                return;
            }

            projectsList.style.display = 'block';

            fetch(`/projects.json?query=${query}`, {
                headers: {
                    'Accept': 'application/json',
                    'Cache-Control': 'no-cache'
                }   
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    projectsList.innerHTML = '';

                    data.projects.forEach(project => {
                        const listItem = document.createElement('li');
                        listItem.classList.add('dropdown-item');

                        const link = document.createElement('a');
                        link.href = project.url;
                        link.textContent = project.title;
                        link.target = "_top";
                        listItem.appendChild(link);
                        projectsList.appendChild(listItem);
                    });
                })
                .catch(error => console.error('Error fetching data:', error));
        });

        document.addEventListener('click', (event) => {
            if (!searchInput.contains(event.target) && !projectsList.contains(event.target)) {
                projectsList.style.display = 'none';
            }
        });
    }

    // Feature and Bugs Search
    const bugSearchInput = document.getElementById('bug-search-input');
    const bugsList = document.getElementById('bugs-list');

    if (bugSearchInput) {
        bugSearchInput.addEventListener('input', () => {
            const query = bugSearchInput.value;

            if (query.trim() === "") {
                bugsList.innerHTML = '';
                bugsList.style.display = 'none';
                return;
            }

            bugsList.style.display = 'block';

            fetch(`/feature_and_bugs.json?query=${query}`, {
                headers: {
                    'Accept': 'application/json',
                    'Cache-Control': 'no-cache'
                }
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    bugsList.innerHTML = '';

                    data.forEach(bug => {
                        const listItem = document.createElement('li');
                        const link = document.createElement('a');
                        link.href = bug.url;
                        link.textContent = bug.title;
                        listItem.appendChild(link);
                        bugsList.appendChild(listItem);
                    });
                })
                .catch(error => console.error('Error fetching bugs:', error));
        });

        document.addEventListener('click', (event) => {
            if (!bugSearchInput.contains(event.target) && !bugsList.contains(event.target)) {
                bugsList.style.display = 'none';
            }
        });
    }
});
