package com.example.kotlin.areacalculator.android

import com.orange.areacalculator.shared.AppLogic
import kotlinx.coroutines.flow.map


class AreaViewModel {
    val logic = AppLogic()

    val initialWidth = logic.initialWidth.toFloat()
    val initialHeight = logic.initialHeight.toFloat()
    val initialArea = logic.initialArea.toFloat()

    val setWidth = { value: Float -> logic.setWidth(value.toDouble()) }
    val setHeight = { value: Float -> logic.setHeight(value.toDouble()) }

    val widthFlow = logic.widthFlow.map { it.toFloat() }
    val heightFlow = logic.heightFlow.map { it.toFloat() }
    val areaFlow = logic.areaFlow.map { it.toFloat() }
}