# Online Editor 
[Editor](https://vega.github.io/editor/#/custom/vega-lite)

# Data source
https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv

## Data description
The dataset contains Facebook's daily stock price from June 2019 to June 2020. There are 7 columns: Date, Open, High, Low, Close, Adj Close, Volume. 
Take a look at the data: https://github.com/smbillah/ist526/blob/main/FB_data.csv


# Simple visualization:
## A line graph showing 

Code:
```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "mark": "line",
  "encoding": {
    "x": {"field": "Date"},
    "y": {"field": "Open"}
  }
}
```

Looks out of control, right? Let's fix the height and the width.


```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "width": 400,
  "height": 300,
  "mark": "line",
  "encoding": {
    "x": {"field": "Date"},
    "y": {"field": "Open"}
  }
}
```

Much better? No? Let's fix the data types.

```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "width": 400,
  "height": 300,
  "mark": "line",
  "encoding": {    
    "x": {"field": "Date", "type": "temporal"},
    "y": {"field": "Open", "type": "quantitative"},
  }
}
```
Much better? Where is tooltip? Let's fix the `mark`.

```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "width": 400,
  "height": 300,
  "mark": {"type" :"line", "tooltip": true},
  "encoding": {    
    "x": {"field": "Date", "type": "temporal"},
    "y": {"field": "Open", "type": "quantitative"},
  }
}
```

Can you see the text on mouse hover. Much better but still too wide, right? Let's group the time by months.

```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "width": 400,
  "height": 300,
  "mark": {"type" :"line", "tooltip": true},
  "encoding": {        
    "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},
    "y": {"field": "Open", "type": "quantitative"},
  }
}
```

Makes no sense, right? This is because we did not aggregate the data. Let's use an aggregation.

```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "width": 400,
  "height": 300,
  "mark": {"type" :"line", "tooltip": true},
  "encoding": {        
    "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},
    "y": {"field": "Open", "type": "quantitative", "aggregate": "mean"},
  }
}
```
Readable, right?

## Try out different `mark` types
What is mark? What are the available marks?
Are marks related to pre-attentive variables?

```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "width": 400,
  "height": 300,
  "mark": {"type" :"circle", "tooltip": true},
  "encoding": {        
    "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},
    "y": {"field": "Open", "type": "quantitative", "aggregate": "mean"},
  }
}
```
  

# Tabular format vs Long format [Multiple lines]
## Why necessary? 
To draw multiple lines; Vega-lite prefers long format over tablular format. We can use a `transform` function named `fold` to unroll a table into a long format. 
It internally creates `key`:`value` pairs for the columns. 
[more] (https://vega.github.io/vega-lite/docs/fold.html)

```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "transform": [{"fold": ["Open", "Close"]}],
  "width": 400,
  "height": 300,
  "mark": {"type" :"line", "tooltip": true},
  "encoding": {        
    "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},   
    "y": {"field": "value", "type": "quantitative", "aggregate":"mean"},
  }
}
```
Why only one line? Where is the other (Open vs. Close). We need `color`.

```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "transform": [{"fold": ["Open", "Close"]}],
  "width": 400,
  "height": 300,
  "mark": {"type" :"line", "tooltip": true},
  "encoding": {        
    "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},   
    "y": {"field": "value", "type": "quantitative", "aggregate":"mean"},
    "color": {"field": "key"},
  }
}
```

Can you see two lines? Too close, right? Let's change the representation from lines to bars. 
```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "transform": [{"fold": ["Open", "Close"]}],
  "width": 400,
  "height": 300,
  "mark": {"type" :"bar", "tooltip": true},
  "encoding": {        
    "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},   
    "y": {"field": "value", "type": "quantitative", "aggregate":"mean"},
    "color": {"field": "key"},
  }
}
```

Any better? Not really. Let's split the graph.

# Rows and Columns
```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "transform": [{"fold": ["Open", "Close"]}],
  "width": 400,
  "height": 300,
  "mark": {"type" :"bar", "tooltip": true},
  "encoding": {        
    "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},   
    "y": {"field": "value", "type": "quantitative", "aggregate":"mean"},
    "color": {"field": "key"},
    "column": {"field": "key", "type": "nominal"},
  }
}
```
Hard to compare? Let's get back to `line` mark to see the trend.
```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "transform": [{"fold": ["Open", "Close"]}],
  "width": 400,
  "height": 300,
  "mark": {"type" :"line", "tooltip": true},
  "encoding": {        
    "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},   
    "y": {"field": "value", "type": "quantitative", "aggregate":"mean"},
    "color": {"field": "key"},
    "column": {"field": "key", "type": "nominal"},
  }
}
```

Nice. We need a reference line to compare. What is a good reference? A `mean` line? Let's try.

# Overlay: Layers and Rules
Here is a snippet for two layers
```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "transform": [{"fold": ["Open", "Close"]}],
  "width": 400,
  "height": 300,

  "layers": [
    { },
    { },
  ]
}
```

Let's complete the above snippet: 



Facet, repeat, layer

# mark type: rule
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  
  "layer":
  [
    {
      // "mark": "line",
      "mark": {"type" :"line", "tooltip": true},
      // "mark": {"type" :"area", "tooltip": true},
      "width": 500,
      "height": 300,
      // "transform": [{"fold": ["Open", "Close"]}],

      "encoding": {
        // "x": {"field": "Date"},
        // "x": {"field": "Date", "type": "temporal"},
        "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},
        // "y": {"field": "Open"},
        // "y": {"field": "Open", "type": "quantitative"},
        "y": {"field": "Open", "type": "quantitative", "aggregate":"mean"},
        // "y": {"field": "value", "type": "quantitative"},
        // "y": {"field": "value", "type": "quantitative", "aggregate":"mean"},
        // "y": {"field": ["Open", "Close"], "type": "quantitative"},
        // "y": {"field": "Open", "type": "quantitative", "aggregate": "mean"}, 
        // "tooltip": {"field": "Open", "type": "quantitative"},      
        // "color": {"field": "key", "type": "nominal"},
        // "column": {"field": "key", "type": "nominal"},
      }
    },
    {
    "mark": {"type" :"rule"},
    "encoding": {        
        "y": {"field": "Open", "type": "quantitative", "aggregate":"mean"},        
        "color": {"value":"red"},
        "size" : {"value":2.0},
      },
    }
  ],

}




## repeat rows
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "width": 500,
  "height": 300,
 
  "repeat":
  {
    "column": ["Open", "Close"],
  },
  "spec":
    {
      "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
      // "transform": [{"fold": ["Open", "Close"]}],

      // "mark": "line",
      // "mark": {"type" :"line", "tooltip": true},
      "mark": {"type" :"area", "tooltip": true},

      "encoding": {
        // "x": {"field": "Date"},
        // "x": {"field": "Date", "type": "temporal"},
        "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},
        // "y": {"field": "Open"},
        // "y": {"field": "Open", "type": "quantitative"},
        // "y": {"field": "Open", "type": "quantitative", "aggregate":"mean"},
        // "y": {"field": "value", "type": "quantitative"},
        // "y": {"field": "value", "type": "quantitative", "aggregate":"mean"},
        "y": {"field": {"repeat": "column"},  "type": "quantitative", "aggregate":"mean"},

        // "y": {"field": ["Open", "Close"], "type": "quantitative"},
        // "y": {"field": "Open", "type": "quantitative", "aggregate": "mean"}, 
        // "tooltip": {"field": "Open", "type": "quantitative"},      
        // "color": {"field": "key", "type": "nominal"},
        // "column": {"field": "key", "type": "nominal"},
      }
    },
 }

