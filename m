Return-Path: <linux-can+bounces-2602-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E79EA0A948
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 13:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221C9162CA2
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E871B85C2;
	Sun, 12 Jan 2025 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mhe89JXz"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6651B3943
	for <linux-can@vger.kernel.org>; Sun, 12 Jan 2025 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685743; cv=none; b=Sb17bZieVxwjiU3Nn2vQATgU98t4A3rAHOnsFsfxJJFcsA20lH9C6LUI2PvHZJPhjmbKvtXb/QDxAzfvO1++ieyaX/hmeBOXZIbAzAtbWe56KwUo1jdYG9X7dnXySUrI5TA63k17WOpf7+fcVaA3Es/P94nuOBDKhS8Ann8yQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685743; c=relaxed/simple;
	bh=7xeXLsqibZMqnxZiL/fw5CQqndvY6kmfslX3QiDDA+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0AM1CbN0/P7dmytYRjn7gB9z53R+ny9/5m7VyOoOArlZzfAXNEhn57oL/g7Z4qYXKfKgLZZ8NCsxTmR2YrdurvUhUw0f8X7KylnB5Ne8oRqBMce6/xH48Osmz+1X6KuRE/3D3BCYDYo9+eEtU0a5nFLwf1JwWMQxztiJOIQSak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mhe89JXz; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6a38e64e4so60294066b.0
        for <linux-can@vger.kernel.org>; Sun, 12 Jan 2025 04:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736685740; x=1737290540; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cq7xkKQC1SCW6LHfRdWmJ+g4NWqJSmYLsUVantx3RJ0=;
        b=Mhe89JXzwhcCxh6ACgZ1veDnTtHnCRU2ht5IFD/4/BcqS6gmjMY5fsRcAcOCytmNi/
         wWgSlb7kXDtVZwUW43FpeSe+8yiAJ4PrDJCyz1qA7PP/JP19F2rJuoPmefHYYA/M/4lq
         ssatkPUErfVEV4J9QUBBksK5Zz216/S9YJJX0jqcsSqtH1DiOYT/vMxrVYxfQES1X4i2
         CY7CitKaxMtum5wXNhzztAU2aOPY39ikKnUUzJgOJMc05+ryh00LbJZNaKdO10MUVLe1
         mbtvWOvmPEIdNOG9gcZpRtudw5iyW+OJELIN7B/R2GViHUw3kjj/IQSWjKDnMJCCg38S
         hC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736685740; x=1737290540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cq7xkKQC1SCW6LHfRdWmJ+g4NWqJSmYLsUVantx3RJ0=;
        b=Jnwl0tBUG++HFy8qvOzw4F6LqB7r1TNFQ0MBDtc8vF5rVW26RkbKZvxJDh0buPbxqn
         f5F5tyL79I8a9P9a9XDVD4mCmT8XQq1LlNwHHUMDRKGClpiql41bLybbCxCJ+XI2/wT5
         qlwRKd4s7JNcBef+Z936IPXP9fzvWZGYatncJgrod6T+JKxRZz6AFVzh9ZRrSwyxILJC
         cMVm52+lv+F7w2hGt+i1MfTQmCb7/qKpTMMx9e4hglHoJMBWmLO2Dd3ZcLpYLPy4c7q9
         bQitGNNVdpd9pUm+7r3fXkCbhMyxscdS/kvMp62ZASZ8qb6U87HVWykk8poS2g8+NyfH
         q3hw==
X-Gm-Message-State: AOJu0YxMaF6d4XrOU9wDk774KcoLb+cyNNTtUkd0XmqMWoJNofEYuqZ+
	Z0PSIusyBvlNFKsgpiuwwH/Nn4rYywOinBp/SQSNz9TNi8exVTo5x/swTHn8+qU=
X-Gm-Gg: ASbGnctI7sDcOGP2MiYQ/L+Q5bGJibnbrU1ynly2amWGMjCYaWpq0U6E5uEOxIi5iKZ
	jrgvmvrFiIlm6d0Iq46TOt5UTzRm2ZnOfqQXwpp7ZlrtPXbXrnvTiIyhb3NVMT8Ze/eMzlixAwQ
	IyY4tgY/aolznz+W6YAjh9ubjznLbUw/uw06DeJFB+N4r3W+LgS5WbQELVAA4453SqZBunwd/a0
	+tflhW7QIuwVSI6BpjdAJO9ZAjMdCjib6EIQtdJ+mx1YWFA7nPQyfDnEh0cX0XnES/0XmA8
X-Google-Smtp-Source: AGHT+IGpqDRkV/lT4QWFDCU3MXF8WB77wXygM+uli9M7uXIGaYfIWXixuN8O6rUfVLBpIatg4FpT6A==
X-Received: by 2002:a05:6402:510a:b0:5d3:d747:649f with SMTP id 4fb4d7f45d1cf-5d972e7907emr5839018a12.10.1736685739992;
        Sun, 12 Jan 2025 04:42:19 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99091e9absm3777087a12.45.2025.01.12.04.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 04:42:18 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 12 Jan 2025 13:41:54 +0100
Subject: [PATCH RESEND 3/5] can: c_can: Simplify handling syscon error path
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-syscon-phandle-args-can-v1-3-314d9549906f@linaro.org>
References: <20250112-syscon-phandle-args-can-v1-0-314d9549906f@linaro.org>
In-Reply-To: <20250112-syscon-phandle-args-can-v1-0-314d9549906f@linaro.org>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBng7icP+tbZiUsL9uOT5X3Zc6u9r8qZR3rV5hZZ
 8AxHsJMUNiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4O4nAAKCRDBN2bmhouD
 1/lkD/942PhZm9BUPaDo2YejtqZkxax2D2uck4zreYvtBuu7GX37uYnNbpc7uE7HYDTrNFctwbz
 bEAAJw0er83F+Kd1SxgeKv2TsxHopBgVe+u6JCWYU1XvSXQyJtqgIH1302ykv60tokSXEqT1X/y
 y1g7n/ta1BrB7Gf28YqFlRvL5kmJNs4sKVxf8ltkKDXjv54AzRpxkUl40Dy17h87SmavlYo9E2R
 Fh+/aaJBXV4qIp3JSOZ2JFOmy9ieH6pTqOtrRJhIDZOlH4yV18ozrbbChcM4CoYHc5Zm6zQadI4
 o29Rk/76M1JLPevQjkcA1srLVDMncbmP221naYfOmCuQ3TAnqiSQ0h4NJIiHF7f4sOtXZ6SrrK0
 XpcRMxmYcqn0VFYOuy0N/mQpPg1l3PE0nLWiTsJTV5DkR1DdhYpE/zGuNwtCdM4yQ+wKSBbFW6s
 B5gwLqU/8bU4JFifHEA6cySlJ7ul1I52N1JQz2m+90fTNRK9M1VDaGcvIuL4GIFu7IElkNdsWVK
 JzWdGIzAaaiT3gEd1mzdqCyyoR9HvNlL0c3Se+PK4r1UV39qsvA/EmBl/a5zWEoSBRz0IKP+XFs
 OlOy7JQvEEivVanjYlMiePGbngoEQYPGLC9xU97W+bB/aDznBcc41nXnIY1K9J+yIcJ+wsVOmJS
 pSlr4Qo1U5Hspsw==
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


