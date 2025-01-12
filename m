Return-Path: <linux-can+bounces-2603-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DD3A0A94A
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 13:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5546161EF2
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE411B87D8;
	Sun, 12 Jan 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMYhE0RG"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D0E1B85D7
	for <linux-can@vger.kernel.org>; Sun, 12 Jan 2025 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685745; cv=none; b=lF4xFGJaAhXAxURIXzw21MoaXoIKuDHnnWmOC4VGqRvvN3OELfFifkZPV0RcCTVahrDqPbpIZgzpzAGJ4rvujeowlpNpTdtCadP03Kr3JVKGPoFt8JGym95X8CL8mrniBB0WEBoRBt8pmN3+khR9RWI0qCtMPOc1xjrhslwKCuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685745; c=relaxed/simple;
	bh=Y7Py9ATmugAtvfRo/YsRM3Wtk0WTgGLNgzgMx8AaCBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pMzYHYS0VSF6uIi6K1P7ZX3HOQ3CxSJQBQQx9JnTAzo74c78ACDX7kMo2m0v2n+QDIQWg36px797TxxiZN1OEmdLR1cr4kKqnEARoPRnaT5aAIuiUoiTmENbvdAUYdqkYFn/1+MMa3faMI60sklcei9eek450Sospz21kHVbpOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pMYhE0RG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3cd8e59fdso565682a12.3
        for <linux-can@vger.kernel.org>; Sun, 12 Jan 2025 04:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736685742; x=1737290542; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1ktXxniTaO34Ok/Jjo815DE8byVSW3KIGjNme4BebQ=;
        b=pMYhE0RGNIAhlAtahl3X/6SDi3hQA0507Nm9xHGKdkuk5QT87/hkjkijhpCrKsFuC0
         a0oWdlKyAoJh07rGH6vuhszpvY02CPIQLItY81IibKpMO9SM1VAfEKD8pxi2K/3lo0dO
         ikNt61Pjl5RZhi7X+LN8IJCI4+/6KOepQ3h+w4OA0L5yLiAXW0R0FZgObiKAz7YMnM1e
         5mL7stq9ZXt6o1ESEIyYL9qQJIj0XEJZyrT7ridkjhZsoYKXK0OZXjLSeWIewGpJyLHl
         WcrxY8kBS0AYNiIdMG+/H7PaOgmJGQJ0N2np/U1iMEK4qzdO/0SiwpBzbAbMj2/NTmJ7
         p0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736685742; x=1737290542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1ktXxniTaO34Ok/Jjo815DE8byVSW3KIGjNme4BebQ=;
        b=M/pXQxmFUi+V7U57SmtnCmfnUMZA2DO23wTSSGR4l1BHu9MNkq5P3Tj6jsB5Vtgqof
         7zF04+TSM4huYaRJ8LSyq12P/I7gd3ioITRdm0y7DAxj8AzjTFOqU84LfM0ZA8RHjotw
         ewrKMKWC09NXx7yzI9Gj1Y/6+avMrSyGByL6+CdrZ95u4WinR3N3RH7tV/aWqPePCrKX
         rYJL4wJA3tsDMOpF/1iiQYkWM4+EbNzOY7iX5GyMuMJ7EKeCB07b4MUzKQwCfD/eqIUB
         TtxXO0oEdGAkMHEKXV34KHTpx+GanECfF20FH2aObvpLt9wolAWK8tWpQq41E08SrjXy
         XMVA==
X-Gm-Message-State: AOJu0Yxj+cf8HoNurSziLeEqxHTtEjH0FYoDX92VKrvTfrTM+Bgjz5V6
	zYzdmqG+ImF54M4yDrN4OZwG9OuAVMddXru2pCfDyPGZUU53kbot/npUs1d2WbY=
