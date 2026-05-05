Return-Path: <linux-can+bounces-7501-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFZCI2XF+Wn2DgMAu9opvQ
	(envelope-from <linux-can+bounces-7501-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:24:37 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 392EB4CB1E3
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DA8E309C5C9
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451F7401491;
	Tue,  5 May 2026 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AJCuNzdY"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC643FB049;
	Tue,  5 May 2026 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975577; cv=fail; b=esVic3Bbg056aAKGc/0fF48q4RXa+VQ1imsyC1Pe65uK4F9AOhsNsfmR2/T8aC4Qxk5eJS4RIr5SDFG+dLv69UVDx3imxR7cti1aLMB/jwqzhkVKxz1yKjXfxErmUKN2zvnfkJRPPthg7hYMTW3tRdWUz3R7ZxC11h7ZKu2ZdSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975577; c=relaxed/simple;
	bh=ZHH1cgFKix21vvk71mPJgHN9XbODyafruvQMeH+Ir7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UEHFBG3gA+B4eF4doSLofqCSJICn1WxDeA+OHtcSbnTxAaWJSwLfaXyv6vDS8OFowW3gpm3PNUL7Ttr4ee9IaJpUjI7ayOuUG5cMMEE2MGWWZL0YlnuDddjmpVublFVcVuEha48XC3R+RCyV8aKP8LE/+JOyuzd7SE7VCv9mVAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AJCuNzdY; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qzu4otWk23bVNMwJgMBhviSj+5XmqRhQQgl6XtNU3ZQn74PeIIRelVxTBtr/r5v4BFIlpCFk4q1IrpMdeGgVE2G85G9GR5bgODUT3xsQRwa8p3OXFCu9CHM2zsDCwBIEFP2NnDYf82/vswpYOEW0TbvHyccvMm9FW4FsaOOgSWXHSZWRifm/+FUIJFWyRXx5+WH9Mu0rkT9aivsh1b+nquFyl6L6gxb5bwPopqHosZqAj16ML0JTd+VUrynIBo4C0mPR0g8IVm6/xALHqIe/MVGHKgnwZONFXwiP8Ll1dq0jReV0klrNDnu/I0jQ2+h7zdu4lIztMvAG2D1BIRkedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peY7nwIrQ0Vo9Wg3nyAoFzgTp4el9JJoCbdirxkwdqk=;
 b=Ss1d3fAR3kozy7FHzPYpvLqnD+EJi8My9m+MznO+5TxA8WORLGDq+FHF4B955IBnUWWBZEPjIXSzmjUFnqaM1M+Gs+QRyzKniG7VDR3+8dTcH71NUGOsJqdhjy64127qHCt4OsfjxqFox9ltrK8rzKtkJPOcmkqqvkn1gxms1YuRmynR4QXIXoqWuRjhp9u7aPU8uX0algP14I+H/yGZAMSF/BdgovlLv3oHdQODG5PKrsCPo9DFv9PNxR2Z8unojvQdnBid7W01ojikCsvhwmV/JESJtjhMY2D239dNNt8MbqAANocxbnsfo9O6rn16dQyQUYuINmtyAI25b7L3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peY7nwIrQ0Vo9Wg3nyAoFzgTp4el9JJoCbdirxkwdqk=;
 b=AJCuNzdYJokyTO80JgMKrtxfAcHe1Q5fp5MHltqBibLmfVMs9WYCYDbqB0TMAK7IHnc2QHu6C3+m9JoK2QRsitTncKQKy+T5jDDaTIgATpnaeP+0a81PI+HdtrKpUa04CqeyHR+zgIhgKDFxf8otvQvh7vVwswmRLn+ZpZ8aevRoifRK1dw2Bb8We66Z+P69FGK4izV6nPf9t0EXhIeF0TCSSXcA3HzOnqLbm+TO8QGIbqQpDzn2XrpHG40wfnVlAhccLdaBK+XHAqbfMmDahOCLRKDZ5KQRiB1NNGb954Z+J2HTWfM6TQvLS6vGYm5k8pjx7tt9nZNqGJWqM5fVZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:06:01 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:00 +0000
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
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Can Guo <quic_cang@quicinc.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v8 phy-next 12/31] scsi: ufs: qcom: make use of QMP PHY dynamic gear switching ability
Date: Tue,  5 May 2026 13:05:04 +0300
Message-Id: <20260505100523.1922388-13-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0318.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: c5912e16-2270-417a-826b-08deaa8de8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WYwMZhUHUemFwqXcR+xwqMsIhqpwbUAcQiPC4lxt3u8ZksTWkvNCQafH/MiqgKg6Zr0/LWv9R/Uyv79Ohu2qPCEeRShY72llaln2/l1IAxbN9aMRQezKbbiqfthAvOBB2X6ktPUCfvHgU74g2kVgKbGkJp0JA92xZJ128PM6ijLSQtOzIpnYYuA2h4GhDWXYv3q14v7jIFZwCLP4mnNYZsNYmq73i5YZjdQkGZdnluQ1VYa9iycsT/YE5iEx5yA+UdGwm3mTDG+fry5ia7AxdzuKXg2xMt8j8Fn87SZcX4q8Vxyc8UbmsgbcIWA8FLFKAL/wOZoLjVytXDp5N2/YCjtvp2Z6mZbuwYP6Uuvil9o/lEs07BfRbtN/cugLN6QP7k7lKzx16Dk6gQ29T9UUlpSiwP5NeuePlx3ZtnMcuDutDX7yghiCJ11OywAQXIWqE42g0HJjvsz9/I+YsNviBqUpmAOIXvzGAIxWG1HlmxzU5pBCwHrjMnkx02cNfi4YvEO7fRjdjIdwfFzqgNjQ1ZjGc/agZrB1NEaNucvsaDYGegSJ9ydvpuGObTTgQ56m9M/jgh5oo1ePOODlP4fo66VE5OoUPIVOhhyXfYnixwNgA2qD3ruQXy026izg44N1k7eaGV1dD1UUO/yoR2t6rUivI3rOHEIRwl7k5m3UmNUt4JzCAJO9z2tk4MCZiMH8E+S/FAAZEX9J10++zfverA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pjKll4/ioIkeELFDNEd1hF0upjtMTS/DKjWtvcJTQFO10zOYLDFsRZWKOTX2?=
 =?us-ascii?Q?ya3mc82lfOPSl+2UxIPYnudpGNdWuEg6KLMwjkM9SdgqbAXk1J6y2asgQcVZ?=
 =?us-ascii?Q?F17qn3TPOmeCI3AYn2wEg2boY2BU4UfYmErDYDbrreqG9mFNXAozb18cNnSn?=
 =?us-ascii?Q?ITscUdxJnA/ThZJgZHqMxm+pPx33Pw4rGO7G/QBBpWwtT+gIWHUjMqa9FK56?=
 =?us-ascii?Q?WOlTuAg5TXsfL0xddKH+mC+Bfbx+hJD/IjMpsMhYkhuS8g+1hUIoMjn2Fp4h?=
 =?us-ascii?Q?Pz15DD1E4UAlMMr9NHecLZiKOFtmtzmdcDUIj0SjvE1mZMPQEOj0ii9htT+k?=
 =?us-ascii?Q?Liwzl6yU1MwmewaHBfY0yNeYcCYXLF9i54AvL2M9BiA8nus4QUgwFU1aqmEQ?=
 =?us-ascii?Q?K/cE6yheNMqpN9jynyxde4iDdrIQaHTLdzCKAa4ZhkmTJfqYcQ6TyV2mf+zk?=
 =?us-ascii?Q?YWwNOyUZsa0Pdv2GSR2Zuq9ToHJvApyPP213fJcr8WH5yqtCITPlVWgGp5op?=
 =?us-ascii?Q?bnmRtEgmcIo+td6wb6UXmE1d03naTJllH2FeOCfOJpk/++KGqExZLdKK1jK9?=
 =?us-ascii?Q?TXCSBsHXr/I/HykwMgXkkLlv8gzNVRPqSixo7QXMbiyaCdomBjJdkCQYKNdV?=
 =?us-ascii?Q?sHlSsmM8A8aSZZprFc/CEj/WnG8w7+eU4+wpJV6J2J8dqOLHAK0hpSaRatE/?=
 =?us-ascii?Q?BLfkuhG2mxNYKUdVraNq+hBVwQEebGNObcjQgjqmOzF8Ofln7H4xR0ZV/+Oz?=
 =?us-ascii?Q?w1Z7txZNrlPE57YZSBd9p/z36yaWz8gvtjK5svJRN2U4iLkFpwoDII/I5hvw?=
 =?us-ascii?Q?zANHjhObkFhHUVtG8WHyPdASHSY1IbO+ys43tjwgXdkMmof2eZ0tFS8GFIKe?=
 =?us-ascii?Q?JuGtR1u3B8gthWFjagsDEw3fkVVuLgZ3G2c0Q8sBv9uQslkY1GLa4RNqBVcc?=
 =?us-ascii?Q?beYKllRQrA3vrGE59L4TeOnldEL6jk70DFMxXS6YpPNOsWfOsqLXsRMfxDKl?=
 =?us-ascii?Q?pj6g1fBj2SWmYxKCHP16YIJOBmCiqmdpQLCC59OPzvs70Ey6OWhiIyuwiq8s?=
 =?us-ascii?Q?a9IRSZR1G/6gaq/PDVedd+63JIdGRslWOL/3Q5vSAf6ijK7wxvHy/2xLjA9/?=
 =?us-ascii?Q?DHGht/o9KeBCIYGRkaHb6AjXOHgXC7qHtqm0IwdY7NjZKO2WvNbUcjbPgRFl?=
 =?us-ascii?Q?KH9tuVfO7rSyhyjiT0qG6MkVhwrvPPgeXYcUOvD1HWqYcYqbSXgXEGMT9oot?=
 =?us-ascii?Q?nKsxMTLntWmtKXAclYw8R5fuJlXIqh2PK6Cw6kqN9rB87KEqtfe+hFh6WWZv?=
 =?us-ascii?Q?5OiUkIE/MJoPjAdOvDmVaJFwfC8bJlLKwNClmQRhKlfNlzh1Cym4jWEU36BF?=
 =?us-ascii?Q?C/YF6Lz3WEUOnkX9k7DoAzKhfLoAsL0OFInKv9i890xo0p+PEcjdOrgMmi4M?=
 =?us-ascii?Q?HMoujpVJ/vyZ7FJiPIT3jGGBrGiCG6Fo/4m4glgc1zG0sB+49tOdyjhwgZR1?=
 =?us-ascii?Q?5BiXMII+ZbbstHL66Vbwhtes9ns9JiFJacUWV1sXultdjh5kgNmEQZRpJwi9?=
 =?us-ascii?Q?bshiZQRVMsOZwCGuFAd85jUgQ8HfNGiNmaw3i5N9kAOXfChAocNDonIsKFif?=
 =?us-ascii?Q?FuZ3p8IgHDc6K3fV/Bo51P/XsR/KNAHXkHtEjhJYTVGdqaa/34PtbVKhE2ru?=
 =?us-ascii?Q?0CrQ+bU/5uHqWHuoU+5AxeAH+4xtxBjKd/PbWqDtosFdW6WVk6f31fnHCoOp?=
 =?us-ascii?Q?TkpVQdqkjw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5912e16-2270-417a-826b-08deaa8de8e0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:00.9297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kwx2JG4W23Z+iAECvHQij9XwnjMiVoyt7YcCzYmYSXWLSZCVocibJmdd+OdWtvwsPa1yoOCAP8/M5l4ryTZoXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: 392EB4CB1E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7501-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hansenpartnership.com:email,nxp.com:email,nxp.com:dkim,nxp.com:mid,qualcomm.com:email,quicinc.com:email,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Currently, phy_set_mode_ext() on the QMP UFS PHY makes no change to the
