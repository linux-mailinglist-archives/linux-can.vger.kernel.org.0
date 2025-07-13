Return-Path: <linux-can+bounces-3971-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CA0B02F4D
	for <lists+linux-can@lfdr.de>; Sun, 13 Jul 2025 10:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160354A0188
	for <lists+linux-can@lfdr.de>; Sun, 13 Jul 2025 08:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D700C1DF26B;
	Sun, 13 Jul 2025 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="V99KZ+iZ"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75A32AD0C;
	Sun, 13 Jul 2025 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752393888; cv=none; b=BkSeGf9iHEZ+vGk8EZSOFUMwUKvzvZt6oerMn1HSGGWfUxBpK8HD1TkHawufZU2TajODpUiNe6NAF04AyI6H0ssVIGK/tktvJUd2yO162Y+dZIftCAh5fks8sVh/pgGsIPUoUKzNy5Aub08ON+DIiGSaPdRelhYvb6d2L1saTUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752393888; c=relaxed/simple;
	bh=2Rjie1sDvmMpKC9lot54elqnsJb0YSgVo8ZnhBCeOtg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OMT1GWIkGRiSeeZnstWonxm86qipQHeMMwgWhwQOA75LNKIHuSFChWIzUXcHdJja3Gsy2kQ89CAHVmCF28Lws7LCPZ/G23KDBSUhqRiuqUgW5qYRpBX3e/ewQMb4Ae0bY4NYra5M4FoHz8RLin3oEBEXtkU5zFz0sTax95kkfy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=V99KZ+iZ; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id arfyuJE25DfrTargKuRCGY; Sun, 13 Jul 2025 10:03:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752393814;
	bh=er9G+dUjTMeiQU31gsvxm2Yfw1LZCuC8vZZLytsSHT8=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=V99KZ+iZVhNWvZYpbdus6Eg1lGOgdIQvABro+6XCO6r9SrR1flbjMxMmEod4CI5ZZ
	 JMTGQnnoPLZeUsJLq30uX7SJZyFceSz/xvKVM1KxSvSCkOc1ETUvk7GbtsSL2+B+HG
	 b9DQ5elpwltmT9gTUqMTCk3Bxqm2cRtHDs09XFZlIVwqKVDpKh5lksKsjiEBsh+FE6
	 UiF8g/LoPJF6mkoY8TZkY/CdYoAA0mSztWsmP45IOVNeVhtIxmCRgsD90W2yBU8L8M
	 4ft7xfglSAalqHtfkKOVNg0aPMq5SG1exNwvWHFPhXaF085SlGlFVViWMmcCHdeu7v
	 Yzp2SkCNQwGDg==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 13 Jul 2025 10:03:34 +0200
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 0/3] can: Kconfig: add missing COMPILE_TEST
Date: Sun, 13 Jul 2025 17:02:42 +0900
Message-Id: <20250713-can-compile-test-v1-0-b4485e057375@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACJoc2gC/x3MQQqAIBBA0avIrBvQpoi6SrQQm2qgNFQiiO6et
 HyL/x9IHIUTDOqByJckCb7AVArcZv3KKHMx1LpudWcInfXownHKzpg5ZeyJ5tZQ05E1ULIz8iL
 3vxyn9/0A3yCsGGIAAAA=
X-Change-ID: 20250713-can-compile-test-933d513473a1
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=2Rjie1sDvmMpKC9lot54elqnsJb0YSgVo8ZnhBCeOtg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnFGW7s63fW8fwPTTO6fLmN+3Cm3bPuAvbz7y+9uTTh5
 W6TxY1/OkpZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAExk5SJGhs/HvrYefm3cG7z6
 wfLqwvyd//Ya7mR8kFAqP+sjg9zu3R6MDHv/fW/+c53nAItnpa/txB2rIzNnHzwWxNxZHLfYUda
 ujRcA
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
Vincent Mailhol (3):
      can: ti_hecc: fix -Woverflow compiler warning
      can: ti_hecc: Kconfig: add COMPILE_TEST
      can: tscan1: Kconfig: add COMPILE_TEST

 drivers/net/can/Kconfig         | 2 +-
 drivers/net/can/sja1000/Kconfig | 2 +-
 drivers/net/can/ti_hecc.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: a52f9f0d77f20efc285908a28b5697603b6597c7
change-id: 20250713-can-compile-test-933d513473a1

Best regards,
-- 
Vincent Mailhol <mailhol.vincent@wanadoo.fr>


