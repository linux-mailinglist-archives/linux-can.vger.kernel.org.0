Return-Path: <linux-can+bounces-2804-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE8BA330BD
	for <lists+linux-can@lfdr.de>; Wed, 12 Feb 2025 21:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16FF188A5ED
	for <lists+linux-can@lfdr.de>; Wed, 12 Feb 2025 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2B7202F9E;
	Wed, 12 Feb 2025 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w0KpcvVA"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB2202C58
	for <linux-can@vger.kernel.org>; Wed, 12 Feb 2025 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391808; cv=none; b=feTS+2a57jtbn6Yaw7+eLCH/XCqMMyYxtdKY9F9nPE0QxOZukaq0qVtSpxW4gS0QbXA4r/NrYzcCezqCrp4ULu5BHYOzm7i8o9KjAnI/0pFNuVQohTZWDhY5glawGOqr77yuu3g0OHXxeVs11xZW4zZZ6P1GhvCqNLEuayIhrx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391808; c=relaxed/simple;
	bh=YdLcJOKQc+JyEEQm/WKU7c1rP96Y/6AeinxtJg48yHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNT/YOolkCE79uiKfUmcK7FbRfPZU97fw62xpQLMc9q53eQH7XnNnhckLwzC7qaAot89FFWo+D/lU5Lr0RyEfeiF2240CZwfWYFmlZv2YUlbXd9KZedFr8IOs/L0N6Ry1zTrZZiHbni1nQmZR6BKRcWcT127wWrPL8SS993Rv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w0KpcvVA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7bc87197bso4365166b.0
        for <linux-can@vger.kernel.org>; Wed, 12 Feb 2025 12:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739391805; x=1739996605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3mNPU+LR4h3V6TxdDn8bLuYJ+/VeUr0D42fSLZpupc=;
        b=w0KpcvVAZl1gNpa6Ot6U1Hfig/JMz7Mv2uKcunlS0Pko1v2ApArWs0CHjT/BF5gBv7
         7PbgRHO9JJjq5VDwTlSOREk/7qXYZmcRB7L3eMyNoAaAR9AYXEJ+T8gmXXBg+OvFL6PW
         4RKVFwMi78hvOLo37Du8XZUxDr2fia+6da+k1XGnEYU6K/Ip4yj7qBKmYg4QUUMzCFCx
         DjZjRwmeqfUrFCpKkoge7Ezt/Rq3bapKJt3bTvh0DPBm6cAEz278Yt0yynNhnbgbiSeP
         mN4yAnbxUaS12iI8S0aGmdEj6tGAGHTdGDCFlYv5EwQYRtLLLM6qXAAuHzA7r7I29xD7
         w7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739391805; x=1739996605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3mNPU+LR4h3V6TxdDn8bLuYJ+/VeUr0D42fSLZpupc=;
        b=A2fAtiCpIHiOqEYk4RrEMIG5x1T/2C0gxpwFq5i7J6nEh1PyRz8jDTyRXBfJbt8dSX
         bz2lg3mijQs/PWkdLF+3hxGoraD0s1oQywbwv7pqOmSSX7t756F6GH/fyBnkP/BppfoL
         5zC5oC6prc6AnG0mGQEYZAf9wy/LfnGzy6rMtUEomay+k0rZVEA+AEA3q9Rh8Dfmjezx
         mo5RsiJr0w4UKlUNFDje9n9lwCMwnivIKNsoZwDe3xqBtS4t3EBZSA85w2QWcA4YTADS
         0mydvv80bmim3canz3629jAdWljGY6YF971Yx1KPsuKnAFFDtpK2eSfWjwUnIdewr2ac
         3PWQ==
X-Gm-Message-State: AOJu0Yw+cZuT6l6NWoNTv2Yz/kj8ZM0BU+XUr70kgYvPWrBSWT0wU0v0
	T7AmwLcrK08iZfUEn80R2LcPoqa6S1mquYg3Ix0/fRkHZRQdBW1Sxuk/1iPF4AE=
X-Gm-Gg: ASbGncvtQ2Vc6w3EqnZgx76gtxAyK7FrivBaFvmmp56Q1m2mp/Ux5tuBGEhyPcx32+p
	J7oh/lyzNtoBODTn/hJW8j+7rpkTK0dsTwBUjBvK0z2lnc5HvR88+j9fvt/qzghWsuMJoYcyr/e
	Uvt8PLTTTJt8nGzDpu434c9b2o41sfYxzaOBeT51W0NBRaAk/PO3bFKr7tRU2h+h9XFvlbUGXOy
	WelAINUReqr4FJGdtNzp/CbjKawiknTgOZOU81Fht4XP5R2l6Dj7Dl4x2aJv+2dtXd2n0QjM0DR
	vD0cRqg9QBo6wGiBLnTAyM/W8G70AJs=
X-Google-Smtp-Source: AGHT+IE8CYeuyLuHhWUOn+/Nntm5CLze5WPHM2552HvXledXoT2RwZTzv30yFuzyODSMwZlS20HT9Q==
X-Received: by 2002:a17:907:60d2:b0:ab6:eec4:c9c2 with SMTP id a640c23a62f3a-ab7f33cd42emr156854466b.7.1739391805326;
        Wed, 12 Feb 2025 12:23:25 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7db5ef658sm419660066b.42.2025.02.12.12.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:23:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Feb 2025 21:23:15 +0100
Subject: [PATCH RESEND v2 4/4] can: c_can: Use
 syscon_regmap_lookup_by_phandle_args
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-syscon-phandle-args-can-v2-4-ac9a1253396b@linaro.org>
References: <20250212-syscon-phandle-args-can-v2-0-ac9a1253396b@linaro.org>
In-Reply-To: <20250212-syscon-phandle-args-can-v2-0-ac9a1253396b@linaro.org>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnrQM2qWjKWqmymVGMAA09vBIR1+khsrxWWPPN8
 V4LEJnRj0mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ60DNgAKCRDBN2bmhouD
 189LEACGjro+mUt8FRa+Hk8icqyt1sckNS+OE5ueZbGmzU4z6C8037F9wjqHBxjX1QMiQxVf064
 ZJD6/IhRnZ+K4LddE5EDzf5HHRaJ9C4sdaPwNaDSUuqRVnfYTSclUO7na30rDSq76p0noXFIAV8
 no/FqXXJ5GkhvknU65pwboSoFmYE2leZ7gwfcijtv+30h6cCoEr24Wgo3bIxoBriULzJImWsOKJ
 18AqB96AmdM23QZyIK+BDdN4RZQaxSh+oq2qOL4D0TfUUVymmdAUde+av7owAF+FPuKYIIl+kcj
 w2QKw0ZvXMAxBLvRQakhFqxLIi71351jSg8LTJ4WNxb6tovmTg/ZY/8OenxeNZ7AifyMvitCfpF
 9K6xd8iockfLFsoWXpOlqOR+Xko3NBaiyqSSToTPI3gH7uqF0+Zhp7kpt/bymx6PxVjZKRRJQ5A
 BzxsoWzz1clTJDnZQn9zgAxIF6P8Jz5GtNj2g1QWBihosNw/5g1sIV5USnkZ4BioHaMVsWNDt5F
 Nu4hGEU7d6DIMGZQZblsFXJRBT9AjTTlW4sg33lKAaQ8pRYVio5wXKtQpPc+jR3ezMQOQQvdXFa
 k7GJf3ZeGxRygStwwgHfLoIkXvN359fm3jUVxagv5NYW02ROixXjUEcOff10xPUSY9fBt7JxzgG
 dUMBqVBqCU0sR8w==
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


