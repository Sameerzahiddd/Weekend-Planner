"use client"

import { useState } from "react"
import Image from "next/image"
import { WeekendPlannerForm } from "@/components/weekend-planner-form"
import { RecommendationResults } from "@/components/recommendation-results"
import type { FormData } from "@/types/form-data"

export default function Home() {
  const [formData, setFormData] = useState<FormData | null>(null)
  const [recommendations, setRecommendations] = useState<any[] | null>(null)
  const [isLoading, setIsLoading] = useState(false)

  const handleFormSubmit = async (data: FormData) => {
    setFormData(data)
    setIsLoading(true)

    try {
      // For demo purposes, we'll use mock data instead of making an actual API call
      // In a real application, uncomment and use the fetch code below with your actual API endpoint

      /* 
      // Replace with your actual API endpoint
      const response = await fetch("[your-railway-app-url]/recommendations", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
      });

      if (!response.ok) {
        throw new Error(`API error: ${response.status}`);
      }

      const result = await response.json();
      setRecommendations(result);
      */

      // Simulate API delay
      await new Promise((resolve) => setTimeout(resolve, 1500))

      // Use mock data for demonstration
      setRecommendations(mockRecommendations)
    } catch (error) {
      console.error("Error:", error)
      // Always fall back to mock data if there's an error
      setRecommendations(mockRecommendations)
    } finally {
      setIsLoading(false)
    }
  }

  const handleReset = () => {
    setFormData(null)
    setRecommendations(null)
  }

  return (
    <main className="min-h-screen bg-gradient-to-b from-gray-50 to-gray-100">
      <div className="container mx-auto px-4 py-8">
        <header className="mb-8 text-center">
          <div className="relative h-40 w-full mb-6">
            <Image src="/images/sf-skyline.png" alt="San Francisco Skyline" fill className="object-contain" priority />
          </div>
          <h1 className="text-4xl font-bold text-gray-800 mb-2">San Francisco Weekend Planner</h1>
          <p className="text-lg text-gray-600 max-w-2xl mx-auto">
            Discover the perfect spots for your weekend in the city by the bay
          </p>
        </header>

        <div className="max-w-3xl mx-auto">
          {!formData ? (
            <WeekendPlannerForm onSubmit={handleFormSubmit} />
          ) : (
            <RecommendationResults recommendations={recommendations} isLoading={isLoading} onReset={handleReset} />
          )}
        </div>
      </div>
    </main>
  )
}

// Mock data for demonstration purposes
const mockRecommendations = [
  {
    id: 1,
    name: "Dolores Park",
    description: "Sunny park with stunning city views, perfect for picnics and people-watching.",
    address: "Dolores St & 19th St, San Francisco, CA 94114",
    website: "https://sfrecpark.org/destination/mission-dolores-park/",
    image: "/images/dolores-park.png",
    attributes: {
      locationType: "outdoor",
      budget: "free",
      vibe: ["chill", "social"],
      distance: "medium",
      food: true,
      plugs: false,
      wifi: false,
      ambience: "crowded",
      wheelchairAccessible: true,
    },
  },
  {
    id: 2,
    name: "Sightglass Coffee",
    description: "Artisanal coffee roaster with industrial-chic space, perfect for studying or meetings.",
    address: "270 7th St, San Francisco, CA 94103",
    website: "https://sightglasscoffee.com",
    image: "/images/sightglass.png",
    attributes: {
      locationType: "indoor",
      budget: "low",
      vibe: ["chill", "study"],
      distance: "short",
      food: true,
      plugs: true,
      wifi: true,
      ambience: "quiet",
      wheelchairAccessible: true,
    },
  },
  {
    id: 3,
    name: "Golden Gate Park",
    description: "Vast urban park with gardens, museums, and recreational areas.",
    address: "501 Stanyan St, San Francisco, CA 94117",
    website: "https://goldengatepark.com",
    image: "/images/golden-gate-park.png",
    attributes: {
      locationType: "outdoor",
      budget: "free",
      vibe: ["sport", "chill", "romantic"],
      distance: "high",
      food: true,
      plugs: false,
      wifi: false,
      ambience: "crowded",
      wheelchairAccessible: true,
    },
  },
]
