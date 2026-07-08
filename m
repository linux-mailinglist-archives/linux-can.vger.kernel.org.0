Return-Path: <linux-can+bounces-8128-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LWbhFqxKTmo1KQIAu9opvQ
	(envelope-from <linux-can+bounces-8128-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 15:03:40 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AE272695F
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 15:03:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="GU7+/CQq";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8128-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8128-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED131300B53F
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281E7213254;
	Wed,  8 Jul 2026 13:02:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C59233947
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 13:02:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515724; cv=none; b=XvJJlC2kNVgWvAZE8PLjuhxVuZp8PFY3Jn0+k5OUlIOAEPZ08OdVFKoY/Ta1OIqT89Of4Zy/cr4u8nt5wgYmvKSw6wepu4K/l1VC5IMbuQ3OPpZmT+kyjdXSVtq6cKdGLJjgXtslULMJGD6ly+ZdzJxtJ1KCLOwmhS84ht5bkas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515724; c=relaxed/simple;
	bh=4JU2q3mtR2wS+Nw1c00/a25L1KenoBvbQ0NlzwKTufk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DU3E5AJvsDCVZ6H0TNHhhoWKcMuI1Zl/Fp61T32NAYyI0+S6IOHiHw3WAvmRSdt8yRueYkaalaDJwxejnvN8FN8mPVH1lV0F0rBvQ+flY+d9ZaeCv258LJq1TLV5WFk067TwFPZj59qXlsEgjpApRMFU471GEL9NwqFV4CYUVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GU7+/CQq; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso7136265ad.2
        for <linux-can@vger.kernel.org>; Wed, 08 Jul 2026 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783515722; x=1784120522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PHqORVTQXLEwN5n2TZklcKo7QLlfA8Vtj176/nlR0Hc=;
        b=GU7+/CQqwWGeLuYhrbqORtLE8LNngUlrujiB/6tJcqOiJ6d4Ct/KlSbxJ2gFDBmuSY
         JndJ+7yTbhqXZgPUTUUVOpxjjAxtRNHqddIEjvmfrQH7hfaFURRmZp13ygPC5ksDu7IX
         j9RZp/x62K3nJuE9hywnjXpUCnfSr3wX3xeYZzRznahF+fEgf47ad4qWXs1blKclIlHn
         cg/EI/mav+gI0fxU1SgdZF0b+qAovkIsj/bMfEzidkel3p/Zkto+ksNpeydntyLW9E5g
         n2XE+l6UOqMTs3GZSV6c1kcOhVsitaC/2qKy0QFzDhVh4U/jyEvXO1XzkT7fzHQXF25r
         hrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783515722; x=1784120522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PHqORVTQXLEwN5n2TZklcKo7QLlfA8Vtj176/nlR0Hc=;
        b=kQPTH5QFSRxMRzNF/o2vXpyX/ZNh3i6HtGC2mAJm4YSmHLtnzOr8197ZhEe37R/M3q
         AP/cUrtGtJjXCdFsT7VLK6O/pOsegAZwrqR/KT8dvj05SAtXIcB/z2Ln0a3tK4SU7w3g
         7Gkm9Wpfg0/NFdWXAb8eSQYPj9YeWjyBgxAsFOcP24OjF6Usf2UGT5kaSOMl5Rvsh4sS
         +DSP+EeNt1+TN58l9CkJ0AsLRvBR9UK7PsROUB/KEpGVivl2k3FbSQwEe+uEXPptcHzP
         r10f6AT/IXCisXin3IyexcSgyek1ggd5abFTdWUqcJnFziT+iX4Kj16jeYcQJatBpogl
         MYAA==
X-Forwarded-Encrypted: i=1; AHgh+RqqHt1vMiEoOUfcgcuX4rJaTjTm8nqFeGpVlyu1Q3qpXH9nm9czjUPXdztpFz2xhz/gWKBDHSWxQcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTyMkzsRBNVw1mPAMiEAByarSx5UZjdwTTywBvfMoOFRGlb1qt
	Zk13qrLjCxr4XcLhS67lSAhIbWmjjOyTai1etbbEqcsSh74zEEzQMkSQ
X-Gm-Gg: AfdE7cntGyExedtHbuS4CS63IPR+6m0w+0Jq6ARwuX9anQfpBvr2ZsXsxfGduS6bLAq
	xIykfL50ZM/48VqHkC8Qo2tZjtZSQmtkOaWcjBTMUyeXSAiOnSzHcJg2iiiNoGnyZfvEMJw+nsW
	/kLJWLI95UXYj0tuT+Awi4PgdmBe6/XyRDyzjLNuSwTWn3sPBfKVZOsjD0aqoDZJ5/5TbZasVEB
	OajOtMV0U/UgtzcUJovRcw73BzkoxWTMOmP04ClFObnS12u46nOgbS8YpMwLuO1WUChscz6jyE3
	R1Af0Y/cnSYzlbN+e+PcpbxZbDqynGsLFYHZr0dI7ezbcT2LdQzH9mLSBDtVGTJF6oKAXv4NL/u
	GGrDf7KBejdvnsqG7CCSnR5B3QmDfrRVkDvfGFc03+GUB7JQD75Uo/3wVT4GIE2vKXtP9pAE=
X-Received: by 2002:a17:902:ef4d:b0:2c8:2808:3ec9 with SMTP id d9443c01a7336-2ccea36556dmr22451975ad.12.1783515722124;
        Wed, 08 Jul 2026 06:02:02 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3da55sm27783045ad.71.2026.07.08.06.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:02:01 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Sebastian Haas <haas@ems-wuensche.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: ems_usb: validate received CAN message payloads
Date: Wed,  8 Jul 2026 20:59:49 +0800
Message-ID: <20260708125949.765815-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8128-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:lgs201920130244@gmail.com,m:gregkh@linuxfoundation.org,m:davem@davemloft.net,m:wg@grandegger.com,m:haas@ems-wuensche.com,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,gmail.com,linuxfoundation.org,davemloft.net,grandegger.com,ems-wuensche.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35AE272695F

ems_usb_read_bulk_callback() validates that the fixed CPC message header
fits in the received USB buffer before dispatching the message to a
handler.

That is not enough for messages with payloads. The CAN frame handler
reads the CAN id, DLC and data bytes from the variable payload area. A
malformed device can place a CPC message header at the end of the
received buffer so that the fixed header check succeeds, but the CAN
payload read by ems_usb_rx_can_msg() extends past the actual USB data.

The post-dispatch length check is too late because the handler has
already read the payload by then. Also, the number of CAN data bytes read
by ems_usb_rx_can_msg() is derived from the CAN DLC field, so it must be
validated against the received CPC payload length as well.

Validate the complete CPC payload before dispatching the message, and
make sure CAN frame messages contain the bytes required by their DLC.

Fixes: 702171adeed3 ("ems_usb: Added support for EMS CPC-USB/ARM7 CAN/USB interface")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/can/usb/ems_usb.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 9b25dda7c183..f72e36fdf788 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -409,6 +409,28 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 		netif_rx(skb);
 }
 
