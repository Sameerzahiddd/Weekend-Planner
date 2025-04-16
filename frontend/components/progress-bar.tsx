interface ProgressBarProps {
  progress: number
}

export function ProgressBar({ progress }: ProgressBarProps) {
  return (
    <div className="w-full h-2 bg-gray-200 rounded-full overflow-hidden">
      <div
        className="h-full bg-gradient-to-r from-blue-500 to-teal-400 transition-all duration-300 ease-in-out"
        style={{ width: `${progress}%` }}
      />
    </div>
  )
}
