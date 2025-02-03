const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = 3000;

// Middleware to parse JSON
app.use(bodyParser.json());

// Middleware to log every request
app.use((req, res, next) => {
    console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
    next();
});

// Middleware to add a random delay
app.use((req, res, next) => {
    const randomDelay = Math.floor(Math.random() * 100) + 500; // Random delay between 500ms and 3500ms
    console.log(`Delaying request ${req.method} ${req.url} by ${randomDelay}ms`);
    setTimeout(() => {
        next();
    }, randomDelay);
});

// Middleware to log response status
app.use((req, res, next) => {
    const originalSend = res.send; // Store original res.send method
    res.send = function (body) {
        console.log(`${req.url} with response status: ${res.statusCode}`);
        return originalSend.call(this, body); // Call original res.send method
    };
    next();
});

// Load workshops data
const workshopsPath = path.join(__dirname, 'datasource', 'workshops.json');
let workshops = JSON.parse(fs.readFileSync(workshopsPath, 'utf-8'));

// Load workshops and details data
const workshopDetailsPath = path.join(__dirname, 'datasource', 'workshopDetails.json');
let workshopDetails = JSON.parse(fs.readFileSync(workshopDetailsPath, 'utf-8'));

// POST /workshops
app.post('/workshops', (req, res) => {
    const { searchText, orderedBy } = req.body;

    // Filter by searchText
    let filteredWorkshops = workshops;
    if (searchText) {
        filteredWorkshops = workshops.filter(workshop =>
            workshop.name.toLowerCase().includes(searchText.toLowerCase()) ||
            workshop.services.some(service =>
                service.toLowerCase().includes(searchText.toLowerCase())
            )
        );
    }

    // Sort by orderedBy
    if (orderedBy) {
        switch (orderedBy) {
            case 'Distance':
                filteredWorkshops.sort((a, b) => a.distance - b.distance);
                break;
            case 'Lower Price':
                filteredWorkshops.sort((a, b) => a.price - b.price);
                break;
            case 'Higher Price':
                filteredWorkshops.sort((a, b) => b.price - a.price);
                break;
            case 'Most Positives':
                filteredWorkshops.sort((a, b) => b.positives - a.positives);
                break;
            default:
                break;
        }
    }
    res.status(200).send(filteredWorkshops);
});

// GET /workshop
app.get('/workshop', (req, res) => {
    const { id } = req.query;
    if (!id) {
        return res.status(400).send({ message: 'Query parameter "id" is required' });
    }

    const workshop = workshopDetails.find(w => w.id === parseInt(id));
    if (!workshop) {
        return res.status(404).send({ message: 'Workshop not found' });
    }

    res.status(200).send(workshop);
});

// Load comments
const commentsPath = path.join(__dirname, 'datasource', 'comments.json');
let commentsData = JSON.parse(fs.readFileSync(commentsPath, 'utf-8'));

// GET /comments
app.get('/comments', (req, res) => {
    const { id } = req.query;

    if (!id) {
        return res.status(400).send({ message: 'Query parameter "id" is required' });
    }

    const workshopComments = commentsData[id];
    if (!workshopComments) {
        return res.status(404).send({ message: `No comments found for workshop with id ${id}` });
    }

    res.status(200).send(workshopComments);
});

// Load services
const servicesPath = path.join(__dirname, 'datasource', 'services.json');
let userServices = JSON.parse(fs.readFileSync(servicesPath, 'utf-8'));

// GET /services
app.get('/services', (req, res) => {
    res.status(200).send(userServices);
});

app.post('/schedule', (req, res) => {
    const { services, date, id } = req.body;

    // Validate input
    if (!services || !Array.isArray(services) || services.length === 0) {
        console.log("services error")
        return res.status(400).send(false);
    }
    if (!date || isNaN(new Date(date).getTime())) {
        console.log("date error")
        return res.status(400).send(false);
    }
    if (!id) {
        console.log("workshopId error")
        return res.status(400).send(false);
    }

    // Find workshop details
    const workshop = workshopDetails.find(w => w.id === id);
    if (!workshop) {
        return res.status(404).send(false);
    }

    // Calculate forecast date (2 days after provided date)
    const serviceDate = new Date(date);
    const forecastDate = new Date(serviceDate);
    forecastDate.setDate(serviceDate.getDate() + 2);

    // Add each service to the services.json file
    const newServices = services.map((serviceName, index) => ({
        id: userServices.length + index + 1, // Auto-generate unique ID
        workShopId: id,
        workShopPhoto: workshop.photoURL,
        workShopName: workshop.name,
        name: serviceName,
        status: 'pending',
        forecast: forecastDate.toISOString(),
    }));

    // Append new services to the in-memory services array
    userServices = [...userServices, ...newServices];

    try {
        // Persist to services.json
        fs.writeFileSync(servicesPath, JSON.stringify(userServices, null, 2));
        res.status(200).send(true);
    } catch (error) {
        res.status(500).send(false);
    }
});

// GET /rate
app.get('/rate', (req, res) => {
    const { id } = req.query;

    // Validate serviceId
    if (!id) {
        return res.status(400).send({ message: 'Query parameter "serviceId" is required' });
    }

    // Find the service by ID
    const service = userServices.find(s => s.id === parseInt(id));
    if (!service) {
        return res.status(404).send({ message: `Service with id ${serviceId} not found` });
    }

    // Find the workshop details for the service
    const workshop = workshopDetails.find(w => w.id === service.workShopId);
    if (!workshop) {
        return res.status(404).send({ message: `Workshop with id ${service.workShopId} not found` });
    }

    // Build the response object
    const response = {
        service: {
            id: service.id,
            workShopId: service.workShopId,
            workShopPhoto: service.workShopPhoto,
            workShopName: service.workShopName,
            name: service.name,
            status: service.status,
            forecast: service.forecast
        },
        workshop: {
            id: workshop.id,
            name: workshop.name,
            photoURL: workshop.photoURL,
            distance: workshop.distance,
            positives: workshop.positives,
            negatives: workshop.negatives,
            comments: workshop.comments,
            description: workshop.description,
            todayOpeningHours: workshop.todayOpeningHours,
            address: workshop.address,
            services: workshop.services
        }
    };

    // Send the response
    res.status(200).send(response);
});

// Start server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});