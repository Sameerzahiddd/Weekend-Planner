"use client"

import { Info } from "lucide-react"
import { DollarSign } from "lucide-react"
import { Button } from "@/components/ui/button"
import { 
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger
} from "@/components/ui/tooltip"

interface BudgetQuestionProps {
  value: string | null
  onChange: (value: string | null) => void
}

export function BudgetQuestion({ value, onChange }: BudgetQuestionProps) {
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
          variant={value === "free" ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => handleSelection("free")}
          disabled={value === "no-preference"}
        >
          <span className="text-2xl">🆓</span>
          <span>Free</span>
          <span className="text-xs text-gray-500">($0)</span>
        </Button>

        <Button
          variant={value === "low" ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => handleSelection("low")}
          disabled={value === "no-preference"}
        >
          <DollarSign className="h-6 w-6" />
          <span>Low</span>
          <span className="text-xs text-gray-500">($1-$20)</span>
        </Button>

        <Button
          variant={value === "high" ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => handleSelection("high")}
          disabled={value === "no-preference"}
        >
          <div className="flex">
            <DollarSign className="h-6 w-6" />
            <DollarSign className="h-6 w-6" />
          </div>
          <span>High</span>
          <span className="text-xs text-gray-500">($20+)</span>
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
              <p className="w-64 text-sm">Selecting "No Preference" means you're open to any budget option. We'll show recommendations across all price ranges.</p>
            </TooltipContent>
          </Tooltip>
        </TooltipProvider>
      </div>
      
      {value === "no-preference" && (
        <p className="text-sm bg-blue-50 text-blue-700 p-3 rounded-md border border-blue-100">
          <strong>Note:</strong> You selected "No Preference" - we'll show you options across all price ranges. For more budget-specific recommendations, select a price range.
        </p>
      )}
    </div>
  )
}