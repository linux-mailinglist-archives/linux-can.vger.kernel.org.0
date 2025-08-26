Return-Path: <linux-can+bounces-4376-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF14AB35A6C
	for <lists+linux-can@lfdr.de>; Tue, 26 Aug 2025 12:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC08C189CABF
	for <lists+linux-can@lfdr.de>; Tue, 26 Aug 2025 10:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AACE233D85;
	Tue, 26 Aug 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN+mb1zU"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D522817332C;
	Tue, 26 Aug 2025 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205604; cv=none; b=s2jcPWDPU3s1l2eTBZr9y0xI/zZS74xqb+06emApBV6/eh5I7BcspwCjPBeWBvZf+P21xcEPyAxvab7ugAYIWjCscF47BpXPTtcnFOfJA/SOlblhq1zbQMkItL8vYv+HORMzNfBP3NQNLJZv/FGxs1ehrBf9x1S31D5Ogk9QNCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205604; c=relaxed/simple;
	bh=3+ELfM0epNw1oYJH9C+GvtT6/HvOrgVds/sR7asWJoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X9m7na+D1e5N1xpz6bqGe2ZTI8iAufYZGS1QFKXenX9JPFzyUB3+GelmXqa2gqfG/5JtGImpMyko2T6PVFXDYJitl7m00+4fus0ueLOS4OtrynfG7wcqHHKynOMI0bPZM25g4QN2GyS6a5fcS11I6FNi2AOcfYEeMDE/TNZ3w0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN+mb1zU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65FAC4CEF1;
	Tue, 26 Aug 2025 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756205604;
	bh=3+ELfM0epNw1oYJH9C+GvtT6/HvOrgVds/sR7asWJoM=;
	h=From:To:Cc:Subject:Date:From;
	b=ZN+mb1zU42X/nR9y4HzjbelTu48wJ0RCwXKNByFWv7AIZVFYBz8flmL9tf1LlTHUu
	 i9koUc4xOZWcPvQoGbS2TWAXQ//2SFg2A7tLSEv+/0qyjtJrlgWOAB0y86lFJ7IVMX
	 XL61ntWCBPq3lees1OgBKW2JF2VzWt1y/dQgw7iBDKajZUUOvho2lzyxyUcHp/spkX
	 WusYD1Rj9jDYc8Y8h1cY9Y+7a8ipaljgqkVJ8eo8BfdOWvMj7BMeJSS2LN8QSZLofp
	 keTcFPok00/zlpnaDjyDFIoA9f85dU0Xvv2OCQhZMK6MkP/OUkC0uUTF88xkJBlYEx
	 /q1tMTs7BjRpg==
From: mailhol@kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH] MAINTAINERS: update Vincent Mailhol's email address
Date: Tue, 26 Aug 2025 19:48:39 +0900
Message-ID: <20250826105255.35501-2-mailhol@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2219; i=mailhol@kernel.org; h=from:subject; bh=uRq0zsJA2XwNh7TH04cWFbG7PtSA1N3oNyvMqNCeB6g=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlrJ7H/mfLwlk92+ZPKn2J7ZOOEtm7ZEa1/+p+Cv2bfX oMXUQatHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACZSdYThf92sh+4sD++5sGrd fpjfwmsSYLnL9iy75JHe9WcZ5SY3lzMyzNNe68JgtH9nYTFf0KW4Zmb22XwifF7zpe43/XhxZ74 TEwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

From: Vincent Mailhol <mailhol@kernel.org>

Now that I have received my kernel.org account, I am changing my email
address from mailhol.vincent@wanadoo.fr to mailhol@kernel.org. The
wanadoo.fr address was my first email which I created when I was a kid
and has a special meaning to me, but it is restricted to a maximum of
50 messages per hour which starts to be problematic on threads where
many people are CC-ed.

Update all the MAINTAINERS entries accordingly and map the old address
to the new one.

I remain reachable from my old address. The different copyright
notices mentioning my old address are kept as-is for the moment. I
will update those one at a time only if I need to touch those files.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index d9fa1b5551165..ff317a4887e2a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -813,6 +813,7 @@ Veera Sundaram Sankaran <quic_veeras@quicinc.com> <veeras@codeaurora.org>
 Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com> <vbadigan@codeaurora.org>
 Venkateswara Naralasetty <quic_vnaralas@quicinc.com> <vnaralas@codeaurora.org>
 Vikash Garodia <quic_vgarodia@quicinc.com> <vgarodia@codeaurora.org>
+Vincent Mailhol <mailhol@kernel.org> <mailhol.vincent@wanadoo.fr>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@intel.com>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@linux.intel.com>
 Vinod Koul <vkoul@kernel.org> <vkoul@infradead.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf6..2b5173d75d376 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5418,7 +5418,7 @@ F:	net/sched/sch_cake.c
 
 CAN NETWORK DRIVERS
 M:	Marc Kleine-Budde <mkl@pengutronix.de>
-M:	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+M:	Vincent Mailhol <mailhol@kernel.org>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 W:	https://github.com/linux-can
@@ -9069,7 +9069,7 @@ S:	Odd Fixes
 F:	drivers/net/ethernet/agere/
 
 ETAS ES58X CAN/USB DRIVER
-M:	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+M:	Vincent Mailhol <mailhol@kernel.org>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/devlink/etas_es58x.rst
-- 
2.49.1


