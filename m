Return-Path: <linux-can+bounces-3996-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D603B058C4
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 13:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526A43ADFBA
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 11:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7577D2D94A8;
	Tue, 15 Jul 2025 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="uEEULQfi"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (outm-52.smtpout.orange.fr [193.252.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57DC2DCF52;
	Tue, 15 Jul 2025 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578928; cv=none; b=Ip4y+fC84te/X4V5xcee7IqbBbY+DEECCyNEqjHuH3QDFx9EdbgZa/f6qazdsALIp8zYY4qAlGCck3K8PeCliWFnrZCaE3XB1kEJkJEYYgyM37HeRh+BDfNr6OmGlFyNeYM19yyP+wKlY14/FDZSEg+hiy8fCxQjdPNvEDCLE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578928; c=relaxed/simple;
	bh=SRFouP6KTmGEvHECL3xGuN9Sag3qvEGNII92JSVlT4w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q5csdeQDT6RwFbjA939u+e80BCk+Fk+IUxCbB8Pa9fiSgRK5LHkP+yDeJJauz8Ua1Bt9lBscvY4DJYYpRs+D9agulCOYn3mERSTG7aqctSp/vp7gk+iNtmDzsZae6ZihCNKVV53paZsg+6xiZgTZRbsv3NgygxNcj5sqxJHX9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=uEEULQfi; arc=none smtp.client-ip=193.252.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id bdpWuN5ypJXJvbdptuiCn7; Tue, 15 Jul 2025 13:28:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752578918;
	bh=Gbda2E+QCgjQl9RAp+V5ZDjWyAidFptJ/ApHzNNQBmY=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=uEEULQfiu6RluqOUsWVY5wYFOZPZZkpQDsP+ZZ0ExfACkf5AG8x4OfRkN5s3f11fw
	 kTvQm/vBUB2E6FJRNPgZc3v78U0tvba7eYtBxUr4p7/bKvlOybbWY4yjO8spDMQ9mG
	 k9e0HIImLt9H3LAdSZB/RkG4JXBm8q13+K5yxgg/mJ4vTNMkuspDbmVOBmAP5t2/6E
	 4CU+05wtH5iNQh6tdYQ7esxeNUaLuVng9290fQZuK1BAATbMgUaQyGNWlrMCLpRKin
	 mV82ftlAiQ1bdV0kghqDFeBKxB1gIUUIrOXzjDTs2bRnKRR1rnApxRNmwr9/AOGt4j
	 b+1yYpHVhr26Q==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 15 Jul 2025 13:28:38 +0200
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 0/3] can: Kconfig: add missing COMPILE_TEST
Date: Tue, 15 Jul 2025 20:28:10 +0900
Message-Id: <20250715-can-compile-test-v2-0-f7fd566db86f@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEo7dmgC/32NQQ7CIBBFr9LM2jFQIKir3sN0gWVqJ1FooEFN0
 7uLPYDL95L//gqZElOGS7NCosKZY6jQHhoYJhfuhOwrQytaI6xUOLiAQ3zO/CBcKC94VsobqbR
 VTkKdzYlGfu/Ja1954rzE9NkfivzZP7EiUeBN65MhYayypnu54HyMxzFBv23bF6BDxhCxAAAA
X-Change-ID: 20250713-can-compile-test-933d513473a1
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=SRFouP6KTmGEvHECL3xGuN9Sag3qvEGNII92JSVlT4w=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBll1mHua+u9s4KnPl9S329kMnn7ZYGsNRccovRkVeamG
 EzoO36to5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwEQWVzIyvJXvD62am/TP7nF+
 a8GOt9p6rnrmm+Z5bl1o4O1YUrfAkOF/yNYSO7Fb921jBFIUJ6d2J7Ks/nk5Q9a9OsLUP67iCQs
 zAA==
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The ti_hecc and tscan1 CAN drivers can not be built on an x86_64
platform. Add the COMPILE_TEST dependency to allow build testing.

Doing that, a so far unnoticed W=0 warning showed up in ti_hecc. Fix
this warning. To prevent any potential noise in some future git
bisect, the warning is fixed before introducing COMPILE_TEST.

Note that the mscan and mpc5xxx drivers have the same issue but those
two use some helper functions, such as in_8() and out_8(), which are
only available on the powerpc platform. Those two drivers would
require some deeper code refactor to be built on x86_64 and are thus
left out of scope.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Changes in v2:
- Add HAS_IOPORT to tscan1's build depedencies

---
Vincent Mailhol (3):
      can: ti_hecc: fix -Woverflow compiler warning
      can: ti_hecc: Kconfig: add COMPILE_TEST
      can: tscan1: Kconfig: add COMPILE_TEST

 drivers/net/can/Kconfig         | 2 +-
 drivers/net/can/sja1000/Kconfig | 2 +-
 drivers/net/can/ti_hecc.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 55e8757c696210292cfda6f1464991d6f5c4300f
change-id: 20250713-can-compile-test-933d513473a1

Best regards,
-- 
Vincent Mailhol <mailhol.vincent@wanadoo.fr>


