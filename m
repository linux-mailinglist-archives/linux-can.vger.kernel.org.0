Return-Path: <linux-can+bounces-3535-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83D3AAA594
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 01:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A775A3E7A
	for <lists+linux-can@lfdr.de>; Mon,  5 May 2025 23:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67533146B9;
	Mon,  5 May 2025 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8fygMUu"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC583146B1;
	Mon,  5 May 2025 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484220; cv=none; b=i/m87tqRja7jVkr+alCg9mK4R/ktsQslfxTTtiSxULOgT1Lq/Qj4gZxQq77aefGtMTxH3FZ02WcNK+ZEmj8Q+h4gkEkTFD/1DshUYGh2/wLGKIMuDCZJME+RYjLgCdQGTYAhVuzJW3jgJ4C16IeAI3Ds4yPozxSscrm9tgaDFi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484220; c=relaxed/simple;
	bh=PWQwL/8lGJrL3olWT3owPFo7svYEz7+bqRzTKfO0nmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i4X6o6Ai/l7kXp174pKbKsbHIpd6ezktPf0ACGcb4KQ0LxjDgP5s9SZyzyGYYIZUt4gJlV+c8CEI09ypQDad0vnOpaEIqmjjR2b4RjjdO47MJpqn9XqKSGzYYfjEQcA5s3/q4auP6VSEVr3C6two/CqfImjcnyEm6BWzVJbIXhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8fygMUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9CAC4CEE4;
	Mon,  5 May 2025 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484219;
	bh=PWQwL/8lGJrL3olWT3owPFo7svYEz7+bqRzTKfO0nmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8fygMUuMBU9Y6uRVUowbOB0prTLCAyPTGn16vo3+McnE/0oBFOAD0SMhDY5c8Siw
	 UnWeDPZNHvf1jHS5BLT9G7FdEPavPFWtZVDqZUmstaIZGfIgfph0c89mEZGdzqaune
	 HJ4BoMt6VdxOoW7JfwZ5klYrQ+9GZIu7RLtZmjqxzGpxrxApLhk70ayp0fEksJ2dIx
	 J7Q0V7Vle9eylFLPUpDbve2ubgSgRJoxTNpkiGNOLQFvt12N6YKC1cZH34AI3VcrBn
	 d/qNtdzIoSDgEYrRWl05X1jwA/cphWMdK/hHLJ9ycrE+Zyc1B/z8pY0/2xjskcxWAG
	 +4MDSKJOTt/QQ==
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
Subject: [PATCH AUTOSEL 6.14 393/642] can: c_can: Use of_property_present() to test existence of DT property
Date: Mon,  5 May 2025 18:10:09 -0400
Message-Id: <20250505221419.2672473-393-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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