## layer approach:
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "width": 500,
  "height": 300,
 
  "layer":
  [
    {
      "mark": {"type" :"line", "tooltip": true},
      // "mark": {"type" :"area", "tooltip": true},
      "encoding": {
        "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},        
        "y": {"field": "Open", "type": "quantitative", "aggregate":"mean"},
        "color" :{"value": "blue"},
      }
    },
    {
      "mark": {"type" :"line", "tooltip": true},
      // "mark": {"type" :"area", "tooltip": true},
      "encoding": {
        "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},        
        "y": {"field": "Close", "type": "quantitative", "aggregate":"min"},
        "color" :{"value": "red"},
      }
    }
  ],

}

# scatter plot matrix
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  // "width": 500,
  // "height": 300,
 
  "repeat":
  {
    "column": ["Open", "Close"],
    "row": ["Open", "Close"],
  },
  "spec":
    {
      "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
      "mark": {"type" :"line", "tooltip": true},
      "encoding": {
        "x": {"field": {"repeat": "column"}, "type": "quantitative" },
        "y": {"field": {"repeat": "row"},  "type": "quantitative"},

      }
    },
 }

## selection

{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "width": 500,
  "height": 300,
 
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  
  "params": [{
    "name": "pts", 
    // "select" : {"type": "point"},
    // "select" : {"type": "point", "resolve": "global"},
    // "select" : {"type": "point", "on":"mouseover"},
    "select" : {"type": "interval"}
  }],  

  "mark": {"type" :"circle"},
  "encoding": {
    "x": {
      "field": "Date", 
      "type": "temporal", 
      "timeUnit":"week",       
    },
    
    "y": {
      "field": "Open", 
       "type": "quantitative", 
       "aggregate":"mean",
      //  "scale":{"domain": [100, 230]}
    },

    "color": {
      "condition":{
        "param": "pts",         
        "value": "orange",          
      },
      "value": "grey",            
    },

    "size":{      
      "condition":{
        "param": "pts", 
        "value": 200,
      },
      "value": 40,      
    },    
  }
 }

## 
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "width": 500,
  "height": 300,
 
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  
  "params": [{
    "name": "pts", 
    // "select" : {"type": "point"},
    // "select" : {"type": "point", "resolve": "global"},
    // "select" : {"type": "point", "on":"mouseover"},
    "select" : {"type": "interval"}
  }],  

  "mark": {"type" :"circle"},
  "encoding": {
    "x": {
      "field": "Date", 
      "type": "temporal", 
      "timeUnit":"week",       
    },
    
    "y": {
      "field": "Open", 
       "type": "quantitative", 
       "aggregate":"mean",
      //  "scale":{"domain": [100, 230]}
    },

    "color": {
      "condition":{
        "param": "pts",         
        "value": "orange",          
      },
      "value": "grey",            
    },

    "size":{      
      "condition":{
        "param": "pts", 
        "value": 200,
      },
      "value": 40,      
    },    
  }
 }
