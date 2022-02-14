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
	Leverage   int     `json:"leverage"` // 账户杠杆
	Margin     float64 `json:"margin"`   // 已用保证金
}

func main() {
	app := gin.Default()

	router(app)

	if err := app.Run(":8147"); err != nil {
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

			fmt.Println(cont)

			go func() {
				if err := pgsql.Model(&PsModel{}).Create(&PsModel{
					User:       cont.User,
					Balance:    cont.Balance,
					Profit:     cont.Profit,
					Percentage: cont.Percentage,
					Server:     cont.Server,
					Leverage:   cont.Leverage,
					Margin:     cont.Margin,
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
	pg, err := InitPostgres(cfg.PostgresConfiguration{
		Host:     "43.135.75.195",
		Port:     "5433",
		User:     "dollarkiller",
		Password: "H3vuyZ5ri",
		DBName:   "monitor",
	})
	if err != nil {
		panic(err)
	}

	pgsql = pg

	pgsql.AutoMigrate(&PsModel{})
}

type PsModel struct {
	gorm.Model
	User       int     `json:"user"`       // 用户
	Balance    float64 `json:"balance"`    // 利润
	Profit     float64 `json:"profit"`     // 余额
	Percentage float64 `json:"percentage"` // 浮亏
	Server     string  `json:"server"`     // 服务器
	Leverage   int     `json:"leverage"`   // 账户杠杆
	Margin     float64 `json:"margin"`     // 已用保证金
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
