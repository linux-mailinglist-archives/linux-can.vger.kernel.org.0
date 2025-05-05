Return-Path: <linux-can+bounces-3537-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617A7AAAF25
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 05:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650A11895343
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 03:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF372F5F9D;
	Mon,  5 May 2025 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcNAgj5o"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDB92DFA4D;
	Mon,  5 May 2025 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486180; cv=none; b=HEvR7KuIwc1v1MZQYZiaZLuXu4fEqhKCTF5VpviaVLSI/OYXodlIJxh8QSjlcJGY4xv8JUNZZKGDJe9seATDHNCXFzAQxK/ydpyNFmR+Lk1S/fplJSKvMJsDCb416vGxbYJRM9uuj/TA2q3RYagUz5CPCFPXlpTSjrFvgAwLdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486180; c=relaxed/simple;
	bh=+BdJJ2xWjuR4qfYXG8rODyRJVYqVlhib4yqZHEzXxOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o+6bjvIR6KznuA2gBLjWqRA6XtCZGPt64vVsaLkPieOsbD6Bre2O9ATRSdoLmACaQptJxfg73GP59SLwvCI07GBiBNtBXtAQTgWliFsDl+3ZYQc86WPnoh9y4lactoEds+4ykUN0NiGKS1XpELsu0d7eySym/+vrYX489pEpEPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcNAgj5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1B4C4CEED;
	Mon,  5 May 2025 23:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486180;
	bh=+BdJJ2xWjuR4qfYXG8rODyRJVYqVlhib4yqZHEzXxOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UcNAgj5o33WjZXQ5HbW32kVjgMWP/ObblbzLiUlJGo6S+052uLcEW9q1pLXEAiCHy
	 HZnH6EGfKm4ZtXUBz4r6g+GWB6keEPLoExvFKrlpPp8a08J99A6v1Dvh86i9izzVhF
	 AthpCWCgdqM/AEvWQGjwgotGI370vVX+nQxPHnFO2kqECyOh3UCokO491k48+qE3x1
	 LiVW+kdw3LPv3y4pnxqAnU6Yd8gOL9fdUF4qEbqPNxvmwhyYjA+LvKZkh3J3q7jLO0
	 Ga9UkHVLAE+1jL+IKgRQyuvXcXixMp5Wchr1ux83hFq4t54Dof3vr0CYoIoqy5hFKy
	 XoiGTUgkOJVDQ==
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
Subject: [PATCH AUTOSEL 6.6 189/294] can: c_can: Use of_property_present() to test existence of DT property
Date: Mon,  5 May 2025 18:54:49 -0400
Message-Id: <20250505225634.2688578-189-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 7f405bcf11c23..603680792f1ff 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -333,7 +333,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		/* Check if we need custom RAMINIT via syscon. Mostly for TI
 		 * platforms. Only supported with DT boot.
 		 */
-		if (np && of_property_read_bool(np, "syscon-raminit")) {
+		if (np && of_property_present(np, "syscon-raminit")) {
 			u32 id;
 			struct c_can_raminit *raminit = &priv->raminit_sys;
 
-- 
2.39.5


