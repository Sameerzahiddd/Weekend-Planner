import axios from 'axios';
import type { FormData } from '@/types/form-data';

const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000';

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
  validateStatus: (status) => status >= 200 && status < 500,
});

// Transform form data before sending to API
const transformFormData = (formData: FormData) => {
  const transformed = { ...formData };
  
  // Handle no-preference values
  if (transformed.locationType === "no-preference") {
    // Set to null to indicate no filtering on this attribute
    transformed.locationType = null;
  }
  
  if (transformed.budget === "no-preference") {
    transformed.budget = null;
  }
  
  if (transformed.distance === "no-preference") {
    transformed.distance = null;
  }
  
  if (transformed.ambience === "no-preference") {
    transformed.ambience = null;
  }
  
  // Handle vibe array with no-preference
  if (transformed.vibe.includes("no-preference")) {
    // Empty array indicates to include all vibe types
    transformed.vibe = [];
  }
  
  return transformed;
};

export const getRecommendations = async (formData: FormData) => {
  try {
    // Transform data before sending to API
    const transformedData = transformFormData(formData);
    
    const response = await api.post('/api/recommendations', transformedData);
    return response.data;
  } catch (error) {
    console.error('Error fetching recommendations:', error);
    throw error;
  }
};

export const getPlaces = async () => {
  try {
    const response = await api.get('/api/places');
    return response.data;
  } catch (error) {
    console.error('Error fetching places:', error);
    throw error;
  }
};