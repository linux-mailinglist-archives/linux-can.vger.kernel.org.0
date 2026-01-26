Return-Path: <linux-can+bounces-6309-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP0hB7iTd2n0iwEAu9opvQ
	(envelope-from <linux-can+bounces-6309-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 26 Jan 2026 17:18:00 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 860368A936
	for <lists+linux-can@lfdr.de>; Mon, 26 Jan 2026 17:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9203301C903
	for <lists+linux-can@lfdr.de>; Mon, 26 Jan 2026 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D362F069E;
	Mon, 26 Jan 2026 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ERkB9s1Q";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="r3Nbq1Cd"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F232AAA1
	for <linux-can@vger.kernel.org>; Mon, 26 Jan 2026 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444257; cv=pass; b=m5fYOSh0tuwdu9F4KuFpTbS3If3lYDGxNfwRJUW6E3LTwwFzD7MTBUmwWQROOLPxrcvCRw/WMv5sRwx9BOjxXtVBndtbn4U4WsUkrw2+NCC8m1mtUVnRmRcbBEVOFcmLGlf/9inBFNtmB602ifl7HmbIzUVOLlIpkmfuqgrPcqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444257; c=relaxed/simple;
	bh=7K+oHsOzPjHEeVAoU6PV+FA4S8ble+b5HJbCLJHoS+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q8aSz7O1Z9JnfpjT+4W31+xQsRYNonF5HhCxdWFrA/F01mAc4M8rjvRuFzABkPEb5CHy1CEYXHVafNlrRzzfsVT+jQrTngP49zfpyffqGL4I+//PDr++5ZDWFQ/0074oaBDRmBF2GEtxAGG3s2RO5TBU4amnJ0pre/YeGVtA1ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ERkB9s1Q; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=r3Nbq1Cd; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769444246; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lgzWCtQGeRtoRgdRjrr5yaB3x3fVJIN97y6MB2AwgxdxLKFlBGHMBom30j2QRe+KNl
    WBr4O+UYToMdqno0+BYGRbgHhLiJL1zI1uI6ZgFI8jOjHZ9Xb0MlVNhMbZXDeQfgiZrF
    RI++gA8G38XyAvO5afPuWz6r/RV3WriJf66f8VsrjP0jPFDB3jq8dlMErO0v7TSqx2Fo
    rdTDlPUPLbAc/orxS1fqfm1LKXLXSMob+07WgYkiaX9HkL74mNp96XQ3J8CU5SmSFAk+
    RY2eGA3CczN+h04hpBpGPwsJze1I8PEA3dWvvwfHW6LN1gOnL1G36Oyff51ybV1g7d65
    Fj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769444246;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=6eGxfaoUteg2AUvGr8a76peA4hTs2P6+s4JH+53hqOw=;
    b=iZ5DI/uclgvsAemUHbn2Ooq/bbczeMHX1bgKBrg+ctjeqPlqTugFruSk/OBzC6lfQi
    yZ7lbj8Tm6p08H2Ld/kvOugWhhSwoD93JNPvrPOITRNbTcEOeJ1Ih+t9eU8V6+xftZx1
    hxp1Wxufg43f/XZAPjxlCteCcZPYb5pAwzNG4W3izdT4aarmT5wG0raM4knunwWb1bx4
    TSENOSfwVt1pR4zTklXOv2YdxjVvEqQL5tcsXfTkpQwISgv2pnAwLzGuTW2dTETe8fm/
    V26u/N7zxGSUSmIzqZaW5YqmHqYtNdfwNgOszxMik7w0LraVtHkzHSYtNWnWeknlIUWJ
    NIsA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769444246;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=6eGxfaoUteg2AUvGr8a76peA4hTs2P6+s4JH+53hqOw=;
    b=ERkB9s1QRIAfbpBOa72hF9fWo6CgHjDeJGGza0sZIUa3Dqfu6o7xtq7LBrXXLTzn56
    438cY7OMmAAvPoysVwe4V8SC6CUhVJvtIVmV0vbLaC0MzqntmD9V+nvwxdQP+VJ8kBtH
    31UvXifKun4QDIaOV6vy16wTIkimWTXqAeKzQMOSMXDi0QJERriomrNV+kdqDJreAJp9
    KoOxyplsiVxw3KVJ8BaIIWq1G3V/jrvRZ78vZFGppNwU+9/PW+PC+BuGCd/01W1wUsD1
    IxdaoBd2xgoBreQT5NL2duqML8XFvNTcf2bK5lERNwlRhUCT1Li9U9YcHkiuzNEY0lrQ
    e0Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769444246;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=6eGxfaoUteg2AUvGr8a76peA4hTs2P6+s4JH+53hqOw=;
    b=r3Nbq1CdmRzWo4/XxnFVfhGOPn+QUzCAQme/Eoe3uSEl8paMslARWG8AOqbsjly/cq
    y5dWLEHfteehovpLRTBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8YjX10Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20QGHPdop
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Jan 2026 17:17:25 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
Subject: [PATCH] can: bcm: disable bh when updating filter and timer values
Date: Mon, 26 Jan 2026 17:17:11 +0100
Message-ID: <20260126161711.2374-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6309-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,75e5e4ae00c3b4bb544e];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 860368A936
X-Rspamd-Action: no action

KCSAN detected a simultaneous access to timer values that can be
overwritten in bcm_rx_setup when updating timer and filter content.
This caused no functional issues in the past as the new values might
show up at any time without losing its intended functionality.

Btw. the KCSAN report can be easily resolved by protecting the
'lockless' data updates with local_bh_[dis|en]able().

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 7eba8ae01a5b..5fde4d4db893 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1145,23 +1145,27 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		 * therefore (complexity / locking) it is not supported.
 		 */
 		if (msg_head->nframes > op->nframes)
 			return -E2BIG;
 
+		local_bh_disable();
 		if (msg_head->nframes) {
 			/* update CAN frames content */
 			err = memcpy_from_msg(op->frames, msg,
 					      msg_head->nframes * op->cfsiz);
-			if (err < 0)
+			if (err < 0) {
+				local_bh_enable();
 				return err;
+			}
 
 			/* clear last_frames to indicate 'nothing received' */
 			memset(op->last_frames, 0, msg_head->nframes * op->cfsiz);
 		}
 
 		op->nframes = msg_head->nframes;
 		op->flags = msg_head->flags;
+		local_bh_enable();
 
 		/* Only an update -> do not call can_rx_register() */
 		do_rx_register = 0;
 
 	} else {
@@ -1254,24 +1258,26 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 	} else {
 		if (op->flags & SETTIMER) {
 
 			/* set timer value */
+			local_bh_disable();
 			op->ival1 = msg_head->ival1;
 			op->ival2 = msg_head->ival2;
 			op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
 			op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
+			op->kt_lastmsg = 0;
+			local_bh_enable();
 
 			/* disable an active timer due to zero value? */
 			if (!op->kt_ival1)
 				hrtimer_cancel(&op->timer);
 
 			/*
 			 * In any case cancel the throttle timer, flush
 			 * potentially blocked msgs and reset throttle handling
 			 */
-			op->kt_lastmsg = 0;
 			hrtimer_cancel(&op->thrtimer);
 			bcm_rx_thr_flush(op);
 		}
 
 		if ((op->flags & STARTTIMER) && op->kt_ival1)
-- 
2.47.3