hardware state, instead it is mandatory that phy_power_on() followed by
phy_calibrate() be run afterwards, for the new mode to be picked up.

By absorbing the phy_power_off() -> ... -> phy_power_on() ->
phy_calibrate() surrounding sequence into phy_set_mode_ext(), the UFS
HCD consumer driver can be greatly simplified, and we also have a proper
self-standing phy_set_mode_ext() implementation which does not rely on
other calls to do its job.

So simplify ufs_qcom_power_up_sequence() to only call phy_set_mode_ext()
and let PHY power management be handled just by ufs_qcom_setup_clocks().
Actually, after this change, ufs_qcom_power_up_sequence() becomes an
inadequate name, since from the consumer perspective the powering up is
invisible. So change it to ufs_qcom_phy_change_mode().

The consumer and the provider are modified at once because ufs-qcom.c
already calls phy_set_mode_ext() while the QMP PHY is powered on, so
introducing the extra logic in qmp_ufs_set_mode() would cause a
potentially breaking second QMP PHY power sequence until the consumer is
patched to remove its own calls.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Can Guo <quic_cang@quicinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>

v7->v8: patch is new
Commit was previously posted here but did not get any testing.
https://lore.kernel.org/linux-phy/20260327112858.r5lpqygtvsane2vf@skbuf/

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c |  6 ++++++
 drivers/ufs/host/ufs-qcom.c             | 25 +++++--------------------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 771bc7c2ab50..e4e7966eb39a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -2012,6 +2012,12 @@ static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	qmp->mode = mode;
 	qmp->submode = submode;
 
