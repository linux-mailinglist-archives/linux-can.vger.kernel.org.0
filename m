Return-Path: <linux-can+bounces-3839-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48176ADA959
	for <lists+linux-can@lfdr.de>; Mon, 16 Jun 2025 09:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACE8189506A
	for <lists+linux-can@lfdr.de>; Mon, 16 Jun 2025 07:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C020420C48D;
	Mon, 16 Jun 2025 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="P3aSlgKJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770EF1C6FE5
	for <linux-can@vger.kernel.org>; Mon, 16 Jun 2025 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750058658; cv=none; b=kQJNi6Lj64h0QTnidDQAORwSMRFW5b9G0y384tYjHS3JxL6qjgi/hwjdmnolVq+ZgJoEfJ4uuOtzgapjXwlsn/LXCFrnBkB6yykNMpAXQb2iCZkiA+iC4n4iAOVpNRGP0/AV+UbgckGVxWlksmpwBubX4mW5EyZFwJITOPD92/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750058658; c=relaxed/simple;
	bh=Yl+OrShKybgGktQ+kbAvNrti8ByItxmFOhxh8elUoMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wwg37c+nLCvzpSltvuzsWA8U5oKnBQuEu/UkFhIdZBk+7MuOOruRyAbXXyfaLArsRL1k5Nn0n9YOwzGJkRjs139EentJ2wlKDgn0moW8u892Ico57+zTwxYMUtQYxxfZK99VwHH/WS811rpRSyhiK87KcK8YzwS//Pa2tSjp0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=P3aSlgKJ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso2751021f8f.2
        for <linux-can@vger.kernel.org>; Mon, 16 Jun 2025 00:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750058655; x=1750663455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Prze7KarTtiEr9ULuOe3gPur17rt7b2Vlkz0iOaKSnE=;
        b=P3aSlgKJbdDaG6Yn6SNFubplfYERLj6RO4hIPmy+6xmkF2vQyxSvBpG19zNf0cXDuP
         xHInndB5Bur0UflhHoGz4ajfsx+ZCAn8J9dRHFMny8Sx88/6giYgbCUIDV/5w80RbNgb
         Q4hoCcB02eLj56S4qY/xja2JPqJ3huV9ZYEblSYfAWB3BPZ5pRrZjW9CnZ4AmYYaMBU8
         yLrTYZYQToMK0qCX+c/iAEytu52nahXMUpuVUKv0tgCDugGjfgUNV+KUzBD3TtG0wQdM
         ukjhpeK+oVlqWbqUvASa6iSs99Lc03ReAllbGCKGu4XPZjS2EBiZ+4E5i2zLh6XBTUBv
         GxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750058655; x=1750663455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Prze7KarTtiEr9ULuOe3gPur17rt7b2Vlkz0iOaKSnE=;
        b=HdUPZe9hZ3t8FHIlgP1ZG6KRCVMxPr1R6l7vL6kq+8TChdKmZsw6qsH8q/OkSbldU3
         nvFcl7rXbphTiLy2GziwLWV/NuboTgWKUbGObOqoZBN4fVqE0yHp8LDMtUmf2Z3k+yzZ
         inRlBNWjGRvaHp8jj7Hea9FIRKwS6dZxmHoQwKZa1WQ6md4aLXLqhPcYJTdT2dURPR3n
         A5TgRf40FCRaWTdIP8FvRwsu5HumFVve+pG1rctwvhans0p20w2QmNO6Hva+FRqsZh+D
         mA7Etb9VchrxF0k6tU1AAXVHZjK6FL/sT6YL81HIRaSNeZlO7BtAWaQpu3LYY5CbKDfU
         h7Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUW24Fk4dpPoUTKRco+mmoQxtkEAIwkDbrE/UVHLNqCkJP9EtXRnCf6AhzoxYPDQ5KnyVnEO+8A2II=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbFq6AT9JNSLdrCowIBqVV7DGFwl/TDZek0ctVi/39rVeaodjg
	k/j7L7oSDAgCywZdhEudCnzNWDyRmSuRO3F4vZAD5gAMaMskZHvrdNkiO/xf/eHiZfE=
X-Gm-Gg: ASbGncvYuuI+LT+a7LMsxyP5/delThgC5b5aCjfiGiiwXdCjW4t69URgSH6obpT548w
	Lz+z7Mu5vPrTXt48TcuaoA8HIpnhcoBWGioqWu1GiMk22kKi/ipQedicDbQgu1o83ZHUj9szmPu
	dPPPgkltUfuwhMbUxntkZbjD8WAqYfq0RBTzkSKer1WjJ4YtwSIM27xVcdXSyuLSJklY0Q94aIa
	Ybong6iaVUvEf1v7V5QMluIP+2hRg8vv8wTNZYTpXkkvrmsGDZRdHmC64gjhL8puKWWq6ZSEJZo
	GPRMHaVvrBz7lR8GtZt0ZozRniknKUezP4XbOxzpj5RqJOw7w4h/10AA
