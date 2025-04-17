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
  onChange: (value: string) => void
}

export function AmbienceQuestion({ value, onChange }: AmbienceQuestionProps) {
  return (
    <div className="space-y-4">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <Button
          variant={value === "quiet" ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => onChange("quiet")}
          disabled={value === "no-preference"}
        >
          <Volume className="h-6 w-6" />
          <span>Quiet</span>
        </Button>

        <Button
          variant={value === "crowded" ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => onChange("crowded")}
          disabled={value === "no-preference"}
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
                onClick={() => onChange("no-preference")}
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
        <p className="text-sm text-blue-600 italic">
          You selected "No Preference" - we'll show you both quiet and crowded locations.
        </p>
      )}
    </div>
  )
}