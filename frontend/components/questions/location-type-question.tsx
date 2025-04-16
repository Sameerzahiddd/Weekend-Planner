"use client"

import { Home, TreePine } from "lucide-react"
import { Button } from "@/components/ui/button"

interface LocationTypeQuestionProps {
  value: string | null
  onChange: (value: string) => void
}

export function LocationTypeQuestion({ value, onChange }: LocationTypeQuestionProps) {
  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
      <Button
        variant={value === "indoor" ? "default" : "outline"}
        className="h-24 flex flex-col items-center justify-center gap-2"
        onClick={() => onChange("indoor")}
      >
        <Home className="h-8 w-8" />
        <span>Indoor</span>
      </Button>

      <Button
        variant={value === "outdoor" ? "default" : "outline"}
        className="h-24 flex flex-col items-center justify-center gap-2"
        onClick={() => onChange("outdoor")}
      >
        <TreePine className="h-8 w-8" />
        <span>Outdoor</span>
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
