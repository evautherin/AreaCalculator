package com.orange.areacalculator.shared

import kotlinx.coroutines.flow.*


class AppLogic {

    val areaCalculation = { width: Double, height: Double -> width*height }

    val initialWidth = 2.0
    val initialHeight = 3.0
    val initialArea = areaCalculation(initialWidth, initialHeight)

    val widthFlow = MutableStateFlow<Double>(initialWidth)
    val heightFlow = MutableStateFlow<Double>(initialHeight)

    val areaFlow = combine(widthFlow, heightFlow, transform = areaCalculation)

    fun setWidth(value: Double) { widthFlow.value = value }
    fun setHeight(value: Double) { heightFlow.value = value }
}