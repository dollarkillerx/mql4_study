package main

import (
	"github.com/gin-gonic/gin"
)

type content struct {
	Content string `json:"content"`
}

func main() {
	app := gin.Default()

	v1 := app.Group("v1")
	{
		v1.POST("/vp", func(ctx *gin.Context) {
			var cont content

			err := ctx.BindJSON(&cont)
			if err != nil {
				panic(err)
			}

			ctx.JSON(200, gin.H{
				"firstName": "XXXXX",
				"content":   cont.Content,
			})
		})
	}

	if err := app.Run(":80"); err != nil {
		return
	}
}
