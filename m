Return-Path: <linux-can+bounces-4091-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 066D0B101DB
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC291CC87D6
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 07:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCC326E17D;
	Thu, 24 Jul 2025 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="WU1ZuLnM"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2132.outbound.protection.outlook.com [40.107.20.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A08F26D4C0;
	Thu, 24 Jul 2025 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342250; cv=fail; b=gU6BbTr00k10+GwOX2ZSMETv5GOK9s6GvbKVJ9lefrs2NNDrEqKUy5tE3R9qHWC4VylgHZG/oNCq2KV/WD8W32pZiG+mV5rV/viz+ANiySjbjUpQ6UGuSN/QF0XElhlDBWsOrXmz9piSEct02tYENMTnm61iiwIBUhLGLw4PYrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342250; c=relaxed/simple;
	bh=JL/fTafOO8M2gNfTd4y0WFvVRD75m6CxwHznMD4DjNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RbNec55FHNpIOp7hqgiNOTnb7fyfObJWpT2kTGaSgYL1bTdD5U342LN6SwnOf6lrbdzrHaKOQ97H3owyP8T+c8LfWLi95q/QaZNLedos7FuEHWGeavjDS2QnGokiNYKPKiTOx/fz2sMiFGeAV9S9Bsq6sK/tS/bNtQPtXcfdGWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=WU1ZuLnM; arc=fail smtp.client-ip=40.107.20.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoV0A9df0LiKlQaCaoqvZGTZcYKxeOe8gNRJ+AeETpTxkbcordhywjxZYqIEpX66LChnAXCV4yeBQ+tB7iKkPC1GqQZAQ1h0Dp9PZ6tazrY+Laj+9ovGjoX6nMEo0EkDV8fUx6G6IMf0N1lDs+TxcAZzYPlQzsDr3Gii0TGIXtHeE4UUpAa/h7x9GfX7g/dkwB5eBC+jHsjwXW+BjE8HO0J1HvdPUbaRker9n02DWYMTWr0DcHv8Hv37QmIT+wfg5lVFP7l5Yu+ewg9LtcolIY8YnYXlw6D1Tj5xjAc5Wg/5FnZHtzD5DCzPO5GCK3GmggiCHzc0HMUQDF6xF3eVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxvwlIR+awFSqSHpreHwCTTaWl8/+vHDzHZED0Od8ag=;
 b=qDMcxs3sbULddhQQLj1A60dy6YnwVsoSUV7qQERkyEnkOEWHHp4tqe323tui2a03URSZ7GyRAt5F95piqbm4no47Zx4FJ162wh9BQqrp7zV/P0tQXYwM9NDYa9p+lLKna+HV4MqJJeQR0zTNg2QQTvYmdD4atIgxwZ6wLVvoW90Z4bfBTcga4O7UdvHfkmIIy1FhjdfAInE6PxIutwCUKJvtCUVU77l57/6stqHPmensPJZ1m0gsgeNGykxziPhCcVgMCmLvIJyImjrg7vH0bBxar/ykpGO3q1j7i5GTW1KXU6X+j6cnHFPvn/pSWzsly7s8+jbJaeJIhvXC+87EsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxvwlIR+awFSqSHpreHwCTTaWl8/+vHDzHZED0Od8ag=;
 b=WU1ZuLnMR5VyLNFtYt49A5BOqDmf3mBy5g+ol/tliyqXwpiFWBDvRl4aAXQ8TrcV6rdHKeWvd3adlJhrtgdoHC/tXQorJ1JXGLqTxDCVina7QUCMrFriFi5PIuZRHGWgcZO7O6fnOdrpg6Dc36uUAiVupdPZLh927D7PpI4Ds1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB2657.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:32d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:30:36 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:30:36 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v3 04/10] can: kvaser_pciefd: Store the different firmware version components in a struct
