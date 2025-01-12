Return-Path: <linux-can+bounces-2604-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C5AA0A94C
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 13:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2B3188274E
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 12:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A9A1B4258;
	Sun, 12 Jan 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQSJdamy"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EAF1B87E3
	for <linux-can@vger.kernel.org>; Sun, 12 Jan 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685750; cv=none; b=RbkUOZo7b86G+NWXIvnoZOETzfgEaZiI3lSWxsig1xUD9tFYUO6Z/9SlhJQRo5gu/Kfyl7CdcR9Ji5LS2xcg7FmZQfcmkIhArfeZNyu1GPJreJCKPk4DM9mcvdPjDo0ZNILvgKXAVs7alucPbBzPjlx2VD25GRifJZaPT2H51XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685750; c=relaxed/simple;
	bh=YdLcJOKQc+JyEEQm/WKU7c1rP96Y/6AeinxtJg48yHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UwoxTV8AQHWrqSM7lD0Us/TzSTz3QKIA/wOfz63mnOX9LniMKraZQ2sRQQQ6GcJ6OIxfuDtu8yRMLo0f9rSBwiIvsEyfCWJuA7B6DdiNHrpX45678IRCWd1kdSuC+kgH+N+DXHcLZGM/2DBeqbmbifQ/MsYs5tunHkRQo7VA0NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tQSJdamy; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab30614c1d6so15870866b.1
        for <linux-can@vger.kernel.org>; Sun, 12 Jan 2025 04:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736685746; x=1737290546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3mNPU+LR4h3V6TxdDn8bLuYJ+/VeUr0D42fSLZpupc=;
        b=tQSJdamykT8gsa26zzMx5bCiQGJlXp3UKj5Ynbc6FwRk48RtJOxXjosZ+Fw6uoqYrw
         EU1VhNxx6t8e+wUDjAvhQo9o0pTlEERH6MRud9VCiB2emY0o4TAEtmnE/6lRJdcefkMV
         UYWqi8VTzVSvHz9+8q2VSYiKs39d2PjeXFey6vgZ4FtrcQ8Lpc9tQxniuPEg+vVGAHYn
         e/AQsCVtsCR3yZUICfTuR0aGUuC89EoUgSvmZyFRHeiEIE/w++EiPfF0SlaygtQHRHz5
         kSJEz3W1OdwJarWWlOr9UlX9xdGpY/lcaTcKoJ+CugxWtadTY7THvkEptjqbM5rzBZeR
         P1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736685746; x=1737290546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3mNPU+LR4h3V6TxdDn8bLuYJ+/VeUr0D42fSLZpupc=;
        b=oMdK+J4R+BX5FwPsiZkdGqoSxLKY/6wXUk6c43b9SSdu16Hv2ApNd1Lqtb+4WvuF57
         F//kJO/DAtKFgrVSGqXdabjuajz9yhKpWIkR/tWFr+Y+PQ1Qr2C/JFNOYWlf4RfR6gBN
         BziysmxtJcWlOhb3DEBS2fBZKNyPKCetFJqDwZ0C+UHWjpYsOGuf59pPpuDLF3ztW8UB
         sG3tzVvATfB0mHbNl+yYNYwmfU6t0BjkcUtWc4xLxnyTPEyJHMK1JDA8uacr0XGVs15C
         X+j4hfskm4Muk8V/dEUVBihxYpH1GFP4Lkp7vlNYHZ/okhRcceTGn29mCBLjkl8XiY0G
         58rg==
X-Gm-Message-State: AOJu0YyG2xNaLRiwcFtMHfzWxk5NJTmUbIXgBjbeUvDSmr6YakZ2fv5P
	4L0t7w+ZafknuiUQmUiHXoDwYRzuoxZIpcaMiAe/gOEiRlRCjRt6Q8uLsyvB9SM=
X-Gm-Gg: ASbGnctMBCIcHQYtZE2/hJQA1SH7yX4V2x0dXfMn8u1u0JV/sU5aEyx7moen4emlqqo
	MRGPVKfTomWOXx+d3j3CYEZUFpGdzWCtY+2FHwwmCONTMdlxDY2YQf+iOqPv4QIXnddDXrPEGQJ
	+/Vt8julOU5EzUMXjQyyP8CM9+HuX888bii/4txsB9o8eFrE5d4XqtS1UwZwvBcQkAcs6iPAcE9
	r9PsIEsn1bFfRQ6MvHzqTqVJcsKTuNWkSib+mrJuGYpDSH/jO2DGrIxS70W3s7pUZWxF7rY
