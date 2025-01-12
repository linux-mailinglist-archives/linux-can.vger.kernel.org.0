Return-Path: <linux-can+bounces-2601-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ABFA0A946
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 13:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E1616282C
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DB31B6CFA;
	Sun, 12 Jan 2025 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvgPZV/W"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8CF1B4F21
	for <linux-can@vger.kernel.org>; Sun, 12 Jan 2025 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685740; cv=none; b=DjD0BhOO8tLRD4Q/F4SzMDpoG8Dbb7hP/ygSL1WVjVT7h5gU3d6SrvLXejted8ZmKgexhQ6AKlD6A9zwf2L8t3sgHxESLBRvMSSZ2hoqQq6ynZtwzZ3VhQp77ecEhXFy4RxJveOlvYg4LXtqnN7dIX3BlH02GSHDvQigWrvnWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685740; c=relaxed/simple;
	bh=BJr7Fun8ATHBkMDr6CDcYQMi5sV579CbQ0ida1QdEuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLzlUmLkISVZtTPsRFEWrb/DTGpjkJVj2UiVd3JMKwqG1gF6LWdGm+Fk7PmJGvlL3h0WXbv3LfX4a606kMYcD7g3Ul5ydyxKB7/nON/gU/D14TW4lYVk4rRpawgrJuXKY3h/It8DiYVCQic5BxkkH2JK3EUE2AEcTsMppd2pGVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PvgPZV/W; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3c0bd1cc4so546797a12.0
        for <linux-can@vger.kernel.org>; Sun, 12 Jan 2025 04:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736685737; x=1737290537; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jp4nnMqVM+wmvakBBSoNXcZew9pqFP31o7lF0iT/704=;
        b=PvgPZV/W09NPPMD3eEhpkx5kwVGtLbAvShs6QKSr4XtOsriZXvTDPyxomg+v4GyRm1
         Sqb8eYP3RArzxCI6yeXvHiO0h9MGqVzDP28GyqE1m+pYZ4gy+6tETZdXYAGMO0E676q2
         lC2jW/l6Rfxsb0dnuPe6cCzFtY60hXALJkp/0CgxlCNyB9dTtalkQExHdCHtE3VNus6L
         msPbnXXtwXKVPHwBd39HG3VLi2aT7JguwvKUbAx035Qe+d1r2Q4A35l+V3HRGUB9ASYr
         Le+8STAlvpsz/oV4WOQSQYnGk4oYESAA4kfP5tPr/LMhVf4w23wz0Em/mQEMD9K6Ck43
         MkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736685737; x=1737290537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jp4nnMqVM+wmvakBBSoNXcZew9pqFP31o7lF0iT/704=;
        b=ZHBOtN4D2ybDkxyn0DVNDxRNI2v+x2q4P0ceAQ8jftCASZ7DdPNKMZDNk8LmjDqaGN
         Ca3yS0HIuN06fXSP9WI7Fpadd7LikBN1ejtqjdH6h2odKtTVWrCmyXqglbBlfPxPwrVJ
         IvJwureaw4I71RZSo5aO1ze0/oxfNXcoBwXMrXjy7+wEneFpObIf1qavpDJK3w4F742+
         cNUuimIx6D3iiTrJqllKs6ZFMfjdTE0kBG5s/ScYiW4wtvQGZtwZv/hBQW4s82UrwLDn
         mbj8Q76Qrt32RYrZ7ulLPpmD7ynwRLkX6w92Z33iXfGXKtj996i5P7JCMs/mrFwgml/T
         rr4Q==
X-Gm-Message-State: AOJu0Yz4T42WtVgKPKk0MKg5TaG2tAd9aYCsYOfIEOp08JXSUE6F94Uk
	H40YEvxu+Z30us2dWXc3ME/b8dypIj3bgjx54HksBsXUt7vFkzit4FYV+3q+P9k=
X-Gm-Gg: ASbGnctahcX3YGzFVWSdn91Ix9BUn4mLlVzjrDT8PNVeaDpbiWNvjmL3Ht5o+E/6ZPz
	cuv+C0m/1YUDFfiRj666D4ZdQZfuRLiEgahG/QhW5nabE+K2T7kDE4/77dN45jUer/6e9FbfCgS
	+jSBjXtkqS/ZAfs6fT56DarkBX8tQfs0q57quaNYoXWqUMz8+gNq0qZ/V3XOEzK09DcdQIEp/h4
	9oq2X4sgNr+R9//QzH25ksBPxMCn05cdNrfH6yZ7RylS1UpD/Ch+JJJjZSjGQU7btDPk2L4