X-Gm-Gg: ASbGnctFY5Jk467+dAwkXLGK4tbm0KvslXNGHFksKcpGVRKEmvH6gpAAUftegpIkArP
	OZ16E0ODCXaYftaR5HVHZxQYEDT0s4rVPB7HXDJUbUN/eGm0WwIHyYaWovHqYKNB0eJYjyE3dWL
	o2TXjnhz25r6FXxQvPF1Af24pi1IjOYdWfnv3oTcnd+nQYsunp1wPelSkQU9C7wXL//NM+PLBSL
	CWB2dldAxQG/HcwIM+vlVSn7RNQepeXo3R2dxIqZin+Z4wX76SKm1LksN6yZ0kFT34ki9Lp
X-Google-Smtp-Source: AGHT+IFs2E295c2Hf631FizwR6ecJ4q2zrnvoT7a+sYTppI0fd/Uk4D7ciJLKl4yAXWcv+NE/sZ1eA==
X-Received: by 2002:a05:6402:5291:b0:5cf:5ff9:2a34 with SMTP id 4fb4d7f45d1cf-5d972e16371mr5607984a12.5.1736685742319;
        Sun, 12 Jan 2025 04:42:22 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99091e9absm3777087a12.45.2025.01.12.04.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 04:42:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 12 Jan 2025 13:41:55 +0100
Subject: [PATCH RESEND 4/5] can: c_can: Use of_property_present() to test
 existence of DT property
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-syscon-phandle-args-can-v1-4-314d9549906f@linaro.org>
References: <20250112-syscon-phandle-args-can-v1-0-314d9549906f@linaro.org>
In-Reply-To: <20250112-syscon-phandle-args-can-v1-0-314d9549906f@linaro.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Tong Zhang <ztong0001@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=967;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Y7Py9ATmugAtvfRo/YsRM3Wtk0WTgGLNgzgMx8AaCBE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBng7idrgq0Ihhng0hub2INpyez3rHxez8yrKQ4Z
 R10XXW+L7iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4O4nQAKCRDBN2bmhouD
 19oPD/4w8kbbvTgvNN8m5Sub35e9pNyIaH0rJd6FdznmwA19pUWqOWVkIFyErvfmXLf/SMADTeE
 qMI+RzNgR91LEvRo6WKZsLPfgHbg0Zc4j8kpM5PQPc2bw+jhUw7Vqpv06819wD21MceGaG/60Jq
 if74OHgPBWgSx7QF96rRME2Twdqjrc1ixhQvFiG92miOeV4PoL9RL6YKBxfrpnwvQ7k21Ckk77Y
 VgUnAIjb6ejpYNaWOc9o6Bc5nPOa/unSpn6R8iWPCQU4vzodR8lDFCFA1l0KZDt1I6tvjDI93yK
 9qTcKW8KCihLV3IE9XsoNqUdOItuKz1fXALO0wUYOw0HV19UbUgfUqTy9aRt5LYMDyoQuSxCf5G
 d7uOsgS9p+w63d28DNviMx7Y0aBLR2y76Ucyxqt1sxmg5oI4qOrc0Pj0270q5hRPY+OFjC7zW+t
 E4V7wP03vdmWARHYI6+p2VEyZzMR+mHOrazJCdFAdnyrwE2+xUd5ONgYkeF9JTxtlubRzC00BHm
 10f5Gj1rJWabr4NDKbX+aB6KmqPLZjj2D+fEBYnPqyHloOFhzBo4FqRHhrBFLyh47k5CQq3n88K
 L5KSZz6ccb8Q37n1sBJRfUrPBSt2oyUaOv73XQWS4P57WkbRFkc+MQb+vCfE94tmLJJkPghzY8N
 7ApfkATCGbr8SgA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

of_property_read_bool() should be used only on boolean properties.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/can/c_can/c_can_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 96d1225c41d0a93627015c4582c1ef1565f53174..1acceb097c17fb7c0e2095a43d926d9cf802ebef 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -316,7 +316,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		/* Check if we need custom RAMINIT via syscon. Mostly for TI
 		 * platforms. Only supported with DT boot.
 		 */
-		if (np && of_property_read_bool(np, "syscon-raminit")) {
+		if (np && of_property_present(np, "syscon-raminit")) {
 			u32 id;
 			struct c_can_raminit *raminit = &priv->raminit_sys;
 

-- 
2.43.0


