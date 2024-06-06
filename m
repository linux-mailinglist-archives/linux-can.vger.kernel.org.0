Return-Path: <linux-can+bounces-705-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8628FEB32
	for <lists+linux-can@lfdr.de>; Thu,  6 Jun 2024 16:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786FF1F2751C
	for <lists+linux-can@lfdr.de>; Thu,  6 Jun 2024 14:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B445F1A2FD6;
	Thu,  6 Jun 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="P9MqYJmj"
X-Original-To: linux-can@vger.kernel.org
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988251A2FC5
	for <linux-can@vger.kernel.org>; Thu,  6 Jun 2024 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683222; cv=fail; b=RjHy2bCg1iR6W2m7TU+2DWeC1vycje1BUfHSZk/+BeJa1PRhyhgDbQ6a7MbGbFchARjAkJ2gYDnBEo8kNystDKM1xlkdXU+UIt2fpPJ51ZgJ7LOUiB3IPdK5yvFu/KAIaeLgo4ikBy/NbaXrughXFn3qA+RHbd3LTGiZPkxQlaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683222; c=relaxed/simple;
	bh=ZXv35xifz+hJm716XeIMbGKw4efsIvlgMuhBrLoADbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ioVs5RUKtRr/98Y3ENkODpvjLO7zAltDgQbMuVfTu1lx/7vFKEWqTJtpvtkIcwZ56sh8qzv3fxkhO0xzqw40mbAN9JfYuv75lR/j4ji5uVBtEXWf4DBQm7/8/s1TcuYxp+BUqzWOGXWI1lBLgXR+/+vk3OOieEZYjUVxdU4L090=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=P9MqYJmj; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.10.202])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 527671011DD08
	for <linux-can@vger.kernel.org>; Thu,  6 Jun 2024 14:13:39 +0000 (UTC)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.163.121])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id CBA8D10001FB2;
	Thu,  6 Jun 2024 14:13:31 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1717683210.892000
X-TM-MAIL-UUID: b2d114a7-56b0-42fe-9394-aebe964cfdac
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id D9E651000031A;
	Thu,  6 Jun 2024 14:13:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4x+IMA7qCFQ/3YMkVHJE+90gqwnxK1S8ZWj4v81Eq+fzLuE8hNDm4iM6ATTcNXmtXL92PMwBrWP8JorD35jEGg7xSvK7mtfKJX2BV5gLdGr4iDvR58+8yZLdXqtDbsKtQ4BH8iTCd3Ac3h/z6aCoB12Lz521JKVsWDih1VYz5fKF8bZVBlLPKWxwyneKCPkm0YBkolGfL6P/D9DE7rmo1l1rvh4ArVyLoyG22O8Kqpj60qpDRTHAZrfIL0qi5TYEpIXVeL1HiNn5QgDO3rCPJG9Im0vfpT4stLCeoo1LAEtxQT1F1VUynnqtkZ30pPeuSmR+X8eC1w3cpLeCB3DJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nu7ix7PCGKEAqZGthDLNSCsfM/y6b3m/vUkfP75TGQ=;
 b=kw+anKL0k5jSiBtaPWFEVShcXapBM7TFP69+95Q+3Huri1Pi4xYPvb9vsBb5gpeLxvAjb8Iys+xiCRO/s5VUVRQwSpp8DzlvAcjv1qnl2lOWk8mvZnTUXvtbmnBXuk6u4FG5ggtkrJ4yWq33Ld3PJHdIk0ZAmjqsBahOrLmmHj4X9//s9py8+KUEGpS9mjvvvDjgS+ZZUhbY7rkGHgUV8dtgw8CrkiWN6+mQ+AWFjIEC0R/2Y8NTGIHFsrECDTsp2zqusGvn8FVPEVyadXSn0VfbLZ93Gp+A/V3/ra9xbkLw1Ma/++ENC//Kc2yU/GY8FzxC9v8Ab9rUi6WTTYdHig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 213.61.166.92) smtp.rcpttodomain=davemloft.net smtp.mailfrom=opensynergy.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 213.61.166.92)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensynergy.com;
Received-SPF: Fail (protection.outlook.com: domain of opensynergy.com does not
 designate 213.61.166.92 as permitted sender) receiver=protection.outlook.com;
 client-ip=213.61.166.92; helo=SR-MAIL-03.open-synergy.com;
From: Harald Mommer <Harald.Mommer@opensynergy.com>
To: virtio-dev@lists.linux.dev,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>,
	Harald Mommer <Harald.Mommer@opensynergy.com>
