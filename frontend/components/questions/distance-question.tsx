"use client"

import { Button } from "@/components/ui/button"

interface DistanceQuestionProps {
  value: string | null
  onChange: (value: string) => void
}

export function DistanceQuestion({ value, onChange }: DistanceQuestionProps) {
  return (
    <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
      <Button
        variant={value === "short" ? "default" : "outline"}
        className="h-24 flex flex-col items-center justify-center gap-2"
        onClick={() => onChange("short")}
      >
        <span className="text-2xl">🚶</span>
        <span>Short</span>
        <span className="text-xs text-gray-500">(&lt; 1 mile)</span>
      </Button>

      <Button
        variant={value === "medium" ? "default" : "outline"}
        className="h-24 flex flex-col items-center justify-center gap-2"
        onClick={() => onChange("medium")}
      >
        <span className="text-2xl">🚲</span>
        <span>Medium</span>
        <span className="text-xs text-gray-500">(1-3 miles)</span>
      </Button>

      <Button
        variant={value === "high" ? "default" : "outline"}
        className="h-24 flex flex-col items-center justify-center gap-2"
        onClick={() => onChange("high")}
      >
        <span className="text-2xl">🚗</span>
        <span>High</span>
        <span className="text-xs text-gray-500">(&gt; 3 miles)</span>
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
