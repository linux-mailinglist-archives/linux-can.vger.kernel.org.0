Return-Path: <linux-can+bounces-708-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BC98FEF63
	for <lists+linux-can@lfdr.de>; Thu,  6 Jun 2024 16:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544BB1C24516
	for <lists+linux-can@lfdr.de>; Thu,  6 Jun 2024 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A53D1A2FA4;
	Thu,  6 Jun 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WeROrlgf"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ACE1A2C2B
	for <linux-can@vger.kernel.org>; Thu,  6 Jun 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683875; cv=none; b=FkIp1zw6XQwQyTISTDVtpwLlfEdJI/0KP5FhKGHdOSAgmo91s6qYRy4DJ5Es+N66j8dQtydA0rakAhrmuwW75hc2e5b46C53vQ0FU3kE/2iKygeN//K73cEzwWxbJW9IftbqFDWyV9rC4dvyL6UUyN1/OeCe2TfHqaWSO0/hoyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683875; c=relaxed/simple;
	bh=8XJvY4PRNd7QP5IlcghDRm7uf8FuIIF+wmBZT8DMjQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVb50F44/Dhle8QvyGymHWEWyWsBJb3dtufVrYf4i2vpw8TCe2oFaMDWDNUwEX/9Ti1E1YqwlyqGITPaBbbiZdsEd1HZqQ0eRVMaitvUAgGnn7gC6XjwcsZzlrCNZbY4Wtj9fsoQ0Y5QDv1Iasg44cED0/yqPakLJV0McR13WIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WeROrlgf; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5295e488248so1257634e87.2
        for <linux-can@vger.kernel.org>; Thu, 06 Jun 2024 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717683872; x=1718288672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++6vpzo3dEirc2BXnRm0i3mFbJVPl95CbYYtfzrVJSQ=;
        b=WeROrlgfNQ1p0/j3NdlyeOT/+NO75Z1fur4SfX8sst39SBCzDJcHmKeKIxhpsn8SI+
         currbqjo+DETlrHvAD+JuWpMLoTzVbIhHluRjtNeJ8OV9iBNEekCrXBNvR97GspzHPZ1
         nffqEIjyRJuRRdKvOyIOLBuM3LMnCPRRz3mda8ObD/kJL4jzLKlR2kkYtcSnm6XG1SbL
         eFUaOZ3H2KYiRvg1EOs3+e2GznVMLEIDzu/Bl68Vee9O+s/n3rq/Ar0JtJf68+DyZgsq
         TTJ58EQFkFRihRSufULY9iRXzTre4Qssh/sJTTmxf5/kJvRkvq0AQJQhtBKC+0F4sxED
         EtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683872; x=1718288672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++6vpzo3dEirc2BXnRm0i3mFbJVPl95CbYYtfzrVJSQ=;
        b=rZ3VK1VcEHgRdGBfxlzcYYJeQyJZangoSVcPyDsTxG3ZjlYK5adnsJDjggP2t8W8rA
         tLFjSG1D4jFMRlCZegiuKYy2j68L+vNsv0GnvfTBm1w9WFkVom3oLzhUtwXahbL53hMg
         OV0WjfoAQXD3fQkpATM9d8VLFYonKo0QRnnDpCvt+yL1phjZMoNG0gNUzJvP+LJm0Sbx
         kbLogyd1hzQ6KT9wITRZ8OvzC1U/hgT1Ouk/c8ABwrI94vja1sWl+jJvVDBJcy3UP6wP
         lBMmFsipy4ekCNKaGkyQiK+DLPirjM8ScYoSD39S2rMbjiiRj/yqZo6yYjeUJ6xCxVeo
         +K6w==
X-Forwarded-Encrypted: i=1; AJvYcCWuFoOfI5pFygOdaMROmTmRtxNrkVHhk/78xUBVbZRmjHaBxc2UeUyqU9FPMaxnJDtXeK3z3z9iNhw1p/qRNKEgP2fU3rr1rRX3
X-Gm-Message-State: AOJu0YxwZRj7NwjWf0q+nrEX3yUaI/IdtRWi/KRB6p5R3mgNnTjDyteP
	V8Eq/2WlD7aDBG1RXrLaTYacSHItiGbJoTjh0dP2vGlGmDuZzynTOpvozj4iTPQ=
X-Google-Smtp-Source: AGHT+IGK6NHwjN3jn4VsJlrqvbN9hjMoiszVr84okdXBzSyf4bSyTjksFWYG+VZCJ382BSeLaVQeGw==
X-Received: by 2002:a05:6512:2035:b0:529:b609:fa0c with SMTP id 2adb3069b0e04-52bab50b666mr2809751e87.67.1717683871828;
        Thu, 06 Jun 2024 07:24:31 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb423ceeasm211659e87.185.2024.06.06.07.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:24:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next 3/3] can: mcp251xfd: simplify with spi_get_device_match_data()
Date: Thu,  6 Jun 2024 16:24:24 +0200
Message-ID: <20240606142424.129709-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606142424.129709-1-krzysztof.kozlowski@linaro.org>
References: <20240606142424.129709-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 1d9057dc44f2..4b7e08e8ed56 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1989,7 +1989,6 @@ MODULE_DEVICE_TABLE(spi, mcp251xfd_id_table);
 
 static int mcp251xfd_probe(struct spi_device *spi)
 {
-	const void *match;
 	struct net_device *ndev;
 	struct mcp251xfd_priv *priv;
 	struct gpio_desc *rx_int;
@@ -2081,13 +2080,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->pll_enable = pll_enable;
 	priv->reg_vdd = reg_vdd;
 	priv->reg_xceiver = reg_xceiver;
-
-	match = device_get_match_data(&spi->dev);
-	if (match)
-		priv->devtype_data = *(struct mcp251xfd_devtype_data *)match;
-	else
-		priv->devtype_data = *(struct mcp251xfd_devtype_data *)
-			spi_get_device_id(spi)->driver_data;
+	priv->devtype_data = *(struct mcp251xfd_devtype_data *)spi_get_device_match_data(spi);
 
 	/* Errata Reference:
 	 * mcp2517fd: DS80000792C 5., mcp2518fd: DS80000789C 4.
-- 
2.43.0


