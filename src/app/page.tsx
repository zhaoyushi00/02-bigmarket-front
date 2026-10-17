"use client";

import Image from "next/image";
import {LuckyWheelPage} from "@/app/pages/lucky/lucky-wheel-page";
import {LuckyGridPage} from "@/app/pages/lucky/lucky-grid-page";
import {strategyArmory} from "@/apis";
import dynamic from "next/dynamic";

export default function Home() {

  const StrategyArmoryButton = dynamic(async()=>(await import("./components/StrategyArmory")).StrategyArmory)

  return (
      <div className="flex flex-col items-center justify-center min-h-screen bg-gray-100">
        {/* 头部文案 */}
        <header className="text-3xl font-bold text-center text-gray-800 my-8">
          大营销平台 - 抽奖展示
        </header>

        {/* 装配抽奖 */}
        <StrategyArmoryButton/>

        {/* 中间的两个div元素 */}
        <div className="flex flex-col md:flex-row gap-4 mb-8">
          <div className="w-full md:w-1/2 p-6 bg-white shadow-lg rounded-lg">
            <LuckyWheelPage/>
          </div>
          <div className="w-full md:w-1/2 p-6 bg-white shadow-lg rounded-lg">
            <LuckyGridPage/>
          </div>
        </div>

        {/* 底部文案 */}
        <footer className="text-gray-600 text-center my-8">
          本项目为 大营销抽奖项目 https://github.com/zhaoyushi00/02-big-market @zhaoyushi00
        </footer>
      </div>
  );
}