X-Google-Smtp-Source: AGHT+IG/lAGJDXz/7A3CvJT8e5vgl3jiY1Lw3i6jYgkiFDTNWEgx2Zv5/09zy+DHigY6izksTnVhjw==
X-Received: by 2002:a05:6000:310e:b0:3a5:1266:3e96 with SMTP id ffacd0b85a97d-3a5723710afmr6864057f8f.15.1750058654687;
        Mon, 16 Jun 2025 00:24:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4238:f8a4:c034:8590])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b08c99sm10312334f8f.63.2025.06.16.00.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 00:24:14 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 16 Jun 2025 09:24:06 +0200
Subject: [PATCH v2 3/5] net: can: mcp251x: propagate the return value of
 mcp251x_spi_write()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-gpiochip-set-rv-net-v2-3-cae0b182a552@linaro.org>
References: <20250616-gpiochip-set-rv-net-v2-0-cae0b182a552@linaro.org>
In-Reply-To: <20250616-gpiochip-set-rv-net-v2-0-cae0b182a552@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-can@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=9MP33N5pSy3OGgT8wnmaqvxECSreBBEZS21KtQDntIg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoT8aZLt+zmsPfXHGowMV7wiRrZdvT9d0pjybCs
 eRaNCJ9eEWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaE/GmQAKCRARpy6gFHHX
 cr8SD/98aDqkM/VGj5uwtBE5gFWYPj5Z1zIx8qY+nCaRVn2DKwC2Kg4yMV70J9jSdq4ekrRinZV
 RnyJ7ds9/3L20t39TnghIi+GiIxnfHsIawEWyCLFFyEa+b4Fke0iOl/kx2jqaDSFM0C1C3u3ENG
 GbhKATNcf7F7G6DJ2xccIinHhEu+mBXrCrceO+kijsDh6wbut7AtETdESfZaIpQQXFCqwzKl/XS
 6Etd4fE9UpLJ2bmyzW7Yn1/TFo+/OBPgyujTYD2t7FkbOI4ytp4QF/Wl22eeoB7lysoWLzZyI8n
 nA6GYs2OMox0U1nnMmlIEaY2L/73AbfJwzTOV9wnUgLFPgZSW9JGRtzYINWTz9/DrCHmlMwljUE
 VNcYSKhQL1LOduvDgcp3j2z8rI9/aOKxIVCFkXTr0FVHxM2Y7rh+JPFN5sV0TVIDNX/H5h3LMl6
 OvVOPepI/+66wgHuOlV4dGNmeV/6yi2RcwONb7FHZq9wYxDJZtLX2fk6qLjQw8a1vXBfsiO/+Ci
 YULlo87CssHva7nhnuEC+iTL6EiiynLq4/MDVFCaCCFyAz9/cCdRcbyQx34tL8jxS2RAtH6OV48
 dm/bkqz6CxfJxgmvOTb4RBiJdfLXyyoctwXbW/4h9irmuYzMUuV9rctiyHDtoR/H4R1bWJ/dhf1
 u44dRSvvUN2+JGg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add an integer return value to mcp251x_write_bits() and use it to
propagate the one returned by mcp251x_spi_write(). Return that value on
error in the request() GPIO callback.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/can/spi/mcp251x.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index ec5c64006a16f703bc816983765584c5f3ac76e8..60b7fd3040d02f114693cf66d61c8a075a32e278 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -388,8 +388,8 @@ static void mcp251x_write_2regs(struct spi_device *spi, u8 reg, u8 v1, u8 v2)
 	mcp251x_spi_write(spi, 4);
 }
 
-static void mcp251x_write_bits(struct spi_device *spi, u8 reg,
-			       u8 mask, u8 val)
+static int mcp251x_write_bits(struct spi_device *spi, u8 reg,
+			      u8 mask, u8 val)
 {
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
 
@@ -398,7 +398,7 @@ static void mcp251x_write_bits(struct spi_device *spi, u8 reg,
 	priv->spi_tx_buf[2] = mask;
 	priv->spi_tx_buf[3] = val;
 
-	mcp251x_spi_write(spi, 4);
+	return mcp251x_spi_write(spi, 4);
 }
 
 static u8 mcp251x_read_stat(struct spi_device *spi)
@@ -441,6 +441,7 @@ static int mcp251x_gpio_request(struct gpio_chip *chip,
 				unsigned int offset)
 {
 	struct mcp251x_priv *priv = gpiochip_get_data(chip);
+	int ret;
 	u8 val;
 
 	/* nothing to be done for inputs */
@@ -450,8 +451,10 @@ static int mcp251x_gpio_request(struct gpio_chip *chip,
 	val = BFPCTRL_BFE(offset - MCP251X_GPIO_RX0BF);
 
 	mutex_lock(&priv->mcp_lock);
-	mcp251x_write_bits(priv->spi, BFPCTRL, val, val);
+	ret = mcp251x_write_bits(priv->spi, BFPCTRL, val, val);
 	mutex_unlock(&priv->mcp_lock);
+	if (ret)
+		return ret;
 
 	priv->reg_bfpctrl |= val;
 

-- 
2.48.1


