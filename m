Return-Path: <linux-can+bounces-3540-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AF5AAB64D
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 07:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F051C04C27
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 05:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F2233451B;
	Tue,  6 May 2025 00:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5hSHyDx"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86505283136;
	Mon,  5 May 2025 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485436; cv=none; b=i1O+bOIbTz30yOhQXz0V+/V32m76O/btpCj/Pi5p7OmifiZzLxXsl9sVsNLtY642U2iva6A0EpZIIclgHO33jWkckSpf6bRxT502ik/jGJJSXhBnl9erKP2+e9HkEmGY1bZWgZ0uFZyFc0gqnZIU23AxtSuaNjaHzADgMm3lqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485436; c=relaxed/simple;
	bh=PWQwL/8lGJrL3olWT3owPFo7svYEz7+bqRzTKfO0nmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJ/zQFdyHpbz8JumqBBLIdkznbBYZgf1ykyVrilad5CNVl+U/+Vb0BcYRsu3L75KZrb6vTfdqA2eSTvpu1Z0ZVQ2xjeh0BSlN97/R8auiRgDgS0n2SMQiLblcEUPIR8NSSBCE9lXTR+k5yOLUhATnglNy3mAdwsOwwwEEbYH4y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5hSHyDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CB6C4CEE4;
	Mon,  5 May 2025 22:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485435;
	bh=PWQwL/8lGJrL3olWT3owPFo7svYEz7+bqRzTKfO0nmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u5hSHyDxMTSfZrAw6mHO9Hf0NdYCi6GquhuNYyl7qj12XLUtsDELcHBReAZkcdz4h
	 jv99vtpVLoRXfRQNh9nkLJkPXZM13Y4HLDfAaBXQI+h1k+/2EtTKEfbQCCkZC9XpS8
	 EjLOW+OBVAAmwb3//fYIE7Iu2fYsh0QWQNq4CFI7nKTKNBzFOIDVGufHPwepX+5vr6
	 mhi/+NPT5XRVB+QM3UdsIIgsoJaOhTQwlvo1vztSKygXqLuOAxoL8dR/MWe2OKpXjp
	 QAe99gE9DX0NbVDArghWMAJlXQrVnHPEfiaHKYd9oGZmAPjyieCdyG7Y/4A3AiQOua
	 pvLd979zUa+ug==
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
Subject: [PATCH AUTOSEL 6.12 309/486] can: c_can: Use of_property_present() to test existence of DT property
Date: Mon,  5 May 2025 18:36:25 -0400
Message-Id: <20250505223922.2682012-309-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 399844809bbea..bb6071a758f36 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -324,7 +324,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		/* Check if we need custom RAMINIT via syscon. Mostly for TI
 		 * platforms. Only supported with DT boot.
 		 */
-		if (np && of_property_read_bool(np, "syscon-raminit")) {
+		if (np && of_property_present(np, "syscon-raminit")) {
 			u32 id;
 			struct c_can_raminit *raminit = &priv->raminit_sys;
 
-- 
2.39.5


