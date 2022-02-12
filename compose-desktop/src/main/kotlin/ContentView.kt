package com.example.kotlin.areacalculator.android

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Slider
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.withContext
import kotlin.coroutines.CoroutineContext
import kotlin.coroutines.EmptyCoroutineContext
import kotlin.reflect.KProperty

@Composable
fun ContentView(
    viewModel: AreaViewModel
) {
    val width by viewModel.widthFlow.collectAsState(viewModel.initialWidth)
    val height by viewModel.heightFlow.collectAsState(viewModel.initialHeight)
    val area by viewModel.areaFlow.collectAsState(viewModel.initialArea)

//    val setWidth = viewModel.setWidth
//    val setHeight = viewModel.setHeight

    Column() {
        LengthView("Width", width, viewModel.setWidth)
        LengthView("Height", height, viewModel.setHeight)
        Text(text = "Area: $area", modifier = Modifier.padding(16.dp))
    }
}

@Composable
fun LengthView(
    label: String,
    value: Float,
    onValueChange: (Float) -> Unit
) {
    Column(
        modifier = Modifier.padding(16.dp)
    ) {
        Text(text = "$label: $value")
        Slider(value = value, valueRange = 1f..10f, onValueChange = onValueChange)
    }
}