Date: Thu, 24 Jul 2025 09:30:15 +0200
Message-ID: <20250724073021.8-5-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724073021.8-1-extja@kvaser.com>
References: <20250724073021.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::8)
 To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB2657:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d00fdfe-ede5-415d-75d1-08ddca83fb5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YwjFWfSuxofDbq5Ra789bdksGmTNsn578/jSIe6N7/csanJAnGHRDK/V/M15?=
 =?us-ascii?Q?BShA64r8Bx/1hXXiveFCWy+XQ6SOwdawtz+nxu04v02Mdg3M8P9T4Z5ddbOV?=
 =?us-ascii?Q?As2wvTi5zOsVZtMtCbN1r++Bn5DlvcMlhM+o6aI9sEbv4Z9nhBWydOzVIekL?=
 =?us-ascii?Q?iANxDELX8lmSPkPnt+1gh2oE1NkRfkkzz/QT6fOJN6edYOH0mqKM7nOg4mmo?=
 =?us-ascii?Q?9O+xvI2E2qSA464gVYFiSBQrqHoSHoqvxJyDBflN/vCKAqo6C/bv/vYDNpe9?=
 =?us-ascii?Q?lQiyZ5jatGdUyk4suVAPWlnX1m2imKdNLsXZbkTCifRYG/Z7RCK/BIUaomAv?=
 =?us-ascii?Q?//xuy3AfOsuQBG78C1imE52p7liVHH0MxDs3Td13zE9rKjgbck5HX92et63a?=
 =?us-ascii?Q?iIrswa2gJX/oa6V58yGFxuMdr0S+4M2DCnYljtOn6/LKMK1nrjEJAORhLOb2?=
 =?us-ascii?Q?S/EltiBXyHZZYyCkwKum9vNWXrq4S6p3zXlKLu3xOjyJb0efduyNnHKXA+s+?=
 =?us-ascii?Q?2V6UyXRyHrYJBX2f5/eGbgjOw5HNzr++4jpf5ifw4uiTnIUvXE9XIQCgQRiI?=
 =?us-ascii?Q?q7TM6/iXz+dHhC1BD7GFUdTH7gIFSsbssCqhMDER5xBb2X/dLoWNm2uXQ23S?=
 =?us-ascii?Q?Ic+G8GZSoc7M/izx65Z7VjhhoNu6PF3m6VOeOsTEPT/tnBJroSyl/jeNCI+X?=
 =?us-ascii?Q?rFYFSdMEJo14IwTYpYYicrhUpRS2OO2muXPl7Hkr6fNkdpj3fbpulz6LtqVb?=
 =?us-ascii?Q?3i4NIeH0taGkUj9sM92dHZ/TP8Wye4kA6tjRXNQ4X1qoQKolABfp1H33h7xd?=
 =?us-ascii?Q?OOzma14p6EnBO1GqH0PinyVsBdy7NtLfNTS5Zh0WptnNwcfIlhMEnz/143Yf?=
 =?us-ascii?Q?CT2QSQ3Z8EAApbVyRwgzfeMDZ8A+2bC9sZhznDnW0VomZJNRTV29/yds7vW0?=
 =?us-ascii?Q?F2fdAYW0iGf3SI51qg2LWSJsCDVd5YtM6ZxIHf1ZKUAjdawLmwrQ/D/GO9Fs?=
 =?us-ascii?Q?HBwXDhTDS7LgtlZGlfkGYKADqbdCUUBseTZ+XM9kNlF3suWOGUkF4owizmL2?=
 =?us-ascii?Q?QTPqb/xbCoDpNy3LGV8TcE4xwkwrfpeVsopYIfvddfUJ+GFcout9o6fd+smF?=
 =?us-ascii?Q?opDRNLEQONzjtZic/ACY7zYrOHqQXprWUATNnb+rA1o8MEHPSmQZ8oO9vKRm?=
 =?us-ascii?Q?bZtyefv/teEYSMolTee7vZTqAWX0fnUq5XOelIkWEMDYPhp5RhTJbtC8ughU?=
 =?us-ascii?Q?Kk9AAuyRGn8Jo5B8iB9us2yvk2IBNeB6r8PH4LjC2Qj4knCiR88veq3toB+A?=
 =?us-ascii?Q?itERZSykEpCQDl91BPLhj0yvKeJsv8guE5ZggsVkC4JJvDGQpSCPAJBT48FE?=
 =?us-ascii?Q?HUxC8LU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NZyu8znHymgu3RCqDLQUdS36y3PliO8csLTHvlOlQAtmARhB68Lv6Gtf2ygG?=
 =?us-ascii?Q?J0hsxu8USQ4lvwmgkdN0ARNRgRbBU7IuJsdDHE+Qn4ziKCLFitHyKcBLl8wm?=
 =?us-ascii?Q?p/kKSnUq1jtoOoPjpVFqdisYRADjDzj+R6M14srekKLChjm5Y9ZuUbNGUBLv?=
 =?us-ascii?Q?waVdO2jCdvu9RqmjUAJenJ7hlYKit0JWzQ9qSWFiy1Ucy1EWrq6G7cjIW/AT?=
 =?us-ascii?Q?ihmFs8o38whfNRiWb30ZwLv41qEEk4/UpXWHZo85nM1ofUPX8ONG2vSHH6bB?=
 =?us-ascii?Q?0jb7QOlFij2jpqyzC7Lpi70b2+eleCkYMfZOYvtophqbsBBlToQOINOlGNEQ?=
 =?us-ascii?Q?5UOO13uYJUURobMGRW3sTGXeWkIb+TE3J6rEgOtZ46rWRaCh0Dy9k2MV3lPD?=
 =?us-ascii?Q?sp+oyudlLpCHCJexFHhfRUuezi7I4SVh8KHR65Ln1VB3ld9otuQaaJQeoMWI?=
 =?us-ascii?Q?eEqw6aGXvhkfGQSgDfkmTamvUso8PTSBJn1J0fDsXAludijLlInxWeqp07Az?=
 =?us-ascii?Q?gq4RiODl4KRfC9BVt7zkeRIkNN6r0Hs3Cl39yg1+yo9rmT1/dadmk3IGDPgj?=
 =?us-ascii?Q?v8HSQdkfk7pOg+YuOwbhVG2f6IBSH/ujZcTtGCZQFAjd+puy2nft9KtjmuRw?=
 =?us-ascii?Q?4TaNCgdmxUF7KIZIrAZy+bQ/SsXpDW1eNGGN0ME7+O3f49+piTDGiiT8xa2a?=
 =?us-ascii?Q?l9FAAI1te3ou8T/bfb0PNUb09lDHnYzsakQjcNaTOPCcd6lGfVuOtg9397wj?=
 =?us-ascii?Q?8figsVXp1/+5vo5zMtM/MYLvbVl1ikCDXD7EL4ZzFSRhFer8CdfoVzZkm4ZS?=
 =?us-ascii?Q?NyAW3aCoTcivW3IOSmPWazQ2dYjq/+yJTsTqR/oMQaKsg76X3ITp5m0Bt3HM?=
 =?us-ascii?Q?U43K4E/+MLUdFZ7SRH+F8e5UV3d6HpRAaQAiSy8izLjec5Q0JA3UmSsw6vnC?=
 =?us-ascii?Q?/NbX54E0kYgktt4pFUVQwdYV37P41OXuWRgVj8pOnCnncpuJSKB/BGR1raMZ?=
 =?us-ascii?Q?ehQWBnRWYIr/cr3ZY7HpkMzppQ1YG/L74/YFfnuwHrqJUDXo8P55U6YRvBtR?=
 =?us-ascii?Q?sjcJSFIJYbYTf6aO1/aj6y1N3ShhgiRtH0AhNz31naZsI3RTMrl3PkR5e48h?=
 =?us-ascii?Q?Dsa9iGTSVVmw7SbpaDwOCx2eaFH7CPD+3ax1jkOqgJxdIJj9kUfimgTSG9G/?=
 =?us-ascii?Q?Wj6Ozy4+dgik1T2y8y3AxD8cic/CfvMQljrrkPzaFZN2KfRO8KmLZ65e4BsF?=
 =?us-ascii?Q?ATlQeHwVsheAOU5Na25HUQ+J2OPNdtMPE21VLXaAe7wfJbv2yu1gq9UK/X4s?=
 =?us-ascii?Q?kGzfRKQlZAeVgoM2Kb7DTD1c2R9FoubiR9Tm81aoSOreO27GEfpSAi6brjPq?=
 =?us-ascii?Q?kXlQhuVSHUW4ubjVJEQhkX6IzBWBt859hrHw3d+RJpPF9rPsUzcFkj2Oaz+l?=
 =?us-ascii?Q?fsYsL2S+W+bjRpfJU0Iy32bg0prfda0NZ7AX1nnneBB6AplLy5X3sq6lt2gD?=
 =?us-ascii?Q?nx7FPE2xxx0aum4dXVoUw1dUQ9Pvsv6ncGfIOeX/46Ur39daPi0MNcBoHQOD?=
 =?us-ascii?Q?k97PW/vF/vYTI/aHuewcf8epK8cDj3v93dDqbLrCx1V785ssCqAN077e4Cnq?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d00fdfe-ede5-415d-75d1-08ddca83fb5f
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:30:36.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHteRDsByxg/nTEHafWDCf3xJazvCSwhQQ1sid5U1rcToqPYv3iNhRzAy2LBLRVIiPCnRGr6BXaK99cjKancKKhTdlxuc5qT1vXSv4+/w88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB2657

