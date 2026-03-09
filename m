Return-Path: <linux-can+bounces-7048-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CEyLKAcr2lIOAIAu9opvQ
	(envelope-from <linux-can+bounces-7048-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:16:48 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D54023F897
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E84430379D7
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C105542983B;
	Mon,  9 Mar 2026 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KfpcKZXF"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46263429805;
	Mon,  9 Mar 2026 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083413; cv=fail; b=oek3x/b74D4h/lNouC53IbR8iEaYcu9wRufid3yUiavNbBBx+U0VxB12XCR6XZiIRxwMjgaocXcRvcoBK94+qwOf+EttI4Sb/zLaWTn//6AvwfbzKw3SNTHSYZkxp9mNlxfDI2tVaG9w0frzD9wTCKd9sJQzstWtnEMq5XMaTok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083413; c=relaxed/simple;
	bh=lig5ET4oQC2K1LiylkRloBqDy99lgHqwFZoltBwZxtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OyvnApA7RBKio1jFkmBbvV3LK5Qbv7r6vRvEkXNDA0XGot8qHrhdk0hCTgdPmNSjHTQt9wPhAtoH9Sgf4tVhv9InfTUrzIH7CB/mE97HXMkzAj9wWX+aM+QorLjPasPr5pl90Em637tIa31uIxrKijhIx2SBNB7EKAaYQoel8VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KfpcKZXF; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRx/wt+ZnZkxuHs+Ual1rzHSeNIVmb6OqfrQA4v3aY98FxyUcrQZhRX87tzqyxRo64CLAO47HCq2A8nMIqCwwwbvDQwxJrSkkYa/WBOVTHoshFtCt1FPU7FS1hVGf2tyG7QaJbvDVs8C+ewJCp9lEt5taqPEyEAFvfLhmAGfjjoY2butQEAyNvzzOd9ITXbd22m+BlXDtLusWoTlnvJGriS/UmjY6JnhP8DvnAKAcsa4O6RAX2W14otp9fKbR+ZK/v2VDRtdFc0kCepHyv3u0wIE85DJUO422ZwwSn6vhU1AQmM5odtO1f/729fHYnoscnFGV+ETRj5M0t2k+MW8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNHSYpmQDUk3Lifwtw7VbiBA60zVvJNEyVFv99z2Sn8=;
 b=b1BHMPqjADRZrMT1SSVG6Arm/+KDurUaiAZ4Ije/Gr+pZSCAW3LabxYYMJyW55r3t3IFApUsJlo6XL7fcBz6p/oQo9EKCWIRVWi41txhKoptOzdQVdNa5zdac08zu3fjGHvxUc1UMse8sZ37vpuTIfPUOHwZRh99yN1GhFtSlw+BXogCx1Xzu9FlbJQcKq0A/fCDHPUOu5rbUnXypZID/jnNTDfFmyAgKj6nFfzMbWxaodqJBRjZCmci6ayppXcL2Z78FFhbuSMNBEvmpDMbdKoP0gTDgvlhLmtbUMr9T5KB9gJXb7NGauIx/t8zwL+X7HVRRef2qKOdKvp5VlY9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNHSYpmQDUk3Lifwtw7VbiBA60zVvJNEyVFv99z2Sn8=;
 b=KfpcKZXFiH9PsfBmtoSA6QnUlJsXx9v+UL2F0SXsYvvfp6ny623Hp0jr8q9aNd7fxQ+TSMYr+EQiLL/5F0Vj2odsiwo6I+CRHY/sjyAJSFJjlGVKNsNIOL0jeObztMToOk/sd9bSo6+oTBdqrsS20aadNW/AOKqzecGib4979ioKazd8qY9Chr2siXQAoI39NzFkujLm5kRzSQlkk2EV6DUjNfVBvH8tQYLj2TxBRcOWhZ4/cNRDEfkgtEfudSbF8hGxLIcZRjkXii8vTmznsW7ba2tqjMDb7yeUTjSV0f0R9BoE26wETEfAZWigXfOWbS3NCRtyJANzwcwdbjmn5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB9841.eurprd04.prod.outlook.com (2603:10a6:10:4ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:10:10 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:10:10 +0000
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
	Linus Walleij <linusw@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 phy-next 19/24] pinctrl: tegra-xusb: include PHY provider header
Date: Mon,  9 Mar 2026 21:08:37 +0200
Message-ID: <20260309190842.927634-20-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::24) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB9841:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ffc9c7-ba98-45d3-e6b6-08de7e0f7bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	PeGfAwAKAtuCrNQjZzxepXa5Qz1VIBtHxHw+1rP5n0MdqL1ineqRl0aB9FpzRlHWHT44zIQ497eyl5/uw+yURIt2Biz4szB9uB0Ei8DTILSAxm8FUQHA2X/QM8mBEZCjAStN056PyzaLbOQMajlUk+r26GJko+IkkGjA1s07xS2HviQkx10gyQaTqH40Ur+OmG/U549YgMk9uJp5S1AvNVUWfFERLxvr1reZD5Uh+kCrsQGcxN8SSkRK6ENLx+AM3nf5EVSvkk+y+EHrvF3XkgknImY/KhxiI4rdakCpvTgr15qcZzerCzPquJfuWPLTpxXQBc20azzgk+KkCyrttDtyN08StepKFPLcvDnGNl8j/TPweo0FSj+dBpwY908NLYmflNqFbs00Gl8szjxvIk8mhl98eKEUtOnTiH0IQi+q8zNOQ+ZfCwL7g3o6aGkfo9BJziYDhYkypWu1cXaRc7keI3dfd+EfDOITwgf5wED9mH/InLCiriMpX+OyTlYFGn5565ZH1he9f34ThRHU/wpXRKelhJzNY+o+2k0r7XaRXGl//RrlhDCUZjqX7/fuS39GjFLDhitPM//Q1yNZvRrOtuQlr5uemFmtAg/KV3+TC2Fo4mI3AMhNNH4blwk8eljJClin41KpRFqizMfsMjYG3fJrc9EA8PAq2i7bFw+Si+5MtO+7oA/XX232eSTPQW8o+USepe9wn6L4hBNnj20OWbzK43F2quMNFJ7Wd8M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mz7ACRwblKcsUwO7CaZvNcmTU8TFIQ6wKc2928RYCd+9a0W3PUAxuU1FH859?=
 =?us-ascii?Q?AgqiAqiVqMQdh34CCRupycd5Ti0RAIP69g3/2s7U30NOPieI4hvh3JtITA9w?=
 =?us-ascii?Q?3soWU8euk4FtAyOfrBGAzH/cA8lS2j6V4vEh4Xj/XD7dDTDy7Mh/OCtS40La?=
 =?us-ascii?Q?EABMSOt6hiHgHe4x/2IrLc/B6pfqRB3Wo2BSJ8S96bBSeukNc6lON6NTV1sf?=
 =?us-ascii?Q?RmiF6uDeKP61JZDpvBvIEFhYKnWniOjhOvL7KnDn/FK24r3zYIlNlvBOG9wo?=
 =?us-ascii?Q?yJaf123Hlw6U/RVZyQbPKWZa4IkQBJoJHElk/Ta0Vl8gfnGVFQr1PKshelCU?=
 =?us-ascii?Q?FB+BIUphC0pHGfm5MmpCoky/f080lGaeCsOeOzUAldwUdAs7mIJsH4AB967X?=
 =?us-ascii?Q?5E6rqb6wWpYXzj7zcVXUwP7XaTqCOjfYHLSFg1qw7hiA3Lp/aq3uQ9Kj31mw?=
 =?us-ascii?Q?y76hqJLkT+gBKdHhsDklD15kVKqEFMEKk33/e0aKjaj/uq954QaW+nhEpSVB?=
 =?us-ascii?Q?fmOUvPoe55I0spfy4R/7tMbx08Wd4/XG/FvViXNdZxdEcUujBOoaG9lIXgU9?=
 =?us-ascii?Q?aabH3+5jXqBOLMYvWUDaPDx/jXtOyq59C5bnJGrABHpFyZGa4jdz+TVSBlpx?=
 =?us-ascii?Q?ngq7qIvix7MdgBQAZIfANcRfh7SF3Vu2yKiDukpFEtAUjm7otRUnCkjEiZxn?=
 =?us-ascii?Q?6tB+mW66uGmAGOhDuMJT1+LxNuyRMyrP65QZ3iWUGBhrWM+BSOPdWAovLDWs?=
 =?us-ascii?Q?o9LdV5msp5D3Qm40dEB4Ac4Egg9VmWRx/VYbAIYmT5U6yPbtfCcyCDB4+MSK?=
 =?us-ascii?Q?MvRBUy3fs7+xd64Qkj1vS2Zun6QiumtOmSqpjggg0Nu2qNjXeCPWV0SqrqX8?=
 =?us-ascii?Q?bt6D0JDjanqk0c/lqVQIl57/cZ/uBYNGoeLibDgDyrem6uaaHmP5sfpAFpVs?=
 =?us-ascii?Q?3SE4D+/FjcT1JdfNDiNcnV1XBAnjg0SNJFFthXaMZSBithiOLHardUaypge0?=
 =?us-ascii?Q?eFrOEPVqQH/4+I9bVCqnI3m78p2yhD63It2751IyXGHVoCGADZoC8eJEOS0b?=
 =?us-ascii?Q?8/8lBZOP/LxNalnzGMv2RjzhjlnjGlkkbuDa5j0B8rTk0H0ScPE+jZcVAfCU?=
 =?us-ascii?Q?fO9VBGzt8XNSvfVq5W19UlZDcbsnE0Wq4Y2tXJRTL0pdn4Y4oVdTIfc0WXUT?=
 =?us-ascii?Q?KZtp2E4vucmDteUTOcJy9noOxyeOg7as2hGY8pw18BElD/yv7QwKCcDfJFr/?=
 =?us-ascii?Q?Mq3X43Zk3lhr/C6JU7gF5oRWXZenRIQDy7Xy5QDS/3gu0FkqnJjWvVHRAC43?=
 =?us-ascii?Q?JWoK+YuEFL6OagpyPl4B2dsuDtvWBvOX10vmfG6U3pWDZGidydmkch5s2ebt?=
 =?us-ascii?Q?FOmDxjWWY+KXfBtDn8YrYbpQ8BoVtZugHRRBRtJ9QK8HIIGBcroB/EJbF+Qm?=
 =?us-ascii?Q?qhSogRgM/pSmsIF5PkS8latpVYAieQqwSRNk+n5lHQkySG5okaSytMNLUcFK?=
 =?us-ascii?Q?B5/t0ee0x6+A4+DxalUlDjujldXasvEpY5BUkx62aQ+hJyaJdPcabehAPO2V?=
 =?us-ascii?Q?UvNhCqPllejSUiBmDBDdqVqkwkYMrvXKZgGQJpvZ6VMGlamBIfziUV3ZaIZW?=
 =?us-ascii?Q?DuY0hkR7vJc9Pie49foHldGw+XVrs/dNLOeNoDbM0i+aQ/eK1u0JVlMl+htK?=
 =?us-ascii?Q?LygyeLM1NHV7eWr42Elz1eOHYmjapP4lfvxj2B0kPUahBCxRjogiUIe45azD?=
 =?us-ascii?Q?I5TDNLxBI1NRzf2lcw8/kwwDgc7Yhsf4bam1sBeutRhSj49qCPC/+CXvkg6V?=
