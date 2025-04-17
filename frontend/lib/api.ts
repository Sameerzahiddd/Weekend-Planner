// In lib/api.ts
import axios from 'axios';
import type { FormData } from '@/types/form-data';

const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5001'; // Note: changed port to 5001

// Create the API instance with proper error handling
const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Add request interceptor to transform the data
api.interceptors.request.use((config) => {
  // If this is a POST to recommendations endpoint, transform the data
  if (config.method === 'post' && config.url === '/recommendations') {
    const formData = config.data as FormData;
    // Create transformed data with explicit string conversions for all fields
    config.data = {
      locationType: formData.locationType === null ? "no-preference" : formData.locationType,
      budget: formData.budget === null ? "no-preference" : formData.budget,
      vibe: formData.vibe.length === 0 ? ["no-preference"] : formData.vibe,
      distance: formData.distance === null ? "no-preference" : formData.distance,
      food: formData.food === null ? null : formData.food,
      plugs: formData.plugs === null ? null : formData.plugs,
      wifi: formData.wifi === null ? null : formData.wifi,
      ambience: formData.ambience === null ? "no-preference" : formData.ambience,
      wheelchairAccessible: formData.wheelchairAccessible === null ? null : formData.wheelchairAccessible,
    };
    console.log('Transformed request data:', config.data);
  }
  return config;
});

export const getRecommendations = async (formData: FormData) => {
  try {
    console.log('Original form data:', formData);
    const response = await api.post('/recommendations', formData);
    console.log('Response data:', response.data);
    return response.data;
  } catch (error) {
    console.error('Error fetching recommendations:', error);
    // Return an empty array to prevent the app from crashing
    return [];
  }
};

export const getPlaces = async () => {
  try {
    const response = await api.get('/places');
    return response.data;
  } catch (error) {
    console.error('Error fetching places:', error);
    return [];
  }
};