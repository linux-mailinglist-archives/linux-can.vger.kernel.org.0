Return-Path: <linux-can+bounces-5316-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB4CC429D9
	for <lists+linux-can@lfdr.de>; Sat, 08 Nov 2025 10:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EFC188D41B
	for <lists+linux-can@lfdr.de>; Sat,  8 Nov 2025 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5805F2749CE;
	Sat,  8 Nov 2025 09:01:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC125524C
	for <linux-can@vger.kernel.org>; Sat,  8 Nov 2025 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762592481; cv=none; b=BE+tOLBIDTINGXFea3Gm6ftGEsWPfG+JRgxn/HvzfSQ/N7oln8ix6G62zIdlkBC0ARc0CqZo8DZb6QKEy5a/K2m1mAM0PILhBTo6VKExXJY2Md7XSSFukrFc3c/OUs+Dac34EmS200sVCa4X7ka7wrBVhAyfe4aHWODD6IW8dHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762592481; c=relaxed/simple;
	bh=Ek2EiErAw6PRGNdh+pk9UEnKLWfCLp3xLu6W1ssyUw8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k5Ec9KSRX9G+A/KYJtXdPGdgwpe04hkw52pYSDCRYfhCclSZrXBhzHji4creAmyjp4kL+MqtqpG9GhKLS+H+dN+atW38OtaCALjo1JCXTZyb4Y7qhyiKMCWAZHX7DXyxp9YEgQb/Zj5jCF5bD11lk2eaLj0mHLc01GvKf6ymafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vHeor-0004vX-Ss; Sat, 08 Nov 2025 10:01:13 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vHeoq-007fM7-25;
	Sat, 08 Nov 2025 10:01:12 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CDBB649A89B;
	Sat, 08 Nov 2025 09:01:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can 0/3] can: gs_usb: fix USB bulk in and out callbacks
Date: Sat, 08 Nov 2025 10:01:00 +0100
Message-Id: <20251108-gs_usb-fix-usb-callbacks-v1-0-8a2534a7ea05@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMwGD2kC/x2M0QqDMAxFf0XybMBWinS/MobELGqYdKNBEcR/t
 +7pcODce4BJVjF4VAdk2dT0m4q4ugKeKU2C+i4OvvHBuabDyfrVBhx1x5tMyzIQfwzDSD6G4GP
 kFsr8l6VE/+snMCV4necFxxJfpm8AAAA=
X-Change-ID: 20251107-gs_usb-fix-usb-callbacks-5fa2955299c3
To: Vincent Mailhol <mailhol@kernel.org>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-509f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Ek2EiErAw6PRGNdh+pk9UEnKLWfCLp3xLu6W1ssyUw8=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpDwbQVEHziBvS1sLXgHJT1/ntDuNIz+NwauWtu
 Bxai4FGPRCJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaQ8G0AAKCRAMdGXf+ZCR
 nAh4CACNc+HvpZpZVhdqdC9WV9uuK0nOhIbWEF7hCKYVCO35JhNpBNEf5N1pH9MsC4XvCaab8fc
 i37Lkw8KVXkt2GvyJ3Tbzhm7fTrlqfZtDo7FO9q1fju8zW1A08NPiXDH1ZtMWHgaeioTCBHu3yf
 KyCS/usgtddHSL1JMy9d7SBrhCcjZYfxoC1L4aT/Mhj1Y82NVitqESrXOC08hADwz/tSTT5LisE
 eVBT2boKycnbhJ0lsAtnX/IFRB2SA9dXZF63f+dSfpy6AzfRVt+e7DcJeQ21VfcXkMzIOgnjq/K
 zxjKvscDH0xwE+aW/G62/hx52uiNTqMxByHt21PtkFQSF+Lm
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The bulk-out callback gs_usb_xmit_callback() does not take care of the
cleanup of failed transfers of URBs. The 1st patch adds the missing
cleanup.

The bulk-in callback gs_usb_receive_bulk_callback() accesses the buffer of
the URB without checking how much data has actually been received. The last
2 patches fix this problem.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (3):
      can: gs_usb: gs_usb_xmit_callback(): fix handling of failed transmitted URBs
      can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing header
      can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing data

 drivers/net/can/usb/gs_usb.c | 108 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 94 insertions(+), 14 deletions(-)
---
base-commit: 74d4432421a3e2669fbccc08c0f4fc2980bf0e39
change-id: 20251107-gs_usb-fix-usb-callbacks-5fa2955299c3

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


