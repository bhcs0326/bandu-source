"use client";

import { useEffect } from "react";
import type { RefObject } from "react";

function isScrollable(node: HTMLElement) {
  if (node.scrollHeight <= node.clientHeight + 2) return false;
  const style = window.getComputedStyle(node);
  return style.overflowY === "auto" || style.overflowY === "scroll";
}

function canScroll(node: HTMLElement, deltaY: number) {
  const atBottom = node.scrollTop + node.clientHeight >= node.scrollHeight - 2;
  const atTop = node.scrollTop <= 2;
  return (deltaY > 0 && !atBottom) || (deltaY < 0 && !atTop);
}

export function useWheelScrollRelay(rootRef: RefObject<HTMLElement | null>) {
  useEffect(() => {
    const root = rootRef.current;
    if (!root) return;

    const handleWheel = (event: WheelEvent) => {
      if (event.defaultPrevented || Math.abs(event.deltaY) < 1) return;

      let node = event.target as HTMLElement | null;
      while (node && node !== root) {
        if (isScrollable(node) && canScroll(node, event.deltaY)) {
          return;
        }
        node = node.parentElement;
      }

      let scrollRoot = root.closest("[data-chat-scroll-root='true']") as HTMLElement | null;
      if (!scrollRoot) {
        let parent = root.parentElement;
        while (parent) {
          if (isScrollable(parent)) {
            scrollRoot = parent;
            break;
          }
          parent = parent.parentElement;
        }
      }

      if (!scrollRoot || !isScrollable(scrollRoot)) return;

      event.preventDefault();
      scrollRoot.scrollBy({ top: event.deltaY, behavior: "auto" });
    };

    root.addEventListener("wheel", handleWheel, { passive: false });
    return () => root.removeEventListener("wheel", handleWheel);
  }, [rootRef]);
}
