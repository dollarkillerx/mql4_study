package main

import (
	"fmt"
	"log"

	cfg "github.com/dollarkillerx/common/pkg/config"
	"github.com/gin-gonic/gin"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

// 写的太乱了 真的非常抱歉

type Content struct {
	User       int     `json:"user"`
	Balance    float64 `json:"balance"`
	Profit     float64 `json:"profit"`
	Percentage float64 `json:"percentage"`
	Server     string  `json:"server"`
}

func main() {
	app := gin.Default()

	router(app)

	if err := app.Run(":80"); err != nil {
		return
	}
}

func router(app *gin.Engine) {
	v1 := app.Group("v1")
	{
		v1.POST("/vp", func(ctx *gin.Context) {
			var cont Content

			err := ctx.BindJSON(&cont)
			if err != nil {
				panic(err)
			}

			go func() {
				if err := pgsql.Model(&PsModel{}).Create(&PsModel{
					User:       cont.User,
					Balance:    cont.Balance,
					Profit:     cont.Profit,
					Percentage: cont.Percentage,
					Server:     cont.Server,
				}).Error; err != nil {
					log.Println(err)
				}
			}()

			ctx.String(200, "success")
		})
	}
}

var pgsql *gorm.DB

func init() {
	fmt.Println("Init Server")
	// init pgsql
	pg, err := InitPostgres(cfg.PostgresConfiguration{})
	if err != nil {
		panic(err)
	}

	pgsql = pg

	pgsql.AutoMigrate(&PsModel{})
}

type PsModel struct {
	gorm.Model
	User       int     `json:"user"`
	Balance    float64 `json:"balance"`
	Profit     float64 `json:"profit"`
	Percentage float64 `json:"percentage"`
	Server     string  `json:"server"`
}

// InitPostgres ...
func InitPostgres(config cfg.PostgresConfiguration) (db *gorm.DB, err error) {
	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=disable TimeZone=Asia/Shanghai", config.Host, config.User, config.Password, config.DBName, config.Port)
	db, err = gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		return nil, err
	}

	sqlDB, err := db.DB()
	if err != nil {
		return nil, err
	}

	sqlDB.SetMaxIdleConns(30)
	sqlDB.SetMaxOpenConns(100)

	return db, nil
}