+static bool ems_usb_msg_valid(struct ems_cpc_msg *msg)
+{
+	u8 can_len;
+
+	switch (msg->type) {
+	case CPC_MSG_TYPE_CAN_FRAME:
+	case CPC_MSG_TYPE_EXT_CAN_FRAME:
+		if (msg->length < CPC_CAN_MSG_MIN_SIZE)
+			return false;
+
+		can_len = can_cc_dlc2len(msg->msg.can_msg.length & 0xf);
+		return msg->length >= CPC_CAN_MSG_MIN_SIZE + can_len;
+
+	case CPC_MSG_TYPE_RTR_FRAME:
+	case CPC_MSG_TYPE_EXT_RTR_FRAME:
+		return msg->length >= CPC_CAN_MSG_MIN_SIZE;
+
+	default:
+		return true;
+	}
+}
+
 /*
  * callback for bulk IN urb
  */
@@ -452,6 +474,16 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 
 			msg = (struct ems_cpc_msg *)&ibuf[start];
 
+			if (msg->length > urb->actual_length - start -
+			    CPC_MSG_HEADER_LEN) {
+				netdev_err(netdev, "format error\n");
+				break;
+			}
+			if (!ems_usb_msg_valid(msg)) {
+				netdev_err(netdev, "format error\n");
+				break;
+			}
+
 			switch (msg->type) {
 			case CPC_MSG_TYPE_CAN_STATE:
 				/* Process CAN state changes */
-- 
2.43.0


