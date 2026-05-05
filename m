Return-Path: <linux-can+bounces-7512-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLcjJjTG+WmmDwMAu9opvQ
	(envelope-from <linux-can+bounces-7512-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:28:04 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F424CB3CB
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5214304BCAA
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9473945BD71;
	Tue,  5 May 2026 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QOoOtHuN"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F343E489;
	Tue,  5 May 2026 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975601; cv=fail; b=axk4+TbnuvrilVEB1w93xR7Dk+cGw7WmtC6qgJbrLGLcEVoQbZiO9dh+RHsBA96oDJKu/HAEOKUkbK0GkubjOMZVD1tqAPk4zfxkS8J6uygh0wKMnXtO/0hmIdBlDETnVbEmCZkG7QUJohIqmzITcrrE9uB6eByXwoaSTwUXefA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975601; c=relaxed/simple;
	bh=li86jnhyV3jP1X1mpZzEpu2k4VUTnKlq5RVmz+Sr+Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kcGfPnV4Nwra1ga/vkxghGpBqv/PztcEc+isVA859aXz1zJIF4plruzeceeA30zLsdRHhn/XmRyTCSvo28amkKKNXhytS3wgsFUfPtcUvdPI0PPk9pzJFKZy4LJHo+ljl/u3ETZfeXbljIBsBY5LJ1yt8D3JAQp2AzmhDxXBXIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QOoOtHuN; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/PsfbC6d2u5IwOhKU9X/4eES6EYzP2ULt0pCC0XphS2G1BjiQLYwlx0ksGxkXXbfMuCQU0r8l+GqHt0dAhtjiAyDGDLqBdTgRStKjleGcJjq7SnwMZyPxeXTWYe4h2UVkgSYJYCZQ7Zg6ICfOEV93mSKhZxKhVrtbitFLRHlFOZt6pDLo2hUl1npc/WdlTyTBND7JzFbe2t6fQ15vFAyVKfommphO15B9TJKOCzV/6Un3Y5Mxhqm8QNll+P2cKzL4c953vhGqRM7n0LMDb3wIOVNPt4Wd2rsm1oyNuJHPvmtsQYAULy6at/K/6eFHmD+IBZY+U90dFKK2RMSvwe+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/k7vYdLws6FTAMdc6KNTB3gOo9/Gyn+PoJjzYl+k+ms=;
 b=UcRgoR4S0NSJliJgWl5BaJCHzr1Mw7wmeJSaAVKOMQ038cmyoYXA4R+ynwvNusJbpYECTrT6vBH+OX2LUBEQl8HG6+g8kzrN8aAtP2bdFOGzcvQzsmPQb7uG7RiABjaZGT9dgdp95e8PiJM8+1d9aZ6FfYpyOjLe0LlDZX+kAaB1Pi/rYq7kngehLfLL9SgCqgEu9ckt3SwBAWq7ZZSlhsqUl90jspdEHPITUQsHeVahKAs1Y5M6dAIk5k/naigbQYE5OadYD9SvYU0ObilG1OwTa5gbvRFP1n4f7I+B/6ISOd4dErbz0GGC5LMvEX8tCI3RdawZg3lcwQVScULzuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k7vYdLws6FTAMdc6KNTB3gOo9/Gyn+PoJjzYl+k+ms=;
 b=QOoOtHuNhsCPQdZNuACTxHUX3lbVl1DyWc5JVLCMY1cjWEdw2I8Z3It7JfgneYqfjhJB2Gtg1BjITJYvmqvlbGs4UEPDcFaSGdD2eobUOAdM5lOgJWPEI/ZSLCL5w9JaY0x709PVym5M05NPIs03Dy/b0gYHgChPmI2L7nX9dHcCPoOuNkFn3v4aBeWuknEW+cSQ9QmAYGbetjg7cREbz8g2yjn4S9LXanVDunP8g98Z1C4iNVeJLI4aZVm77KAHuQhlQiMnt6RWRmY5aNH+9fnDQc1/zfdCJq8vVeRyzz5hSQFffsHf2lY3eXut8wGmFO7A1xhMjIwoxJoJ2gDiVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:06:27 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:27 +0000
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
	Chen-Yu Tsai <wens@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH v8 phy-next 23/31] media: sunxi: a83-mips-csi2: include PHY provider header
