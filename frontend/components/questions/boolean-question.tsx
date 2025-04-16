"use client"

import { Button } from "@/components/ui/button"

interface BooleanQuestionProps {
  value: boolean | null
  onChange: (value: boolean) => void
}

export function BooleanQuestion({ value, onChange }: BooleanQuestionProps) {
  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
      <Button
        variant={value === true ? "default" : "outline"}
        className="h-24 flex flex-col items-center justify-center gap-2"
        onClick={() => onChange(true)}
      >
        <span className="text-2xl">✅</span>
        <span>Yes</span>
      </Button>

      <Button
        variant={value === false ? "default" : "outline"}
        className="h-24 flex flex-col items-center justify-center gap-2"
        onClick={() => onChange(false)}
      >
        <span className="text-2xl">❌</span>
        <span>No</span>
      </Button>

      <Button
        variant={value === null ? "default" : "outline"}
        className="h-24 flex flex-col items-center justify-center gap-2"
        onClick={() => onChange(null)}
      >
        <span className="text-2xl">🤷</span>
        <span>No Preference</span>
      </Button>
    </div>
  )
}
