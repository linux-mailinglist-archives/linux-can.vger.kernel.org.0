Return-Path: <linux-can+bounces-7163-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AII9DgAbvGlEsQIAu9opvQ
	(envelope-from <linux-can+bounces-7163-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 16:49:20 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6862CDFC0
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 16:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1C0A3012E40
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FC23E8C64;
	Thu, 19 Mar 2026 15:48:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560653E8C4F
	for <linux-can@vger.kernel.org>; Thu, 19 Mar 2026 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935282; cv=none; b=sbhMc0XVMX2FfOu8aTwhTyPGm9YOK4KEAq8Vje7ROYhLPiyKEVo01De5T9JKG3m6P/d9ThhWrEUqe8sK69+ucXMIefW7r4UMLhiw9QYdmNSn3uPYP0I+wv24SF1LNcreQDUZgRyuRHYRjC5Bp+rg82rvEhK4Ozn6v4/ZlhGkEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935282; c=relaxed/simple;
	bh=Hikubl6/WTjVc4hjS/LYe+hYrrHGS8idSAczXMg9X/I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sTxGmXxAHj1ihbkg7d2Xt3uf0FGq3jlzUFGL0Cqmx6qunSaaok2Pu7b04HMCiBha0DvqmdBbf32k1tG7Rh+hGPTsJBgDnaqkOJauBuCpa5IKl1IAviJDpr7jcSx8Uz7HO2NnenbSBFv6ApGGoe9uRtXo8RXgjn4cyFOZ6YcVuDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3FbI-0002Ti-My; Thu, 19 Mar 2026 16:47:56 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3FbH-0016Et-2u;
	Thu, 19 Mar 2026 16:47:55 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 970A150869F;
	Thu, 19 Mar 2026 15:47:55 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can v2 0/2] can: fix can-gw Out-of-Bounds Heap R/W and
 isotp UAF
Date: Thu, 19 Mar 2026 16:47:43 +0100
Message-Id: <20260319-fix-can-gw-and-can-isotp-v2-0-c45d52c6d2d8@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ8avGkC/02Nyw7CIBBFf8XM2mlgTKl15X8YF0inLTYCAXwkT
 f9dWjfu5t6ce2aGxNFygtNuhsgvm6x3JdB+B2bUbmC0XclAgpQ4yBZ7+0GjHQ5v1K7bTpt8Dli
 3RI0h2QiloMxD5MJu6gsUDK6/Mj1vdzZ5la5YH/0D8xhZ//85SlVLEpVsaiVQYvJm4lws51HHP
 PkQKscZluUL1gOJQsEAAAA=
X-Change-ID: 20260319-fix-can-gw-and-can-isotp-59227c217066
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, Ali Norouzi <ali.norouzi@keysight.com>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=651; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Hikubl6/WTjVc4hjS/LYe+hYrrHGS8idSAczXMg9X/I=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcI7VQ2TRHYyGrkm7IqQu/mb8tXfxR+WDLn5qmt0Hn5
 Qr2v9TY01HKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJHAxk+O+p9Hweq8L2uAbz
 6ZfVqzdl7zhudGiWk1Czz+l4uRZvowSG/66pxyQMFgcdmfJJ0n1TTkASf3T/sYl5Vy3naZ/W8+4
 RZAIA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-7163-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.963];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pengutronix.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD6862CDFC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series is by Ali Norouzi and Oliver Hartkopp fixing a can-gw
Out-of-Bounds Heap R/W and can-isotp UAF.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Ali Norouzi (1):
      can: gw: fix OOB heap access in cgw_csum_crc8_rel()

Oliver Hartkopp (1):
      can: isotp: fix tx.buf use-after-free in isotp_sendmsg()

 net/can/gw.c    |  6 +++---
 net/can/isotp.c | 24 ++++++++++++++++++------
 2 files changed, 21 insertions(+), 9 deletions(-)
---
base-commit: 8a63baadf08453f66eb582fdb6dd234f72024723
change-id: 20260319-fix-can-gw-and-can-isotp-59227c217066

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


