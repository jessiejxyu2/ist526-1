# Online Editor 
[Editor](https://vega.github.io/editor/#/custom/vega-lite)

# Data source
https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv

## Data description
The dataset contains Facebook's daily stock price from June 2019 to June 2020. There are 7 columns: Date, Open, High, Low, Close, Adj Close, Volume. 
Take a look at the data: https://github.com/smbillah/ist526/blob/main/FB_data.csv


# Simple visualization:
## A line graph 

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

Looks messy, right? Let's fix the height and the width.


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

Circles are not good. Let try bars. 

```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "width": 400,
  "height": 300,
  "mark": {"type" :"bar", "tooltip": true},
  "encoding": {        
    "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},
    "y": {"field": "Open", "type": "quantitative", "aggregate": "mean"},
  }
}
```

Can you transpose the bars? Easy-peesy. Just swap the axes.

```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "width": 400,
  "height": 300,
  "mark": {"type" :"bar", "tooltip": true},
  "encoding": {        
    "y": {"field": "Date", "type": "temporal", "timeUnit":"month"},
    "x": {"field": "Open", "type": "quantitative", "aggregate": "mean"},
  }
}
```

Since we are interested in trend, let's switch to `line` again.
```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "width": 400,
  "height": 300,
  "mark": {"type" :"bar", "tooltip": true},
  "encoding": {        
    "y": {"field": "Date", "type": "temporal", "timeUnit":"month"},
    "x": {"field": "Open", "type": "quantitative", "aggregate": "mean"},
  }
}
```


# Overlay: Layers and Rules
Often, we need a reference line to compare. What is a good reference? A `mean` line? Let's try it.
We will add the reference line as a layer. Here is a snippet for two layers

```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},  
  "width": 400,
  "height": 300,

  "layers": [
    { },
    { },
  ]
}
```

Let's complete the above snippet: 
```
{
  "width": 400,
  "height": 300,
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},

  "layer": [ 
    {
      "mark": {"type" :"line", "tooltip": true},
      "encoding": {        
        "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},   
        "y": {"field": "Open", "type": "quantitative", "aggregate":"mean"},
        
      }
    },
    {
      "mark": {"type" :"rule"},
      "encoding": {        
        "y": {"field": "Open", "type": "quantitative", "aggregate":"mean"},                
      },
    }, 
  ],
}
```
The rule is pretty bland. How do I change the color and size of this `rule`. 
Use `color` and `size` attributes with `value` field. See below:

```
{
  "width": 400,
  "height": 300,
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},

  "layer": [ 
    {
      "mark": {"type" :"line", "tooltip": true},
      "encoding": {        
        "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},   
        "y": {"field": "Open", "type": "quantitative", "aggregate":"mean"},
        
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
```

Can you add another layer with a green `max` line. Why not? Let's try:
```
{
  "width": 400,
  "height": 300,
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},

  "layer": [ 
    {
      "mark": {"type" :"line", "tooltip": true},
      "encoding": {        
        "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},   
        "y": {"field": "Open", "type": "quantitative", "aggregate":"mean"},
        
      }
    },
    {
      "mark": {"type" :"rule"},
      "encoding": {        
        "y": {"field": "Open", "type": "quantitative", "aggregate":"mean"},        
        "color": {"value":"red"},
        "size" : {"value":2.0},
      },
    },
    {
      "mark": {"type" :"rule"},
      "encoding": {        
        "y": {"field": "Open", "type": "quantitative", "aggregate":"max"},        
        "color": {"value":"green"},
        "size" : {"value":2.0},
      },
    }, 
  ],
}
```



# Facet, Repeat, Rows and Columns
## Tabular format vs Long format [Multiple lines]
### Why is it necessary? 
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
Why only one line? Where is the other (Open vs. Close). We need `color`, a pre-attentive variable, to separate them.

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

How do I add a reference line to all rows and columns? Well, we can do it by layers, right? Unfortunately, not. Vega-lite does not support rows/columns in layers. We need to use `facets` instead. 

```
{
  "facet": {
    ... // Facet definition
  },
  "spec": ...  // Specification
}
```

Here is a complete example:
```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "transform": [{"fold": ["Open", "Close"]}],
  "width": 400,
  "height": 300,

  "facet": {"column": {"field": "key"}},
  "spec": {
    "mark": {"type" :"line", "tooltip": true},
    "encoding": {        
      "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},   
      "y": {"field": "value", "type": "quantitative", "aggregate":"mean"},
      "color": {"field": "key"},      
    }
  }
}
```

Great! Can we add a reference line now? Yes. Check it out.
```
{
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  "transform": [{"fold": ["Open", "Close"]}],
  "width": 400,
  "height": 300,

  "facet": {"column": {"field": "key"}},
  "spec": {
    "layer": [
      {
        "mark": {"type" :"line", "tooltip": true},
        "encoding": {        
          "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},   
          "y": {"field": "value", "type": "quantitative", "aggregate":"mean"},
          "color": {"field": "key"},          
        }
      },
      {        
        "mark": {"type" :"rule"},
        "encoding": {        
          "y": {"field": "value", "type": "quantitative", "aggregate":"max"},        
          "color": {"value":"green"},
          "size" : {"value":1.0},
        }
      },      
    ],
  }
}
```


## Repeat Rows and Columns
`repeat` is similar to `facet`. However, a `facet` locks an axis (either X or Y) for all data points in sub-plots but a `repeat` does not. In other words, sub-plots in a `facet` are dependent, but they are independent in a `repeat`.

The template for a `repeat` is as follows:
```
{
  "repeat": {
    ... // Repeat definition
  },
  "spec": ... // Specification
}
```

Here is an example:
```
{
  "width": 500,
  "height": 300,
 
  "repeat":
  {
    "column": ["Open", "Close"],
  },
  "spec":
    {
      "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
      
      "mark": {"type" :"line", "tooltip": true},
      "encoding": {
        "x": {"field": "Date", "type": "temporal", "timeUnit":"month"},
        "y": {"field": {"repeat": "column"},  "type": "quantitative", "aggregate":"mean"},
      }
    },
 }

```



# Scatter plot matrix
Repeat is a powerful operator. It can be used to create a scatter-plot matrix. 

```
{
   "width": 500,
   "height": 500,
 
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

```

# Interaction: Selection
Interaction makes data alive. The basic template for an interaction is as follows:
```
// A Single View Specification
{
  ...,
  "params": [  // An array of named parameters.
    {
      "name": ...,
      "select": { // Selection
        "type": ...,
        ...
      }
    }
  ],
  "mark": ...,
  "encoding": ...,
  ...
}
```
For example, the following code selects a point on mouse click.
```
{  
  "width": 500,
  "height": 300,
 
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  
  "params": [{
    "name": "anything", 
    "select" : {"type": "point"},
  }],  

  "mark": {"type" :"circle"},
  "encoding": {
    "x": {
      "field": "Date", 
      "type": "temporal", 
      "timeUnit":"month",       
    },
    
    "y": {
      "field": "Open", 
       "type": "quantitative", 
       "aggregate":"mean",      
    },
  }
 }

```
It is hardly useful, isn't? Why? Because we did not change the color or size to indicate our selection. Let's add those two attributes:
```
{  
  "width": 500,
  "height": 300,
 
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  
  "params": [{
    "name": "anything", 
    "select" : {"type": "point"},
  }],  

  "mark": {"type" :"circle"},
  "encoding": {
    "x": {
      "field": "Date", 
      "type": "temporal", 
      "timeUnit":"month",       
    },
    
    "y": {
      "field": "Open", 
       "type": "quantitative", 
       "aggregate":"mean",      
    },
    "color": {
      "condition":{
        "param": "anything",         
        "value": "orange",          
      },
      "value": "grey",            
    },

    "size":{      
      "condition":{
        "param": "anything", 
        "value": 200,
      },
      "value": 40,      
    },   
  }
 }

```

See the difference? We also update our selection from a single point to a range. 
```
{  
  "width": 500,
  "height": 300,
 
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},
  
  "params": [{
    "name": "anything", 
    "select" : {"type": "interval"},
  }],  

  "mark": {"type" :"circle"},
  "encoding": {
    "x": {
      "field": "Date", 
      "type": "temporal", 
      "timeUnit":"month",       
    },
    
    "y": {
      "field": "Open", 
       "type": "quantitative", 
       "aggregate":"mean",      
    },
    "color": {
      "condition":{
        "param": "anything",         
        "value": "orange",          
      },
      "value": "grey",            
    },

    "size":{      
      "condition":{
        "param": "anything", 
        "value": 200,
      },
      "value": 40,      
    },   
  }
 }

```
Draw a region with your mouse to see the effect. 

## Interaction with `repeat`
When `interaction` happens within `repeat` or `facet` the `params` attribute becomes a part of the `spec` attribute. Also, we need to specify `resolve` field. See [more](https://vega.github.io/vega-lite/docs/selection.html).
Here is our running example:

```
{  
  "width": 500,
  "height": 500,
  
  "data": {"url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"},  

  "repeat": {
    "column": ["Open", "Close"],
    "row": ["Open", "Close"],
  },

  "spec":{
      "params": [{
        "name": "anything", 
        "select" : {"type": "interval", "resolve":"global"},
      }],  

    "mark": {"type" :"circle", "tooltip": true},

    "encoding": {
      "x": {"field": {"repeat": "column"}, "type": "quantitative" },
      "y": {"field": {"repeat": "row"},  "type": "quantitative"},    

      "color": {
        "condition":{
          "param": "anything",         
          "value": "orange",          
        },
        "value": "grey",            
      },

      "size":{      
          "condition":{
            "param": "anything", 
            "value": 200,
          },
          "value": 40,      
      },   
    }
  },
 }

```

# Dashboard: Concatenation
A dashboard is a collection of multiple visualization put together logically. We can use vertial or horizontal concatenation operator to do so.
Here is the template:

```
{
  "vconcat": [
    {},
    {},
  ],
  ...
}
```

or 
```
{
  "hconcat": [
    {},
    {}
  ],
  
}
```

Let's try an example by putting two of our previous graphs together.

```
{
  "vconcat": [
    {
      "data": {
        "url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"
      },
      "width": 400,
      "height": 300,
      "mark": {"type": "line", "tooltip": true},
      "encoding": {
        "x": {"field": "Date", "type": "temporal", "timeUnit": "month"},
        "y": {"field": "Open", "type": "quantitative", "aggregate": "mean"}
      }
    },
    {
      "width": 500,
      "height": 500,
      "data": {
        "url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"
      },
      "repeat": {"column": ["Open", "Close"], "row": ["Open", "Close"]},
      "spec": {
        "params": [
          {
            "name": "anything",
            "select": {"type": "interval", "resolve": "global"}
          }
        ],
        "mark": {"type": "circle", "tooltip": true},
        "encoding": {
          "x": {"field": {"repeat": "column"}, "type": "quantitative"},
          "y": {"field": {"repeat": "row"}, "type": "quantitative"},
          "color": {
            "condition": {"param": "anything", "value": "orange"},
            "value": "grey"
          },
          "size": {
            "condition": {"param": "anything", "value": 200},
            "value": 40
          }
        }
      }
    }
  ]
}
```

# Filter
[Filter guide](https://vega.github.io/vega-lite/docs/filter.html)
Key idea: (1) use a placeholder, `datum`, to refer to data (e.g., `{"filter": "datum.b2 > 60"}`) and (2) use a boolean predicate that returns True or False.

Supported boolean operations are  `equal`, `lt`, `lte`, `gt`, `gte`, `range`, `oneOf`, or `valid` (e.g., `{"timeUnit": "year", "field": "Year", "lte": "2000"}`).

`filter` needs a `transform` operation. 


```
{
  "data": {
    "url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"
  },
  "width": 400,
  "height": 300,
  "mark": {"type": "circle", "tooltip": true, "clip": true},
  "transform": [{"filter": "datum.Open < 180"}],
  "encoding": {
    "x": {"field": "Date", "type": "temporal"},
    "y": {"field": "Open", "type": "quantitative"}
  }
}

```

or,
```
{
  "data": {
    "url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"
  },
  "width": 400,
  "height": 300,
  "mark": {"type": "circle", "tooltip": true, "clip": true},
  "transform": [{"filter": {"field": "Open", "lt": 180}}],
  "encoding": {
    "x": {"field": "Date", "type": "temporal"},
    "y": {"field": "Open", "type": "quantitative"}
  }
}

```

How do I use multiple filters? Note that the date time field is problematic to use. Check out the following examples:
```
{
  "data": {
    "url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"
  },
  "width": 400,
  "height": 300,
  "mark": {"type": "circle", "tooltip": true, "clip": true},
  "transform": [
    {"timeUnit": "yearmonthdate", "field": "Date", "as": "Date"},
    {"filter": " (datum.Open > 160)"},
    {"filter": " (datum.Open < 180)"},
    {"filter": {"field": "Date", "lt": {"year": 2019, "month": 12, "date": 21}}}
  ],
  "encoding": {
    "x": {"field": "Date", "type": "temporal"},
    "y": {"field": "Open", "type": "quantitative"}
  }
}
```

Note that we used multiple `filter` parameters within `transform` to apply them all at once. 

```
{
  "data": {
    "url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"
  },
  "width": 400,
  "height": 300,
  "mark": {"type": "circle", "tooltip": true, "clip": true},
  "transform": [
    {
      "filter": {
        "and": [
          {"field": "Open", "lt": 150},
          {"field": "Date", "lt": {"year": 2022, "month": "jun", "date": 1}}
        ]
      }
    }
  ],
  "encoding": {
    "x": {"field": "Date", "type": "temporal"},
    "y": {"field": "Open", "type": "quantitative"}
  }
}
```


or

A more complicated filter is as follows:
```
{
  "data": {
    "url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"
  },
  "width": 400,
  "height": 300,
  "mark": {"type": "circle", "tooltip": true, "clip": true},
  "transform": [
    {
      "filter": {
        "and": [
          {"field": "Open", "lt": 180},
          {"field": "Date", "gt": {"year": 2019, "month": "jun", "date": 1}}
        ]
      }
    }
  ],
  "encoding": {
    "x": {"field": "Date", "type": "temporal"},
    "y": {"field": "Open", "type": "quantitative"}
  }
}
```

Since `filter` can be used with a `selection`, it can go with a parameter ,`params`, to set up. 
Furthermore, without using `filter`, we can change the values of `x` and `y` by using `"scale" : {"domain": [start, end]}` for input data. Note that `range' is used for selecting output span, which is different.   


More examples:
```
{
  "data": {
    "url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"
  },
  "width": 400,
  "height": 300,
  "transform": [
    {"timeUnit": "yearmonthdate", "field": "Date", "as": "Date"},
    {"filter": " (datum.Open > 160)"},
    {"filter": " (datum.Open < 280)"},
    {"filter": {"field": "Date", "lt": {"year": 2019, "month": 12, "date": 21}}}
  ],
  "layer": [
    {
      "mark": {"type": "circle", "tooltip": true, "clip": true},
      "encoding": {
        "x": {"field": "Date", "type": "temporal"},
        "y": {"field": "Open", "type": "quantitative"}
      }
    },
    {
      "mark": {"type": "bar", "tooltip": true, "clip": true},
      "encoding": {
        "x": {"field": "Date", "type": "temporal", "bin":true},
        "y": {"aggregate": "count", "type": "quantitative"}
      }
    }
  ]
}
```

An interactive version of the same graph:
```
{
  "data": {
    "url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"
  },
  "width": 400,
  "height": 300,
  "transform": [
    {"timeUnit": "yearmonthdate", "field": "Date", "as": "Date"},
    {"filter": " (datum.Open > 160)"},
    {"filter": " (datum.Open < 280)"},
    {"filter": {"field": "Date", "lt": {"year": 2019, "month": 12, "date": 21}}}
  ],
  "layer": [
    {
      "params": [{"name": "pts", "select": {"type": "interval"}}],
      "mark": {"type": "circle", "tooltip": true, "clip": true},
      "encoding": {
        "x": {"field": "Date", "type": "temporal"},
        "y": {"field": "Open", "type": "quantitative"}
      }
    },
    {
      "mark": {"type": "bar", "tooltip": true, "clip": true},
      "transform": [{"filter": {"param": "pts"}}],
      "encoding": {
        "x": {"field": "Date", "type": "temporal", "bin": true},
        "y": {"aggregate": "count", "type": "quantitative"}
      }
    }
  ]
}
```

```
{
  "vconcat": [
    {
      "data": {
        "url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"
      },
      "width": 400,
      "height": 300,
      "params": [
        {"name": "pts", "select": {"type": "interval", "encodings": ["x"],  "resolve": "global"}}
      ],
      "mark": {"type": "line", "tooltip": true},
      "encoding": {
        "x": {"field": "Date", "type": "temporal", "timeUnit": "month"},
        "y": {"field": "Open", "type": "quantitative", "aggregate": "mean"}
      }
    },
    {
      "width": 500,
      "height": 500,
      "data": {
        "url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"
      },
      "transform": [{"filter": {"param": "pts"}}],
      "repeat": {"column": ["Open", "Close"], "row": ["Open", "Close"]},
      "spec": {
        "mark": {"type": "circle", "tooltip": true},
        "encoding": {
          "x": {"field": {"repeat": "column"}, "type": "quantitative"},
          "y": {"field": {"repeat": "row"}, "type": "quantitative"}
        }
      }
    }
  ]
}
```

overview+detail
```
{
  "vconcat": [
    {
      "data": {
        "url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"
      },
      "width": 400,
      "height": 300,
      "params": [
        {
          "name": "pts",
          "select": {
            "type": "interval",
            "encodings": ["x"],
            "resolve": "global"
          }
        }
      ],
      "mark": {"type": "line", "tooltip": true},
      "encoding": {
        "x": {"field": "Date", "type": "temporal", "timeUnit": "month"},
        "y": {"field": "Open", "type": "quantitative", "aggregate": "mean"}
      }
    },
    {
      "width": 500,
      "height": 500,
      "data": {
        "url": "https://raw.githubusercontent.com/smbillah/ist526/main/FB_data.csv"
      },
      "transform": [{"filter": {"param": "pts"}}],
      "mark": {"type": "area", "tooltip": true},
      "encoding": {
        "x": {"field": "Date", "type": "temporal", "timeUnit": "day"},
        "y": {"field": "Open", "type": "quantitative", "aggregate": "mean"}
      }
    }
  ]
}
```


If you've made this far, congratuations! You now have working knowledge with vega-lite now. 
