Return-Path: <linux-can+bounces-7189-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGsiJuR9vGk1zQIAu9opvQ
	(envelope-from <linux-can+bounces-7189-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:51:16 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F732D3CDF
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E081030709E9
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291F2429826;
	Thu, 19 Mar 2026 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SSa2q9nM"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7B405AAC;
	Thu, 19 Mar 2026 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959621; cv=fail; b=eGGagzOJrDjSKg2T8NSJZMO1d053xn4PLabe0eaPnncioKQkGbx47KaMzzVPbEtnKZgcHsbPQBJufWOvJ6pDdJQkIPzCcbDQiahYOoiTDE0DJiPEosC1dI7CaYD5YQSeICaCWOzNfxy/niw2bvkuxhWvykLDhzHugOZKxuV6U6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959621; c=relaxed/simple;
	bh=QyerQROb5TmLwouEhxy1HlpDX9JDlF3A2jCNgAHPwSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E9BcF8rAvN1Qei4nxv0q7zfWE0Sqk39mnj6v1+ICmSTX87MvGfcMcYOFHAcbRI90WGwgPcj/Qytk6BZbAJAw8BLGiwhVlbqF+yEhZFfsA72gNispU7GsXXcDti0bnAQa+M9MdBmdU7xsjpz7trBfehteKlRJqT0c1jNUSxTvYSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SSa2q9nM; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsSSVyacxFLbFH2MfxT1ui09EuzOeWKJBJGlQjdUP4zEEoL/GuA3T+/RZBTZTnduvOq3i+8aQ+6dNqaB8XcMRFh4rvuge9H3MbAYhqWLhf44GVp42YejE+3zRttVV6PkJ/3OQeWr8q+jTt1G/0P8VCXP2Zg/In9rJnBwzgcB1KGWh3lcGYL5F2BrnpiV4hpIbTSSqLF/TPKwJFVteBVda0aZ7Ylz39buiGckIlwpsfcLDAQ6PIuJarSH+n2zqPa52xNbSSDMEIGzFFFWvVwkYZo9P00O+A1OmQdc2fbQpF6jXPNkrvVnUzYlsAg9P/9WO7gUflf2wIADmN3wtW3cSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uc+3g1DIJVqmB7JSN2F2Kp6tUtD376sQzGcWiiM1BBk=;
 b=Ax3164d7VAZiU9AqJd+E3uipXCmxN5zfIdVFP184D80L87zU6nzwDiyZQyj90T2XC94MlfKz8ETjIOhuPa1XyIpPDh1TxN0ifWZC7rBPynrdKGK+urpjNvfbqkpzE5Uh+/r9Z9/5fvQiv4FYN4sldR9zzDib9/IFDKm/36zHRe2IPJ1SGRJ54aNu9PqiJZbUh1siwPcH6SylRsVQiRiovm7NpeHl5h5csCwotrPDQX3yoaNO/g6JLCZyLHjiywf4rpTX3LSnsbL2osly0+khekB/nu6kMKpkQLlxhqoXZ7yhvJkY3LZ4yA6pL+z5hkCUUaOV5jhFA13SpD3Z7eN9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uc+3g1DIJVqmB7JSN2F2Kp6tUtD376sQzGcWiiM1BBk=;
 b=SSa2q9nMO6jgEr8Jlu9FFzkUSypMgxqv496dh8uEtyPatOijP44HSvETUwOkPce7VQLAQCmAoR8RDOYa74EzfsF5OhGHTBuAHhuv8gB8UicdApYTXE2PDTsJQjWvabLdrf81QeaJ3XqL3FE4Qj7CANdl21J50wpMeGihZIRmXeUfA/Ck7nEge7SjK+SLsxNRj1NUU5txdZZHHah6AYB5Kog3nXh8IkzXkQAUA2bpaNG/zx24thckXX5ALEVjurXvS8okwkra7xPb760h0gGap2KOW8P5gHXQcLzSUP4N0Fs2T5Vudl6FDzx1AnVBkvqfQYydhEhV0GVXoYuiko5h4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8079.eurprd04.prod.outlook.com (2603:10a6:102:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:33:27 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:33:22 +0000
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
Subject: [PATCH v5 phy-next 21/27] net: renesas: rswitch: include PHY provider header
Date: Fri, 20 Mar 2026 00:32:35 +0200
Message-ID: <20260319223241.1351137-22-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0046.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::35) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 914efb22-4348-4a14-f715-08de86078718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Im+sry+LgnOOYQgDYYH1nlzVyUJSIDxbCXXP3h/FQ4k6XA9zmPQlU2j2h0Mn5KzQ4VWZg2ccpuQRIwtVVG8inkqHTsSKY+umxg2LgLzPgPujC5OUMCbTKf+jnR7bJNDknbp/e5ByGps4DMLhl0ugDJIHlooDMH9b/XqwiR+CBOVdQYr6bEQdeWuKl03lnwLYSvKrkMHHaCE+p8LXh1cIpUIH8uHKZit2VJqPiN/vLJoEzbd7bUubqvHb6DK5sEBf95BsDSJwJo9BPhD0oHR4boyd8uuHLZd2x5gVxhkzaFooEHMZ7xaygKaM9jCcp8brzZ5bNyBohWSfoPs0L/MeUcW/p203L9e//IiccZIc83p40K9DvagTLHhdvUvGS1k2YfslAAyK9nzbJCHJUEadHMdkzqaIfsCtUE++Pvp+SjirbHO22ULkfNBtGKXnLzjTW5jKC9hb/Qa2Rpnnnp8xDrcOaSBGtomjgt9BSmZ8s3TVrRwtsjqeDqEQVriwqV6mIST+f5Xpaw0iizRoMsv4Ks56957bIgW2IKURl++zoxTlIyk94wNAQ0wElR/XPirZ0fJUPMnN5PZvlN72/hv5wT7gwfbZAiH1k71lIjVM3IUt5EGnXyLpJooMSZwDILtlF5viXT8bthm5O6c6AX4YOp66A0qEHYqe2vWyAXrYMYRsZPKEal1T5GXdMUgZTZ4+5AKsYva0K8Yh1XRx6Y3Te3HZerCWlBpdLg+YQEOiNXM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kgHd9AH+n9itJ+2PsJDIAc5/rs4pzqwm025Pe0smX0wIJ83/CTMoBWzyKxDl?=
 =?us-ascii?Q?h7RCLEv8DMTGx08sfuYMFzxAAaiNynri84zVaeHP75obs6jeRexZR1vE4wwf?=
 =?us-ascii?Q?brV9JL+u5r7nkejfyujN6f3SFMXUOlOOh9tmeKNqOWAOGLMYR8tc8083w6Mw?=
 =?us-ascii?Q?YoN2vR7DAtpnuXeQLOlxxIwLiDaW5+fGKki3AAlDdEf7JpYb7yaRevpbqq2V?=
 =?us-ascii?Q?I7b8C+g0mWg8E5KtEFZU0XRYraStAkaNF9/XbJ1bM045zaaS/6wxb7vJtpuR?=
 =?us-ascii?Q?JSusaGZgorw4H17/zvEhf5DUASkxXfp+wVGCYBLcXYQDrxskMp+PCWGs//XE?=
 =?us-ascii?Q?QLjrw7NhqSREF/TVBa3UtI1S6BwK2yScp1Yk/jEu4z7g5/sfO5hVU7dLjGoz?=
 =?us-ascii?Q?Fd3GJ11QTb+MJ+Mm7BmcKZkHJcyxCDksaDAT2rMETJZlJ0sE/3GRAxCBNi6P?=
 =?us-ascii?Q?2aIVJAzztw5VHb0wBZHx0sDTSteOCyTVs4gwn08NDNEQpq+D18Rvtf7e9xiq?=
 =?us-ascii?Q?q2SPn9WS/+3jN+PHGnTlvm/ULLU3Mf+zmnmVa6FnAeTaCETariiL0lId5dqA?=
 =?us-ascii?Q?5jxaJwQ9BUqfh6bDdJBTBxLHtflJ/oq+0ZZf2XN55eZ+zgjYWH3r13dpIVKX?=
 =?us-ascii?Q?J1iUVktY6a35yPG9w6X58Iyvsz6YDio5Oot3UAJT2zhv+mvqTVGIozUnzrV/?=
 =?us-ascii?Q?pPYzrZHTSf8uMJPtSBeyyH/0gQq63Y1oKfr2zhO9SI+SmZ9bPk7Z5dtb+DQX?=
 =?us-ascii?Q?S5DHUmn6eZmBAAMYOWjWx7lBp1Q3OwxFYukRF4/JHFTDwSlboTN3InIzbdEI?=
 =?us-ascii?Q?zARdWtRYq6CaHtB2ODdXUuSXUzStK7V6CWmxwKeFRPqOwRHcK8TgMeGvQsel?=
 =?us-ascii?Q?mAqN/dK8G+qqauuQIKb6IghZZYUGOhKnTJ72mXgzB4bIBGXQBMFye/pe16vv?=
 =?us-ascii?Q?dhW54ovB5mlBj1JCFMIgeOqag3A6k+Z0royOXDoJ/BQy0yD8zuoOwhzGD2Zi?=
 =?us-ascii?Q?9iQtqu0juLG/ekg4USKC2Bs48BdPyQILmY2I0DgdFUJ/6G+ku1n3dFwmsMo8?=
 =?us-ascii?Q?Ce4/YcnI4msfaOUFQ154lSwLnhEg+rAMD6gCzdKy+AeAFLHtMDpYimZcZidy?=
 =?us-ascii?Q?1MKQfos6QScFl0x/jMwWb1BQn2wm8JmM+nAAeai/si22FxHPFBp+ZRrG3iNC?=
 =?us-ascii?Q?xthhH7q6dWGzlwqABpAwghNoo1pBqfV7wor0spaR8/OHmKVDdORA1o0cdLYD?=
 =?us-ascii?Q?Auyy0gIIhM7l0FePrNRQZzMfVYE43vEbYnJGZbFIw8Da5LSTN3xx5FvRCgks?=
 =?us-ascii?Q?WM6Wo+IBW1h6MJcKz4CEjtBYek38q7FOs6uypGn5RhLtxCs1JGWAxxlZD6s6?=
 =?us-ascii?Q?sjINVQeK8TBM5xaQ7qvrrrRhUKtKgfOG3oN8MaGC8w1vRpnMo0K1P85Zi29b?=
 =?us-ascii?Q?26xBKzjc0UruRRBLDHy2CYTzVL1sz207D6aIbTqIKMcSf6w4uTYrnamqyehs?=
 =?us-ascii?Q?PB7wCjHNunF+Wcdtlxws+HZfkTaxwZ+bgDLxBLIM8A2B15i9KYSdktKWNvWB?=
 =?us-ascii?Q?pdD6laQI//DU3WQukZ8beYTABzxE2cngD7zKOpo49ZkWLkYHxucLIdYQzjco?=
 =?us-ascii?Q?BY7k4N/mW6XU33A8m/YEZNkDDybHsR0b9ujMSPhh6k9oG/zAdaGjIpDLesnF?=
 =?us-ascii?Q?JAKomoJ7uGhlY7sVmfyV2zEu5zqQZ4VOm8/FyhrqSBo5JpXVMcr3WlUo1BSF?=
 =?us-ascii?Q?giv5MvEv6R2QvObmjy6KUjSsNiAgru/i7yedeTZjhHxMuPOX3defQstojNXi?=
X-MS-Exchange-AntiSpam-MessageData-1: XNWrHojWj0MOUvlc8nA/zPB5H/l0tOWqOis=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914efb22-4348-4a14-f715-08de86078718
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:33:22.3672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNzB+08At8utlOsz+mUNbZF/2cttPgrriutD6eOIEyeA5bk2Cw0mw32T8RL2FsWLBYLrsYmg+atgPxjkXvgDqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8079
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7189-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,renesas,netdev,kernel];
	NEURAL_HAM(-0.00)[-0.953];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,lunn.ch:email,glider.be:email,armlinux.org.uk:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,davemloft.net:email]
X-Rspamd-Queue-Id: B6F732D3CDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v2->v5: none
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
2.43.0


