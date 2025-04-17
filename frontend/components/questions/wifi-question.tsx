//wifi-question.tsx:
"use client"

import { Info } from "lucide-react"
import { Button } from "@/components/ui/button"
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger
} from "@/components/ui/tooltip"

interface WifiQuestionProps {
  value: boolean | null
  onChange: (value: boolean | null) => void
}

export function WifiQuestion({ value, onChange }: WifiQuestionProps) {
  const handleSelection = (selected: boolean) => {
    if (value === selected) {
      onChange(null)
    } else {
      onChange(selected)
    }
  }

  return (
    <div className="space-y-4">
      <h3 className="text-base font-medium">WiFi availability</h3>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <Button
          variant={value === true ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => handleSelection(true)}
          disabled={value === null}
        >
          <span className="text-2xl">✅</span>
          <span>Yes</span>
        </Button>

        <Button
          variant={value === false ? "default" : "outline"}
          className="h-24 flex flex-col items-center justify-center gap-2"
          onClick={() => handleSelection(false)}
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