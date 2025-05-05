Return-Path: <linux-can+bounces-3539-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352FAAAAD53
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 04:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F6E17FE2C
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 02:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FADC3B19BE;
	Mon,  5 May 2025 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSiHWSz1"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C05337BE0C;
	Mon,  5 May 2025 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487249; cv=none; b=sjLSl6828jqlmHuROEcHh0YxsKdH+MZGIT46sGDmab8ZfCtao9ZgpVqLZKPeIh2fo4tGKoM9khnJVljc3jDkPMjrb6TR8U7IhVzZ4wiqIQP0/f8y9xk912/b4YBf5tBru4cki/KG6xnHSXKimOoXeVMmR7Mlz43bem74WoIUcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487249; c=relaxed/simple;
	bh=ctq2HEvnujahFPz7cH4UMcGubUAwVqWS3cYH6tARv/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8rEwJA5LfWohM31Usd/n9aSvBqF/gb69js30qLSQBmKl2xN2ukPd1WR5AIAh519DuFB3BonVxcq79jEh/G+72YMFBGe/7YE4DtcaMh+DG8W7A6T7W7+Xa9sr8EQ5BCU+uyFLSMeXjpTOOEumORD/rg4B7cGLnceAlMoIvlan1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSiHWSz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817FFC4CEE4;
	Mon,  5 May 2025 23:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487247;
	bh=ctq2HEvnujahFPz7cH4UMcGubUAwVqWS3cYH6tARv/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pSiHWSz1IeygHF4qxzWJBSoAxrmAyLWIsorCE7POnIRP/c9ylyMbFgr/ccGilKIKc
	 YDumluaQiz3O2TvFjHStnQQ2RJ4BonKQewrCfvhanW/jFU9tri8BLq5eL2LVTVy8Ed
	 dipYKiBEaetOg10py0eU+ENID6xvOG+AclBOtTJDyQQvgNz8nL/+fQBXhamMkqkxrr
	 NEXKwGAol8J+Fhz09YgTfXO71NpmXNLGtabx+Mn5IBo+Oq82aQIU/HtgoQiJGp7SBr
	 xN2b9cDeUGwN9Lb3PqCghPoH54wfO4ioYZ8i9EeiQTpavr1wEyXb2S2qftcjpKM2Sc
	 X2QzUlC2YqnZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	u.kleine-koenig@baylibre.com,
	linux-can@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 078/114] can: c_can: Use of_property_present() to test existence of DT property
Date: Mon,  5 May 2025 19:17:41 -0400
Message-Id: <20250505231817.2697367-78-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit ab1bc2290fd8311d49b87c29f1eb123fcb581bee ]

of_property_read_bool() should be used only on boolean properties.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250212-syscon-phandle-args-can-v2-3-ac9a1253396b@linaro.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/c_can/c_can_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 8f0dde85e3da2..1e0bf3405394a 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -330,7 +330,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		/* Check if we need custom RAMINIT via syscon. Mostly for TI
 		 * platforms. Only supported with DT boot.
 		 */
-		if (np && of_property_read_bool(np, "syscon-raminit")) {
+		if (np && of_property_present(np, "syscon-raminit")) {
 			u32 id;
 			struct c_can_raminit *raminit = &priv->raminit_sys;
 
-- 
2.39.5


