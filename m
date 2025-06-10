Return-Path: <linux-can+bounces-3792-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534FBAD370B
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 14:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19E617A181
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 12:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592B62BEC34;
	Tue, 10 Jun 2025 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IodXpGrF"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ABF299945
	for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559085; cv=none; b=cELVpd23uolw58+ix+oZh4lZCRQK0c/3u1h474R4zHanPMjxxmuOq4S+gtwxhvDYpjB4jFTgeWrsIgJjjeHnW52tYe0QsAV+5tX4b7FbAFvUX3Pt5T6/yUabsaj5BEnFDkwenBSKV+hnj0WS6BsqaUdrtpIFX46OFFpKuA+xLhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559085; c=relaxed/simple;
	bh=DMxSE+KlKXo7E9j2J1aDyImW/V4iGavbbTY1DlV8QQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C85yQTqdjYXQl/QaNyDQHZaHLmDsN+wUGhkUkjmpqm2Apg4O8BjSVMZJ1Xwl5ZFK4Wcw5GbtPJdgWF1kJU0kIyyKp8ReIvPsWgfA3Vvi1s68T3BU+W9murjqrjgi5h/spV6luG0tjuLH7UCICWqOyUMOqLm1PK1sa+p3Aj2rgSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IodXpGrF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so42893645e9.1
        for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 05:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749559081; x=1750163881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yE6IzPfXHMNhFc7FmQD93cM50XDdvhBiuKkLkDIaWfk=;
        b=IodXpGrFLjRGcV1nkVBU1g4unfGzRe+OHBvbnInsqSaWIZThCLxE9ROu17n30FuyN+
         GZooQDXCYLscRe8YrcJeVLUmJXdC/BO6knngtJN1rhk4NsTHe+Npv+dnG+6HbjwsG/KP
         onEF4zlyAWcLd7SSowvt7ujTaeNewK31XCC4T/56VOY7caLd/FXb4IxfOWgU38mZREEd
         aTiYq+LPkixxcuOjqqJVsHLg9iPTUnagpav0SJXr7Of6doezKEz6ywpga2GM1477CnK7
         92KaZNqJcMZB/SPcRl6wDFqljojCpWUZVrKVDSi7jTORzjq56nGZD0XVGih4T3qETypW
         +fOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749559081; x=1750163881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yE6IzPfXHMNhFc7FmQD93cM50XDdvhBiuKkLkDIaWfk=;
        b=W47mZgbN9tjJWMTXuj88HyEeq/sRnbn1vWMx64CUzCPmH3GMotH+8ziCLNssh9Oej7
         io8geezbuyGO4ahYEq0n5KAF4v0yduyfOzWUxedIby8FDL/yB6qTmtofOBaTBh+T/zIt
         kbo6CO7TV8TtQZbYJVbBBJBRUZeoioXRbiB1lZCfMhG4w3zy4RcxPPMSPkih77W/ydBm
         4LUnsZzthAQYgmviKRJKGV2ZY46lYYIEhzNsUkG7P3fQEeMlDZqm20dQA5SBfnz80AeF
         AEb5eYy4sjH8V27ZTd3z7RxMtMIwxRX5roMsfvYDf0uwiwuUKaHmM+zjz/kx5M2yJGne
         2Vww==
X-Forwarded-Encrypted: i=1; AJvYcCV87dvxVH2cfN41JdgaG7Ysc99FL0pslDmqv6Jk6ooBHrJzD83/Qb6S840Hy+VGJfioR3mZt5Ej300=@vger.kernel.org
X-Gm-Message-State: AOJu0YydmsH8uUQnuEK2UDibIrlQWrTMzLAprP0/0OdTYy7fI0wn+gxA
	OSiSVSvUsOJ9NFMdkowvRnd27YWIzQuu+AQ3rdxC74WVTsmSFwpHUGx7WXk+aWt9yfg=
X-Gm-Gg: ASbGncviKyg9fCLW5L3TR3KYO7D36Mev1O9ErsZ7Yx5fmuZflyxi3BmPMmhYURwt8A6
	UPAdfdXGJqXqtWFtZD0zDF7FCJoXx0RcFu/6MsQxBBZizTGklbeCEflsy+leO/x79jEdZHrvc3b
	NyyXnhBBjznwmg6wP6M+fYQyyLYHyzNKrOUo2z7rAbHZkA8YB6je9EISusETci4VlbNi/jddIYs
	7rPPbrGn2smrB5m2JuiuQZ8pV/oTEXliL+KHWqmkmiCIMTYvLK2c9hZiOXpRC1ZjUvjWHkNfBU8
	4kFbAEUilxFUuH98+9JLkZ9/1QNH7LdiLNlqcyYwTJGy5xoX29LmkQ==
