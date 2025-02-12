Return-Path: <linux-can+bounces-2802-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E962EA330B6
	for <lists+linux-can@lfdr.de>; Wed, 12 Feb 2025 21:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43CE167F15
	for <lists+linux-can@lfdr.de>; Wed, 12 Feb 2025 20:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A189202C38;
	Wed, 12 Feb 2025 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LapzYjM+"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EACC201258
	for <linux-can@vger.kernel.org>; Wed, 12 Feb 2025 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391806; cv=none; b=rDPKVI/GYSdQOG/J+lKUPfcTLCra6yO7Wc905gVQFTILr8+lAQWmjnVqAx2N/weHnmN/xPcN3gnBxzrPPaTnHD/vMnzMkh9Sd+UeBuUYbh3m44KPOHHUlXnhwspP6ZEAbpdyNAI/rLSCrJfbaq2h4Opw5G3mLeowsUa21zZv1U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391806; c=relaxed/simple;
	bh=7xeXLsqibZMqnxZiL/fw5CQqndvY6kmfslX3QiDDA+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJwmgKOE3GlqE5/nEH/blKR4kr/37HPziP84pd81+XDSwLdGIuIJm26IXXNqk+p0WdM8KIGepvVfBk9cPvjN2FifAqJ9iTMYb+jV3cQU6iN8tC+OD17LWbHwM9G7I3NdLRLA4ksLFtLN1nwW7A8sXjTPGrg57bFavG8Ad6znZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LapzYjM+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7098af6fdso3053766b.2
        for <linux-can@vger.kernel.org>; Wed, 12 Feb 2025 12:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739391803; x=1739996603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cq7xkKQC1SCW6LHfRdWmJ+g4NWqJSmYLsUVantx3RJ0=;
        b=LapzYjM+AAymbyCJs6a2dzIiKEMmkL/l1K0/ciRs6LdDX+V681weQ1KL69nD76iFQS
         3TPBPZYsGNwZQ/g6FsUCwkFF249x2kSek6mTK3dHYdl1kPFYLVVClj/AcQkibzrWweb+
         sYjLoWJwcWgGEgDDP40F+AzDFd4iJ/2oo+LBlCRVus0KJIRK9iPiKLjqrLpL8n9dDTw2
         as/stec2SDcUu/3IgxzEgXsPISArtXIeIAheN+yJIY1Da7bBeanE/XLOynm0lUm2g5/b
         1wK+ncQlWlR5eM+jqEnU21OXvo14Iya5AQooHtY5Q3L+DXqgL5Wv3gch941B2y1zqcDc
         rr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739391803; x=1739996603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cq7xkKQC1SCW6LHfRdWmJ+g4NWqJSmYLsUVantx3RJ0=;
        b=Eup8bfT7nCEU098+ZYGKOp2E6PCaGnpUJnnr2QRul1DwnAp4M1IbkVC4ooK8/EXKVf
         i1BPFFG7sdyn9YS1+rLfu3gTQRvlulHfp/xiAp8DqXAdifbGWr3pogLye3QOaMP0IYpl
         hhi2tlKIQfPR7+jc95okijZnfKGFtMf1bYxj5GpWHbYyIsBZxR8t+7nNe5LOXNXEHmTT
         hGRfClNz3zjzYs5lRiyFlLv+i7n6njd/JbF+M/AvaJz4FYKGumVcyzyGW6Qyl1dG4Dvf
         moKpV6t80ZGxyCDEK4S9nRRN39FB6Bbw0w3H1C0au6cEprAGZfGGAtbL7QcTmh/+2wU/
         E4/Q==
X-Gm-Message-State: AOJu0YyErXcohQe746+gyZo4kf+FzUUoE7MfKzHDApG1G21zpXcOgQfo
	FOeCoFrpvZNvKBbr4R6c+MkIzZOSKD2H7TGGm9lxZVRZydXijwW+S+npjViudZU=
