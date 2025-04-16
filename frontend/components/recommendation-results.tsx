"use client"

import { useState } from "react"
import { motion } from "framer-motion"
import {
  RefreshCw,
  MapPin,
  Globe,
  Coffee,
  Utensils,
  Wifi,
  Plug,
  ShipWheelIcon as Wheelchair,
  Volume2,
  Users,
} from "lucide-react"
import { Button } from "@/components/ui/button"
import { Card, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import { Skeleton } from "@/components/ui/skeleton"
import { Badge } from "@/components/ui/badge"

interface RecommendationResultsProps {
  recommendations: any[] | null
  isLoading: boolean
  onReset: () => void
}

export function RecommendationResults({ recommendations, isLoading, onReset }: RecommendationResultsProps) {
  const [expandedId, setExpandedId] = useState<number | null>(null)

  const toggleExpand = (id: number) => {
    setExpandedId(expandedId === id ? null : id)
  }

  if (isLoading) {
    return (
      <div className="space-y-6">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-2xl font-bold">Your Recommendations</h2>
          <Button variant="outline" onClick={onReset} disabled>
            <RefreshCw className="mr-2 h-4 w-4" />
            Start Over
          </Button>
        </div>

        {[1, 2, 3].map((i) => (
          <Card key={i} className="overflow-hidden">
            <div className="flex flex-col md:flex-row">
              <Skeleton className="h-48 md:h-auto md:w-1/3 rounded-t-lg md:rounded-l-lg md:rounded-tr-none" />
              <div className="flex-1 p-6">
                <Skeleton className="h-8 w-3/4 mb-2" />
                <Skeleton className="h-4 w-full mb-4" />
                <Skeleton className="h-4 w-full mb-2" />
                <Skeleton className="h-4 w-5/6 mb-4" />
                <div className="flex flex-wrap gap-2">
                  {[1, 2, 3, 4].map((j) => (
                    <Skeleton key={j} className="h-6 w-16 rounded-full" />
                  ))}
                </div>
              </div>
            </div>
          </Card>
        ))}
      </div>
    )
  }

  if (!recommendations || recommendations.length === 0) {
    return (
      <Card className="text-center p-8">
        <CardHeader>
          <CardTitle>No Recommendations Found</CardTitle>
          <CardDescription>We couldn't find any places matching your preferences.</CardDescription>
        </CardHeader>
        <CardFooter className="flex justify-center">
          <Button onClick={onReset}>
            <RefreshCw className="mr-2 h-4 w-4" />
            Try Different Preferences
          </Button>
        </CardFooter>
      </Card>
    )
  }

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center mb-4">
        <h2 className="text-2xl font-bold">Your Recommendations</h2>
        <Button variant="outline" onClick={onReset}>
          <RefreshCw className="mr-2 h-4 w-4" />
          Start Over
        </Button>
      </div>

      <div className="space-y-6">
        {recommendations.map((rec) => (
          <motion.div
            key={rec.id}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.3 }}
          >
            <Card className="overflow-hidden hover:shadow-lg transition-shadow duration-300">
              <div className="flex flex-col md:flex-row">
                <div className="relative h-48 md:h-auto md:w-1/3">
                  <img src={rec.image || "/placeholder.svg"} alt={rec.name} className="w-full h-full object-cover" />
                </div>
                <div className="flex-1 p-6">
                  <CardTitle className="text-xl mb-2">{rec.name}</CardTitle>
                  <CardDescription className="mb-4">{rec.description}</CardDescription>

                  <div className="flex items-center text-sm text-gray-500 mb-2">
                    <MapPin className="h-4 w-4 mr-1" />
                    <span>{rec.address}</span>
                  </div>

                  {rec.website && (
                    <div className="flex items-center text-sm text-blue-500 mb-4">
                      <Globe className="h-4 w-4 mr-1" />
                      <a href={rec.website} target="_blank" rel="noopener noreferrer" className="hover:underline">
                        Visit Website
                      </a>
                    </div>
                  )}

                  <div className="flex flex-wrap gap-2 mb-4">
                    <Badge variant="outline" className="capitalize">
                      {rec.attributes.locationType}
                    </Badge>
                    <Badge variant="outline" className="capitalize">
                      {rec.attributes.budget}
                    </Badge>
                    <Badge variant="outline" className="capitalize">
                      {rec.attributes.distance} distance
                    </Badge>
                    <Badge variant="outline" className="capitalize">
                      {rec.attributes.ambience}
                    </Badge>
                  </div>

                  <div className="flex flex-wrap gap-3">
                    {rec.attributes.food && (
                      <div className="flex items-center text-sm text-gray-600">
                        <Utensils className="h-4 w-4 mr-1" />
                        <span>Food</span>
                      </div>
                    )}
                    {rec.attributes.wifi && (
                      <div className="flex items-center text-sm text-gray-600">
                        <Wifi className="h-4 w-4 mr-1" />
                        <span>WiFi</span>
                      </div>
                    )}
                    {rec.attributes.plugs && (
                      <div className="flex items-center text-sm text-gray-600">
                        <Plug className="h-4 w-4 mr-1" />
                        <span>Outlets</span>
                      </div>
                    )}
                    {rec.attributes.wheelchairAccessible && (
                      <div className="flex items-center text-sm text-gray-600">
                        <Wheelchair className="h-4 w-4 mr-1" />
                        <span>Accessible</span>
                      </div>
                    )}
                  </div>

                  <div className="mt-4">
                    <h4 className="font-medium mb-2">Vibe:</h4>
                    <div className="flex flex-wrap gap-2">
                      {rec.attributes.vibe.map((v: string) => (
                        <Badge key={v} variant="secondary" className="capitalize">
                          {v === "social" ? (
                            <>
                              <Users className="h-3 w-3 mr-1" /> {v}
                            </>
                          ) : v === "chill" ? (
                            <>
                              <Coffee className="h-3 w-3 mr-1" /> {v}
                            </>
                          ) : v === "study" ? (
                            <>
                              <Volume2 className="h-3 w-3 mr-1" /> {v}
                            </>
                          ) : (
                            v
                          )}
                        </Badge>
                      ))}
                    </div>
                  </div>
                </div>
              </div>
            </Card>
          </motion.div>
        ))}
      </div>
    </div>
  )
}