X-Google-Smtp-Source: AGHT+IGtrSSyi3GajkyciYGNhGqghdLOnYoOIyHAbe9Wgien/XyJ4xZsAe+xcZJTyuI2xCnKljpLfQ==
X-Received: by 2002:a05:6402:388a:b0:5d0:d927:824e with SMTP id 4fb4d7f45d1cf-5d972d29511mr6035216a12.0.1736685736998;
        Sun, 12 Jan 2025 04:42:16 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99091e9absm3777087a12.45.2025.01.12.04.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 04:42:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 12 Jan 2025 13:41:53 +0100
Subject: [PATCH RESEND 2/5] can: c_can: Drop useless final probe failure
 message
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-syscon-phandle-args-can-v1-2-314d9549906f@linaro.org>
References: <20250112-syscon-phandle-args-can-v1-0-314d9549906f@linaro.org>
In-Reply-To: <20250112-syscon-phandle-args-can-v1-0-314d9549906f@linaro.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Tong Zhang <ztong0001@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1839;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=BJr7Fun8ATHBkMDr6CDcYQMi5sV579CbQ0ida1QdEuA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBng7ic5kKg/SREMIipFlE8dWrGZ24FpqsC1/UXR
 YlEEBEUaIWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4O4nAAKCRDBN2bmhouD
 17VZD/96wgyot0dnwa0nfthafVdHGrXyOOoDxIa1/8i3fb1Gh+31nDomIZbGka67xUooRjT04p7
 pYZeCLR+0amtZ3QGzakEbUbhDW3sTb6wgKwvDEEuzh7/XoUdrJnch45i4MV7qJTk2pLygSdW/m6
 QWmrcNp3l82LvjP3j6jl6xSLTXox7R7fN29+B+DIT9pyrCIctsUC1oge3jqDmtSUoqPi2SnAbNs
 x+XySyRF/H1jbQVCpmKU6guIJwzkl+TFDfA2I5ropelKihT2oYmqd9RwEKeOuH0zJkVCBzZ7fCc
 6YMA5p/56+ITRkTSEce4V8dpn+CkVeyvnn7jOOVotUribf+YSvO+dtrej7sU4jjxETd6Mfaa6Aw
 ESLpnxJ+tKZyg+20GE+vDwbqsCGw8nuumPffHTFc0w65VsSITRAoUdnApXGiG3Oz9EHIGTyLiqE
 2PVukD3U/B62XNBjh0+uZTiptXXCB1WvxqE6KdOMpJgpqbZl4QIxglYqSvtP5ze2fBHtel6Ashr
 sSyMPIdYlQUtjBjFaJDyYDgRrUe6zMr2Fa78ns8KcbEPfJhexdYArm/yfAo44mKKl3i+Q2zg0U/
 2ckbnXsOJC02baQ7Ah8TeYNcw5ytGaGcFYO4y4te3tbuTxFaGjI7WeCQDcG6a7kc5s7AEwBX5ax
 ikWUSFdIAbRxDYg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Generic probe failure message is useless: does not give information what
failed and it duplicates messages provided by the core, e.g. from memory
allocation or platform_get_irq().  It also floods dmesg in case of
deferred probe, e.g. resulting from devm_clk_get().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/can/c_can/c_can_platform.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 399844809bbeaad42e19b4003b85fc487b01d336..8968b6288ac7adc54894f09efbd869c950cce4bf 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -269,30 +269,22 @@ static int c_can_plat_probe(struct platform_device *pdev)
 
 	/* get the appropriate clk */
 	clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto exit;
-	}
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	/* get the platform data */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto exit;
-	}
+	if (irq < 0)
+		return irq;
 
 	addr = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
-	if (IS_ERR(addr)) {
-		ret =  PTR_ERR(addr);
-		goto exit;
-	}
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
 
 	/* allocate the c_can device */
 	dev = alloc_c_can_dev(drvdata->msg_obj_num);
-	if (!dev) {
-		ret = -ENOMEM;
-		goto exit;
-	}
+	if (!dev)
+		return -ENOMEM;
 
 	priv = netdev_priv(dev);
 	switch (drvdata->id) {
@@ -396,8 +388,6 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	pm_runtime_disable(priv->device);
 exit_free_device:
 	free_c_can_dev(dev);
-exit:
-	dev_err(&pdev->dev, "probe failed\n");
 
 	return ret;
 }

-- 
2.43.0