Store firmware version in kvaser_pciefd_fw_version struct, specifying the
different components of the version number.
And drop debug prinout of firmware version, since later patches will expose
it via the devlink interface.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Drop debug prinout, since it will be exposed via devlink.
    Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m2003548deedfeafee5c57ee2e2f610d364220fae

 drivers/net/can/kvaser_pciefd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 4bdb1132ecf9..7153b9ea0d3d 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -325,6 +325,12 @@ struct kvaser_pciefd_driver_data {
 	const struct kvaser_pciefd_dev_ops *ops;
 };
 
+struct kvaser_pciefd_fw_version {
+	u8 major;
+	u8 minor;
+	u16 build;
+};
+
 static const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_address_offset = {
 	.serdes = 0x1000,
 	.pci_ien = 0x50,
@@ -437,6 +443,7 @@ struct kvaser_pciefd {
 	u32 bus_freq;
 	u32 freq;
 	u32 freq_to_ticks_div;
+	struct kvaser_pciefd_fw_version fw_version;
 };
 
 struct kvaser_pciefd_rx_packet {
@@ -1205,14 +1212,12 @@ static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
 	u32 version, srb_status, build;
 
 	version = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_VERSION_REG);
+	build = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_BUILD_REG);
 	pcie->nr_channels = min(KVASER_PCIEFD_MAX_CAN_CHANNELS,
 				FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_MASK, version));
-
-	build = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_BUILD_REG);
-	dev_dbg(&pcie->pci->dev, "Version %lu.%lu.%lu\n",
-		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MAJOR_MASK, version),
-		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MINOR_MASK, version),
-		FIELD_GET(KVASER_PCIEFD_SYSID_BUILD_SEQ_MASK, build));
+	pcie->fw_version.major = FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MAJOR_MASK, version);
+	pcie->fw_version.minor = FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MINOR_MASK, version);
+	pcie->fw_version.build = FIELD_GET(KVASER_PCIEFD_SYSID_BUILD_SEQ_MASK, build);
 
 	srb_status = ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_STAT_REG);
 	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DMA)) {
-- 
2.49.0