Subject: [PATCH 1/1] virtio-can: Add link to CAN specification from ISO.
Date: Thu,  6 Jun 2024 16:12:22 +0200
Message-Id: <20240606141222.11237-1-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922E:EE_|BE1P281MB3013:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 482a6911-d7d7-40d0-b68d-08dc8632d56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S/USiP98O9D9oMvhHySeHzM5MJ9mhIrxjaHWBmKiWfCr9yaSk7D/mUrUhzFN?=
 =?us-ascii?Q?Y4ZstUoqFGohPNDkk5NDPEkq2f9/Fz1jzu3VitCeejFrKs9erWLSO9ZHt/T/?=
 =?us-ascii?Q?AZuR3azZszMyliutO7G6ILZSPIaVdelAU7/RJLkX+lR7lfDdx3hrLvubl03K?=
 =?us-ascii?Q?R2qI8Tje+OUsYOHnHF443Fr+QQirq6FOnb3SVS8gEerrz68vtcyxktHjNYOV?=
 =?us-ascii?Q?TDTCnwfG9ljD+LXiXM58mtKteTAAsd+anq5kK78Jd/nPFpsgZ7aQ1uqFihj+?=
 =?us-ascii?Q?eMtHr9Z+Evr0JXAHm3V6BavBzKAMtCZGyfDQEnVAuhtuIQGlNXermxQuy9Gx?=
 =?us-ascii?Q?BQbzwHuTG3l/NnOBjvDfmyJzILg6lG+fACGOsQYdWE+ivyfLHW+lSfxPj9Is?=
 =?us-ascii?Q?yhcPHRbPnldoQ4ZVw31N3yysFSOB3bVGG6ILETJyerDD9dygeMLHJBg9mwkk?=
 =?us-ascii?Q?TQEf6Y8/HXOo9Gj+ytxwGXlwRJIVRFR6VVpDesRJw2q7fJI+6jNnjiqLyDzK?=
 =?us-ascii?Q?j5ZSq8vhNeAhx5VB7OMwRzqJW+Y7Mr5nrOGR2BZOr1eDu80C0zyYa5q/jSBo?=
 =?us-ascii?Q?MBl4xS6HXDhoVp3Fgz5xXmMKrBD2v8UU5WvZBJ36Dr8t3/yaVpZxLsZtZFE4?=
 =?us-ascii?Q?gyUqvcELlJKMkEGVdLrgc5eXJ7QTnrjYbvQ2tKxkbuU9kU3Qlrx7nGTRQmlC?=
 =?us-ascii?Q?T+c2xMbEddsiPCXf7+WYk1+xcBUdgoibv+KujoejiktHwulXGApcq5unsMj5?=
 =?us-ascii?Q?Y3QXHBRhWNiavnVaH0mg/9m/rIyukU5m5DiYYfjCzexHTcjixj8wG1XyGdfA?=
 =?us-ascii?Q?4JUYcfShyYWVSpaoHdGKAav/QyGA2by+oXt/qPk/W8HSx3vJo+ij8aELYtkw?=
 =?us-ascii?Q?5nKTAwRGQ3uwq8+V4BMEY7S8iXDrdefSn+n0kd/Ma1kMCjnhyd2qlL7FZ/F+?=
 =?us-ascii?Q?Lt5Nr+P946JcfwnKR3dDyLVDVNrDthPjq+vFvS2MhoO1EWo8rjlaKslGpfTF?=
 =?us-ascii?Q?ilkrqlVZOMqI3dlnPxZ/BO52NCgpnDIAVRtHhfqE0SBbxTmjOXGl2scmcmeY?=
 =?us-ascii?Q?CHqocwX+Wzd7Ti3GfE8Hlf65uyUhJUYEW5C0Ne6v+zaWASJUWt1PyvURrUyY?=
 =?us-ascii?Q?+FYpwoTijWsDdMfaW7P4T1y60N9sqHecfPelE3mCVXlqnOsMLr5PpmELg2vZ?=
 =?us-ascii?Q?1zX8OW7SiT9xPajo5x+awbY8D/Y5SOkZJHnp0bZ9BXHtyscHKtHPZca60wpY?=
 =?us-ascii?Q?0pz4c2SrPNuOh3azFuauS/gdC6MuJSxkraLmLI/TGwBZqLRJ4QkaHSj6JYY7?=
 =?us-ascii?Q?XE+4ms/mZXY9QZPm2lk5O+hmhQWlw+zOWLK/QCHD02c8SmSA2XsPRpHuhu2S?=
 =?us-ascii?Q?eGDku0CMASwMwytmaFMjmDa41Xi7EGq1ePCj+M2SweLC0vg40Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:213.61.166.92;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:exchangeconnector.opensynergy.com;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:13:26.5832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 482a6911-d7d7-40d0-b68d-08dc8632d56c
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[213.61.166.92];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB3013
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1023-28436.000
X-TMASE-Result: 10-1.047800-4.000000
X-TMASE-MatchedRID: NGDYxnKYxb3J+P2VFrJmrKdMZMc4JlQbCsYnJzXwRoqL12p7cZqBWIvP
	iBq/iW91MpPx8OFzfY1Ta75sGuqeWKi8PTAxIaqS7yR/hLt1y2iFU/rz+g+hxFtpNa0o3mGFqXN
	pl1fc2dczrT87MhOW5dAxdIKEp2hCA3ASNiUtxi2wL+/cgG+7zMn4xfDEuqcVQUZlCPgOIPyF6z
	UvsSpW6rEDulXIfwn2ckkZYKzf3mGfQEixngIIE2B6KL0WmlgVYppqMItbEgOI/kD+1oWNGb/a0
	nd+hIFCI/NGWt0UYPAv8kOye9F0ID8aOpcAGK1zWClmBfZH1l0adwCj1QH6tsX55enpC3hi