Date: Tue,  5 May 2026 13:05:15 +0300
Message-Id: <20260505100523.1922388-24-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::12) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d5664a-f433-4366-ae9e-08deaa8df8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	PHVGY84uXU++jf7xFUTZTgivfJPsAUJSPxFTJ7/kIyYNxZQdj5HDWLyrQW4tN6OZxCTw6YXE6OiJ6EdkUVIjt3MbynhRvmfbZqstWRd1PapAyyoIdvR9E9ASrtzAmDcx7F5hikJB0ttxOVN6iVvTgKNPUSgDqURvdY4ToME83jhQyUn0CuOgNllDvhN9AXXf3Vk4WQsAA/UiV8Hp4eKNRIwPtQg3Yw3ugM3Ur4HEoB49KlEG4F6j14/Pi2zn+QltGO46vAROGQuXs61POE1c+NYNMkM0eHKu0mkZ/sjzP8/x/V3zPaIH6XMEnb8aQirx1Taqr0KSk3sXjj+S+8dlsj6jVEa9oQy2opsWffGNPSDM5sRSCgZrUj1mZbzFjNiqnI/QMLNR8l3vYp/XwqABUZNlbaMviaTtkRvf4mnvS16UoJyl9TstTU8VhnlYDaCPOeLTGSj289gu19n8Pk0CrTZ0owHnhM1KKhxj1r7NuLX4ZGTBq3w6+zpj7cfuKb3MqB+rOuVgqstbcnjPu0z6WLwm8VoiYLXU7s/lwU71rB+c6UcL/8gfNBQb4cPSCpiyHy6jFVhGfT4xFrCTy5dQfp+gQAwRq4yp6nG+XCOuM7OjhCVhLiyCzNduH4Jp54DGuYy1wblCYGc+OAWsi1T9uyFzENzXrHLHZbkXmwavC7VG4UTjiyPnQlUXZkSuXNnF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9xFT8VVJkZjouG2SM14pJnirVLdjFaTtZTEynyDvany/By5yzIY33DyCIGH2?=
 =?us-ascii?Q?Knxx4eJ4XNGSOhkdWME1R99wGwJOBCEirL3NNNgv9HLkhqgb1Re+hn7h0Jvk?=
 =?us-ascii?Q?drHzTi/WieT9ncFKV5O6XwvZ3v8r1gpLd86+Xgus5mNNbUQ00aTg8MW36m7a?=
 =?us-ascii?Q?i1k4w7gyTCpR+AuhqRUQPB91eS+bfZO0+L2kNw9Xij6Pg5tzbNmMIyZ7/ga/?=
 =?us-ascii?Q?D25pNrkZ1qT7tQpMUBZYZJii8zCA/ZcG72unY2z0XbdY+3NoHGNxOOERhgAI?=
 =?us-ascii?Q?zD4g06maXXRpAnlFVoBuK+wrRVEPKnh2/8rif3EQad10X3NwZyow6Nw7Xtjh?=
 =?us-ascii?Q?6AZiugssEPktn/0cx7F9hMy2rKwzhEpHSBRn5JuCqSsqjbwpewr4FzVREA2S?=
 =?us-ascii?Q?zEzAYHycv7RUjk9Ok18d2N38i8kX/NieBe2VQ+FG3EFL7/usHboiVtu/U2LN?=
 =?us-ascii?Q?JPBxfb5ar8zv/6CtV5GfI4PfwJU9YKpBqLVISTolrjvDBDTDgL1q5psZUEOd?=
 =?us-ascii?Q?yHyD15FWkyYHLFQ7vCn8fd1JjSfO/E/5I8H8viLP4b/CFdNkSg+9Zj4x+ARz?=
 =?us-ascii?Q?murJWnofwdV6dSioZea64gY1sFLSJY/mAFcEUbW52buu0a0dznLD9+dUBW+x?=
 =?us-ascii?Q?HW0Aiz9BFSLD2wVquznWHtWVlKL8p9qhzqjCelnGz6EXfwbhu76HGLYC77SR?=
 =?us-ascii?Q?VMkDwcNRr/SYbPVSf+J9LH5Fxv6RdQt37fYntZk36Q6ZPRVahre8lE//1FEX?=
 =?us-ascii?Q?ZgkcV24VKTFVgjeJhM+wuXZcT4P3GyqlrOugAUiS3WAH7Sr5V66Nh2jIbV9S?=
 =?us-ascii?Q?h14XSJDgpcQatHHjmzw1rxUHiauZCDbNt7GN6bX+oZTW9CNThuVwna8pkbpA?=
 =?us-ascii?Q?CwDU/g4EhSQydxhQSDSJ+tABDeSFVtLPvD34UaSAMHJF3aKQomZnHfPkxyNk?=
 =?us-ascii?Q?FruS4KBLtkkETdc9BfkHBVLTrx+WX6Kh+MyDS4ybQ8qvE+47PVYJrVhHLrEQ?=
 =?us-ascii?Q?x91LpwegW83+iHOIMhN6BF2eK54adNK6YzHlEn754KOD+tE+aQ4UwDhfZQFG?=
 =?us-ascii?Q?prNK3Gj0U70v/aUBW9B+oPPwpiRgC1TWmYy+sZrLySM1viCPUaKdWbDK5jsf?=
 =?us-ascii?Q?raAeGRCEowoxeJ32W4FFYXVM6CePcudRwYSaSu1VO60DfpJBzlQBdcj3xbhj?=
 =?us-ascii?Q?ogvNA7npybtymG+TJSBfRNKVDPmfrcfnjSDFpHomDJXOpZ1vILw8xHmeLsDY?=
 =?us-ascii?Q?mz1je4c3Nt6EiDtiPsGoKW8KEKApGX/TQQcqmN+TcjPdcb5AgymVwv8FAVVc?=
 =?us-ascii?Q?HVPQkIwJHeOO6c5ZWThCFnTdu0Ro48PrU0l8EZvehhvewAPwLbA6JagV9gl2?=
 =?us-ascii?Q?CqAmS5fEZpJ32uMHVM1/Lt43Fs1YpeClY3v3GwLVjgqis2itN44wL9ZXajzf?=
 =?us-ascii?Q?v/7inabNsUQgPkFfkUMcJSN0Z807pZgMoemqpfLofO0ikE3q3u5IccNAXKtA?=
 =?us-ascii?Q?wwMS6eQFVSzEkqWrMW9VD9PZAyQtpAz+khayWuuPaQl9bdSr7YzVHfK5LCQO?=
 =?us-ascii?Q?BWG+0hLQ2F8/BiX/eGh5Mt4E4m8aWv3cz2UbhmNAuTnujzlPKbvbx61eTOWN?=
 =?us-ascii?Q?Pms4jodC2K+zHYftpdc5016zni91JIgC0Uzl3FoD4fpSEcKuMoC0Qn2AT3eV?=
 =?us-ascii?Q?ngwTWal2RhNxHRN1JxDRNpG3iHwfCW3cbX1u9NzRQ0LfhX2KcR30UH92GKYu?=
 =?us-ascii?Q?7pzXQTsN9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d5664a-f433-4366-ae9e-08deaa8df8c9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:27.5997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9rRbxletVMGtNFUDlXpQOqr1eScL0SfKhX5cdi8qngs+Wy0AOjnH2ya7TAKvgNCWS8HBgFxsCyNycgjocLNYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: 97F424CB3CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,gmail.com,sholland.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7512-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sholland.org:email,bootlin.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

The introduction commit 576d196c522b ("media: sunxi: Add support for the
A83T MIPI CSI-2 controller") says:

    This implementation splits the protocol and D-PHY registers and
    uses the PHY framework internally. The D-PHY is not registered as a
    standalone PHY driver since it cannot be used with any other
    controller.

However, this does not matter, and is not the only instance of tight PHY
provider <-> consumer pairing. According to Vinod Koul, using the PHY
provider API outside of drivers/phy/ is discouraged, although it would
be difficult for me to address a proper movement here.

So just include the private provider API header from drivers/phy/ and
leave a FIXME in place.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Chen-Yu Tsai <wens@kernel.org>
---
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>

v7->v8: slightly reword commit message
v4->v7: none
v3->v4: collect tag
v1->v3: none
---
 .../media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
index 24bbcc85013d..1143feeb4fcb 100644
--- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
@@ -4,9 +4,9 @@
  * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
  */
 
-#include <linux/phy/phy.h>
 #include <linux/regmap.h>
 
+#include "../../../../phy/phy-provider.h" /* FIXME */
 #include "sun8i_a83t_dphy.h"
 #include "sun8i_a83t_mipi_csi2.h"
 
-- 
2.34.1


