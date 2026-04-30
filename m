Return-Path: <linux-can+bounces-7451-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIh+Gu4882kGywEAu9opvQ
	(envelope-from <linux-can+bounces-7451-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:28:46 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3AF4A221B
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81C0F30384BF
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C58543E482;
	Thu, 30 Apr 2026 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cK9mLnlo"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698F43C069;
	Thu, 30 Apr 2026 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547268; cv=fail; b=JDdgZFS1PyvL8bw8hLQVGWAQLhLxpR5mMDU4HQtgcF9CthACf+1tqd2fH2Hd/Z2oIwAV/6PxpcpAY1B3amEkEkf+/KtzTbGnmM2X23fV2AEbGfjny0z02Bh0C0qRTnvEiwgK3h5TqhZSM/nSjANYT2T4r4CsdA9iOfm6kmiX8Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547268; c=relaxed/simple;
	bh=BFQktr3CkyK8+/zk/Dkk2j/43tCaOe7TNIegyGrm9Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHARRDDhtJNvgqV2LBLWbOWyGLv0Ji4wUcd0W2kcvGUNDi+kb47xvyFX5bsFbtQvV6nx7cxA6DJv2zMPQqJT6KIjdtP61L/YdMCYE0UYW4NXB2EDhqTYFk8usa0XIEY50K2F7bBuu6NE7aasAy6G25PpEVmOzM9dZYlnM4ytWf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cK9mLnlo; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDLOIj2CfkyN6iyePtQSPHIuonIDnMIsMtqR14es7e2O1uKqX8w57aRPzUAmVnGXwAJvSB8rbDtR5mJdrB40xiFyz4GDVH7oBRfyNuRpT+TxZwVJ8p99xHRzpF7GnSkUxsJsd2LAAsIKNHrL0lqpM5h0FBE3Kyso+xPmpblDtYQBQsWH/Nj9nFb6zdOcCwV9+f7+WukAAamoDi/1GwBMoSxYLNKUPm9laz/9+gL1Lc+13DA8w9TXsv74bNaQZ4WZm624NgvH7vz+8M/CymOq94nWfvgftdkisYccDltV792T+Zw8VtAK3ujcwAM2BKYJ0iaGsdcQEWspenrde4LdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHJ2MT9Dp3X8SKY53dXQufllTDipdkJu0Z2skcsmABc=;
 b=V7AuiTvxwEu/wexz91hy8s0cMQC5v3otB9/XlsfhKi5QcjLUoRTcfvPleHUBhYd9YaT8b7NW6sRgSMMgHEEzlHPvmAJCzo9ePtLYrA8OGzSb4J97FK0v12qFBzr/rvnf2/mV/r91stieSoJ7CuFTxocqL/bNFqhD9esvaXyWVtsalfgbqVrnLVzuhj8NohTxO26BpWHzbREBxUwOwwKTaDft6G1kOtQO9JRwy9WzlTTZzQL8MhqzbqdksJayxEo5JiKQEuOR49vJzWGK5xnziHLfVuEuvzStBLqr4QHadriu66dQuLCTGwPHuQn6aVJrkB9YMzuS/ADBDwj24nXKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHJ2MT9Dp3X8SKY53dXQufllTDipdkJu0Z2skcsmABc=;
 b=cK9mLnloxUq2O4eWDsQGGemLeZJVBzp92K/hMWmAOu/oWHyc5HeIStuVjgBPK72wHDdQT0mmRKj/M0vhSN1D+ref1t4U3Y0zV0mFHbpRLCRVUjGkiySlO7MkG9F9Y+HFeDxck1Zx3J7jdJPC+OCxLSLmWO2h2pwnGveVT+uLoArIs1/y7Kasz1WjPwqjgNSnlq0AV6wD0OOpal7tMWC7S774Qc/WqGFjZwXtjjE6eZhjfeqYZvYFHWjgAyhmPVWPaRAIbt6TeyusO58Zfyech3oaz6RCelquBilzNsP6GSfGGNHxPP1H67Gvp19u+DvhuTBRoYg4tz4YWvx6C67DyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:07:34 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:34 +0000
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Michael Dege <michael.dege@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v7 phy-next 21/27] net: renesas: rswitch: include PHY provider header
Date: Thu, 30 Apr 2026 14:06:46 +0300
Message-Id: <20260430110652.558622-22-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::9) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e932299-0b69-46c5-286d-08dea6a8ae17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|19092799006|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4p1MeVQeJ5RWPxISMGpe71JP6WyCcT/Sa3TOMIizI43gkgyuHQHsbxo+w/v4JMqDPac3Gn1plINlPe8QcA39EY4QOEj31D1qzniXw575GwkxAIYNFcujoA0WovaOLgr5GlFQ0/S2U9IQr5VHIDzfvrByriLmB89BHEFDkCMCERuDSct/JNbq8+HgR3DCl2Xw+3kFgcwX1I3WZk4iD8qZpHUPldKeJ0rjSo0boRKRSK+OzveJffbjUf/T1Ke4INTAvI8Zb7yNah8G68MXQScMJKuDP1Uh/I/iuGJv96L0jGLcfqoYrhR3ObJQ5oYtkDnMD8KU1uvTJZvrqhQfnGG41F9zxdnGo9DtRyEN6d1mrbql5H5kB3NxTjh2g8J8WHOH/fIPyQN8sFTDgywrmSPRvnsZKjgVMOsyyd+ze0Xi1NsSgCWJMyLfdmStle2qHQqCqnnhL8BKBSPcPn+0978J7NftjkGUNEKZdbPVLC9OHrXsd/0Lt9Rlt1f4GW8DXCCJ0nlWt/pyjekqmOTuJWLGG6Kov1iYx0W4vIQtiPF9Ldhy5AxdgnRMpNZ+WP9t9nfYGSciF36ACHXDfwFG4B2XX96rspnVBvUV4zrDLokXOdHcbk0BbIBslOtuTSr8zHHdjywZrDoAhXa459/cunvlvY4BkMcfS3T6vVz6IyT+cEroD0ixxPTdH/RyXn8bDKjM36GszHrLdp2o8tLFOk962BAwUWvkSy00yT8FWqyGSlg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dw1E7Ys0xzRLXwKV4vIstoez/Sk8iQWuwTS7fY8DMTDUGygzURGq+4qd/sXA?=
 =?us-ascii?Q?n01fv2wd0LFsMgyVA1/w3CkJFRDXk1GmXUyfLsye540J2LtzgKuvcKKuMoK8?=
 =?us-ascii?Q?GPcDdS2IHGa2jvcViSBGkpm7MbPyJepnulHAn2GUu9klxd57h5oV8o9STLYi?=
 =?us-ascii?Q?f3smQd1RoKthibza9VUCuwyosgh2ZydiKPXwfQw2vLOzNlB9HNvVTocPhRQ9?=
 =?us-ascii?Q?SsraonmfLiXvdZ/YfhHrADB/ZeoHuVvbvGRe/ToXlkQ5jS8+O+C1NKJFmhDS?=
 =?us-ascii?Q?qkeM11+OZ1agkNckv3MJRfjtYU8P/O2HAoOc3uifVi784ccpLj7oqFQRBvrg?=
 =?us-ascii?Q?wJS0OIGAlXVpOm8TqVnT5sm3Y/yC2Mc32XORnHZbwaQsxVVoaU2s+OKPa4ZV?=
 =?us-ascii?Q?pXwzIc/xWEO7YZ+4yoZdDQtH3n609f/Nq+NP+gqmkM57k22fXO4nv2HcsGEW?=
 =?us-ascii?Q?Api7dXKiyvhr9uMGhCnvQ/hnr4pfO6LFT3sD3XqUsnS2mkuPN5mIYwzoRUuN?=
 =?us-ascii?Q?WNyt96NWAI8ov8UAAvmMoy0Di9MvQ5ok5RSEKLqa2UJuhu+q/+zeQHwM2PFU?=
 =?us-ascii?Q?SZDn7IcioQT0yx3g4pIiUizw44U2yMR6xHNN8O+u4ExuU4+hC1Rx6d8h/wvn?=
 =?us-ascii?Q?vvQtD09r04xMHaCS3tY1w2SFP/IbR9tc0FM7UBqjjpjBdeFRspHflfbu1xcj?=
 =?us-ascii?Q?b7JJHbPXp0iU0Y7j2OPhdPmlXiVB/Av5rePZafb5ir16JEfBz/nL+TDmIz5Y?=
 =?us-ascii?Q?TDpPpYJ+LwSmwZHFmKFlnoOWYBMSwrkjJOEBibew0CtN1A1semOBBMt9aL90?=
 =?us-ascii?Q?04GtPS2+E0dblb6e1/B+iXSnUHlL7wzPYGs1Z+YSrQXtBqbrY36b8r8SN/jo?=
 =?us-ascii?Q?ouD2W/fT/B3uIg4droPjo2089ECAy7Km1ir/wVBAZJPIjNVh+4WOcAuqUIVd?=
 =?us-ascii?Q?SRXZyTEDEe3k6FkOuIO2sM0YCTQ9i5aQeqUHQmNPMka9QLPCHgHOZVMMWM/T?=
 =?us-ascii?Q?5jk5rtR4xWAxRyNPIakqwsTb1u5cKdNozzT8BOWgobrqnXEplk0ZH0LAtIBi?=
 =?us-ascii?Q?kQwT88za8KO53ZIOvbD1eRP/8zWvj3JmiYOvpDqBIDlVVwXjhRUGOgMwfaK1?=
 =?us-ascii?Q?IZi7fiZEZ7eiBi4RqDAsg1zLED7MdYnTACkmAeqOZ0Cqq3UAOw9kIKcUUpcp?=
 =?us-ascii?Q?GSLuGDK3MiH8bn+w20sk79CamjdOD1hZBWj2+ktMCndhXr40lVJ/us5UxUF+?=
 =?us-ascii?Q?5ZLyq+1DcxEgMSrJawdxZU2zlBOXXW8aWeuv5oNHLRhohDn/S0zVKKnZttaR?=
 =?us-ascii?Q?CCTTrqfn4f+rPfJuSVAvMBzbVIF2Jn0Pj53CvH3dPTMk6eLX1nPmZu9XhNf+?=
 =?us-ascii?Q?mGaovi10Xx/9iY4tM9sKgd9853BJmiP1Hw/lmU8+OEoy9UMxp1NNtUwFc+Qr?=
 =?us-ascii?Q?1r+jpBGxYL5dwlG/AaGwAfMeBFHjXbXexYPbb5t8wE5LvG142S8EFhFmrA/J?=
 =?us-ascii?Q?kIotYPQ3KzQE01VFkGuC7uJnNmcnGlv60nPehtrL+uS/bdZ1ZQLOD2hgFDNq?=
 =?us-ascii?Q?/aifaS/0oFY0ljf3BQwwOFx4uYwH72S29c2TqHQ5EOrne1J3wFTp4B/CcNP0?=
 =?us-ascii?Q?zfIZJVZxWktc2M5xFoNDWGsJWg2UeVPLv9OAmMO4n6mP3185jceN4DoVrNFl?=
 =?us-ascii?Q?q7zTkVNyVexImGHDq/qzRCTHqH5OQXwz65NsV0Z4Ag9aWzIiOT7BzgHEApwN?=
 =?us-ascii?Q?V6nEyRX4a/KX6XK7f9e81I9EW/lJtnc3EL8kYDU//7D4RRs6mVmC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e932299-0b69-46c5-286d-08dea6a8ae17
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:34.0072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQtlHIHV8ikI2rx0W0HSemGk+G1OjQTVMG1NCasUYmTlltl9QB/U2fVSITY01tXox/7LLj+Un5i1DyQxAKjw5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Queue-Id: 5D3AF4A221B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7451-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,renesas,netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,glider.be:email,renesas.com:email]

