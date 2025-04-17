"use client"

import { Info } from "lucide-react"
import { Home, TreePine } from "lucide-react"
import { Button } from "@/components/ui/button"
import { 
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger
} from "@/components/ui/tooltip"

interface LocationTypeQuestionProps {
  value: string | null
  onChange: (value: string | null) => void
}

export function LocationTypeQuestion({ value, onChange }: LocationTypeQuestionProps) {
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
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <Button
          variant={value === "indoor" ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => handleSelection("indoor")}
          disabled={value === "no-preference"}
        >
          <Home className="h-8 w-8" />
          <span>Indoor</span>
        </Button>

        <Button
          variant={value === "outdoor" ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => handleSelection("outdoor")}
          disabled={value === "no-preference"}
        >
          <TreePine className="h-8 w-8" />
          <span>Outdoor</span>
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
              <p className="w-64 text-sm">Selecting "No Preference" means you're open to any option. We'll consider both indoor and outdoor locations when providing recommendations.</p>
            </TooltipContent>
          </Tooltip>
        </TooltipProvider>
      </div>
      
      {value === "no-preference" && (
        <p className="text-sm bg-blue-50 text-blue-700 p-3 rounded-md border border-blue-100">
          <strong>Note:</strong> You selected "No Preference" - we'll show you both indoor and outdoor locations. For more tailored results, select a specific option.
        </p>
      )}
    </div>
  )
}