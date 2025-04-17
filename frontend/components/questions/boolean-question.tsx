"use client"

import { Info } from "lucide-react"
import { Button } from "@/components/ui/button"
import { 
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger
} from "@/components/ui/tooltip"

interface BooleanQuestionProps {
  value: boolean | null
  onChange: (value: boolean | null) => void
  label?: string
}

export function BooleanQuestion({ value, onChange, label }: BooleanQuestionProps) {
  return (
    <div className="space-y-4">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <Button
          variant={value === true ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => onChange(true)}
          disabled={value === null}
        >
          <span className="text-2xl">✅</span>
          <span>Yes</span>
        </Button>

        <Button
          variant={value === false ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => onChange(false)}
          disabled={value === null}
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
                onClick={() => onChange(null)}
              >
                <span className="text-2xl">🤷</span>
                <span>No Preference</span>
                <Info className="h-4 w-4 absolute top-2 right-2 text-gray-400" />
              </Button>
            </TooltipTrigger>
            <TooltipContent>
              <p className="w-64 text-sm">Selecting "No Preference" means this feature isn't important to you. We'll show both places that have this feature and those that don't.</p>
            </TooltipContent>
          </Tooltip>
        </TooltipProvider>
      </div>
      
      {value === null && (
        <p className="text-sm text-blue-600 italic">
          You selected "No Preference" - we'll show you options regardless of this feature.
        </p>
      )}
    </div>
  )
}