X-MS-Exchange-AntiSpam-MessageData-1: XVIzpr8w6Xpw3aJ9yZgrEGJfCfPpdPzXOjE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ffc9c7-ba98-45d3-e6b6-08de7e0f7bd6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:10:10.3001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbYqtAmhXzwZ+1ozyNzCbF/N3H2tx7tIQPblfCZwmMGX6TkFZye6fcNwzOBB8fmB3pZwAn8IPPsCYdGumcHZ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9841
X-Rspamd-Queue-Id: 5D54023F897
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,gmail.com,nvidia.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7048-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,nvidia.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

The tegra-xusb pinctrl driver is also a PHY provider (calls
devm_phy_create() for PCIe and SATA). However, according to Vinod Koul,
having PHY provider drivers outside of drivers/phy/ is discouraged,
although it would be difficult for me to address a proper movement here.

Include the private provider API header from drivers/phy/, but leave a
FIXME in place. It will have to be moved, eventually.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
Cc: Linus Walleij <linusw@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

v2->v3: none
v1->v2: collect tag
---
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
index c6a51bb21215..6b609bf685c7 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
@@ -7,7 +7,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/seq_file.h>
@@ -19,6 +18,7 @@
 
 #include <dt-bindings/pinctrl/pinctrl-tegra-xusb.h>
 
+#include "../../phy/phy-provider.h" /* FIXME */
 #include "../core.h"
 #include "../pinctrl-utils.h"
 
-- 
2.43.0


