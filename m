Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44DF2903F8
	for <lists+linux-can@lfdr.de>; Fri, 16 Aug 2019 16:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfHPOaw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Aug 2019 10:30:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33464 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfHPOaw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Aug 2019 10:30:52 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7GEUjp5074832;
        Fri, 16 Aug 2019 09:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565965845;
        bh=7lKssptxIOAxitELB4UZ1mLlD0h0uMm5uv2xr9vLOXo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WzMDpI3wUCkaqZw5L6hVHmHAmo2OosH3xdPNO68fE2/aeMAEVxHySh/1F7F6WtbDe
         86VQ4T4lbBsiHWJGYzG+Pt/9He9wFhLpRCN1Xx2FeKddDQN428CJ3WVGaE/RTPfryq
         sZEztaXs6Y+5Z7pFJEDXvkVdO3U3J8RPDnVuyz/o=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7GEUjxG049418
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Aug 2019 09:30:45 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 16
 Aug 2019 09:30:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 16 Aug 2019 09:30:44 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7GEUi63068543;
        Fri, 16 Aug 2019 09:30:44 -0500
Subject: Re: [PATCH v12 4/5] can: tcan4x5x: Add tcan4x5x driver to the kernel
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>
References: <20190509161109.10499-1-dmurphy@ti.com>
 <20190509161109.10499-4-dmurphy@ti.com>
 <f6a07c62-3a2b-85a9-b402-0283ace18222@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <c63547d2-4e4a-efd4-e568-fe6624ba96e6@ti.com>
Date:   Fri, 16 Aug 2019 09:30:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f6a07c62-3a2b-85a9-b402-0283ace18222@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

Thanks for the review

