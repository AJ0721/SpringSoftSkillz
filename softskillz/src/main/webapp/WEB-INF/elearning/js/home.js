 // Fetch threads from server
 function fetchThreads() {
    return fetch('/forum/thread/find-all')
       .then(response => response.json())
       .catch(error => {
          console.error('Error fetching threads:', error);
          return [];
       });
 }

// Create a thread card HTML
function createThreadCard(thread, authorName, createdTime) {
    return `
        <div class="col-12 mb-4" id="thread-${thread.threadId}">
            <div class="bg-white p-3 border border-3 rounded-3 thread-card">
                <h5>${thread.threadTitle}</h5>
                <h6 class="text-muted">作者: ${authorName}</h6>
                <h6 class="text-muted">時間: ${createdTime}</h6>
                <p>${thread.threadContent.substring(0, 100)}...</p>
                <a href="/forum/f/thread/id/${thread.threadId}" class="btn btn-link p-0">查看更多</a>
            </div>
        </div>`;
}

// Display threads on the page
function displayThreads(threads) {
    const threadList = document.getElementById('threadList');
    threadList.innerHTML = '';

    threads.sort((a, b) => new Date(b.threadCreatedTime) - new Date(a.threadCreatedTime));

    threads.forEach(thread => {
        const { authorName } = getUserDetails(thread);
        const createdTime = new Date(thread.threadCreatedTime).toLocaleString();
        const threadCard = createThreadCard(thread, authorName, createdTime);
        threadList.insertAdjacentHTML('beforeend', threadCard);
    });
}

// Fetch and display threads
function fetchAndDisplayThreads() {
    fetchThreads().then(displayThreads);
}