X-Google-Smtp-Source: AGHT+IFIluBj/Xfh9+bgn/r8g+NKbyNkI+i+wm2/n6F+sHhauNTA3wsDUZNyQAG+f+/XcQqd3EiXTw==
X-Received: by 2002:a05:600c:3f12:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-452014d4870mr138049945e9.28.1749559081442;
        Tue, 10 Jun 2025 05:38:01 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4d:e52b:812d:eb7c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45213759fb2sm142476805e9.38.2025.06.10.05.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 05:38:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Jun 2025 14:37:57 +0200
Subject: [PATCH 1/4] net: dsa: vsc73xx: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-gpiochip-set-rv-net-v1-1-35668dd1c76f@linaro.org>
References: <20250610-gpiochip-set-rv-net-v1-0-35668dd1c76f@linaro.org>
In-Reply-To: <20250610-gpiochip-set-rv-net-v1-0-35668dd1c76f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1733;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ooSfZcGlJ0aY63V/ZbHM5psbxtwwGfSHGbKlKX+V14k=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoSCcmB+78fH6tpB5mkVhqkKE708zE39erGR575
 rvI5cGQOxSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaEgnJgAKCRARpy6gFHHX
 cn1LEADTJc5hTtmM3Acb673ULtyQ/PL+2cob9ouCpVtKyvLjzgdo8oxkHxkhIIRGcVBUGzrn+2p
 XB2CjbT5YAD5jfBwJifMSAicQoGEV7jTT3z6iqGCTeIdJFgDqJ4tb5OdsTuwfjP3/D8L/C576yM
 CYBNpiv80Foim+N/CCGAdXF4yKHiLCAFN/ddfhyiOT5AoKjgKGbJrmUi2G0OfcnOWycYMaKBlok
 uXYKqTOlNEQGzr4z84+wCQH4h56p4FSrC9NNgCHgArspVfHPzAmrnx1H2KyYb1xMhEBRGOfiDWf
 n/lMMRMzGK1ntxAYffXZBuTOHIkoR7v3JlW+KmmP6L0CrTxRGJPcloGEm+SImKMinydtBMGDrw3
 oXGh4zLcTLTFQXzt+DIVG4NDiqzyOYny+23XxbeQRM+e6uGdp2n4V9alflS+uGkPn9cY/dJtYtW
 J5EcuCUG2+nl52eVPbyTcmq4c7XeHAWFBUrDj6B2QtULkBlyvUTdrrP45DNiVN+7yJWuSyadjew
 Oqxpobdmfi4s0uB97Sik3b1m73zPNnXvlwZB/K4SslYy7IDs74RsE5ZyzIlyKMcYONI/nyjVy1W
 lBtCAAzPe5c91Ga+/Zy13VRvYjKe2LPPZWEMyBJ3gn3Kmi0Uv2zvDbhMqU7uNWCcaClJkWhM8Hp
 k4oJ9c5tEqEYlyQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index f18aa321053d75f34544267528d68ade37264e89..4f9687ab3b2bc1cc61946eef33b7d08f779db8c6 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -2258,14 +2258,14 @@ static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(val & BIT(offset));
 }
 
-static void vsc73xx_gpio_set(struct gpio_chip *chip, unsigned int offset,
-			     int val)
+static int vsc73xx_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			    int val)
 {
 	struct vsc73xx *vsc = gpiochip_get_data(chip);
 	u32 tmp = val ? BIT(offset) : 0;
 
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_SYSTEM, 0,
-			    VSC73XX_GPIO, BIT(offset), tmp);
+	return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_SYSTEM, 0,
+				   VSC73XX_GPIO, BIT(offset), tmp);
 }
 
 static int vsc73xx_gpio_direction_output(struct gpio_chip *chip,
@@ -2317,7 +2317,7 @@ static int vsc73xx_gpio_probe(struct vsc73xx *vsc)
 	vsc->gc.parent = vsc->dev;
 	vsc->gc.base = -1;
 	vsc->gc.get = vsc73xx_gpio_get;
-	vsc->gc.set = vsc73xx_gpio_set;
+	vsc->gc.set_rv = vsc73xx_gpio_set;
 	vsc->gc.direction_input = vsc73xx_gpio_direction_input;
 	vsc->gc.direction_output = vsc73xx_gpio_direction_output;
 	vsc->gc.get_direction = vsc73xx_gpio_get_direction;

-- 
2.48.1