As a PHY consumer driver, the Renesas rswitch dereferences internal
fields of struct phy, something which shouldn't be done, as that is
going to be made an opaque pointer.

It is quite clearly visible that the driver is tightly coupled with the
drivers/phy/renesas/r8a779f0-ether-serdes.c, which puts heavy pressure
on the Generic PHY subsystem.

This was discussed before here:
https://lore.kernel.org/linux-phy/20260211194541.cdmibrpfn6ej6e74@skbuf/

but to summarize, it is generally expected that when a Generic PHY
function is called, it takes effect immediately. When this doesn't
happen, the PHY provider driver must change its implementation rather
than the consumer be made to work around it. PHY providers which rely on
a hardcoded call sequence in the consumer are just lazy and wrong.

The most obvious example is commit 5cb630925b49 ("net: renesas: rswitch:
Add phy_power_{on,off}() calling"). Problem description:
- Ethernet PHYs may change phydev->interface. When this happens, the
  SerDes must learn of the new phydev->interface using phy_set_mode_ext().
- drivers/phy/renesas/r8a779f0-ether-serdes.c implements phy_set_mode_ext(),
  but this only caches the mode and submode into channel->phy_interface
  and applies this to hardware during phy_power_on().

The commit author decided to work around this at the consumer site, by
power cycling the PHY for the configuration to take effect.

This had a worse implication from an API perspective in subsequent
commit 053f13f67be6 ("rswitch: Fix imbalance phy_power_off() calling").
It was observed that phy_power_on() and phy_power_off() calls need to be
balanced, and so, the consumer decided to start looking at the struct
phy :: power_count (the technical reason why I'm making this change).

This is also wrong from an API perspective because
- a consumer should only care about its own vote on the PHY power state.
  If this is a multi-port submode like QSGMII, a single phy_power_off()
  call will not actually turn the PHY off (nor should it).
- the power_count is written under the &phy->mutex, but read unlocked
  here.

The rswitch and r8a779f0-ether-serdes drivers both need to be completely
rethought in terms of Generic PHY API call sequence. There is no quick
fix to apply. Just include the PHY provider API along with the consumer
one, to keep working as before when struct phy will be made an opaque
pointer to normal PHY consumers. But this is a bad offender (and it's
not even a provider) so add a FIXME.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Michael Dege <michael.dege@renesas.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

v2->v7: none
v1->v2: collect tag
---
 drivers/net/ethernet/renesas/rswitch_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
index 6fe964816322..132be5f15073 100644
--- a/drivers/net/ethernet/renesas/rswitch_main.c
+++ b/drivers/net/ethernet/renesas/rswitch_main.c
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/sys_soc.h>
 
+#include "../../../phy/phy-provider.h" /* FIXME */
 #include "rswitch.h"
 #include "rswitch_l2.h"
 
-- 
2.34.1


