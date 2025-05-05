Return-Path: <linux-can+bounces-3541-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E95AAAB782
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 08:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1181715D0
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 06:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5283A7841;
	Tue,  6 May 2025 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPYtBnrb"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52263A6FB3;
	Mon,  5 May 2025 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487011; cv=none; b=N3m1cMWxGYFZyMCsUeipUbOn5jYw846mJ4T6KUL7N5XPH+tqagpuTdSCwUXLGJdBrzF1I0voqmXhiThzH9bgEf0AT3Z9Y5vb4HQsM3m4hGx/xNXAKu93LKV/ADYdjqR7UajT7WyuIT7NTvXFQfqsVIiPHD4syU6RJgYt7oXrkP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487011; c=relaxed/simple;
	bh=RB1GCYxJZRBjdfu7LkDBzuFWTa4iGUxDh2yLcwZrvbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fCLUWKtoYYYXgxGO5ik906dWziPUxm5yFX5LtAxGYrVz6+mU0d3jt/PkTMxfZDtG0J7/ZM4QRXUQ4YSrw8jTkky6fBedkGJWNR9ydKsSUmE+4AYtIh8mn+CajdmMbuv0qVFCvfBCZyI/cz0i1w+e4DYf9Jc+KroaMdFY85Pmf18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPYtBnrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87886C4CEE4;
	Mon,  5 May 2025 23:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487011;
	bh=RB1GCYxJZRBjdfu7LkDBzuFWTa4iGUxDh2yLcwZrvbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPYtBnrbXqxZUGdBY8hOmiK6TjP3lkwcGQIn147+3f+MMRf/OwcH548PTeqrrZMo6
	 yx2y3Je9OYV8sJ/BnLgR8QZ8prf+knOiVn67uDUeWbokxvlpzaXYbaouPRln2nAIwO
	 eQvV54yNR1zG9j1i/cw1bdW72pgFpwdhMYSWWyiRPjxVnJtpU8t7FxmL90BKHd0DMJ
	 ks7gV735VvGMjp1vL4o9jXb78rQqjW4KuW3lGD/52dva8KhJ75sbuJIRLV9lY11hNm
	 PWpTJtn4ieZfxyDn/rHCYZUnEps52a1uuKsQczdxJAJS8w57zol23CR7WpQ84vHLpE
	 K0sunltuMgQEQ==
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
Subject: [PATCH AUTOSEL 5.15 106/153] can: c_can: Use of_property_present() to test existence of DT property
Date: Mon,  5 May 2025 19:12:33 -0400
Message-Id: <20250505231320.2695319-106-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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


