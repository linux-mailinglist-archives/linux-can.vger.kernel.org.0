Return-Path: <linux-can+bounces-2460-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB629F8404
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 20:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8251891955
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 19:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD5B194A73;
	Thu, 19 Dec 2024 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UUClMIUb";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="2+wL71/n"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FA71A0AFE
	for <linux-can@vger.kernel.org>; Thu, 19 Dec 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636062; cv=pass; b=Kcst2d6bzWWb3yrupIMVu5Sz0HR/vuYp3P0COvrcwGeiOVbvDvs9f0rk6kEAIJPxutP7V//hsMLQkVzc2ah24zATLSINYqC2PWXMDMlbL5aWOr6fiu57319lWvXCU5HlpryBssILXRB7gvXgYxp4wODwgnVcmk5rhVhohY0pDBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636062; c=relaxed/simple;
	bh=AVA0GSruM1On4TDKGylmBmUxUJ/pkKfyQZuP/FoyFCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mpZvgfX43FW4QmcMtTTvyGhR2Y/3vkad6qY/wDRLFcy5t/zTpLHX4VzgQmNq9RO02KRgEihmLnJ2MJOQVw+YYSGzEcpmhglQJ6NUo47cvO6vhydm9MHpCmX+I1tzy9aEjVBxocjwWRrrk60ZuHWZ7jkIThzVXYXroJVedSlmoBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UUClMIUb; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=2+wL71/n; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1734635330; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CcPfkvx8Ch0grtMRjU0gcrhOFDuSjRDhkK8k1Fhy+OhsP6zZFFLLQRblPPMqOgT10X
    Q2vTKIqTGeA89sLsYTnq+mNVdwuLXCnSVHpLfvWA/EjNn4xuB7G0BM302M9+97v2Orc+
    QCW87l2fDEYFtWBaWEDonxUZV+1ezFOXn1oakOnhluZqn4DGCQGqkCJMIUBnM7rxTgLi
    1lSzkE/bTKq0wS9+B8HylhPnw48X51l1j4OG0xkJLoxDAEEOvO5TKBGkXvapZqrNQCg6
    8Ert1R8++YcR2O3P4kCBXVI6mel/R0RaLRwfL1Nr6PuHrhDmnjNJStSmeruD6yLvGvgS
    avlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1734635330;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Q10AjathRwvew3GWj4GSCbTHb/NmJ5OFrOIKEdluR3k=;
    b=e+tPy3lZC80vDrxDBySeNyZR/0HcV5yCUEsB51VIgRUsZVSkoleW2sC499mM45Z6+t
    MtZmzIpQJZyi9G1wSy3zyDIoHNuTQPSDb2DNQeLDy7uh/JJEKF+YHTSQEZR6uDMGdK/q
    HubQjBRlPABEiBG6MclxRWVs5CZzMtC9Wew/GGa3wA09Gcum3I0uM4NJK5SV+0OaK2/P
    hgGsB9RVovPoiYc3FtKc+EgSDlK6b6wDQHYSE5q9QBR4JJLpnUUQBr2y+yFRGKZe/b6i
    SSS4+gPbUKq8xO7ysX87G145TD6IT0rwW3RyoNkborIToGfrRRPiY2czqFtsywY3lxwe
    b6OA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1734635330;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Q10AjathRwvew3GWj4GSCbTHb/NmJ5OFrOIKEdluR3k=;
    b=UUClMIUbQbuPyS/J0sUy+0kv0KhRkIG2YFx6YyGV3mxeWjkISOdbGyC5Lx2n46AiFL
    7YoPofYZss71vriwnme697acwKOei81P4HCJIeWLXOMvBLRA4lH6U9aOk1RJg2Qpeesb
    f3jF3HAGXsKfvOuwJ4Oj6Kw0EQJH9TeVqOOlM1tAMo4em43lQgHjaNwy1WMsPJ9Uapmu
    s+L+FTuKaSMTncRgUmVXAtQKoTSh/p2TG00tBBH3qiCYY3vtkunaaO92c7+G6uVkgeqD
    HtPnaJ9OuWeFwi+PZXF4niwCayaks/2RsKS4ooShFHzE6ggvmxhFM2eCpm5Tu6ko12Y7
    F3/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1734635330;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Q10AjathRwvew3GWj4GSCbTHb/NmJ5OFrOIKEdluR3k=;
    b=2+wL71/ndUZdkTHnvXDMpM2lmstxAEs1UoBc0gArwIPOEtPeStbKXs+t/2qhKczw9Q
    v56oGSl7wgCUtET/d8Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.2.16 AUTH)
    with ESMTPSA id K87de70BJJ8o5E4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Dec 2024 20:08:50 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] Assign em_canid.c additionally to CAN maintainers
Date: Thu, 19 Dec 2024 20:08:37 +0100
Message-ID: <20241219190837.3087-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The extended match rule em_canid is used to classify CAN frames based
on their CAN Identifier. To keep the CAN maintainers in the loop for
relevant changes which might affect the CAN specific functionality add
em_canid.c to the CAN NETWORK LAYER files.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e29c4e86db1..ae888e7064c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5108,10 +5108,11 @@ F:	include/uapi/linux/can.h
 F:	include/uapi/linux/can/bcm.h
 F:	include/uapi/linux/can/gw.h
 F:	include/uapi/linux/can/isotp.h
 F:	include/uapi/linux/can/raw.h
 F:	net/can/
+F:	net/sched/em_canid.c
 
 CAN-J1939 NETWORK LAYER
 M:	Robin van der Gracht <robin@protonic.nl>
 M:	Oleksij Rempel <o.rempel@pengutronix.de>
 R:	kernel@pengutronix.de
-- 
2.45.2


