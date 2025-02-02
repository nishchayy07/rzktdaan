function updateCities() {
    const state = document.getElementById("state").value;
    const citySelect = document.getElementById("city");
    citySelect.innerHTML = "<option value=''>--Select City--</option>";
    citySelect.disabled = !state;
    
    const citiesByState = {
        "Maharashtra": ["Mumbai", "Pune", "Nagpur"],
        "Delhi": ["New Delhi", "North Delhi", "South Delhi"],
        "Karnataka": ["Bangalore", "Mysore", "Mangalore"],
        "Tamil Nadu": ["Chennai", "Coimbatore", "Madurai"]
    };
    
    if (state in citiesByState) {
        citiesByState[state].forEach(city => {
            const option = document.createElement("option");
            option.value = city;
            option.textContent = city;
            citySelect.appendChild(option);
        });
    }
}

function fetchStock() {
    const state = document.getElementById("state").value;
    const city = document.getElementById("city").value;
    const bloodGroup = document.getElementById("blood-group").value;
    const tableBody = document.querySelector("#stock-table tbody");
    
    // Simulating data fetching (Replace with actual API call later)
    const dummyData = {
        "Mumbai": { quantity: 10, updated: "2025-02-02" },
        "Pune": { quantity: 5, updated: "2025-02-01" },
        "Delhi": { quantity: 8, updated: "2025-02-02" }
    };
    
    if (city in dummyData) {
        const data = dummyData[city];
        tableBody.innerHTML = `
            <tr>
                <td>${state}</td>
                <td>${city}</td>
                <td>${bloodGroup}</td>
                <td>${data.quantity}</td>
                <td>${data.updated}</td>
            </tr>
        `;
    } else {
        tableBody.innerHTML = "<tr><td colspan='5'>No data available</td></tr>";
    }
}