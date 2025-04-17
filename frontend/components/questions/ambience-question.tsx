//ambience-question.tsx
"use client"

import { Info } from "lucide-react"
import { Volume, Volume2 } from "lucide-react"
import { Button } from "@/components/ui/button"
import { 
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger
} from "@/components/ui/tooltip"

interface AmbienceQuestionProps {
  value: string | null
  onChange: (value: string | null) => void
}

export function AmbienceQuestion({ value, onChange }: AmbienceQuestionProps) {
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
          variant={value === "quiet" ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => handleSelection("quiet")}
          disabled={value === "no-preference" || value === null}
        >
          <Volume className="h-6 w-6" />
          <span>Quiet</span>
        </Button>

        <Button
          variant={value === "crowded" ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => handleSelection("crowded")}
          disabled={value === "no-preference" || value === null}
        >
          <Volume2 className="h-6 w-6" />
          <span>Crowded</span>
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
              <p className="w-64 text-sm">Selecting "No Preference" means you don't mind if the place is quiet or lively. We'll include both quiet and crowded places in your recommendations.</p>
            </TooltipContent>
          </Tooltip>
        </TooltipProvider>
      </div>
      
      {value === "no-preference" && (
        <p className="text-sm bg-blue-50 text-blue-700 p-3 rounded-md border border-blue-100">
          <strong>Note:</strong> You selected "No Preference" - we'll show you both quiet and crowded locations. For a more tailored experience, select a specific ambience.
        </p>
      )}
    </div>
  )
}