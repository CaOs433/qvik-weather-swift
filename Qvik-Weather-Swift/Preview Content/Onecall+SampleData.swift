//
//  Onecall+SampleData.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 7.1.2025.
//

import Foundation

extension Onecall {
    static var sampleResponseHelsinki: Onecall {
        Onecall(
            weather:
                Onecall.WeatherResponse(
                    lat: 60.1675,
                    lon: 24.9427,
                    timezone: "Europe/Helsinki",
                    timezoneOffset: 7200,
                    current: Onecall.CurrentWeather(
                        dt: 1736296823,
                        sunrise: 1736320705,
                        sunset: 1736343301,
                        temp: 2.22,
                        feelsLike: -3.12,
                        pressure: 994,
                        humidity: 84,
                        dewPoint: -0.17,
                        uvi: 0,
                        clouds: 75,
                        visibility: 10000,
                        windSpeed: 7.15,
                        windDeg: 178,
                        windGust: 8.49,
                        weather: [
                            Onecall.Weather(
                                id: 803,
                                main: "Clouds",
                                description: "broken clouds",
                                icon: "04n"
                            )
                        ],
                        rain: Onecall.Rain(oneHour: 7.0),
                        snow: nil
                    ),
                    minutely: stride(from: 1736296860, to: 1736300400, by: 60).map {
                        Onecall.MinutelyWeather(
                            dt: $0,
                            precipitation: Double.random(in: 10...100).rounded() / 10
                        )
                    },
                    hourly: [
                        Onecall.HourlyWeather(
                            dt: 1736294400,
                            temp: 2.27,
                            feelsLike: -2.43,
                            pressure: 994,
                            humidity: 86,
                            dewPoint: 0.17,
                            uvi: 0,
                            clouds: 79,
                            visibility: 10000,
                            windSpeed: 5.7,
                            windDeg: 177,
                            windGust: 8.86,
                            weather: [
                                Onecall.Weather(
                                    id: 803,
                                    main: "Clouds",
                                    description: "broken clouds",
                                    icon: "04n"
                                )
                            ],
                            pop: 0,
                            rain: Onecall.Rain(oneHour: 17.0),
                            snow: nil
                        ),
                        Onecall.HourlyWeather(
                            dt: 1736298000,
                            temp: 2.22,
                            feelsLike: -2.33,
                            pressure: 994,
                            humidity: 84,
                            dewPoint: -0.17,
                            uvi: 0,
                            clouds: 75,
                            visibility: 10000,
                            windSpeed: 5.36,
                            windDeg: 180,
                            windGust: 8.57,
                            weather: [
                                Onecall.Weather(
                                    id: 803,
                                    main: "Clouds",
                                    description: "broken clouds",
                                    icon: "04n"
                                )
                            ],
                            pop: 0,
                            rain: Onecall.Rain(oneHour: 0.0),
                            snow: nil
                        ),
                        Onecall.HourlyWeather(
                            dt: 1736301600,
                            temp: 2.24,
                            feelsLike: -2.15,
                            pressure: 994,
                            humidity: 86,
                            dewPoint: 0.14,
                            uvi: 0,
                            clouds: 80,
                            visibility: 10000,
                            windSpeed: 5.06,
                            windDeg: 184,
                            windGust: 7.99,
                            weather: [
                                Onecall.Weather(
                                    id: 803,
                                    main: "Clouds",
                                    description: "broken clouds",
                                    icon: "04n"
                                )
                            ],
                            pop: 0,
                            rain: Onecall.Rain(oneHour: 3.0),
                            snow: nil
                        ),
                        Onecall.HourlyWeather(
                            dt: 1736305200,
                            temp: 2.25,
                            feelsLike: -1.75,
                            pressure: 994,
                            humidity: 88,
                            dewPoint: 0.47,
                            uvi: 0,
                            clouds: 85,
                            visibility: 10000,
                            windSpeed: 4.37,
                            windDeg: 186,
                            windGust: 7.37,
                            weather: [
                                Onecall.Weather(
                                    id: 804,
                                    main: "Clouds",
                                    description: "overcast clouds",
                                    icon: "04n"
                                )
                            ],
                            pop: 0,
                            rain: nil,
                            snow: nil
                        ),
                        Onecall.HourlyWeather(
                            dt: 1736308800,
                            temp: 2.12,
                            feelsLike: -1.3,
                            pressure: 993,
                            humidity: 90,
                            dewPoint: 0.65,
                            uvi: 0,
                            clouds: 90,
                            visibility: 10000,
                            windSpeed: 3.45,
                            windDeg: 198,
                            windGust: 5.47,
                            weather: [
                                Onecall.Weather(
                                    id: 804,
                                    main: "Clouds",
                                    description: "overcast clouds",
                                    icon: "04n"
                                )
                            ],
                            pop: 0,
                            rain: nil,
                            snow: nil
                        )
                    ],
                    daily: [
                        Onecall.DailyWeather(
                            dt: 1736330400,
                            sunrise: 1736320705,
                            sunset: 1736343301,
                            moonrise: 1736327820,
                            moonset: 1736297280,
                            moonPhase: 0.3,
                            summary: "Expect a day of partly cloudy with snow",
                            temp: Onecall.Temperature(
                                day: 2.01,
                                min: 0.82,
                                max: 2.35,
                                night: 1.21,
                                eve: 1.65,
                                morn: 2.12
                            ),
                            feelsLike: Onecall.FeelsLike(
                                day: -1.67,
                                night: -4.09,
                                eve: -2.75,
                                morn: -1.3
                            ),
                            pressure: 992,
                            humidity: 94,
                            dewPoint: 1.18,
                            windSpeed: 6.66,
                            windDeg: 201,
                            windGust: 10.92,
                            weather: [
                                Onecall.Weather(
                                    id: 601,
                                    main: "Snow",
                                    description: "snow",
                                    icon: "13d"
                                )
                            ],
                            clouds: 100,
                            pop: 1,
                            rain: nil,
                            snow: 1.11,
                            uvi: 0.08
                        ),
                        Onecall.DailyWeather(
                            dt: 1736416800,
                            sunrise: 1736407038,
                            sunset: 1736429818,
                            moonrise: 1736414280,
                            moonset: 1736390220,
                            moonPhase: 0.34,
                            summary: "Expect a day of partly cloudy with snow",
                            temp: Onecall.Temperature(
                                day: 0.95,
                                min: 0.1,
                                max: 2.25,
                                night: 0.78,
                                eve: 1.71,
                                morn: 1.73
                            ),
                            feelsLike: Onecall.FeelsLike(
                                day: -1.44,
                                night: -3.36,
                                eve: -3.27,
                                morn: -3.54
                            ),
                            pressure: 1000,
                            humidity: 85,
                            dewPoint: -1.29,
                            windSpeed: 8.28,
                            windDeg: 193,
                            windGust: 13.77,
                            weather: [
                                Onecall.Weather(
                                    id: 601,
                                    main: "Snow",
                                    description: "snow",
                                    icon: "13d"
                                )
                            ],
                            clouds: 80,
                            pop: 1,
                            rain: nil,
                            snow: 3.59,
                            uvi: 0.16
                        ),
                        Onecall.DailyWeather(
                            dt: 1736503200,
                            sunrise: 1736493367,
                            sunset: 1736516338,
                            moonrise: 1736500980,
                            moonset: 1736483400,
                            moonPhase: 0.37,
                            summary: "Expect a day of partly cloudy with snow",
                            temp: Onecall.Temperature(
                                day: -0.28,
                                min: -1.96,
                                max: 0.79,
                                night: -1.96,
                                eve: -0.26,
                                morn: 0.79
                            ),
                            feelsLike: Onecall.FeelsLike(
                                day: -7.15,
                                night: -8.96,
                                eve: -7.26,
                                morn: -4.42
                            ),
                            pressure: 1002,
                            humidity: 97,
                            dewPoint: -0.77,
                            windSpeed: 11.25,
                            windDeg: 59,
                            windGust: 18.82,
                            weather: [
                                Onecall.Weather(
                                    id: 601,
                                    main: "Snow",
                                    description: "snow",
                                    icon: "13d"
                                )
                            ],
                            clouds: 100,
                            pop: 1,
                            rain: nil,
                            snow: 15.12,
                            uvi: 0.07
                        ),
                        Onecall.DailyWeather(
                            dt: 1736589600,
                            sunrise: 1736579691,
                            sunset: 1736602861,
                            moonrise: 1736588340,
                            moonset: 1736576400,
                            moonPhase: 0.41,
                            summary: "You can expect snow in the morning, with partly cloudy in the afternoon",
                            temp: Onecall.Temperature(
                                day: -3.04,
                                min: -4.93,
                                max: -2.21,
                                night: -4.93,
                                eve: -3.93,
                                morn: -2.66
                            ),
                            feelsLike: Onecall.FeelsLike(
                                day: -10.04,
                                night: -11.93,
                                eve: -10.93,
                                morn: -9.66
                            ),
                            pressure: 1003,
                            humidity: 92,
                            dewPoint: -4.21,
                            windSpeed: 11.14,
                            windDeg: 42,
                            windGust: 18.58,
                            weather: [
                                Onecall.Weather(
                                    id: 601,
                                    main: "Snow",
                                    description: "snow",
                                    icon: "13d"
                                )
                            ],
                            clouds: 100,
                            pop: 1,
                            rain: nil,
                            snow: 6.53,
                            uvi: 0.14
                        ),
                        Onecall.DailyWeather(
                            dt: 1736676000,
                            sunrise: 1736666011,
                            sunset: 1736689388,
                            moonrise: 1736677680,
                            moonset: 1736667660,
                            moonPhase: 0.45,
                            summary: "Expect a day of partly cloudy with clear spells",
                            temp: Onecall.Temperature(
                                day: -8.02,
                                min: -8.17,
                                max: -5.83,
                                night: -8.07,
                                eve: -7.24,
                                morn: -6.79
                            ),
                            feelsLike: Onecall.FeelsLike(
                                day: -14.83,
                                night: -12.47,
                                eve: -12.16,
                                morn: -13.79
                            ),
                            pressure: 1024,
                            humidity: 78,
                            dewPoint: -11.71,
                            windSpeed: 8.1,
                            windDeg: 359,
                            windGust: 17.06,
                            weather: [
                                Onecall.Weather(
                                    id: 800,
                                    main: "Clear",
                                    description: "clear sky",
                                    icon: "01d"
                                )
                            ],
                            clouds: 2,
                            pop: 0,
                            rain: nil,
                            snow: nil,
                            uvi: 0.21
                        ),
                        Onecall.DailyWeather(
                            dt: 1736762400,
                            sunrise: 1736752326,
                            sunset: 1736775917,
                            moonrise: 1736769660,
                            moonset: 1736755980,
                            moonPhase: 0.48,
                            summary: "You can expect partly cloudy with snow in the morning, with partly cloudy with rain in the afternoon",
                            temp: Onecall.Temperature(
                                day: 2.15,
                                min: -7.04,
                                max: 2.33,
                                night: 2.33,
                                eve: 1.7,
                                morn: -3.39
                            ),
                            feelsLike: Onecall.FeelsLike(
                                day: -4.18,
                                night: -2.33,
                                eve: -4.65,
                                morn: -8.06
                            ),
                            pressure: 1021,
                            humidity: 92,
                            dewPoint: 0.97,
                            windSpeed: 11.08,
                            windDeg: 234,
                            windGust: 18.05,
                            weather: [
                                Onecall.Weather(
                                    id: 616,
                                    main: "Snow",
                                    description: "rain and snow",
                                    icon: "13d"
                                )
                            ],
                            clouds: 100,
                            pop: 1,
                            rain: 0.45,
                            snow: 2.37,
                            uvi: 1
                        ),
                        Onecall.DailyWeather(
                            dt: 1736848800,
                            sunrise: 1736838638,
                            sunset: 1736862450,
                            moonrise: 1736862540,
                            moonset: 1736843040,
                            moonPhase: 0.5,
                            summary: "Expect a day of partly cloudy with rain",
                            temp: Onecall.Temperature(
                                day: 3.29,
                                min: 2.62,
                                max: 3.76,
                                night: 3.76,
                                eve: 2.9,
                                morn: 3.09
                            ),
                            feelsLike: Onecall.FeelsLike(
                                day: -1.49,
                                night: -1.44,
                                eve: -1.81,
                                morn: -1.88
                            ),
                            pressure: 1000,
                            humidity: 98,
                            dewPoint: 3.03,
                            windSpeed: 7.99,
                            windDeg: 310,
                            windGust: 16.5,
                            weather: [
                                Onecall.Weather(
                                    id: 500,
                                    main: "Rain",
                                    description: "light rain",
                                    icon: "10d"
                                )
                            ],
                            clouds: 100,
                            pop: 1,
                            rain: 2.25,
                            snow: nil,
                            uvi: 1
                        ),
                        Onecall.DailyWeather(
                            dt: 1736935200,
                            sunrise: 1736924946,
                            sunset: 1736948985,
                            moonrise: 1736955120,
                            moonset: 1736929620,
                            moonPhase: 0.55,
                            summary: "Expect a day of partly cloudy with rain",
                            temp: Onecall.Temperature(
                                day: -2.77,
                                min: -4.48,
                                max: 2.79,
                                night: -4.48,
                                eve: -4.21,
                                morn: -0.89
                            ),
                            feelsLike: Onecall.FeelsLike(
                                day: -9.58,
                                night: -8.03,
                                eve: -10.54,
                                morn: -7.43
                            ),
                            pressure: 1017,
                            humidity: 81,
                            dewPoint: -5.65,
                            windSpeed: 8.03,
                            windDeg: 2,
                            windGust: 13.81,
                            weather: [
                                Onecall.Weather(
                                    id: 500,
                                    main: "Rain",
                                    description: "light rain",
                                    icon: "10d"
                                )
                            ],
                            clouds: 100,
                            pop: 0.33,
                            rain: 0.33,
                            snow: nil,
                            uvi: 1
                        )
                    ],
                    alerts: [
                        Onecall.WeatherAlert(
                            senderName: "Ilmatieteen laitos",
                            event: "Warning for gale-force winds",
                            start: 1736355600,
                            end: 1736384400,
                            description: "Wind warning for sea areas: South near gale 15 m/s in the evening and by night.",
                            tags: ["Wind"]
                        )
                    ]
                )
        )
    }
    
}
