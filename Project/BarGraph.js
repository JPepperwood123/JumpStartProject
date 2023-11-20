import React, { Component } from 'react';
import { View } from 'react-native';
import { BarChart, XAxis, YAxis, Grid } from 'react-native-svg-charts';

class DynamicBarChart extends React.PureComponent {
  constructor(props) {
    super(props);
    this.state = {
      data: [
        // Initial data point
        { timestamp: "2023-11-19T08:00:00", readinessScore: 85 },
        { timestamp: "2023-11-19T09:00:00", readinessScore: 78 },
        { timestamp: "2023-11-19T10:00:00", readinessScore: 92 },
        { timestamp: "2023-11-19T11:00:00", readinessScore: 70 },
        { timestamp: "2023-11-19T12:00:00", readinessScore: 88 },
        { timestamp: "2023-11-19T13:00:00", readinessScore: 95 },
        { timestamp: "2023-11-19T14:00:00", readinessScore: 82 },
        { timestamp: "2023-11-19T15:00:00", readinessScore: 79 },
        { timestamp: "2023-11-19T16:00:00", readinessScore: 90 },
        { timestamp: "2023-11-19T17:00:00", readinessScore: 68 },
        { timestamp: "2023-11-19T18:00:00", readinessScore: 68 }
      ],
    };
  }

  // render() {
  //   const fill = 'rgb(134, 65, 244)';

  //   return (
  //     <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
  //       <BarChart
  //         style={{ height: 400, width: '80%' }}
  //         data={this.state.data}
  //         svg={{ fill }}
  //         yAccessor={({ item }) => item.readinessScore}
  //         contentInset={{ top: 30, right: 30, left: 20, bottom: 30 }}
  //       >
  //         <XAxis data={this.state.data} formatLabel={(value, index) => index.toString()} />
  //         <YAxis
  //           data={this.state.data}
  //           formatLabel={(value) => value.toString()}
  //           label={{ value: 'Readiness Score', angle: -90, position: 'insideLeft' }}
  //           domain={[0, 100]}
  //           min={0}
  //         />
  //       </BarChart>
  //     </View>
  //   );
  // }
  render() {
    const fill = 'rgb(134, 65, 244)'
    const data = [50, 10, 40, 95, -4, -24, null, 85, undefined, 0, 35, 53, -53, 24, 50, -20, -80]

    return (
        <BarChart style={{ height: 200 }} data={data} svg={{ fill }} contentInset={{ top: 30, bottom: 30 }}>
            {/* <Grid /> */}
        </BarChart>
    )
}
}

export default DynamicBarChart;