On 8/16/19 4:43 AM, Marc Kleine-Budde wrote:
> On 5/9/19 6:11 PM, Dan Murphy wrote:
>> Add the TCAN4x5x SPI CAN driver.  This device uses the
>> Bosch MCAN IP core along with a SPI interface map.
>> Register to the MCAN common core code to manage the MCAN IP.
>>
>> This device has a special method to indicate a write/read
>> operation on the data payload.
>>
>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>
>> v12 - No changes - https://lore.kernel.org/patchwork/patch/1052301/
>>
>> v11 - No changes - https://lore.kernel.org/patchwork/patch/1051180/
>> v10 - No changes - https://lore.kernel.org/patchwork/patch/1050490/
>> v9 - No changes - https://lore.kernel.org/patchwork/patch/1050119/
>> v8 - No changes - https://lore.kernel.org/patchwork/patch/1047978/
>> v7 - Fixed remaining checkpatch issues and renamed callbacks for m_can change -
>> https://lore.kernel.org/patchwork/patch/1047221/
>> v6 - Updated Kconfig help and added REGMAP_SPI dependency, fixed coding style issues,
>> removed setting GPIO high in wake routine, change -EIO to return ret in init and
>> setup functions - https://lore.kernel.org/patchwork/patch/1042443/
>>
>>   drivers/net/can/m_can/Kconfig    |   9 +
>>   drivers/net/can/m_can/Makefile   |   1 +
>>   drivers/net/can/m_can/tcan4x5x.c | 533 +++++++++++++++++++++++++++++++
>>   3 files changed, 543 insertions(+)
>>   create mode 100644 drivers/net/can/m_can/tcan4x5x.c
>>
>> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
>> index f7119fd72df4..cf4f32765efa 100644
>> --- a/drivers/net/can/m_can/Kconfig
>> +++ b/drivers/net/can/m_can/Kconfig
>> @@ -12,3 +12,12 @@ config CAN_M_CAN_PLATFORM
>>   	  Say Y here if you want support for IO Mapped Bosch M_CAN controller.
>>   	  This support is for devices that have the Bosch M_CAN controller
>>   	  IP embedded into the device and the IP is IO Mapped to the processor.
>> +
>> +config CAN_M_CAN_TCAN4X5X
>> +	depends on CAN_M_CAN
>> +	depends on REGMAP_SPI
>> +	tristate "TCAN4X5X M_CAN device"
>> +	---help---
>> +	  Say Y here if you want support for Texas Instruments TCAN4x5x
>> +	  M_CAN controller.  This device is a peripherial device that uses the
>> +	  SPI bus for communication.
>> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
>> index 057bbcdb3c74..e77f0eccff97 100644
>> --- a/drivers/net/can/m_can/Makefile
>> +++ b/drivers/net/can/m_can/Makefile
>> @@ -4,3 +4,4 @@
>>   
>>   obj-$(CONFIG_CAN_M_CAN) += m_can.o
>>   obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
>> +obj-$(CONFIG_CAN_M_CAN_TCAN4X5X) += tcan4x5x.o
>> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
>> new file mode 100644
>> index 000000000000..411502c3c98e
>> --- /dev/null
>> +++ b/drivers/net/can/m_can/tcan4x5x.c
>> @@ -0,0 +1,533 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// SPI to CAN driver for the Texas Instruments TCAN4x5x
>> +// Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
>> +
>> +#include <linux/regmap.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/gpio/consumer.h>
>> +
>> +#include "m_can.h"
>> +
>> +#define DEVICE_NAME "tcan4x5x"
>> +#define TCAN4X5X_EXT_CLK_DEF	40000000
>> +
>> +#define TCAN4X5X_DEV_ID0	0x00
>> +#define TCAN4X5X_DEV_ID1	0x04
>> +#define TCAN4X5X_REV		0x08
>> +#define TCAN4X5X_STATUS		0x0C
>> +#define TCAN4X5X_ERROR_STATUS	0x10
>> +#define TCAN4X5X_CONTROL	0x14
>> +
>> +#define TCAN4X5X_CONFIG		0x800
>> +#define TCAN4X5X_TS_PRESCALE	0x804
>> +#define TCAN4X5X_TEST_REG	0x808
>> +#define TCAN4X5X_INT_FLAGS	0x820
>> +#define TCAN4X5X_MCAN_INT_REG	0x824
>> +#define TCAN4X5X_INT_EN		0x830
>> +
>> +/* Interrupt bits */
>> +#define TCAN4X5X_CANBUSTERMOPEN_INT_EN	BIT(30)
>> +#define TCAN4X5X_CANHCANL_INT_EN	BIT(29)
>> +#define TCAN4X5X_CANHBAT_INT_EN		BIT(28)
>> +#define TCAN4X5X_CANLGND_INT_EN		BIT(27)
>> +#define TCAN4X5X_CANBUSOPEN_INT_EN	BIT(26)
>> +#define TCAN4X5X_CANBUSGND_INT_EN	BIT(25)
>> +#define TCAN4X5X_CANBUSBAT_INT_EN	BIT(24)
>> +#define TCAN4X5X_UVSUP_INT_EN		BIT(22)
>> +#define TCAN4X5X_UVIO_INT_EN		BIT(21)
>> +#define TCAN4X5X_TSD_INT_EN		BIT(19)
>> +#define TCAN4X5X_ECCERR_INT_EN		BIT(16)
>> +#define TCAN4X5X_CANINT_INT_EN		BIT(15)
>> +#define TCAN4X5X_LWU_INT_EN		BIT(14)
>> +#define TCAN4X5X_CANSLNT_INT_EN		BIT(10)
>> +#define TCAN4X5X_CANDOM_INT_EN		BIT(8)
>> +#define TCAN4X5X_CANBUS_ERR_INT_EN	BIT(5)
>> +#define TCAN4X5X_BUS_FAULT		BIT(4)
>> +#define TCAN4X5X_MCAN_INT		BIT(1)
>> +#define TCAN4X5X_ENABLE_TCAN_INT	(TCAN4X5X_MCAN_INT | \
>> +					TCAN4X5X_BUS_FAULT | \
>> +					TCAN4X5X_CANBUS_ERR_INT_EN | \
>> +					TCAN4X5X_CANINT_INT_EN)
>> +
>> +/* MCAN Interrupt bits */
>> +#define TCAN4X5X_MCAN_IR_ARA		BIT(29)
>> +#define TCAN4X5X_MCAN_IR_PED		BIT(28)
>> +#define TCAN4X5X_MCAN_IR_PEA		BIT(27)
>> +#define TCAN4X5X_MCAN_IR_WD		BIT(26)
>> +#define TCAN4X5X_MCAN_IR_BO		BIT(25)
>> +#define TCAN4X5X_MCAN_IR_EW		BIT(24)
>> +#define TCAN4X5X_MCAN_IR_EP		BIT(23)
>> +#define TCAN4X5X_MCAN_IR_ELO		BIT(22)
>> +#define TCAN4X5X_MCAN_IR_BEU		BIT(21)
>> +#define TCAN4X5X_MCAN_IR_BEC		BIT(20)
>> +#define TCAN4X5X_MCAN_IR_DRX		BIT(19)
>> +#define TCAN4X5X_MCAN_IR_TOO		BIT(18)
>> +#define TCAN4X5X_MCAN_IR_MRAF		BIT(17)
>> +#define TCAN4X5X_MCAN_IR_TSW		BIT(16)
>> +#define TCAN4X5X_MCAN_IR_TEFL		BIT(15)
>> +#define TCAN4X5X_MCAN_IR_TEFF		BIT(14)
>> +#define TCAN4X5X_MCAN_IR_TEFW		BIT(13)
>> +#define TCAN4X5X_MCAN_IR_TEFN		BIT(12)
>> +#define TCAN4X5X_MCAN_IR_TFE		BIT(11)
>> +#define TCAN4X5X_MCAN_IR_TCF		BIT(10)
>> +#define TCAN4X5X_MCAN_IR_TC		BIT(9)
>> +#define TCAN4X5X_MCAN_IR_HPM		BIT(8)
>> +#define TCAN4X5X_MCAN_IR_RF1L		BIT(7)
>> +#define TCAN4X5X_MCAN_IR_RF1F		BIT(6)
>> +#define TCAN4X5X_MCAN_IR_RF1W		BIT(5)
>> +#define TCAN4X5X_MCAN_IR_RF1N		BIT(4)
>> +#define TCAN4X5X_MCAN_IR_RF0L		BIT(3)
>> +#define TCAN4X5X_MCAN_IR_RF0F		BIT(2)
>> +#define TCAN4X5X_MCAN_IR_RF0W		BIT(1)
>> +#define TCAN4X5X_MCAN_IR_RF0N		BIT(0)
>> +#define TCAN4X5X_ENABLE_MCAN_INT	(TCAN4X5X_MCAN_IR_TC | \
>> +					TCAN4X5X_MCAN_IR_RF0N | \
>> +					TCAN4X5X_MCAN_IR_RF1N | \
>> +					TCAN4X5X_MCAN_IR_RF0F | \
>> +					TCAN4X5X_MCAN_IR_RF1F)
>> +#define TCAN4X5X_MRAM_START	0x8000
>> +#define TCAN4X5X_MCAN_OFFSET	0x1000
>> +#define TCAN4X5X_MAX_REGISTER	0x8fff
>> +
>> +#define TCAN4X5X_CLEAR_ALL_INT	0xffffffff
>> +#define TCAN4X5X_SET_ALL_INT	0xffffffff
>> +
>> +#define TCAN4X5X_WRITE_CMD	(0x61 << 24)
>> +#define TCAN4X5X_READ_CMD	(0x41 << 24)
>> +
>> +#define TCAN4X5X_MODE_SEL_MASK		(BIT(7) | BIT(6))
>> +#define TCAN4X5X_MODE_SLEEP		0x00
>> +#define TCAN4X5X_MODE_STANDBY		BIT(6)
>> +#define TCAN4X5X_MODE_NORMAL		BIT(7)
>> +
>> +#define TCAN4X5X_SW_RESET	BIT(2)
>> +
>> +#define TCAN4X5X_MCAN_CONFIGURED	BIT(5)
>> +#define TCAN4X5X_WATCHDOG_EN		BIT(3)
>> +#define TCAN4X5X_WD_60_MS_TIMER		0
>> +#define TCAN4X5X_WD_600_MS_TIMER	BIT(28)
>> +#define TCAN4X5X_WD_3_S_TIMER		BIT(29)
>> +#define TCAN4X5X_WD_6_S_TIMER		(BIT(28) | BIT(29))
>> +
>> +struct tcan4x5x_priv {
>> +	struct regmap *regmap;
>> +	struct spi_device *spi;
>> +	struct mutex tcan4x5x_lock; /* SPI device lock */
>> +
>> +	struct m_can_classdev *mcan_dev;
>> +
>> +	struct gpio_desc *reset_gpio;
>> +	struct gpio_desc *interrupt_gpio;
>> +	struct gpio_desc *device_wake_gpio;
>> +	struct gpio_desc *device_state_gpio;
>> +	struct regulator *power;
>> +
>> +	/* Register based ip */
>> +	int mram_start;
>> +	int reg_offset;
>> +};
>> +
>> +static struct can_bittiming_const tcan4x5x_bittiming_const = {
>> +	.name = DEVICE_NAME,
>> +	.tseg1_min = 2,
>> +	.tseg1_max = 31,
>> +	.tseg2_min = 2,
>> +	.tseg2_max = 16,
>> +	.sjw_max = 16,
>> +	.brp_min = 1,
>> +	.brp_max = 32,
>> +	.brp_inc = 1,
>> +};
>> +
>> +static struct can_bittiming_const tcan4x5x_data_bittiming_const = {
>> +	.name = DEVICE_NAME,
>> +	.tseg1_min = 1,
>> +	.tseg1_max = 32,
>> +	.tseg2_min = 1,
>> +	.tseg2_max = 16,
>> +	.sjw_max = 16,
>> +	.brp_min = 1,
>> +	.brp_max = 32,
>> +	.brp_inc = 1,
>> +};
>> +
>> +static void tcan4x5x_check_wake(struct tcan4x5x_priv *priv)
>> +{
>> +	int wake_state = 0;
>> +
>> +	if (priv->device_state_gpio)
>> +		wake_state = gpiod_get_value(priv->device_state_gpio);
>> +
>> +	if (priv->device_wake_gpio && wake_state) {
>> +		gpiod_set_value(priv->device_wake_gpio, 0);
>> +		usleep_range(5, 50);
>> +		gpiod_set_value(priv->device_wake_gpio, 1);
>> +	}
>> +}
>> +
>> +static int regmap_spi_gather_write(void *context, const void *reg,
>> +				   size_t reg_len, const void *val,
>> +				   size_t val_len)
>> +{
>> +	struct device *dev = context;
>> +	struct spi_device *spi = to_spi_device(dev);
>> +	struct spi_message m;
>> +	u32 addr;
>> +	struct spi_transfer t[2] = {
>> +		{ .tx_buf = &addr, .len = reg_len, .cs_change = 0,},
>> +		{ .tx_buf = val, .len = val_len, },
>> +	};
>> +
>> +	addr = TCAN4X5X_WRITE_CMD | (*((u16 *)reg) << 8) | val_len >> 3;
>> +
>> +	spi_message_init(&m);
>> +	spi_message_add_tail(&t[0], &m);
>> +	spi_message_add_tail(&t[1], &m);
>> +
>> +	return spi_sync(spi, &m);
>> +}
>> +
>> +static int tcan4x5x_regmap_write(void *context, const void *data, size_t count)
>> +{
>> +	u16 *reg = (u16 *)(data);
>> +	const u32 *val = data + 4;
>> +
>> +	return regmap_spi_gather_write(context, reg, 4, val, count);
>> +}
>> +
>> +static int regmap_spi_async_write(void *context,
>> +				  const void *reg, size_t reg_len,
>> +				  const void *val, size_t val_len,
>> +				  struct regmap_async *a)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static struct regmap_async *regmap_spi_async_alloc(void)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static int tcan4x5x_regmap_read(void *context,
>> +				const void *reg, size_t reg_size,
>> +				void *val, size_t val_size)
>> +{
>> +	struct device *dev = context;
>> +	struct spi_device *spi = to_spi_device(dev);
>> +
>> +	u32 addr = TCAN4X5X_READ_CMD | (*((u16 *)reg) << 8) | val_size >> 2;
>> +
>> +	return spi_write_then_read(spi, &addr, reg_size, (u32 *)val, val_size);
>> +}
>> +
>> +static struct regmap_bus tcan4x5x_bus = {
>> +	.write = tcan4x5x_regmap_write,
>> +	.gather_write = regmap_spi_gather_write,
>> +	.async_write = regmap_spi_async_write,
>> +	.async_alloc = regmap_spi_async_alloc,
>> +	.read = tcan4x5x_regmap_read,
>> +	.read_flag_mask = 0x00,
>> +	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
>> +	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
>> +};
>> +
>> +static u32 tcan4x5x_read_reg(struct m_can_classdev *cdev, int reg)
>> +{
>> +	struct tcan4x5x_priv *priv = (struct tcan4x5x_priv *)cdev->device_data;
>> +	u32 val;
>> +
>> +	tcan4x5x_check_wake(priv);
> Do you have to call this every time you access the Chip? Can you move
> this into the open() function?

Yes we have to call this as the device will time out without bus activity.

The only way to wake it up is through a pulse of the wake up GPIO.  SPI 
interface is disabled in sleep mode.

So the function tests to see if the device went to sleep and if it is it 
wakes it up.

Putting this in the open function only wakes the device up initially.

Section 8.4.3 of the data sheet [1]

Dan

[1] http://www.ti.com/lit/ds/symlink/tcan4550-q1.pdf

> Marc
>
