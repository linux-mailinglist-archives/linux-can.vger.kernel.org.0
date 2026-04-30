Return-Path: <linux-can+bounces-7452-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJQ0OAM882nlygEAu9opvQ
	(envelope-from <linux-can+bounces-7452-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:24:51 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CEB4A203A
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AF5730DBDD6
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F378A449ED2;
	Thu, 30 Apr 2026 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PkxTZ5IU"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9DE43DA23;
	Thu, 30 Apr 2026 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547270; cv=fail; b=Z1pdR8gxGMpjpyagPOLknS/ymPXUjIsGh9gvGl/9fU9VbFrdMyJKKBEWZfF2Mg5i12O6xUbwTh0YLRV4rIspURpsS1pDkWQAHVgwt3ZfHNG1ARUbJgwWrhv/fpvWgN+qDK0gcdS45OBPUGdvIevaCsaWLKwJMo8HGTsCzGQDjwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547270; c=relaxed/simple;
	bh=X2vNABwigsIE08Ibi78D1Gc8txmlkquyX1/nlWn2V8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uflq0OX0fNoYWy0LyCEGrG+CKA0FOylx+78Rzsxvx9bMV58udXyrXfP+RzP2RX1SShmuCxTn0jbFOSDTG8RnyKwP63viTIU+HHQl/wv6uY6GQhL7UmEs3n0STt5ep3gvMm44LRYcZ0rURSPQHXwqegfllCSsFj4tNhAJxC0vduc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PkxTZ5IU; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLJc1VgreyofW9zkWA3kEjiwP98aLghx1V9eCBTVBiBFLGWsGq2M18dWy//FPpBfhqHWblRFCCMZkDwdTBgdPFdO/cYCN4OoRTa3nwrCYFatxzM8hZfAzMUgcoiMivK6X2fMPI9IlOgr/F28ODo8HHD7j3YF7VZWmJcQ8NUhUSRb77WTnarE7yGCM/aUt0cbWe1iDgMsk0qQUpyvsYKhCUr4k7QP4yo7fsy5O+5n7muc1MIeROVjw/afThMzANKvVHOfEBGw9kbVnipG47LGF4vtbpVm/ne+qCQuU0/Pxjrfthi8g0Vok7wYppZrGWd3RL/i0eJ9tEEnyZS+agFRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBQyVg+wqXolpAD2t1BSBahJ+IliGRyZtnS8+K5AfYM=;
 b=ZHk+oFJXYRuGyPPA+AfwIyWFqz1ZU4JocfqlsMalVhaLTTuX0r/cZ5f1h2tnE1/b93hvSW6kcTcs+ORCsIdQnoCnF3sQa5dt9rzuLW5EdTnTykcKOIUCJ38CRBoOBflPN8fBhINR11aL+nmNRYdoswZ2RPfUxgowzs3hiXSR8HLnmlnGWfojtc5xsI07AlducWyHNGzom7SmCqrSu5qKLTB1kKlbsZXMSobjMk20cZIBBtWLleGvOd5zfy5gbH8oFm601I7jdbEKnxERqYaUQb2hPDNby6fXFphDBIQ5307GkaaVEVC/IOXYNz2JEQ1siFYbGRDsblZgXPj91GvlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBQyVg+wqXolpAD2t1BSBahJ+IliGRyZtnS8+K5AfYM=;
 b=PkxTZ5IUVHE5OXaaNzkar93KGNLI4Qvvde/KbQaVkeWV66FzViVZRQ5j9uWWNlMHl5euwq55k5Bku9zWZHFdTl5BfoNG228YK++e8OH7untwKNHcoE/pcBHfqzkcsljCvBvQTkMuPe+QXSdmwEXf119hC8uzCp4iNSqlzef7TAeeL/xlQTQHOskeIUtJLOvinuDZaSDAtk+kjQ64XdiYL87RzvBiVzRzhe/K6QOZIA40kCA08tuz7GO5tMXCGjXauyUy1gt5+JorWBhb6J9ruiaFCkzrYLAvFBzKxDlHSqrZxGk/qITU8x4nN7QTTOLw/j6sNUL/ynrP21V/7iHsLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:07:35 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:35 +0000
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
Subject: [PATCH v7 phy-next 22/27] pinctrl: tegra-xusb: include PHY provider header
Date: Thu, 30 Apr 2026 14:06:47 +0300
Message-Id: <20260430110652.558622-23-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 263809ad-d37c-444a-a556-08dea6a8af23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|19092799006|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	diq379iFo3tgUPy+oHXf36HFNV+UJsCoH0dtRgmtqAYsi/pQI9QnaUeDNPLTiuRPte82SD7VXlXUaHSUNf31FYeIw/HUCHsYDkmMLGuEw8E82avXbQ9EGf+1c4hX4v83x4j4Et9RkbM5ZpN3RdSwhFvTRthDSOuZ9ziQuOc7NO65fnuz9JCG4A5IKmMgb0hsQXkvypS0uFSnNjf9qJj3kh8Dc1pzamVYM2S7gIFRJhAJKJyGUFxi5vzAz3MEM2nfwzC2oMtzvqr+jUjphc8SMVVC1TYV41loiiZJfutzGAXpaecCZ6vR32fbDkGwJg9sH0/F5NOktPUfvWdDG11osQ7KADpwLniOj7lhD39ljNHEttzgG+CaFjwhUM+ix1EL9OO8HXVuXNHPTa/YH9WaGdAD6IkxWa9vTMrfuLBwAzw0lyTpG/dpRGbumpHa7HLAjEzk232kWD5p1HV92fS2+mWEVU2245ELUAs+OWFue8D+aYki7XgB/35bU1bpjCsG7f1nJHVIti4XWUiYY9RnHf7e2KePfGZlmvE6c+ss4cRVMe1OZTUHGqJlpLEP9Grvzxf5WKLA34CejKQMkyK6X0t+MpTx4VrWEe/FEjuDR6l70M/nrQLJkB5ZtQGgJSBzis6p4V4NACCQiQ6BV51XRdc1fRHEuNWMa+8pwC9MWHi1l2Xv1kNl+dYq7SBYVJGscsb3KXGkbMIKEunV2uj4wJntUd2xv5uu4ooC2EA8+Uc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rk/m8tN5Xc7Oe9RgDJXB7MG0JDi51Ly43CHGGRMjnxJpzYByC67pRzSXFc62?=
 =?us-ascii?Q?ezHkElcLC+xQSH+tab/TNP85jmVMEN0OnnQqNenpgGFLdFBY40Amzi3cNfh2?=
 =?us-ascii?Q?sr/yF2zSDKYoV8xAjxUdO7t3HghtnUpGnFg6LZwdbGxCFqyMsrumGB5jiyme?=
 =?us-ascii?Q?mNOEOMaWBytX+v+WPN7kim+z0qxrN1VgvywLxbPvZuJ+TIQYH74lD6B/5b++?=
 =?us-ascii?Q?a2aMKyd2PWLdk1vHIiyd6tv11A8j67hFqfb8Urh8GPs0HX1/Vnj4kLPBFCdP?=
 =?us-ascii?Q?+owUpaE2ZRvEfzElsHk+NXuvjERF4GJFrN6IG1m/XZFd9PcME+4JCk1J8yZH?=
 =?us-ascii?Q?5Z9UbY1eeJ8AoMwi1DRdbzijqyuj5cyqEurxvisygYeue9cI0ob68AvxdzFk?=
 =?us-ascii?Q?PCWVXwWGpWYfy3NdDu+gpFIYr/rcEaN9h4kgYrbo/jpbGpU3U+RE3KzzbbBt?=
 =?us-ascii?Q?LxiirAqE4p8Z/kvZpeGACOdkjtLs5AU8ZzQbN5DWTML8UXAHxRBkypOVq564?=
 =?us-ascii?Q?6KRuucE2VYrkVxrEJNz4Yq4V6NBZ8Gfsy+wzL7uIPTiEeRipl/Cp4PMbPYBt?=
 =?us-ascii?Q?3wolcxHLKYgZC4H6947JGcUBlDWfJAU3ufy6G6mNiz/ELfz6UYDZeP20gveq?=
 =?us-ascii?Q?mXhCRDoWToOZoUCHtY5PVtYpr4sUdhzvQhhb0PwW9zFseu5cx5k9MwdFu8U4?=
 =?us-ascii?Q?efooqrXg2CPcg+inLqpv+ZDcceyFezT0gWD0oEVwP/thCm+F1fHvOMQDdejr?=
 =?us-ascii?Q?3a3Cf+FOiDXapt4+KFEzuZ0waoe0cFb1lB94SajApYEm1PYTT6LLcyAdaNWi?=
 =?us-ascii?Q?DjhZEutB2tndP0pV6ubxYFm3hEKP9XSF1a3MukJ2irFEExBcdn+RSEB/ud6g?=
 =?us-ascii?Q?h6tVD7AU2mRkNVEbBNk8y632B08c97a63Db70qe2oSvmYOUaq7gllTMdQaVR?=
 =?us-ascii?Q?q+XUGOnyHhZGAIQqLkJdFsn0n9KTz5j6tf6hWqkIvFUJNexRfoUeTkZn39Iy?=
 =?us-ascii?Q?nrzIyDupLzGiQFze8d87HNgLw2BNJQOiAdRcy4NnQOE0/+1epcDiZbsTa2AW?=
 =?us-ascii?Q?W7njVJ0Vtsas0TID2c/jawu75BSMznkIjICczr9ON6mxJhKJMRa1C39cBTeD?=
 =?us-ascii?Q?IrCPmShjDd3LsCQkwLN/RRpYUH4PPkTRunvyz9l+uTFuW3B6P8XKZqSYsDGy?=
 =?us-ascii?Q?LKzSZQ51oZkk5wieVTkNBmyl2yn6bXf1SkSuVxZSlPsOGwmyC74ODHoajwoI?=
 =?us-ascii?Q?im7qH4qRnPfht+nDclZvq+fmnsd1qKIzYd23e6wdKj6dUn4Vx6qlEK4GV7Qm?=
 =?us-ascii?Q?eHl+XdGJEmB7hqaiMq/lJtBoW3mc9XgM8dpZgTwTULavRtRFJsuJiwfE4IJB?=
 =?us-ascii?Q?HQdSqURbK3tPWkVHmrubaYKp/aZusl2W/KdAvSY20Wms08sQsM8f0586O//2?=
 =?us-ascii?Q?RpvcqNDHcdOuE8R3vuh3MeVrEI0lsLX6IGdZP+WNO2CJe2sZapQYpV3cDGQO?=
 =?us-ascii?Q?1x3L4kFtCm9UxXv5IgG3A5X0wqnpROvEpO7WU3qEYgRkpWmEVn5QVoo85DR3?=
 =?us-ascii?Q?I3NM2dcquEOfybAYntQpVlqNBsCki6c19NI+U+GK7bC2/o84k3y5LkBur4lD?=
 =?us-ascii?Q?hQWYUcyMNO1AmI71ZCPHh4Zr2rEy4ObJAqapcVwpBxiHenUPpgMtz1yOBbug?=
 =?us-ascii?Q?BFTPp5vEL4XAWB1LzH1vzIRGb3PQOqakMQb3v3Kj+5Ez8k7jZ4GtLUWi9Do2?=
 =?us-ascii?Q?5GoeiwaIyJ9+vPXi4bfZUM3ZhHxSS7v765WRt5ML1XpxjoVEDxO6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263809ad-d37c-444a-a556-08dea6a8af23
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:35.7179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nE32EiJ87BE2HptDJv+Kjqmu/chVEyJQ55r+Mrvf8QXNbXwGf5rPrn3YJ/FLfesnZqoL2htPhU824YrNQa7hmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Queue-Id: A4CEB4A203A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,gmail.com,nvidia.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7452-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nxp.com:email,nxp.com:dkim,nxp.com:mid,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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

v2->v7: none
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
2.34.1


