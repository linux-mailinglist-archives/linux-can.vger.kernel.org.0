Return-Path: <linux-can+bounces-6609-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE/sIdhDnGk7CgQAu9opvQ
	(envelope-from <linux-can+bounces-6609-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 13:11:04 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FD1175ED1
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 13:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A20803016AC6
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD4F363C6F;
	Mon, 23 Feb 2026 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SWiXymF8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8B135C1B4;
	Mon, 23 Feb 2026 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848661; cv=none; b=NF7HZTCp2FfFC+3kQ0P1XWtrBG2MVqzyyHokpAZTTB1Pc5se3qBFwRqUkkg3qa1AcQm6NtWTr6IM9sQ5LhsLKlGweg1r51MIX9UVVggah4gw1BcZb2xlKjN9JmujcCzN5qmF/YBSbxY8FsTPObA1ZRqp0weCq0AK5QpAywBc1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848661; c=relaxed/simple;
	bh=wsal5UlA7n4GfHF3W/xllNhFzDs6+1ZPRAdhpx6QuzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1gL0GhJHERx3tZmriOGMDE47FPaOiK1B90dj3CPY4PtfQqaEqAx8Cv0gOnSd4YOByJOu/z97ltg5ltvPhjaLLPzi3OI0gdL7nO4vpkWmw2LDEqC0NNu9dqIbYtPqYbmiPXW+8xC6mtNMehB+OSUYJy3OP1n1UkdP1kGXorVD84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SWiXymF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBCFC116C6;
	Mon, 23 Feb 2026 12:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771848661;
	bh=wsal5UlA7n4GfHF3W/xllNhFzDs6+1ZPRAdhpx6QuzY=;
	h=From:To:Cc:Subject:Date:From;
	b=SWiXymF8T/Lp9bMbnDt1gx1J+JAHQUQOh1IUW8T1MGRBjghBVWLcqMkNiNbGXwCrI
	 cEJ4ZMFvqP4nXiRcm/N+Qz9n6LeW5Ebptpf2xRRnwTmv5mPESmCihR2w94NLQW40l5
	 7uuvvW0YgbjTVIIm2ob8D4RLS1CzxhTADNNRTzYw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	stable <stable@kernel.org>
Subject: [PATCH 1/3] can: usb: f81604: handle short interrupt urb messages properly
Date: Mon, 23 Feb 2026 13:10:30 +0100
Message-ID: <2026022331-opal-evaluator-a928@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 32
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=wsal5UlA7n4GfHF3W/xllNhFzDs6+1ZPRAdhpx6QuzY=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlznLeznfmZtawm4/ScxjxLmwV8LRUhn4uMQu70LHp7N XVZM/+JjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIutsMC5b1LO7yMdn9YueP tTlpPJ4MVjtF0hjmx/uVzDGV042xXiBj8PdK8wn+jclfAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6609-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pengutronix.de:email,fintek.com.tw:email,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 41FD1175ED1
X-Rspamd-Action: no action

If an interrupt urb is recieved that is not the correct length, properly
detect it and don't attempt to treat the data as valid.

Cc: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/f81604.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index 76578063ac82..c61bd30d1765 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -620,6 +620,12 @@ static void f81604_read_int_callback(struct urb *urb)
 		netdev_info(netdev, "%s: Int URB aborted: %pe\n", __func__,
 			    ERR_PTR(urb->status));
 
+	if (urb->actual_length < sizeof(*data)) {
+		netdev_warn(netdev, "%s: short int URB: %u < %zu\n",
+			    __func__, urb->actual_length, sizeof(*data));
+		goto resubmit_urb;
+	}
+
 	switch (urb->status) {
 	case 0: /* success */
 		break;
-- 
2.53.0


