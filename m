Return-Path: <linux-can+bounces-70-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5375880A9EF
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 18:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8507D1C2080C
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F32D27473;
	Fri,  8 Dec 2023 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZPjUlA30";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DBLWt2yM"
X-Original-To: linux-can@vger.kernel.org
X-Greylist: delayed 178 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 09:00:44 PST
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71171D54
	for <linux-can@vger.kernel.org>; Fri,  8 Dec 2023 09:00:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702054664; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gLKw9Nuqzz6qCPui3rc+BCSHoYAydteioAyOmJvBKAPnP3xNwTih7q/wK/2lAwZ+jM
    EnBRSe4/9gXoho+x0+3BUYGVJHXCPSFe1mJwfHR2s5vAHGbhoxeKC0Tb4cpY53KsVpWA
    dJQJqVKwNbispnBTIa+sYZDq964PpLcYjqBHfCgnEHDolh2Tuz+IHc5Xyp8GrQ80djuD
    A562Pk1VEkjmx1OPPdsbBnyBKH/pEw/NOLUjZxIzu30y3XoXdK9bsEdXBgrCLEmF4HgH
    eFXAGO43ycsYfncypBr0gCiQG/DE1V5ePp4+0mZ9qqo6fWz4crNqz9cgRpsSlHGMVDSV
    t/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1702054664;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=BOoXAIXA9WlH3ldBAHL9M84eRIpG/ZBAuO006AtCXTc=;
    b=S9wJQ3/lqYH5uz5h+a4w0pGAfSDx286/bLN9rVfBkzR0Ri1Yw7Q+QRO25HmiWRm7rc
    7CHeknENDZ0SvzEykKul03uHYSN0BplIEp84Q9TdiSPYRDYKVfVebMC4IE3onmFCFU+c
    GScErYtrdYSeutwkZ/fIk0ax/Wc7b3H1VVcLLAWxZGulmUOsGGXvGXRZAUcVt7f41GWN
    mKwUmIn2LeqpijrsmMjZTQsMj7iVDCOSDZnLGoCsvTnQNKXWIAGHhzEPGLWphsk+wWY0
    ox1vgFNIzperTbJD4jIl+gxB77BDnNQiOAZ1kjq7WTWgk6O8GZbkKZlc2FP7MRsw8S7a
    Nw6A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1702054664;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=BOoXAIXA9WlH3ldBAHL9M84eRIpG/ZBAuO006AtCXTc=;
    b=ZPjUlA30GEW5VmO3M6PYUrZ21KQMX1yBJd/qCzzqyXWYXviPK4T4RA1fhBdnGR1bva
    xhQg4gyBs5V9ROUML3P698OlP5iWoi30hixdmpnkXjKfCcVoXUytilX9gVk9+AmnXVJk
    SFb5lbM6jcVxifmy3VRRMdlA5RtpwxyNugp6CLiZo8xASTsvblAmtdgsDE/sOda9Fm7y
    eiAfIZabHXhmfCe/QP1PDmnAwP6Yi6s8vg3j2znwNFBPfG1iPqOvhr1+FOUkd7UNHtQx
    H++YMigFwqQcOdkEixrYvDjUuZgXdX0lnUyZyP0lyWyp9uDb/hdzs3NyTQun9ijBOyqP
    RsGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1702054664;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=BOoXAIXA9WlH3ldBAHL9M84eRIpG/ZBAuO006AtCXTc=;
    b=DBLWt2yMV4iRaSNCE2Irg4m7OOEJlFejFQ17i79nG5gHN7nfTWYcjhocZIZVO6DS23
    E61euPZSpMz4FoRSrgCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcehrrd"
Received: from blue.lan
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id Kf147azB8GvhD8S
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 8 Dec 2023 17:57:43 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: isotp: support dynamic flow control parameters
Date: Fri,  8 Dec 2023 17:57:29 +0100
Message-Id: <20231208165729.3011-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The ISO15765-2 standard supports to take the PDUs communication parameters
blocksize (BS) and Separation Time minimum (STmin) either from the first
received flow control (FC) "static" or from every received FC "dynamic".

Add a new CAN_ISOTP_DYN_FC_PARMS flag to support dynamic FC parameters.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/isotp.h | 1 +
 net/can/isotp.c                | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/can/isotp.h b/include/uapi/linux/can/isotp.h
index 439c982f7e81..6cde62371b6f 100644
--- a/include/uapi/linux/can/isotp.h
+++ b/include/uapi/linux/can/isotp.h
@@ -135,10 +135,11 @@ struct can_isotp_ll_options {
 #define CAN_ISOTP_FORCE_RXSTMIN	0x0100	/* ignore CFs depending on rx stmin */
 #define CAN_ISOTP_RX_EXT_ADDR	0x0200	/* different rx extended addressing */
 #define CAN_ISOTP_WAIT_TX_DONE	0x0400	/* wait for tx completion */
 #define CAN_ISOTP_SF_BROADCAST	0x0800	/* 1-to-N functional addressing */
 #define CAN_ISOTP_CF_BROADCAST	0x1000	/* 1-to-N transmission w/o FC */
+#define CAN_ISOTP_DYN_FC_PARMS	0x2000	/* dynamic FC parameters BS/STmin */
 
 /* protocol machine default values */
 
 #define CAN_ISOTP_DEFAULT_FLAGS		0
 #define CAN_ISOTP_DEFAULT_EXT_ADDRESS	0x00
diff --git a/net/can/isotp.c b/net/can/isotp.c
index d1c6f206f429..25bac0fafc83 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -379,12 +379,13 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 		so->tx.state = ISOTP_IDLE;
 		wake_up_interruptible(&so->wait);
 		return 1;
 	}
 
-	/* get communication parameters only from the first FC frame */
-	if (so->tx.state == ISOTP_WAIT_FIRST_FC) {
+	/* get static/dynamic communication params from first/every FC frame */
+	if (so->tx.state == ISOTP_WAIT_FIRST_FC ||
+	    so->opt.flags & CAN_ISOTP_DYN_FC_PARMS) {
 		so->txfc.bs = cf->data[ae + 1];
 		so->txfc.stmin = cf->data[ae + 2];
 
 		/* fix wrong STmin values according spec */
 		if (so->txfc.stmin > 0x7F &&
-- 
2.39.2


