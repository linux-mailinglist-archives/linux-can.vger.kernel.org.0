Return-Path: <linux-can+bounces-5594-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D55C7CBD0
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 10:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE4D3A8B05
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 09:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE20221F0A;
	Sat, 22 Nov 2025 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Shy4Z9yh";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="5uUKyKEL"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F072DD60F
	for <linux-can@vger.kernel.org>; Sat, 22 Nov 2025 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763804182; cv=pass; b=uKUVSQoooYyskDWx+EmVw7iBvQJ29khdeEI+botnIHsDXfwxkdFICx4RP4nA8wbyvX2vLrNdojhoEx7n9GWdOaXYZomZ/YPZv8T6wBwbIJSm8XFN7GzpynrTrP7e9/z40LezgfjVJC37REZNMKiZRUr+YyPX5kzLgUWxPPk+f14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763804182; c=relaxed/simple;
	bh=Hxof2O3UdzpM1ttMczPgbAMZ5GEMQTpZxZBjKp1EMEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGHLrAL4+nRdCnMQZU0e/1FKGTWNyTLG2I8gCkXK8n8Br64dsxT1Ir+KoKCNnu7ZrOsl7h73nA/n1XOgBr69N4miS83DU/2o6IWwJUe/xhZIfRQcf7pCWdIgiFmqa5qBm9SjXu+7oe4wgrBzIIfxLEZKJ8cr7I+EqXA0yd9zcbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Shy4Z9yh; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=5uUKyKEL; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763804168; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=X7rDRwP/kTK2HC2URpkQgl94QrErqhByOQzAGLEQN58HSIUzPvmkmN/AwqNot0bPvI
    xqLY3iiBOE9jW1TJrs/pDzU9TWm/NvZ31engG4lH2uBiTRZre4V3eAbLoeqvxgPl5ixR
    CY4fnMkz4DMrpQQNZV+x2ofhFgFXyOk+PXvgx4KygJY1+AT9dZIZy9NaOylW2FQA+67B
    RP0hWOAjYNQIRfdxpjRw/Rol7uaQXosDAguH5kli4GnoqZHkCt30gHmNBSqrGo3lDY1d
    iHlkmNUcHJruSupJJV5pILixlbONkM5FixuXDwNYFfG5OCWNo7HOXZs+H3rmN8WVK5Ic
    0l+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804168;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=z1K8d1Zvz4kmnl8uZijeDNjm5gkR4HlXB9xOBvjElzc=;
    b=AbmtHCbRAge7QYIu23DGTojkre64oMHUYNohIozOki4jznRj8EYuYTQqDH+6okvLAt
    YHkVZebREYLJ+viGCUictEhzAr4kgfFS9axrpqXsM8qIgmgCCwExH+0RuxcrE9rV8mH+
    g+6XaUx3Fm4TzdnmCFpdRlQ7kbyunZ+wdeM2dD2BxFgd1lyBwBJo/yIJdynnYVKyf2Rd
    U7UAsdsv+zy9IUJ7g5HcxjW3vmxLpjGDkkmkaTcOqVWhIaehyR8sE8jtwgGGv1DJ4TtN
    7DkQaGEf4Fj4Qude8Fe7dmU/ZkTg1Fxf0+NbIrOx3UfFHV28xjgtI9uuyYqBVvWOyIQD
    nZKw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804168;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=z1K8d1Zvz4kmnl8uZijeDNjm5gkR4HlXB9xOBvjElzc=;
    b=Shy4Z9yh2IZKfBtp9qESDh0fLDfVDindyfQrNggB50GxExYIHHgHadvQoO+Qv3sbJG
    enZ6qiptOSbXmWT4CPvq95q+JwAA+14BHqMefzDGp1PwJSAUqCbrICZR6hNIusRJZ9Wa
    +IGsB/zVwzKCBfLgoqwgNlNxv79ESVGBSvVD2lkiJv/kigDEXtthTeXapCnQ2EQ90VwE
    yLHvOIwaB/wHOF0IQBVgfpLRlPSrKOzUq6z8NQQ2rhtvD4wj1kg9qh8GoXUuquBoE9hr
    4KmVoocdejahNyVeCPg/nk+AED6jcU5WRj70mpYLybnvihRZhu6HjjNa27m31DIp7oLO
    h+gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763804168;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=z1K8d1Zvz4kmnl8uZijeDNjm5gkR4HlXB9xOBvjElzc=;
    b=5uUKyKEL8hKvk53HECJJnleThz8Yk2rXybUcgAKj4+t5jAFyuSuBVH9XTzh1IFI13H
    ILWkEceeR5n0pVWLOdCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AM9a8Fdl
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 22 Nov 2025 10:36:08 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Stephane Grosjean <stephane.grosjean@hms-networks.com>
Subject: [canxl v6 01/17] can: dev: can_get_ctrlmode_str: use capitalized ctrlmode strings
Date: Sat, 22 Nov 2025 10:35:45 +0100
Message-ID: <20251122093602.1660-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122093602.1660-1-socketcan@hartkopp.net>
References: <20251122093602.1660-1-socketcan@hartkopp.net>
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


