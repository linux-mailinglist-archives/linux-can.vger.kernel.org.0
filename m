Return-Path: <linux-can+bounces-6901-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGjIOJh2qGnpugAAu9opvQ
	(envelope-from <linux-can+bounces-6901-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 19:14:48 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F84520604C
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 19:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 521AD3199D60
	for <lists+linux-can@lfdr.de>; Wed,  4 Mar 2026 18:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953D13E5584;
	Wed,  4 Mar 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B0oRvfOO"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0B3E3DA8;
	Wed,  4 Mar 2026 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647242; cv=fail; b=SL0r73GUjRd6kBgjJnDicAtLKsZBzEaHXqLfW5sgW2XpnVpH8/cFl1OUa3WmwsWG8T9blOk+P2lGqO7HMtYIIVF0Bpc9yA1DF7OPLFB0/Cn8am99vMRYhUJ0yAWKFFggPRu3udnEpcqHQJNrsv/FwvPSfzH6CLAwNSqtwxaDx8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647242; c=relaxed/simple;
	bh=x+6B8hffLsSXIF/DGD7qrv4wrG/XqPl+hYtQtY2JNqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tBV48sBe0PK37onr0ctlYaFHfaKyUoDytYGRpQ/G28oCPRCkB06hZ97lvuS3mBgQL7hK30Sfb5Q9rH9/K9sUOOefHKMWkiYB6bfn8sgTlJ3qgIk7+5Ck9c1vSFWytNNNqAi1LagQ3Th2EhdpqA7zHUucZ03dJU9nvTK3yJYIYhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B0oRvfOO; arc=fail smtp.client-ip=52.101.65.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8u4Yy1411yVaUbfbs28nfM4ibRdgQpZZ1kLpAGA9kBSwxmc1td/nolmD1lDQz/g0j+027lxi0gyASEZ0Vp2lNi+bTn79MjMFRui8AmNhQXIkLCfvZ34665uJaWXrMXPaMShBX21xQyp4C60N7V7tzOfKaY3Yq6soPn0bs2xEsyqcEt2aJbg2+8A0tOP6uKPEC+e8esM3niZWUr9PTmMJDsYC1erydPUpg61N25Kh6X5dcJXY1LEJIoeTptPVFFNU4DlqvV7WDUm4yDPgZPAcx63MhDIf8OLiAcx/yaYB8XLqie5Ijp65URkFAbK4M1e95gfhCyW+zrW3d7oOfKG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuIOjDMeoqhNSmAuyEhAV1reipM7JEOHn9IB1qd34SY=;
 b=dChXbWdhXNMafGUTojELG2Jf6EgdWYjiYYVmaqQs/ExeGcLHzQ5mriqrruvy+kGV7e8Q4kiHFBZzmH5fLIPTit+yfNh7UEpLpebbX5emQJVtZaMlievgxZSfmIHDvb4/MU4KhR7PFTInGYB6/24IYEzEtG9w34onhEM5EUu1LSeJaxDOBRXW28AgdB0InxHtEC/9J2VwOz4B4cR5X8BjFk5U8d0enZIp2MoJ1QPGsu411J65dNT/c+Rrs2vC2SFzE8bSOMF7qw8HvvTYMrGJLlN2qhD1HUlt3b2qTdfQTJsDBnIK5Rn038eZdeO5zdQPNuDPeI1JLJ3H4gBBKqthwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuIOjDMeoqhNSmAuyEhAV1reipM7JEOHn9IB1qd34SY=;
 b=B0oRvfOO4L1NvmADYQjZKDZ9lgWbKLFrmQhDSxhqD1w2PoENjrUQoaVSUV4YY+6gwB/Zzvkmh9W+75voVtcAHciUxf5vJRKfRo5QgHldSOWdzoYprfpEpw75tM9qDkOFHRXYlm33TbXOp6DgZJUTrxCQ0N9lv20EGydCUfVzWtqAFE5Md5GMkATo/jd/fDbnzsL6vmVpGmxx3CVwZ3+GUWzdzq6Ne7mvbcIGcH4CypdliNiO9KW59Y/BZQHO2Y40jJCTPdNxICiEWYjYUlNqdjB7dkPOglTa/6yzEZ6tMIVjcvOF2zwCe+EhUOSyCB2VsqAjOGDR7XJC3AAKEl1bJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV1PR04MB10275.eurprd04.prod.outlook.com (2603:10a6:150:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Wed, 4 Mar
 2026 18:00:25 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 18:00:25 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH phy-next 14/22] drm/rockchip: dsi: include PHY provider header
Date: Wed,  4 Mar 2026 19:57:27 +0200
Message-ID: <20260304175735.2660419-15-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV1PR04MB10275:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1d6f4e-ef92-4966-6ec1-08de7a17e976
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|7416014|376014|10070799003|19092799006|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 jlBEEwmi9BB++s3PUmW9y/KaMOzl3zWONcI/OnKbtbxQo7qmOcFQoszQi05oT3q9Qirl62MbQrL/JoG2O5/lg4F8iQEmOssUOqhq9ht+znEdZlxpnEIOhRlDkHsaROBjNWn7Jg7xneDJH4qT8kU2i0ThbyaetMYzzbegbDhA+13Gnpoi6EKGFUTShm4O9lOs9UfhEh4SHg1I7N/3izfnU9qTwDjT/F+qya/34BIbpvw/rgwf8Cf+Mcn4loVKst/JCeQG8e1LhUoTswlF4XLWlRZPug1u/rQz/4fPhmX74HrRkNVAGqv3/LL/onBnWsMLsHqRAjctAg4wkx7nHMie1cH+xG3a0q7XjNtH1FnHQpWtFXF/5oIflkVJGpo1ccWnDBmrexmGlejnXl9pA9BbPm4NGmdIqV1pFu/dU7KAWxZRnoh5ggdFH/8f06xeKVNZ6kRqzpqZ8yPCelNKUebfeokIeoPletDDhL56JuldDwPcm4oaJDjYscatnC0PUcR6+/wePFY99XzECiudELJ+83wGk/EYUPVeC7mCBmGRWlRbhmNsTZJ+gDHzzMd0wc9TKog9PeorrWWWKfhrQnzPIi3zfSl3Il9y94VFJHrYeR51QKYh5ZbDnlI1A4+k+vqxEgoaxFMQNzwBZcw/tnmEvQtoBf0D32eFpbJ+nHebmu+XzFIVALxhdQHRJ7ES7Rph6bsvneMYd/ZeNRj8EwsPufAFoIMQ7KyA9unsjDBbgc0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(10070799003)(19092799006)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?VQdc8IDTET4/7oefxX1bqYz/zVxpaoB/Uze3zhqPrP8pICs3gxaxRlzwOKdc?=
 =?us-ascii?Q?Myyqx56lK/EuWha8dq/EVZ07QOTdQ7mRCdrZztXJYkEy9tB+0nsP6gurV91m?=
 =?us-ascii?Q?KfY4kqwniDCV+TVwUYR9mtnBIxIg5R6SDYQiTjodHcX2qejk/Br8T1248rwr?=
 =?us-ascii?Q?alJNQadPYuKqkEIKukTbpyGtn3+jznXmEkpyx0yPb4Lr0//OOAYBkJzzlqAo?=
 =?us-ascii?Q?XmCEwBRcVr2Fs1Jv9SQfCmrMDv21XfesS8lPwmzwKIjcQzF+ELGITMlQnZtM?=
 =?us-ascii?Q?ojlnmox/GX9Bxghr0S/sbcKHZ3ymAKfcaLPH5puXz9MDhQl/J2PWrzwCIzRx?=
 =?us-ascii?Q?iyxkT4LseH9VbOZR8DWHd6CttAaxi10o0fbiQFhUaahWr4nk1mPf94e4Qlo/?=
 =?us-ascii?Q?NCfQqmsBR0Jw46DF6m6BSkQHtVyh+ktfH5ruYbVYWysovoaz6vmHoy8xvzKJ?=
 =?us-ascii?Q?xjHNG8rHsULxxYCWYFkI/1erZBcl0DKRnp8Xd69Y0tMW2IvJ4ir+NOSkQ1AJ?=
 =?us-ascii?Q?MXXeHLf58Ge6xRdLzqv+uE2E6g6JY6FXxN3z9bxZC2hVi+3+iNkzGCaALls6?=
 =?us-ascii?Q?XNun51yUaI9nn2zlhcSJGVDdYlRbTFU6dN2wjdZ7duJ2JDeQ1b5E7VYEuhQ/?=
 =?us-ascii?Q?2xalGsXcZKDoXKmI9qWHKDjUfsrlWG0cqIPskFBEWJn+F/QcizsdZvcVcz9X?=
 =?us-ascii?Q?REJUW1yPb56O0Ip5p3WCGwAxqxHHILUI77eIKs86uGuDUVqDubBYo0XALeOm?=
 =?us-ascii?Q?w1aElKyao0dKTA4WRfHnDmsJxUr0zOtgoyoWGt4pFWiPm1nU1IQheRxD01jA?=
 =?us-ascii?Q?g/+zdERt2BBSgvfim4DHDqA2u8LqJd2u0iEiSH6Rff7rtJGNXxtnYMZrfUSo?=
 =?us-ascii?Q?3gPu5DfcdhWspPO29PLrnFhM2ZYICzL6WdnPucTLUtS3YqagYfmQfqCeP8Hc?=
 =?us-ascii?Q?XpeG1lS8jNsF9dLbQd6WIYzUiuSQz4GnjXpSSCjLE3Lol8jVZrYLse55+B+w?=
 =?us-ascii?Q?BI+t9XdskNlLwuYe5YwtbMNqmn0DyLiylxgPF4YqIYOc+fXRypSK2Ia77HSA?=
 =?us-ascii?Q?GSCVZvV204rUyO80cBa3g0qLTUXDTvLxvBc0i9jRiZ7P+qPoqx/nsCw3/MHE?=
 =?us-ascii?Q?mwKOqrlFKAqbhFeNM8KK4N46rqI4d4gfwgS/09BUdZRJVYS+6iuJbD7ADjvZ?=
 =?us-ascii?Q?9rIKi7WpXCLxDUcT9NQhiVELDiWiEhugDP0C7z6aBRDlcOk+F3gSzjrpbX8Y?=
 =?us-ascii?Q?OJ96+CW/YsLPkN1NL4uHfsiQIiYH/O042lNEy5g6gpr4FLxq4BEp7zsGYQQ5?=
 =?us-ascii?Q?YfK10g8VS6NFv2yoNbzHFQr7Snf85PdQnJH2xNYOEUzIloSrf7hLYeqqsLKj?=
 =?us-ascii?Q?zNz6mnXs96Gg6s47ZDXY7WwTDUC50c9laABZWrPtV4ADvWs9VjPezYbyC8tM?=
 =?us-ascii?Q?rDE9pMTRfCZVcIH/OZZtLPCKDAqxykcrbJYMF10XKGHw8i7bQrNfTbDEmdNp?=
 =?us-ascii?Q?zzWDwBXkMUxD4ScLDZNs8LBFk94owZ65arK3v0LAIaTjWPxJaockpahL+fk2?=
 =?us-ascii?Q?MGQWEacZp76ztb+XSj1GiO4kJlbZ72GtHdkwnWrRN+fYqoikAWDYXpEc18p+?=
 =?us-ascii?Q?ifhoM84n47py120MDUYbCv4i1SFUVuxx2xfR4uhBQyVrqtSITks733os/b45?=
 =?us-ascii?Q?WJ0tYZWVcc97klWEZr5nMZ7jmoRFm0eEcj/hjYwdRE2sT5Vm/cl1pGCOOEeH?=
 =?us-ascii?Q?j+w/hs1yAUeN3PG4dmmN7BHxrIw8bnH6bPzuDz9/VwmS0qJSFPmG5aCaVCuo?=
X-MS-Exchange-AntiSpam-MessageData-1: MksSab9fiKUQu5jPN5BLX2oi39DAeADx6tU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1d6f4e-ef92-4966-6ec1-08de7a17e976
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 18:00:25.4462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIWFgd5K0J4VykLuSe74gJbZBRJ9gwyxLj+cI33gei9OgcDKKat4ybKoMRX2FgHQFxWn5wbhuBW6xHEUqRRTZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10275
X-Rspamd-Queue-Id: 6F84520604C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6901-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kwiboo.se:email,ffwll.ch:email,intel.com:email,ideasonboard.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The Rockchip DSI controller is a PHY consumer driver, which is also a
PHY provider (calls devm_phy_create()) that lives out of drivers/phy/.

According to Vinod, this is discouraged, although it would be difficult
for me to address a proper movement here.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 3547d91b25d3..c0aaa51e0237 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -27,6 +27,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_simple_kms_helper.h>
 
+#include "../../../phy/phy-provider.h" /* FIXME */
 #include "rockchip_drm_drv.h"
 
 #define DSI_PHY_RSTZ			0xa0
-- 
2.43.0