+	if (phy->power_count) {
+		qmp_ufs_power_off(phy);
+		qmp_ufs_power_on(phy);
+		return qmp_ufs_phy_calibrate(phy);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 9039b087bf21..e28edcfd13a1 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -485,7 +485,7 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
 	return UFS_HS_G3;
 }
 
-static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
+static int ufs_qcom_phy_change_mode(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct ufs_host_params *host_params = &host->host_params;
@@ -508,26 +508,11 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	if (ret)
 		return ret;
 
-	if (phy->power_count)
-		phy_power_off(phy);
-
-
-	/* phy initialization - calibrate the phy */
 	ret = phy_set_mode_ext(phy, mode, host->phy_gear);
-	if (ret)
-		goto out_disable_phy;
-
-	/* power on phy - start serdes and phy's power and clocks */
-	ret = phy_power_on(phy);
-	if (ret) {
-		dev_err(hba->dev, "%s: phy power on failed, ret = %d\n",
-			__func__, ret);
-		return ret;
-	}
-
-	ret = phy_calibrate(phy);
 	if (ret) {
-		dev_err(hba->dev, "Failed to calibrate PHY: %d\n", ret);
+		dev_err(hba->dev,
+			"Failed to change PHY mode %d submode %d: %pe\n",
+			mode, host->phy_gear, ERR_PTR(ret));
 		return ret;
 	}
 
@@ -582,7 +567,7 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
 
 	switch (status) {
 	case PRE_CHANGE:
-		err = ufs_qcom_power_up_sequence(hba);
+		err = ufs_qcom_phy_change_mode(hba);
 		if (err)
 			return err;
 
-- 
2.34.1


