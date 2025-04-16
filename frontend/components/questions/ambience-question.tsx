"use client"

import { Volume, Volume2 } from "lucide-react"
import { Button } from "@/components/ui/button"

interface AmbienceQuestionProps {
  value: string | null
  onChange: (value: string) => void
}

export function AmbienceQuestion({ value, onChange }: AmbienceQuestionProps) {
  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
      <Button
        variant={value === "quiet" ? "default" : "outline"}
        className="h-24 flex flex-col items-center justify-center gap-2"
        onClick={() => onChange("quiet")}
      >
        <Volume2 className="h-6 w-6" />
        <span>Quiet</span>
      </Button>

      <Button
        variant={value === "crowded" ? "default" : "outline"}
        className="h-24 flex flex-col items-center justify-center gap-2"
        onClick={() => onChange("crowded")}
      >
        <Volume className="h-6 w-6" />
        <span>Crowded</span>
      </Button>

      <Button
        variant={value === "no-preference" ? "default" : "outline"}
        className="h-24 flex flex-col items-center justify-center gap-2"
        onClick={() => onChange("no-preference")}
      >
        <span className="text-2xl">🤷</span>
        <span>No Preference</span>
      </Button>
    </div>
  )
}