X-Gm-Gg: ASbGncs9Ntj1ARs5MhJC7P/2sovs0VgyM8TMbWAx1CViS6gOk74igMB+McYWzo79+z3
	IKeuM9FnWijkqJiAI3g3QbyV3tmIw90nTHtcN0XPESztz6zpTiQZJrPIIb6BiGh3moBO/KXhGJX
	Oey+BwZ3Iq3T6UKVZawCycZsbPYO1T3KrvDClBoWUo3pntAuO6pxgW6G+kx0/F2MkyAXQhBtQ82
	e8gjyX9Plosv62AaUlBu1wUJu11t95tbuOhztHXZmol7kxXFECHl5YyfLHhMdd3y+hnpCW25+bZ
	r76oRyWGvAVM5RPHeSHowSBcqz8/SEo=
X-Google-Smtp-Source: AGHT+IG4PGi1kTxmD8fqe5EI5+bjXhAoGgpv+ke//sZYHazjL07utwG7w1z63OoeyuWMbhBfqpMZTw==
X-Received: by 2002:a17:907:9405:b0:ab7:63fa:e35a with SMTP id a640c23a62f3a-ab7f3334aa3mr150063966b.2.1739391802733;
        Wed, 12 Feb 2025 12:23:22 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7db5ef658sm419660066b.42.2025.02.12.12.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:23:22 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Feb 2025 21:23:13 +0100
Subject: [PATCH RESEND v2 2/4] can: c_can: Simplify handling syscon error
 path
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-syscon-phandle-args-can-v2-2-ac9a1253396b@linaro.org>
References: <20250212-syscon-phandle-args-can-v2-0-ac9a1253396b@linaro.org>
In-Reply-To: <20250212-syscon-phandle-args-can-v2-0-ac9a1253396b@linaro.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Tong Zhang <ztong0001@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=989;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=7xeXLsqibZMqnxZiL/fw5CQqndvY6kmfslX3QiDDA+g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnrQM0QluxVDD5FzO2QehwMZ4EC8b017j92p/bz
 FG33OT9gLWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ60DNAAKCRDBN2bmhouD
 1/SbD/9hUN1hVSp0sPUeCJg35zy9Y1zX1TeZ8Dusk8eR5Gb2RXIU7i2VXHxNkdkrbt3tDdfPvXH
 G49i8LQv1ld9EDAe0cKitI2KTAZYFyd41dD6dOGRtNtL0v/K32oQG4REQbWort77rofQc7fNrbZ
 mlrQc4wdDhO2du/N6Ay1i52hvqgnY8D184GMNIbpkvPCTQEIrNyosrRXQqY2WpYMKrbSEfz+1zH
 oLXBAOAhGkYZ/tnKR9TDwB7bZwWLY9T2ywsqDN7JNX7UpszS5z/C237f2wG/IQcNi64DBIyMPSs
 YXnDO3k7uMi69dLqXSbYa9nx6iGwijrPohHRpUTiNYYEM35ppu/8fx/AFNRm21LjGu8nCa2vtkc
 43Q0/Koi1e/Xzh/LeZ1E5C5/0YwOcn3rocTHTjsEW0X1sjoJfb1oWbK2Mb8QDl475dmVBChvYIj
 2gicLgiZ2EXrDrxiw6JFcVcasOv/OjNDExJCMdiIL/9cHTgxNTDOCd9VCu4rfKxKHSh/HtVELPE
 KlYxwC4L1vM6bLQx742IrDx2X7+fNIhvKgiBM1Xj20RmKQir3Vyx5gCOcOTIesPTMn++nYWj2I+
 79KFC+EBtwd8sgv4roCzWdI6K+OT2gBKyY4zatxhkJ4NYn37RgPaCUbw7P6nkglxsfP7nnH3DF+
 MmY6uuTxEU10XWQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use error handling block instead of open-coding it in one of probe
failure cases.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/can/c_can/c_can_platform.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 8968b6288ac7adc54894f09efbd869c950cce4bf..96d1225c41d0a93627015c4582c1ef1565f53174 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -324,10 +324,8 @@ static int c_can_plat_probe(struct platform_device *pdev)
 			raminit->syscon = syscon_regmap_lookup_by_phandle(np,
 									  "syscon-raminit");
 			if (IS_ERR(raminit->syscon)) {
-				/* can fail with -EPROBE_DEFER */
 				ret = PTR_ERR(raminit->syscon);
-				free_c_can_dev(dev);
-				return ret;
+				goto exit_free_device;
 			}
 
 			if (of_property_read_u32_index(np, "syscon-raminit", 1,

-- 
2.43.0


