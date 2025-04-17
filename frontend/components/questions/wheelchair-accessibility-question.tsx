"use client"

import { Info } from "lucide-react"
import { Button } from "@/components/ui/button"
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger
} from "@/components/ui/tooltip"

interface WheelchairAccessibilityQuestionProps {
  value: boolean | null
  onChange: (value: boolean | null) => void
}

export function WheelchairAccessibilityQuestion({ value, onChange }: WheelchairAccessibilityQuestionProps) {
  // For FoodQuestion, WifiQuestion, PlugsQuestion, WheelchairAccessibilityQuestion
const handleSelection = (selected: boolean) => {
  // If current value matches selected, toggle it off
  if (value === selected) {
    onChange(null); // Setting to null (no preference)
  } else {
    onChange(selected);
  }
}

// For "No Preference" button
const handleNoPreference = () => {
  // Toggle - if it's already null, clear it
  if (value === null) {
    // This should set it to some default, let's say "true"
    onChange(true);
  } else {
    onChange(null);
  }
}

  return (
    <div className="space-y-4">
      <h3 className="text-base font-medium">Wheelchair Accessibility</h3>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <Button
          variant={value === true ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => handleSelection(true)}
        >
          <span className="text-2xl">✅</span>
          <span>Yes</span>
        </Button>

        <Button
          variant={value === false ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => handleSelection(false)}
        >
          <span className="text-2xl">❌</span>
          <span>No</span>
        </Button>

        <TooltipProvider>
          <Tooltip>
            <TooltipTrigger asChild>
              <Button
                variant={value === null ? "default" : "outline"}
                className="h-24 flex flex-col items-center justify-center gap-2 relative"
                onClick={() => value === null ? onChange(true) : onChange(null)}
              >
                <span className="text-2xl">🤷</span>
                <span>No Preference</span>
                <Info className="h-4 w-4 absolute top-2 right-2 text-gray-400" />
              </Button>
            </TooltipTrigger>
            <TooltipContent>
              <p className="w-64 text-sm">
                Selecting "No Preference" means this feature isn't important to you.
                We'll show both places that have this feature and those that don't.
              </p>
            </TooltipContent>
          </Tooltip>
        </TooltipProvider>
      </div>

      {value === null && (
        <p className="text-sm bg-blue-50 text-blue-700 p-3 rounded-md border border-blue-100">
          <strong>Note:</strong> You selected "No Preference" — results will include all options regardless of this feature.
        </p>
      )}
    </div>
  )
}