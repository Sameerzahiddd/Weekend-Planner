"use client"

import { Coffee, Users, BookOpen, Heart, Dumbbell } from "lucide-react"
import { Button } from "@/components/ui/button"

interface VibeQuestionProps {
  value: string[]
  onChange: (value: string[]) => void
}

export function VibeQuestion({ value, onChange }: VibeQuestionProps) {
  const toggleVibe = (vibe: string) => {
    if (vibe === "no-preference") {
      // If no-preference is clicked, clear all other selections
      onChange(["no-preference"])
      return
    }
    
    // If any other option is clicked, remove no-preference
    if (value.includes("no-preference")) {
      onChange([vibe])
      return
    }
    
    // Toggle the vibe in the normal way
    if (value.includes(vibe)) {
      onChange(value.filter((v) => v !== vibe))
    } else {
      onChange([...value, vibe])
    }
  }

  return (
    <div>
      <p className="text-sm text-gray-600 mb-3">
        <strong>Tip:</strong> Click multiple options to select more than one vibe, or choose "No Preference" if you're open to anything.
      </p>

      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 mb-4">
        <Button
          variant={value.includes("chill") ? "default" : "outline"}
          className="h-20 flex flex-col items-center justify-center gap-2"
          onClick={() => toggleVibe("chill")}
          disabled={value.includes("no-preference")}
        >
          <Coffee className="h-6 w-6" />
          <span>Chill</span>
        </Button>

        <Button
          variant={value.includes("social") ? "default" : "outline"}
          className="h-20 flex flex-col items-center justify-center gap-2"
          onClick={() => toggleVibe("social")}
          disabled={value.includes("no-preference")}
        >
          <Users className="h-6 w-6" />
          <span>Social</span>
        </Button>

        <Button
          variant={value.includes("study") ? "default" : "outline"}
          className="h-20 flex flex-col items-center justify-center gap-2"
          onClick={() => toggleVibe("study")}
          disabled={value.includes("no-preference")}
        >
          <BookOpen className="h-6 w-6" />
          <span>Study</span>
        </Button>

        <Button
          variant={value.includes("romantic") ? "default" : "outline"}
          className="h-20 flex flex-col items-center justify-center gap-2"
          onClick={() => toggleVibe("romantic")}
          disabled={value.includes("no-preference")}
        >
          <Heart className="h-6 w-6" />
          <span>Romantic</span>
        </Button>

        <Button
          variant={value.includes("sport") ? "default" : "outline"}
          className="h-20 flex flex-col items-center justify-center gap-2"
          onClick={() => toggleVibe("sport")}
          disabled={value.includes("no-preference")}
        >
          <Dumbbell className="h-6 w-6" />
          <span>Sport</span>
        </Button>

        <Button
          variant={value.includes("no-preference") ? "default" : "outline"}
          className="h-20 flex flex-col items-center justify-center gap-2"
          onClick={() => toggleVibe("no-preference")}
          disabled={value.length > 0 && !value.includes("no-preference")}
        >
          <span className="text-2xl">🤷</span>
          <span>No Preference</span>
          <span className="text-xs text-gray-500">(Any vibe works)</span>
        </Button>
      </div>

      <p className="text-sm text-gray-500 mt-2">
        {value.includes("no-preference")
          ? "No preference selected - all vibes are welcome!"
          : value.length === 0
            ? "Select at least one vibe"
            : `Selected: ${value.join(", ")}`}
      </p>
    </div>
  )
}