X-Google-Smtp-Source: AGHT+IF6UmSsTYuP/GNh4fRN8KX6H2p10jm/QlnI2IiCwqPqxm/cr3DvLngaoZh7ZXilHYgIBmx5eA==
X-Received: by 2002:a05:6402:2355:b0:5d0:8111:e946 with SMTP id 4fb4d7f45d1cf-5d972e15f45mr5734162a12.5.1736685745719;
        Sun, 12 Jan 2025 04:42:25 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99091e9absm3777087a12.45.2025.01.12.04.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 04:42:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 12 Jan 2025 13:41:56 +0100
Subject: [PATCH RESEND 5/5] can: c_can: Use
 syscon_regmap_lookup_by_phandle_args
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-syscon-phandle-args-can-v1-5-314d9549906f@linaro.org>
References: <20250112-syscon-phandle-args-can-v1-0-314d9549906f@linaro.org>
In-Reply-To: <20250112-syscon-phandle-args-can-v1-0-314d9549906f@linaro.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Tong Zhang <ztong0001@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YdLcJOKQc+JyEEQm/WKU7c1rP96Y/6AeinxtJg48yHI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBng7ie679x59YlS8BfNpZKoyamPTsumAiQlaO38
 mT6CAZkq1aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4O4ngAKCRDBN2bmhouD
 1/NlD/4mZ9uKaZ1qR2H0u50NdT9awrKKsAJOjEb9aa8G2hnfjSSntA3JnGJyu09Kjg4ZCxJio7x
 oEbeOiFvzzFhfyKIDh5iE2rHgfVXoSVUAmA3+yFEDfwbneedcAI4ZQEurd5MAL7DxYrSTwzqyg3
 sPA+6IEQyu1VW7tPZ0SuQRXp03rs5QbWi2hS6uhPDlX1EFAFV00sqK5U08c0GYvhDk+0+2MEAbT
 d8uQMIaCA2dP9M9HRAV0vwZPcL4RnodM0JhqU9WzSnmJLgj6diABvP9a9dZy7jnndzS6cALigUl
 nO0A808oucpLNLcmpyOR3etZ8JVggdKz2NZxV+B4NCJ1v0BqT9TcLgTzlK0zpWnZzJIjtvIOg/y
 zq6mZ8wVvsO5/lZM49m9AvfSv2HNt7W53OvmGCSN2Z1Azh3IX6M67yGlTvwXQDCdcTWWirYAkUA
 7iskDcjaEgMxAG+UYx1GiSslq9Cuvr+O0IT57fTCH6Ibdi7sV7B5Lrjah6wMAVo6w+UoZUWguad
 XLj25bIxLi/Apo4DNb42f9y7nU2g002+unOe/1jDdcMF9gbiR1p9YShW2kasYDqvlaGSGuOjw7r
 NmkoTz4skJ81f2BZTvWQ1wogMdzHt4l4en1nvP07vDWpEbG5vTogVb4x9yFBxpH3n/OUoVuw3xw
 Pp6bsvxSC/aVRDA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
syscon_regmap_lookup_by_phandle() combined with getting the syscon
argument.  Except simpler code this annotates within one line that given
phandle has arguments, so grepping for code would be easier.

There is also no real benefit in printing errors on missing syscon
argument, because this is done just too late: runtime check on
static/build-time data.  Dtschema and Devicetree bindings offer the
static/build-time check for this already.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/can/c_can/c_can_platform.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 1acceb097c17fb7c0e2095a43d926d9cf802ebef..19c86b94a40e4f5c3db3c2da67b64da1310584b8 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -317,30 +317,21 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		 * platforms. Only supported with DT boot.
 		 */
 		if (np && of_property_present(np, "syscon-raminit")) {
+			unsigned int args[2];
 			u32 id;
 			struct c_can_raminit *raminit = &priv->raminit_sys;
 
 			ret = -EINVAL;
-			raminit->syscon = syscon_regmap_lookup_by_phandle(np,
-									  "syscon-raminit");
+			raminit->syscon = syscon_regmap_lookup_by_phandle_args(np,
+									       "syscon-raminit",
+									       2, args);
 			if (IS_ERR(raminit->syscon)) {
 				ret = PTR_ERR(raminit->syscon);
 				goto exit_free_device;
 			}
 
-			if (of_property_read_u32_index(np, "syscon-raminit", 1,
-						       &raminit->reg)) {
-				dev_err(&pdev->dev,
-					"couldn't get the RAMINIT reg. offset!\n");
-				goto exit_free_device;
-			}
-
-			if (of_property_read_u32_index(np, "syscon-raminit", 2,
-						       &id)) {
-				dev_err(&pdev->dev,
-					"couldn't get the CAN instance ID\n");
-				goto exit_free_device;
-			}
+			raminit->reg = args[0];
+			id = args[1];
 
 			if (id >= drvdata->raminit_num) {
 				dev_err(&pdev->dev,

-- 
2.43.0


