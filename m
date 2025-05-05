Return-Path: <linux-can+bounces-3538-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D0AAAF89
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 05:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE7D7B1722
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 03:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991E83C01A5;
	Mon,  5 May 2025 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUjQ5/Yr"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBE8387534;
	Mon,  5 May 2025 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486681; cv=none; b=ASVN9SNsjYv0M7+ikCgRBXEzw8EIwpNlSLfh1oz5kWeJj8Haf6ZkqLyVoB2Z5SzNJLMjCESB3nWVasRPm6b7pUKctOyC5sFEQ0q4ldJdABtdQXnmOipikdYhLVSziKLfH1xanu/TJIgkiuy3L0iPJq5TWS+D6mHHnnVzQIvTYTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486681; c=relaxed/simple;
	bh=RB1GCYxJZRBjdfu7LkDBzuFWTa4iGUxDh2yLcwZrvbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K1EFhGQiyEuRpwbQbd9C8kRLGMOYvRwuCwHpggAux3fdyfuSujxsH1eraSBnGt3GRUnpQ5DCes7DNf6oP/TykEETVoqC0XsjUTStPSRDdVRRqwhGjJBnFD0vhINO20p1VI++ISaSITrdePoQfkostmu3Mibtte3eL04Qz5pbjiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUjQ5/Yr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7B7C4CEEF;
	Mon,  5 May 2025 23:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486680;
	bh=RB1GCYxJZRBjdfu7LkDBzuFWTa4iGUxDh2yLcwZrvbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUjQ5/YrfLdLAH4a5yyjfGLPGlE63iQi8y6HDTgsGRO0qzP00So+mohH9AITqDLjL
	 Qj6bzPrux+qX78Ekf+6H0K9/OhJhteAAdRBewKuhle4M6nXlngjHVHL53K2QqzsuVD
	 rhAnBVHdsXGisb/2L6t7Q0VTlK+KnY0nNNzq5lrY3Hqtu14Yz7Tp0HuKfZANOGFJuo
	 GGYXFps/vgUMnwCWEpQrA8SBtXfzHdTFtFpIf6sg/fVsoA6hvk/56fy958M2uIUy0w
	 SK/6mSDVj+DoaSouNhvC6UQjJ82vo5nB5xaZ4i0dFROpw0ll4GOacD6riJNVQX46CM
	 JMyWrH0OfItuQ==
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
Subject: [PATCH AUTOSEL 6.1 147/212] can: c_can: Use of_property_present() to test existence of DT property
Date: Mon,  5 May 2025 19:05:19 -0400
Message-Id: <20250505230624.2692522-147-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index c5d7093d54133..c29862b3bb1f3 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -334,7 +334,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		/* Check if we need custom RAMINIT via syscon. Mostly for TI
 		 * platforms. Only supported with DT boot.
 		 */
-		if (np && of_property_read_bool(np, "syscon-raminit")) {
+		if (np && of_property_present(np, "syscon-raminit")) {
 			u32 id;
 			struct c_can_raminit *raminit = &priv->raminit_sys;
 
-- 
2.39.5


