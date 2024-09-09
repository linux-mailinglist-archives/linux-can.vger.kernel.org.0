Return-Path: <linux-can+bounces-1454-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB31971F0F
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 18:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1860C280F11
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 16:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF60146D42;
	Mon,  9 Sep 2024 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUFhMo1a"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC62213CA81;
	Mon,  9 Sep 2024 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899070; cv=none; b=aqwEQ2fTGITdLeugXoJVVKh96Bgz9VSSMGag5ZYt58WWYed2sT4TgY9oNgo0AbaaIaOpiKRB9Ivf9a2r/T94YntZzIAK1MBJhnjmTH08G4IDszZfx581j16g0ZI+GY76iJaHzXH2mUq/B/9W0eCty4TyPlCjneYlot6n+ySEPIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899070; c=relaxed/simple;
	bh=Z9KQaBMYa5sFKDVDG6vipFDugxmhAcXo+x7jIXMTm4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=REmk7t59vy/18VNlYbtBn6iBaEwRtRhpTB1p2ZYCNtfGwmhSpTBt6hvKxgYv8+I5bSrslwJFsV5adsDwjdyGy/+H50hIYOe3ID7NggPlfBc4YLKK1eqGyKTW5xBCI5ifXwhL7zq68H01tr2fq0JKHLlQsLl0AKROye5gamKivxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUFhMo1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1663C4CEC5;
	Mon,  9 Sep 2024 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725899069;
	bh=Z9KQaBMYa5sFKDVDG6vipFDugxmhAcXo+x7jIXMTm4k=;
	h=From:Date:Subject:To:Cc:From;
	b=nUFhMo1aVL0SZ26zu0BGprNSrg8esC9sKfr9Uhd9jg/awvZA907m1qU8mpnp64FFm
	 ouQ7SY4t02QysCMRIwsc3Cvli6U6OYOyLAxkZWPaNs6rR6BSzK+EFOgjzsCuNcb1mk
	 iLa0Q24Qk0dtrmGSlpQ0ezEsY9QySiqVvrvKN0H6QZhsqbgYns7JovokeAGHke5K+x
	 Zav3hP4vtBFKiBC/8WC14H+TB4So04Mywvw8c42k4LRs2OOdkaFK/V7rBu8Y6Wxg8K
	 unbMZg831bE/l0fBQX+VI6xlGGfX60RaxpFqjXeQdtQ1HKkLeBAbCNVvp5TygqfUhY
	 Tp3ICMpAeku0Q==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 09 Sep 2024 09:24:25 -0700
Subject: [PATCH net-next] can: rockchip_canfd: Use div_s64() in
 rkcanfd_timestamp_init()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-rockchip-canfd-clang-div-libcall-v1-1-c6037ea0bb2b@kernel.org>
X-B4-Tracking: v=1; b=H4sIADgh32YC/x2NQQqDMBAAvyJ7diFqKKRfKR6SzaYuDaskIoL4d
 0OPA8PMBZWLcIV3d0HhQ6qs2mDoO6DF65dRYmMYzWiNMw7LSj9aZEPymiJSbhJGOTBLIJ8zBu/
 Sa3B2siFBy2yFk5z/xQeUd1Q+d5jv+wFsvFrEfAAAAA==
X-Change-ID: 20240909-rockchip-canfd-clang-div-libcall-ba9f619434bf
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Z9KQaBMYa5sFKDVDG6vipFDugxmhAcXo+x7jIXMTm4k=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGn3FW0upoUKl7aqfFFYZn1Cp+1punwQ75573+3fRvc8n
 lCamsbRUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACYS4cHwP/MzDy/DIpdboSzX
 v/7dbybqzzFHbs7kO2aK7/8Ia4btb2X4n/BILDIvXeTg6i9OOXuMgt9enXpGUawva6FZ2/kE4QJ
 dZgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with clang for a 32-bit target, such as arm, a libcall is
generated when dividing the result of clocksource_cyc2ns(), which
returns a signed 64-bit integer:

  ERROR: modpost: "__aeabi_ldivmod" [drivers/net/can/rockchip/rockchip_canfd.ko] undefined!

Use div_s64() to avoid generating the libcall.

Fixes: 4e1a18bab124 ("can: rockchip_canfd: add hardware timestamping support")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This does not happen with GCC, likely because it implements
optimizations for division by a constant that clang does not implement.
---
 drivers/net/can/rockchip/rockchip_canfd-timestamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
index 81cccc5fd8384ee1fec919077db48632f0fe7cc2..4ca01d385ffffdeec964b7fd954d8ba3ba3a1381 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -71,7 +71,7 @@ void rkcanfd_timestamp_init(struct rkcanfd_priv *priv)
 
 	max_cycles = div_u64(ULLONG_MAX, cc->mult);
 	max_cycles = min(max_cycles, cc->mask);
-	work_delay_ns = clocksource_cyc2ns(max_cycles, cc->mult, cc->shift) / 3;
+	work_delay_ns = div_s64(clocksource_cyc2ns(max_cycles, cc->mult, cc->shift), 3);
 	priv->work_delay_jiffies = nsecs_to_jiffies(work_delay_ns);
 	INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);
 

---
base-commit: bfba7bc8b7c2c100b76edb3a646fdce256392129
change-id: 20240909-rockchip-canfd-clang-div-libcall-ba9f619434bf

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


