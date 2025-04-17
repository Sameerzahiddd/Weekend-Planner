//vibe-question.tsx:
"use client"

import { Info } from "lucide-react"
import { Coffee, Users, BookOpen, Heart, Dumbbell } from "lucide-react"
import { Button } from "@/components/ui/button"
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger
} from "@/components/ui/tooltip"

interface VibeQuestionProps {
  value: string[]
  onChange: (value: string[]) => void
}

export function VibeQuestion({ value, onChange }: VibeQuestionProps) {
  const toggleVibe = (vibe: string) => {
    if (value.includes(vibe)) {
      // Remove the vibe if it's already selected
      onChange(value.filter((v) => v !== vibe))
    } else {
      // Add the vibe if it's not selected
      onChange([...value, vibe])
    }
  }

  const clearSelection = () => {
    onChange([])
  }

  const selectNoPreference = () => {
    // Toggle no-preference
    if (value.includes("no-preference")) {
      onChange([])
    } else {
      onChange(["no-preference"])
    }
  }

  return (
    <div className="space-y-4">
      <p className="text-sm text-gray-600 mb-3">
        <strong>Tip:</strong> Click multiple options to select more than one vibe, or click again to deselect.
      </p>

      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 mb-4">
        <Button
          variant={value.includes("chill") ? "default" : "outline"}
          className="h-20 flex flex-col items-center justify-center gap-2"
          onClick={() => toggleVibe("chill")}
          disabled={value.includes("no-preference")}
        >
          <Coffee className="h-6 w-6" />
          <span>Chill</span>
        </Button>

        <Button
          variant={value.includes("social") ? "default" : "outline"}
          className="h-20 flex flex-col items-center justify-center gap-2"
          onClick={() => toggleVibe("social")}
          disabled={value.includes("no-preference")}
        >
          <Users className="h-6 w-6" />
          <span>Social</span>
        </Button>

        <Button
          variant={value.includes("study") ? "default" : "outline"}
          className="h-20 flex flex-col items-center justify-center gap-2"
          onClick={() => toggleVibe("study")}
          disabled={value.includes("no-preference")}
        >
          <BookOpen className="h-6 w-6" />
          <span>Study</span>
        </Button>

        <Button
          variant={value.includes("romantic") ? "default" : "outline"}
          className="h-20 flex flex-col items-center justify-center gap-2"
          onClick={() => toggleVibe("romantic")}
          disabled={value.includes("no-preference")}
        >
          <Heart className="h-6 w-6" />
          <span>Romantic</span>
        </Button>

        <Button
          variant={value.includes("sport") ? "default" : "outline"}
          className="h-20 flex flex-col items-center justify-center gap-2"
          onClick={() => toggleVibe("sport")}
          disabled={value.includes("no-preference")}
        >
          <Dumbbell className="h-6 w-6" />
          <span>Sport</span>
        </Button>

        <TooltipProvider>
          <Tooltip>
            <TooltipTrigger asChild>
              <Button
                variant={value.includes("no-preference") ? "default" : "outline"}
                className="h-20 flex flex-col items-center justify-center gap-2 relative"
                onClick={selectNoPreference}
              >
                <span className="text-2xl">🤷</span>
                <span>No Preference</span>
                <Info className="h-4 w-4 absolute top-2 right-2 text-gray-400" />
              </Button>
            </TooltipTrigger>
            <TooltipContent>
              <p className="w-64 text-sm">Selecting "No Preference" means you're open to any vibe. We'll include places with all types of vibes in your recommendations.</p>
            </TooltipContent>
          </Tooltip>
        </TooltipProvider>
      </div>

      {value.length > 0 && !value.includes("no-preference") && (
        <div className="text-right">
          <Button variant="ghost" size="sm" onClick={clearSelection}>
            Clear selection
          </Button>
        </div>
      )}

      {value.includes("no-preference") ? (
        <p className="text-sm bg-blue-50 text-blue-700 p-3 rounded-md border border-blue-100">
          <strong>Note:</strong> You selected "No Preference" - we'll show you places with all types of vibes. For more personalized recommendations, select specific vibes that interest you.
        </p>
      ) : (
        <p className="text-sm text-gray-500 mt-2">
          {value.length === 0
            ? "Select at least one vibe or choose 'No Preference'"
            : `Selected: ${value.join(", ")}`}
        </p>
      )}
    </div>
  )
}