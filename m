Return-Path: <linux-can+bounces-682-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FEC8CF21A
	for <lists+linux-can@lfdr.de>; Sun, 26 May 2024 01:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31ED41F2164D
	for <lists+linux-can@lfdr.de>; Sat, 25 May 2024 23:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5427B4EB39;
	Sat, 25 May 2024 23:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="fMHhMIbn"
X-Original-To: linux-can@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B6138E;
	Sat, 25 May 2024 23:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716679536; cv=none; b=QrKpkjjn0CapkOJogMGKKQlPR1kpUbG76eJZvkoX/GFv2yCSB0HfiqKHqUix/va1wLylQRI5QElVLVPOWLDm3t3kfkWkGTtSml+FHKfGLN6l2e/wiPK5IeKLnQNtmysqQCL+Q4+I+A0QDcL5JGNLYAl6F+MeNF7An5wB74K2NZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716679536; c=relaxed/simple;
	bh=J/hnJWGEeZhRjPVcwBS8PBjN6KPW69jFwnimgLLpWHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJPKAaDj9TMvzRYrqEAI6Wu93d9odUCJsU29m4qHnaPDjEP4J2nf0zke9wQz6+3KIs+ikqLgwf4aVlI7NtU8U2etUNJ1dhyjsmBJAUZxF9c1h0GC85kqffCMJ10P5M02KzoW16bK/k2vH47MDJRigGQ1H77c+UH7rk6c62CAxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=fMHhMIbn; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=hBulauWzyakmG2rRh4tUuhkO1nkuiF/U5/PLahfKgdE=; b=fMHhMIbn5upjP60F
	J+vGqLt9jf8TdnPIOjvb8R40Pq+sxRpZ59BRDKPsCP3CsgjlaBCGQHsRIEf7Bv0frKacfEmt/458x
	QyIjQlCPsgQcUbYqL45lHk6HQxgD9ikH4LVJ1MYb5b3HGrqWhQq4NRdRFXLtOzty94xJ54DNk/hGH
	qIhJKuyg13gkfHizgkkzsOjBvEu/PMFNpdfYNoprLW5HDRkbAdN0mD6ixjb0S0WvsB3nNtgRcNGrE
	l75hd430HN6Z3nh2mRXMG4EwpP6zARhBPFnSvMvchNl3K6/TcGm4zmbrJF2mKXYDyZKW99yvzxzu4
	Vm+KT42qDqkQyPyGuA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sB0lT-002XiB-1E;
	Sat, 25 May 2024 23:25:27 +0000
From: linux@treblig.org
To: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	wsa@kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] can: mscan: remove unused struct 'mscan_state'
Date: Sun, 26 May 2024 00:25:09 +0100
Message-ID: <20240525232509.191735-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'mscan_state' is unused since the original
commit afa17a500a36 ("net/can: add driver for mscan family &
mpc52xx_mscan").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/can/mscan/mscan.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index a6829cdc0e81..8c2a7bc64d3d 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -34,12 +34,6 @@ static const struct can_bittiming_const mscan_bittiming_const = {
 	.brp_inc = 1,
 };
 
-struct mscan_state {
-	u8 mode;
-	u8 canrier;
-	u8 cantier;
-};
-
 static enum can_state state_map[] = {
 	CAN_STATE_ERROR_ACTIVE,
 	CAN_STATE_ERROR_WARNING,
-- 
2.45.1


