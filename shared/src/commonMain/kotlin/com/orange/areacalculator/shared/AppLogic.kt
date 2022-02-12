package com.orange.areacalculator.shared

import kotlinx.coroutines.flow.*

class AppLogic {
    val initialWidth = 2.0
    val initialHeight = 3.0
    val initialArea = 6.0

    val widthFlow = MutableStateFlow<Double>(initialWidth)
    val heightFlow = MutableStateFlow<Double>(initialHeight)

    val areaFlow = combine(widthFlow, heightFlow) { (width, height) -> width*height }

    fun setWidth(value: Double) { widthFlow.value = value }
    fun setHeight(value: Double) { heightFlow.value = value }
}