Return-Path: <linux-can+bounces-2476-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD0D9FA054
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 12:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABAA1890832
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BAD1F2C5D;
	Sat, 21 Dec 2024 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="D0Dcjtqp"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DF41F37A5;
	Sat, 21 Dec 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734779719; cv=none; b=k4nQlytifw9SPtkoUcrOlsz0FfUNsnNlttIeww5wVGvXaKKXS+cDx1CWUFQHHHpw9w1LbwCkYRh9rZ4aAmDmGhpSxu+xw53qb1SQH2qKIELaX+K5/xdBJOe+kG0MV9oR7Y3j8CGktoohwrmIESenXKslYnJN2KXFQBU51Wo0Ch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734779719; c=relaxed/simple;
	bh=uEmo1klH0U7SH5rDjz3FuRRP2JFUHt/yzHHWnAmkJws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNkDZ9Kt+uLdyNV8YLQmbLPQPpqKbrEh+K2jp+FuvlYPyuF1RtcMkBLIvkRUOvH7sPfMCFSGgF6YFlnJss40GMH5l4UFxJwBJu/6sFu8LIVm1vShtQMPgO+KtkhP16Fh/F1GEoxQhGIT15BDs0qGOXDIj0NxKmtbUrabFY20X6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=D0Dcjtqp; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734779716; x=1766315716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uEmo1klH0U7SH5rDjz3FuRRP2JFUHt/yzHHWnAmkJws=;
  b=D0DcjtqpcpDlW6Wn6VM2XID4PiRCRuag3oWs6kdNg7On7I81jUtEf7Xf
   v+EyKeKmlTAisQGGCLX8pQiOnKuADmbrRgNzdGxshquRAaf8YcsitH4nB
   arWMFIndvoj6Ki3RF+njRJckqN5m9EwG1ZXlIAyiRJO6HcyQmP9/MUL9w
   U=;
X-CSE-ConnectionGUID: R61O3hRBSjuysspIkS5DpA==
X-CSE-MsgGUID: p9IExXMRSMCJ6o8EooLJsg==
X-IronPort-AV: E=Sophos;i="6.12,253,1728943200"; 
   d="scan'208";a="28285769"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 21 Dec 2024 12:15:07 +0100
Received: from localhost.localdomain (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id 9155D24E0;
	Sat, 21 Dec 2024 12:15:06 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 0/3] broadcom, ethernet/marvell,cx231xx,can/dev: Remove unused values and dead code
Date: Sat, 21 Dec 2024 12:06:46 +0100
Message-ID: <20241221111454.1074285-1-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221035352.1020228-1-ariel.otilibili-anieli@eurecom.fr>
References: <20241221035352.1020228-1-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series clears out the Coverity IDs 1487817, 1561102, 1497123,
& 1269153.

Thank you,
--
v2:
* fixed CI warnings
* see, https://linux-media.pages.freedesktop.org/-/users/patchwork/-/jobs/68562001/artifacts/report.htm

Ariel Otilibili (3):
  drivers/firmware/broadcom, ethernet/marvell: Remove unused values
  usb/cx231xx: Remove unused value
  net/can/dev: Remove dead code

 drivers/firmware/broadcom/tee_bnxt_fw.c                   | 2 --
 drivers/media/usb/cx231xx/cx231xx-avcore.c                | 1 -
 drivers/net/can/dev/dev.c                                 | 2 --
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 2 --
 4 files changed, 7 deletions(-)

-- 
2.47.1


