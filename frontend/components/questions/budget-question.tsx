"use client"

import { DollarSign } from "lucide-react"
import { Button } from "@/components/ui/button"

interface BudgetQuestionProps {
  value: string | null
  onChange: (value: string) => void
}

export function BudgetQuestion({ value, onChange }: BudgetQuestionProps) {
  return (
    <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
      <Button
        variant={value === "free" ? "default" : "outline"}
        className="h-24 flex flex-col items-center justify-center gap-2"
        onClick={() => onChange("free")}
      >
        <span className="text-2xl">🆓</span>
        <span>Free</span>
        <span className="text-xs text-gray-500">($0)</span>
      </Button>

      <Button
        variant={value === "low" ? "default" : "outline"}
        className="h-24 flex flex-col items-center justify-center gap-2"
        onClick={() => onChange("low")}
      >
        <DollarSign className="h-6 w-6" />
        <span>Low</span>
        <span className="text-xs text-gray-500">($1-$20)</span>
      </Button>

      <Button
        variant={value === "high" ? "default" : "outline"}
        className="h-24 flex flex-col items-center justify-center gap-2"
        onClick={() => onChange("high")}
      >
        <div className="flex">
          <DollarSign className="h-6 w-6" />
          <DollarSign className="h-6 w-6" />
        </div>
        <span>High</span>
        <span className="text-xs text-gray-500">($20+)</span>
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
