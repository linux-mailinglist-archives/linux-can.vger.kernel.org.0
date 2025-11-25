Return-Path: <linux-can+bounces-5656-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8024DC8502F
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 13:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DAB83B169F
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 12:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6662F2D3A89;
	Tue, 25 Nov 2025 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YX6VUCkJ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="4sX5ANY5"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E783318DB1E
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074540; cv=pass; b=bl5QZDPZRz4E7QG+7EtbYSpZFvYz55EElrwDoAfkt3iTYTtk7md7CvU+ec5nIFXYhcVFm9xLDji1Jip2rx9rqCEWIBgap71s3zGLbLRrtdA8u/Hgb7TYhjR3zqofs5oEYd1zxFA3rf5exm9s3saFs/2KXdg/FpV7jMexzVhfseY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074540; c=relaxed/simple;
	bh=Hxof2O3UdzpM1ttMczPgbAMZ5GEMQTpZxZBjKp1EMEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMWl1WF/9It4rAaxgMbzwIfyA9j+pd4foggbkMa7RrOUnNP+cim+9GPFfvu5nXoRofMESPllUp/r42qY2mE0yez2pXm41/vZDSbyXmN/CRfGV2bVo5Otzc4Ok5EhZUNUeyUtxCrnoeDG97C6aeEwPuz8kWt0CpuxyomQ8nSMUHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YX6VUCkJ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=4sX5ANY5; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764074353; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CCMRugMlkYQrt6cPSzjjin9+DaNf1+tg6YRJECd7ikmr98APwNmUujTmcZR2vifxGG
    LCgfCPOnY4YO6m9mkqFKuVhMSxCbxqyViNJ6/K9ZHpGz0tsFia8PpE9vGAEU9iVFtAOw
    IOhZB+aXaCoJ2vMJlzY/G5RKUPFmRNT6QTh2BvptZJ3ioalODuuQH+lKSNsdOnODB8r3
    cdgR6Icb4yvMgvAPmETg4iSFiczozZtio5ZhVFTAWHfQlolMjpStPKpKiTsWo+J7/mj7
    pZtwR4xsZs1ZU5c7vJP1f39z3lWPeoJM8wTWMqShmvznqflB+al57Qiqo/fFPQjWV1mh
    OVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074352;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=z1K8d1Zvz4kmnl8uZijeDNjm5gkR4HlXB9xOBvjElzc=;
    b=kGBWcIhNkthqUCE+EKifL7xtDHqLWdEpOUXy/z3Y5brmP8OLXQiRKry5pFAPA75brM
    BUdWjPfmcBkbhzXZ7FrdCIPd/U/NvWcICQrrRBMm2cu4l70Nk/lmS8Pb4doPrcyHgxHT
    YkbVi/mMwU8FlewOty5QM1YXEUlcLGXXDxzbLWmMQC4tPF7M1ONyuizIAakGBB7CdRGY
    +HnvPNt2Fm1gIrBnW3nxrHnjSU+HoT561rCSKUndW8A9qzw9n7rNwkbwtB+AMm3TgsYX
    qIj9HkHLyTSen77RljcxoLkXVTIdxuyfTFe6qYbivdNvkTtULks7M4Zt9NWmXKUuWi6D
    ZnCg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074352;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=z1K8d1Zvz4kmnl8uZijeDNjm5gkR4HlXB9xOBvjElzc=;
    b=YX6VUCkJLa9cOlzFCguHCKWGbYiHi5JBmG1V70mbb8A8rEMTDYWINV8spf79X+xr3U
    5jo8CmuDfclbHEuQcwwq+KKjKDYiH8BIjZel/x51Kx36EBcli+lZrTE87nVYPRY8LYss
    TeOjQZorX3hA2Ck2tg/UKP8uTkxLm74fiIyLPWLsHqEpDclg4x3UIcPMeqvGnUlZzCgW
    td+7wIHAyb1pjOS7NJ69NkvEJ70436/fvCXRmFbolJt7b6HZW6TnTMjyM4Zy4HHzGq0Q
    Y3ftwyqR9MJ7mU6D7YGUyct/reOXpWaY45P71PKzcxHchMcRxtfezCpZ9bMNhIkAVnKK
    8cXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764074352;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=z1K8d1Zvz4kmnl8uZijeDNjm5gkR4HlXB9xOBvjElzc=;
    b=4sX5ANY5p9+W5HBWKu380FqUwVZsS+Q0ZTj6Cu75RAu+hRn0Fz1PiZkDpfkDW6G14X
    mUDvOPN5es+Evnb3CbCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461APCdCT8L
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Nov 2025 13:39:12 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Stephane Grosjean <stephane.grosjean@hms-networks.com>
Subject: [canxl v7 01/17] can: dev: can_get_ctrlmode_str: use capitalized ctrlmode strings
Date: Tue, 25 Nov 2025 13:38:43 +0100
Message-ID: <20251125123859.3924-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251125123859.3924-1-socketcan@hartkopp.net>
References: <20251125123859.3924-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Unify the ctrlmode related strings to the command line options of the
'ip' tool from the iproute2 package. The capitalized strings are also
shown when the detailed interface configuration is printed by 'ip'.

Suggested-by: Stephane Grosjean <stephane.grosjean@hms-networks.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/dev.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 0cc3d008adb3..735faa888886 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -90,33 +90,33 @@ EXPORT_SYMBOL_GPL(can_get_state_str);
 
 const char *can_get_ctrlmode_str(u32 ctrlmode)
 {
 	switch (ctrlmode & ~(ctrlmode - 1)) {
 	case 0:
-		return "none";
+		return "(none)";
 	case CAN_CTRLMODE_LOOPBACK:
-		return "loopback";
+		return "LOOPBACK";
 	case CAN_CTRLMODE_LISTENONLY:
-		return "listen-only";
+		return "LISTEN-ONLY";
 	case CAN_CTRLMODE_3_SAMPLES:
-		return "triple-sampling";
+		return "TRIPLE-SAMPLING";
 	case CAN_CTRLMODE_ONE_SHOT:
-		return "one-shot";
+		return "ONE-SHOT";
 	case CAN_CTRLMODE_BERR_REPORTING:
-		return "berr-reporting";
+		return "BERR-REPORTING";
 	case CAN_CTRLMODE_FD:
-		return "fd";
+		return "FD";
 	case CAN_CTRLMODE_PRESUME_ACK:
-		return "presume-ack";
+		return "PRESUME-ACK";
 	case CAN_CTRLMODE_FD_NON_ISO:
-		return "fd-non-iso";
+		return "FD-NON-ISO";
 	case CAN_CTRLMODE_CC_LEN8_DLC:
-		return "cc-len8-dlc";
+		return "CC-LEN8-DLC";
 	case CAN_CTRLMODE_TDC_AUTO:
-		return "fd-tdc-auto";
+		return "TDC-AUTO";
 	case CAN_CTRLMODE_TDC_MANUAL:
-		return "fd-tdc-manual";
+		return "TDC-MANUAL";
 	default:
 		return "<unknown>";
 	}
 }
 EXPORT_SYMBOL_GPL(can_get_ctrlmode_str);
-- 
2.47.3


