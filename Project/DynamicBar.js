import React, { Component } from 'react';
import { View, Text, Dimensions } from 'react-native';
import { BarChart } from "react-native-chart-kit";

const data = {
  labels: ["Java", "C++", "JS", "Racket", "C", "Angular"],
  datasets: [
    {
      data: [20, 45, 28, 80, 99, 43]
    }
  ]
};

const chartConfig = {
    backgroundGradientFrom: "blue",
    backgroundGradientFromOpacity: 1,
    backgroundGradientTo: "red",
    backgroundGradientToOpacity: 0.5,
    color: (opacity = 1) => `rgba(26, 255, 146, ${opacity})`,
    strokeWidth: 2, // optional, default 3
    barPercentage: 0.5,
    useShadowColorFromDataset: false // optional
  };

const BarGraph = () => {
    return (
        <View style={{flex:1}}>
            <Text style={{
                    alignSelf: 'center',
                    fontSize: 20,
                    fontWeight: '700',
                    marginTop: 20,
                }}>
                RTP
            </Text>
            <BarChart
                data={data}
                width={Dimensions.get('window').width}
                height={220}
                yAxisLabel="$"
                chartConfig={chartConfig}
                verticalLabelRotation={30}
            />

        </View>
    )
}

export default BarGraph;

{/* <Text>Bezier Line Chart</Text>
            <LineChart
                data={{
                labels: ["January", "February", "March", "April", "May", "June"],
                datasets: [
                    {
                    data: [
                        Math.random() * 100,
                        Math.random() * 100,
                        Math.random() * 100,
                        Math.random() * 100,
                        Math.random() * 100,
                        Math.random() * 100
                    ]
                    }
                ]
                }}
                width={Dimensions.get("window").width} // from react-native
                height={220}
                yAxisLabel="$"
                yAxisSuffix="k"
                yAxisInterval={1} // optional, defaults to 1
                
                chartConfig={{
                backgroundColor: "#e26a00",
                backgroundGradientFrom: "#fb8c00",
                backgroundGradientTo: "#ffa726",
                decimalPlaces: 2, // optional, defaults to 2dp
                color: (opacity = 1) => `rgba(255, 255, 255, ${opacity})`,
                labelColor: (opacity = 1) => `rgba(255, 255, 255, ${opacity})`,
                style: {
                    borderRadius: 16
                },
                propsForDots: {
                    r: "6",
                    strokeWidth: "2",
                    stroke: "#ffa726"
                }
                }}
                bezier
                style={{
                marginVertical: 8,
                borderRadius: 16
                }}
            /> */}



// class DynamicBarChart extends Component<{}, State> {
//   constructor(props: {}) {
//     super(props);
//     this.state = {
//       data: [
//         // Initial data point
//         { timestamp: "2023-11-19T08:00:00", readinessScore: 85 },
//       ],
//     };
//   }

//   componentDidMount() {
//     // Initial data fetch
//     this.loadData();

//     // Fetch data every 10 seconds
//     setInterval(this.loadData, 10000);
//   }

//   loadData = () => {
//     fetch('./data.json')
//       .then(response => response.json())
//       .then((data: DataPoint[]) => {
//         if (data.length > 0) {
//           const newDataPoint: DataPoint = {
//             timestamp: new Date().toISOString(),
//             readinessScore: data.shift()!.readinessScore, // Use shift to take the first data point and remove it from the array
//           };

//           this.setState(prevState => ({
//             data: [...prevState.data, newDataPoint],
//           }));
//         }
//       })
//       .catch(error => console.error('Error fetching data:', error));
//   };

//   render() {
//     const fill = 'rgb(134, 65, 244)';

//     return (
//       <View>
//         <Text>Dynamic Bar Chart</Text>
//         <BarChart
//           style={{ height: 400 }}
//           data={this.state.data}
//           svg={{ fill }}
//           contentInset={{ top: 30, bottom: 30 }}
//         >
//           <XAxis dataKey="timestamp" />
//           <YAxis
//             dataKey="readinessScore"
//             label={{ value: 'Readiness Score', angle: -90, position: 'insideLeft' }}
//             domain={[0, 100]}
//           />
//         </BarChart>
//       </View>
//     );
//   }
// }