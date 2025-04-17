"use client"

import { useState } from "react"
import { motion, AnimatePresence } from "framer-motion"
import { ChevronLeft, ChevronRight, Info } from "lucide-react"
import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import type { FormData } from "@/types/form-data"
import { LocationTypeQuestion } from "@/components/questions/location-type-question"
import { BudgetQuestion } from "@/components/questions/budget-question"
import { VibeQuestion } from "@/components/questions/vibe-question"
import { DistanceQuestion } from "@/components/questions/distance-question"
import { FoodQuestion } from "@/components/questions/food-question"
import { AmbienceQuestion } from "@/components/questions/ambience-question"
import { ProgressBar } from "@/components/progress-bar"
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger
} from "@/components/ui/tooltip"

interface WeekendPlannerFormProps {
  onSubmit: (data: FormData) => void
}

export function WeekendPlannerForm({ onSubmit }: WeekendPlannerFormProps) {
  const [currentStep, setCurrentStep] = useState(0)
  const [formData, setFormData] = useState<FormData>({
    locationType: null,
    budget: null,
    vibe: [],
    distance: null,
    food: null,
    plugs: null,
    wifi: null,
    ambience: null,
    wheelchairAccessible: null,
  })

  const [answeredFields, setAnsweredFields] = useState<Set<keyof FormData>>(new Set())

  const updateFormData = (field: keyof FormData, value: any) => {
    setFormData((prev) => ({ ...prev, [field]: value }))
    // Only mark as answered if value is not null (for boolean questions)
    if (
      field === "food" ||
      field === "plugs" ||
      field === "wifi" ||
      field === "wheelchairAccessible"
    ) {
      if (value !== null) {
        setAnsweredFields((prev) => new Set(prev).add(field))
      } else {
        setAnsweredFields((prev) => {
          const updated = new Set(prev)
          updated.delete(field)
          return updated
        })
      }
    } else {
      setAnsweredFields((prev) => new Set(prev).add(field))
    }
  }

  const wasAnswered = (field: keyof FormData) => answeredFields.has(field)

  const questions = [
    {
      title: "Do you prefer indoor or outdoor locations?",
      subtitle: "Select one option or 'No Preference' to see all",
      component: (
        <LocationTypeQuestion
          value={formData.locationType}
          onChange={(value) => updateFormData("locationType", value)}
        />
      ),
      isAnswered: () => wasAnswered("locationType")
    },
    {
      title: "What's your budget per person?",
      subtitle: "Select one option or 'No Preference' to see all",
      component: <BudgetQuestion value={formData.budget} onChange={(value) => updateFormData("budget", value)} />,
      isAnswered: () => wasAnswered("budget")
    },
    {
      title: "What vibe are you looking for?",
      subtitle: "Select one or more options or 'No Preference' to see all",
      component: <VibeQuestion value={formData.vibe} onChange={(value) => updateFormData("vibe", value)} />,
      isAnswered: () => wasAnswered("vibe")
    },
    {
      title: "How far are you willing to travel from your residence?",
      subtitle: "Select one option or 'No Preference' to see all",
      component: <DistanceQuestion value={formData.distance} onChange={(value) => updateFormData("distance", value)} />,
      isAnswered: () => wasAnswered("distance")
    },
    {
      title: "Do you need food availability?",
      subtitle: "Select yes, no, or 'No Preference' if it doesn't matter",
      component: (
        <FoodQuestion 
          value={formData.food} 
          onChange={(value) => updateFormData("food", value)} 
        />
      ),
      isAnswered: () => wasAnswered("food")
    },
    {
      title: "Do you need plugs/outlets?",
      subtitle: "Select yes, no, or 'No Preference' if it doesn't matter",
      component: (
        <PlugsQuestion 
          value={formData.plugs} 
          onChange={(value) => updateFormData("plugs", value)} 
        />
      ),
      isAnswered: () => wasAnswered("plugs")
    },
    {
      title: "Do you need WiFi?",
      subtitle: "Select yes, no, or 'No Preference' if it doesn't matter",
      component: (
        <WifiQuestion 
          value={formData.wifi} 
          onChange={(value) => updateFormData("wifi", value)} 
        />
      ),
      isAnswered: () => wasAnswered("wifi")
    },
    {
      title: "What ambience do you prefer?",
      subtitle: "Select one option or 'No Preference' to see all",
      component: <AmbienceQuestion value={formData.ambience} onChange={(value) => updateFormData("ambience", value)} />,
      isAnswered: () => wasAnswered("ambience")
    },
    {
      title: "Do you need wheelchair accessibility?",
      subtitle: "Select yes, no, or 'No Preference' if it doesn't matter",
      component: (
        <WheelchairAccessibilityQuestion 
          value={formData.wheelchairAccessible} 
          onChange={(value) => updateFormData("wheelchairAccessible", value)} 
        />
      ),
      isAnswered: () => wasAnswered("wheelchairAccessible")
    },
  ]

  const goToNextStep = () => {
    if (currentStep < questions.length - 1) {
      setCurrentStep(currentStep + 1)
    } else {
      onSubmit(formData)
    }
  }

  const goToPreviousStep = () => {
    if (currentStep > 0) {
      setCurrentStep(currentStep - 1)
    }
  }

  const isNextDisabled = () => {
    return !questions[currentStep].isAnswered()
  }

  const progress = ((currentStep + 1) / questions.length) * 100

  return (
    <div className="w-full max-w-2xl mx-auto">
      <ProgressBar progress={progress} />

      <Card className="mt-6">
        <CardContent className="p-6">
          <div className="flex items-start justify-between mb-4">
            <div>
              <h2 className="text-xl font-semibold">{questions[currentStep].title}</h2>
              <p className="text-sm text-muted-foreground">{questions[currentStep].subtitle}</p>
            </div>
            <TooltipProvider>
              <Tooltip>
                <TooltipTrigger>
                  <Info className="w-5 h-5 text-muted-foreground" />
                </TooltipTrigger>
                <TooltipContent>
                  <p>Choosing “No Preference” includes more options.</p>
                </TooltipContent>
              </Tooltip>
            </TooltipProvider>
          </div>

          {questions[currentStep].component}

          <div className="mt-6 flex justify-between">
            <Button variant="outline" onClick={goToPreviousStep} disabled={currentStep === 0}>
              <ChevronLeft className="mr-2 h-4 w-4" />
              Back
            </Button>
            <Button onClick={goToNextStep} disabled={isNextDisabled()}>
              {currentStep === questions.length - 1 ? "Submit" : "Next"}
              <ChevronRight className="ml-2 h-4 w-4" />
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
