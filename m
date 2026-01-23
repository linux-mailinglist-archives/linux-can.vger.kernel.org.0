Return-Path: <linux-can+bounces-6276-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFBiKbVLc2lDugAAu9opvQ
	(envelope-from <linux-can+bounces-6276-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 11:21:41 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D637443A
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 11:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A481D302D3C4
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 10:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C9037647C;
	Fri, 23 Jan 2026 10:16:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678823321C7
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163407; cv=none; b=RyMWb5rwTY5ef7iFZ5dlL41OcLvwv5J1gr1b/B3HZ6pkRTHpS2X1mgLLu84QmD60n0xg4Uv0YsZo8EoDTyOsiL3XaCUIlfdNkKXErHo2U/3IPGxZSOtYcphpOHY3NnGFX+kF1GGyHV+m/wrfAy7I5DBI1crbG7yXr2xUfeImDs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163407; c=relaxed/simple;
	bh=ABD2O1isFrTp4f5tAT3VaRBCqa2N10sv/xUoLpdC8bk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=edLXNDXymqxr986B0Z4Hf8M6bn+EzKIPvcI9mxrpcmcWjB9CWmNqVLNICbo8+X1MQhEUoB8KSE5XafOkuHNNBy1LL11ZQ6mYJMriC5Luhm6il+fqXJHH2CWtAnotR6yxNpphd8azK7G6BO5rfLCm/LLwtlhbdgCky7ueSBQG3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjEDX-0006FW-4L; Fri, 23 Jan 2026 11:16:39 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjEDX-0024ii-0W;
	Fri, 23 Jan 2026 11:16:38 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 45BE34D6BC8;
	Fri, 23 Jan 2026 10:16:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next v2 0/2] can: sja1000: clean up CAN state handling
Date: Fri, 23 Jan 2026 11:16:25 +0100
Message-Id: <20260123-sja1000-state-handling-v2-0-687498087dad@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHlKc2kC/1WNwQ6CMBBEf4Xs2TVtBWM8+R/GQ0u3UKIt2RZCQ
 vh3i8aDx8m8ebNCIvaU4FqtwDT75GMoQR0qaHsdOkJvSwYl1FlIdcI0aCmEwJR1JiyIffrQoZE
 XZ6x1UiiCMh6ZnF8+4ju0OmCgJcPj26TJDNTm3buzjuMLc8+k/6/22e+OmCPjqFPyM+EsUaKQ1
 Ni6qbVp3G2k0E2ZY/DL0RJs2xu0fYYB2gAAAA==
X-Change-ID: 20260123-sja1000-state-handling-b18fbddf102e
To: Vincent Mailhol <mailhol@kernel.org>, 
 Michael Tretter <m.tretter@pengutronix.de>
Cc: Achim Baumgartner <abaumgartner@topcon.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ABD2O1isFrTp4f5tAT3VaRBCqa2N10sv/xUoLpdC8bk=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpc0p8QT2zQmyuQVXtrt1tttUKS/ftOl54y4Xax
 C9ZNCqMTLeJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaXNKfAAKCRAMdGXf+ZCR
 nCUvB/9k9lecEfM8ZY9SkO/4uTmXXMhNzUC3xc6NHw/0FbtMfZnHD+cRNR5xkJ0E75Z7fMby3Zs
 pBZO35DuLhW5nf61Wn//jQuvZ71j/Mv8XxX39SGtLPLpGNDbX9Mn67ZB2mt2YAOL7QNWj0HJF11
 RT0HpQVg6v5cTcMfuw9YsYo6IYhcCVbMK7hydynBw1xB6kosuvxcOQVYZCFTK2WEJjKmjO8FEyJ
 FF88E03lnAVwA1yfq1JvFmcYLHJdGnrLqTtjBM7AAhMq1LpiojHXXgyGMIYXIy6cx2EZVEfwMBZ
 OIcXhpWGn7D05INS8UGKkqKbM+rmBeFjoJ87Cr/l6o/Lbq7p
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-6276-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: B3D637443A
X-Rspamd-Action: no action

The CAN controller triggers an EPI interrupt when it enters the error
passive state or transitions back to error active. Rather than tracking
state in the driver, the CAN controller state should be derived from the
TX/RX error counters using can_state_get_by_berr_counter().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- patch#1: new
- patch#2: replace evaluation of error warning and error passive IRQ, by
  can_state_get_by_berr_counter() to determine CAN state
- Link to v1: https://patch.msgid.link/20260123-can-sja1000-error-passive-v1-1-01e5d454ab5f@pengutronix.de

---
Marc Kleine-Budde (1):
      can: sja1000: sja1000_err(): make use of sja1000_get_berr_counter() to read error counters

Michael Tretter (1):
      can: sja1000: sja1000_err(): use error counter for error state

 drivers/net/can/sja1000/sja1000.c | 42 ++++++++++-----------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)
---
base-commit: b00a7b3a612925faa7362f5c61065e3e5f393fff
change-id: 20260123-sja1000-state-handling-b18fbddf102e

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