X-TMASE-XGENCLOUD: 8fd3d490-e00a-41d7-aab8-a1c43a45ac15-0-0-200-0
X-TM-Deliver-Signature: C7A16AA34FA8A78513F2FD2AEEEB9E32
X-TM-Addin-Auth: 1aCZQe/g7OGbQb8gWYKBQTEfmpX+jfFYL+p7mJAt2dl+mksNfThWsLoJMwH
	Y3cC6H5EdD3EOpURaj8x0aTgfdCbN4kxSaLSWYsv1JnKviCdk7y3uZetMwc4+X0ZrLW05cqJBP5
	8kEM4zdO2K/sOySFw4BKC10s5Ne4DAydfQ7zdaHT/VNYyij4kbuCpJCMnYyYFWrmQl7IIwIA6rG
	+gRwYuyPV/l5J1BXIjT1kW4uZinE7dS36U8M7HoH6CweYm5gUGoS50rCvXFGwXkfznrtnakQncD
	ng/F62CWzbPxX9M=.RKfypBes0KPGz17ya+9pF2Ja1WdanpdhAfiEk9EDYrHcTShZ5KSRkCUf1G
	FfRjM1+uwYkekMKZyKEUR8m0s02jbQSuGTiFFXuZ4tFBctT4oqsBSMz8TnhVrCHXc01RjWSmCzi
	Pei4bVMQO9pMaEONDCcRFcQboGBuguh33PwjTxW8XF3iSa9fOGRORDssc3ndRb1/Hv2kXkCDFLs
	h/pXTPWBnFcozd8bYdQH7scdaBbuKuHOpsvSzK4wOGHiUiGmycfDokZlBP+q5KUQvM33kWJVOls
	Y5t3tTAA7ms0510rTB0xNc3GXnP4sjLaU+Q7RxTJpSZreURpOzibPitF+Ug==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1717683211;
	bh=ZXv35xifz+hJm716XeIMbGKw4efsIvlgMuhBrLoADbc=; l=1043;
	h=From:To:Date;
	b=P9MqYJmj61pCmqiu8SaWJGOl2I3Gkc8ROrZ4JQ+GeGCkGKx1wrDVmofaunwtE3DeP
	 z8ubQlcENbwt8esAPbd2hvXgNv7mSplg/k8JEF4CH0YExuT1SdjLBdntj+VzqGdyWP
	 dB3crvClowBovJBPq5gAN2JR4Q65hSXB2LQnaySFyuNdJDzd7Z0cKq/Q8EXGLH/W5N
	 HdwHdmU82exyMsKQv5QoAKlmX2UWm/pmGNM0wjZ9ajKlTK/Md0iiOSI71fm5ozzTcR
	 UYCmRX4h57j7EdS1vMoS6Wrzmvjd+pGyLJNC2vyJpzgVFdm4XS+1FUY6j+z2Bty0Uw
	 rTJVnoB4qJ/7Q==

Add link to the CAN specification in the ISO shop.

  ISO 11898-1:2015
  Road vehicles
  Controller area network (CAN)
  Part 1: Data link layer and physical signalling

The specification is not freely obtainable there.
---
 introduction.tex | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/introduction.tex b/introduction.tex
index 8bcef03..72573d6 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -142,7 +142,8 @@ \section{Normative References}\label{sec:Normative References}
     TRANSMISSION CONTROL PROTOCOL
 	\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
 	\phantomsection\label{intro:CAN}\textbf{[CAN]} &
-    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling\\
+    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling
+	\newline\url{https://www.iso.org/standard/63648.html}\\
 \end{longtable}
 
 \section{Non-Normative References}
-- 
2.34.1


