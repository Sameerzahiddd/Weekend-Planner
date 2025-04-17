export interface FormData {
  locationType: "indoor" | "outdoor" | "no-preference" | null;
  budget: "free" | "low" | "high" | "no-preference" | null;
  distance: "walkable" | "short-drive" | "far" | "no-preference" | null;
  vibe: "chill" | "party" | "romantic" | "no-preference" | null;
  food: "yes" | "no" | "no-preference" | null;
  plugs: boolean | null;
  wifi: boolean | null;
  wheelchairAccessible: boolean | null;
}