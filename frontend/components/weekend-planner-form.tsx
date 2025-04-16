"use client"

import { useState } from "react"
import { motion, AnimatePresence } from "framer-motion"
import { ChevronLeft, ChevronRight } from "lucide-react"
import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import type { FormData } from "@/types/form-data"
import { LocationTypeQuestion } from "@/components/questions/location-type-question"
import { BudgetQuestion } from "@/components/questions/budget-question"
import { VibeQuestion } from "@/components/questions/vibe-question"
import { DistanceQuestion } from "@/components/questions/distance-question"
import { BooleanQuestion } from "@/components/questions/boolean-question"
import { AmbienceQuestion } from "@/components/questions/ambience-question"
import { ProgressBar } from "@/components/progress-bar"

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

  const updateFormData = (field: keyof FormData, value: any) => {
    setFormData((prev) => ({ ...prev, [field]: value }))
  }

  const questions = [
    {
      title: "Do you prefer indoor or outdoor locations?",
      subtitle: "Select one option",
      component: (
        <LocationTypeQuestion
          value={formData.locationType}
          onChange={(value) => updateFormData("locationType", value)}
        />
      ),
    },
    {
      title: "What's your budget per person?",
      subtitle: "Select one option",
      component: <BudgetQuestion value={formData.budget} onChange={(value) => updateFormData("budget", value)} />,
    },
    {
      title: "What vibe are you looking for?",
      subtitle: "Select one or more options",
      component: <VibeQuestion value={formData.vibe} onChange={(value) => updateFormData("vibe", value)} />,
    },
    {
      title: "How far are you willing to travel from your residence?",
      subtitle: "Select one option",
      component: <DistanceQuestion value={formData.distance} onChange={(value) => updateFormData("distance", value)} />,
    },
    {
      title: "Do you need food availability?",
      subtitle: "Select one option",
      component: <BooleanQuestion value={formData.food} onChange={(value) => updateFormData("food", value)} />,
    },
    {
      title: "Do you need plugs/outlets?",
      subtitle: "Select one option",
      component: <BooleanQuestion value={formData.plugs} onChange={(value) => updateFormData("plugs", value)} />,
    },
    {
      title: "Do you need WiFi?",
      subtitle: "Select one option",
      component: <BooleanQuestion value={formData.wifi} onChange={(value) => updateFormData("wifi", value)} />,
    },
    {
      title: "What ambience do you prefer?",
      subtitle: "Select one option",
      component: <AmbienceQuestion value={formData.ambience} onChange={(value) => updateFormData("ambience", value)} />,
    },
    {
      title: "Do you need wheelchair accessibility?",
      subtitle: "Select one option",
      component: (
        <BooleanQuestion
          value={formData.wheelchairAccessible}
          onChange={(value) => updateFormData("wheelchairAccessible", value)}
        />
      ),
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
    const currentField = Object.keys(formData)[currentStep] as keyof FormData
    const currentValue = formData[currentField]

    if (currentField === "vibe") {
      return (currentValue as string[]).length === 0
    }

    return currentValue === null
  }

  const progress = ((currentStep + 1) / questions.length) * 100

  return (
    <div className="relative">
      <ProgressBar progress={progress} />

      <Card className="mt-4 shadow-lg border-0">
        <CardContent className="p-6">
          <AnimatePresence mode="wait">
            <motion.div
              key={currentStep}
              initial={{ opacity: 0, x: 20 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: -20 }}
              transition={{ duration: 0.3 }}
              className="min-h-[300px]"
            >
              <h2 className="text-2xl font-semibold mb-2 text-gray-800">{questions[currentStep].title}</h2>
              <p className="text-sm text-gray-500 mb-6 italic">{questions[currentStep].subtitle}</p>
              {questions[currentStep].component}
            </motion.div>
          </AnimatePresence>

          <div className="flex justify-between mt-8">
            <Button
              variant="outline"
              onClick={goToPreviousStep}
              disabled={currentStep === 0}
              className="flex items-center gap-2"
            >
              <ChevronLeft className="h-4 w-4" />
              Back
            </Button>
            <Button onClick={goToNextStep} disabled={isNextDisabled()} className="flex items-center gap-2">
              {currentStep === questions.length - 1 ? "Submit" : "Next"}
              {currentStep !== questions.length - 1 && <ChevronRight className="h-4 w-4" />}
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
