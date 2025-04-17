"use client"

import { Info } from "lucide-react"
import { Button } from "@/components/ui/button"
import { 
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger
} from "@/components/ui/tooltip"

interface DistanceQuestionProps {
  value: string | null
  onChange: (value: string | null) => void
}

export function DistanceQuestion({ value, onChange }: DistanceQuestionProps) {
  // Toggle selection
  const handleSelection = (selected: string) => {
    // If the same button is clicked again, deselect it
    if (value === selected) {
      onChange(null);
    } else {
      onChange(selected);
    }
  }

  return (
    <div className="space-y-4">
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <Button
          variant={value === "short" ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => handleSelection("short")}
          disabled={value === "no-preference"}
        >
          <span className="text-2xl">🚶</span>
          <span>Short</span>
          <span className="text-xs text-gray-500">(&lt; 1 mile)</span>
        </Button>

        <Button
          variant={value === "medium" ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => handleSelection("medium")}
          disabled={value === "no-preference"}
        >
          <span className="text-2xl">🚲</span>
          <span>Medium</span>
          <span className="text-xs text-gray-500">(1-3 miles)</span>
        </Button>

        <Button
          variant={value === "high" ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => handleSelection("high")}
          disabled={value === "no-preference"}
        >
          <span className="text-2xl">🚗</span>
          <span>High</span>
          <span className="text-xs text-gray-500">(&gt; 3 miles)</span>
        </Button>

        <TooltipProvider>
          <Tooltip>
            <TooltipTrigger asChild>
              <Button
                variant={value === "no-preference" ? "default" : "outline"}
                className="h-24 flex flex-col items-center justify-center gap-2 relative"
                onClick={() => value === "no-preference" ? onChange(null) : onChange("no-preference")}
              >
                <span className="text-2xl">🤷</span>
                <span>No Preference</span>
                <Info className="h-4 w-4 absolute top-2 right-2 text-gray-400" />
              </Button>
            </TooltipTrigger>
            <TooltipContent>
              <p className="w-64 text-sm">Selecting "No Preference" means you don't mind how far the location is. We'll include options at all distances in your recommendations.</p>
            </TooltipContent>
          </Tooltip>
        </TooltipProvider>
      </div>
      
      {value === "no-preference" && (
        <p className="text-sm bg-blue-50 text-blue-700 p-3 rounded-md border border-blue-100">
          <strong>Note:</strong> You selected "No Preference" - we'll show you options at all distances. For more location-specific recommendations, select a distance range.
        </p>
      )}
    </div>
  )
}