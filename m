Return-Path: <linux-can+bounces-7106-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNgXHbXeuWnNOwIAu9opvQ
	(envelope-from <linux-can+bounces-7106-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:07:33 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E64F52B39B2
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 871B63056152
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6C63F8E11;
	Tue, 17 Mar 2026 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NiwyGukV"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D315B3A4539;
	Tue, 17 Mar 2026 23:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788747; cv=fail; b=AP5wIVgbDuuspIqD2O4w95YzINokK9BylxzuCGVJJxLrmYVPqLIpRmlUjay2J24WoOjtk67J7FSUVPRzBI+FdSTi+ngByfCCkVycZKikC1zNzWplwGlsjtnmrSAOtnHaYwzQkYUBrT53ZsE7gVConEDnlX7KXo+tPK5wcDecxzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788747; c=relaxed/simple;
	bh=DLml3K6fjUFbsRAOBXaYwGLzX0xyN7/EbMYJ4as2AeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tSC/MoaIry6f0QRwgE1/eLSkcsLCgzQbApM/5YH0xREdHpYn+OYCbClROWKmiQJ+PUlG68mHwvt6LGhXNxEFEASRGGwY2UNdGcXssPimnyxLFk4yKyVmxnWDvHiEXHNaMfincWUa+/w2ANq004IaAGe5efj86+97xNwHiUq151o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NiwyGukV; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YM1E20D/dj/+2jj2Rqt7EQ0E0+PcQwYAu1HR1RofTqo0WUk4It5W8UGgIr9iaPUs6uMO3jmFxgdDk7BXvXBl6Jq5OA/l+1aSPB+dwi9i7Z28zkg6pSReZ51kIQwX3pFsL6LNZxKHetSY/QOG2DV6I/YWk+RNiduE70oR8HxGR8r0QAFYM0EGgLlZVsvtYUDnWxwBRmIR799KM1a2Hxoff46shFmIIrFz/UHYUS5jSy5VxZyZpRdLG6YFzVXUkC52m78BLop/Yx9gyfF1tqd5OUTLyXd4cdMYhDK5G2MZr8V+o0q57IDOfI0NNajFUUlHvKlhrZC3t62pw4zPdyyHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bJTDeoqx2r+6LGA0A2AbZ34/TiNtswHPakqgqJ61YE=;
 b=lh3NTMt4vBF49ijz9W6cPD8je3TJq02YoKNAbtJIcJOQr6yMa5ieUKyXQ8XsddMeea4Tf5JDZxLBPs8P3GcXCVTw6TQvp1en/pkdSOma6O0uT9wjF6lEji07oHsu2q3bC0HhnlA88w4c/w7yV4IRt1rv55vyESYf+7KBE12HLIdcgo9lZYRXHzS6brwevEdxLwc7YRn3nyvESsljh083h//7/KR6n/FEkk4pfQdFYaEIi0In7n7SC2s6A/pc43Bgyuw3jXh/7k7LAMAWRxfLpnKFHOZaPFVUekXtILasjkqusFkKg/qW+Adn+Wr4LDnL+VvvyMc50fhlNSYBwIAHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bJTDeoqx2r+6LGA0A2AbZ34/TiNtswHPakqgqJ61YE=;
 b=NiwyGukVgVIzOcwCFVRY2ipE/knNp4J27f8ffLPRJosZ4XMXYxmqxJVzuiaw35Yl6ffmlWySThmfvDaNCFvESqU7ZRhxkwLGFT6H1W6X1lVS4OyfBZ7KnPbHyi104wVgFTJyA+JSQuMaGJIE29G/S1tNogVhKZfbxud9cfbTLp5tb/M8mDsUkyR3StPD9eTO6ACAuR1ejnMsI/oSX48S7FMM9cAO/u6fHrOtiwnq/3yubnKp9LTeDTowFxfqoyCn35ERwU9GklsbsOz9TfXmMP7P9L9jtbJy1y/CeVuDgLdjFs+23ubc2zp1Buz25zgxygfv+howflhUnR5v8xQc4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7022.eurprd04.prod.outlook.com (2603:10a6:800:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 23:05:29 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:29 +0000
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
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v4 phy-next 09/24] ufs: exynos: stop poking into struct phy guts
Date: Wed, 18 Mar 2026 01:04:45 +0200
Message-ID: <20260317230500.2056077-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::29) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: fc625275-68d0-492e-68c4-08de8479aeca
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|10070799003|7416014|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 /yB9r4oovnzc1kx3G0wD7Tkap/WNSBxKwLJgTf3PljaWnWL+X3k51wGLyoHncvSN5hwyr2bC7lxUYLynUKkJ8VyFvH0hdVoGbhF8gP3VMJifSZTinjH5a1Upoi0Awk824um7IpY55DOyiR1hP4yOfv/nRq3ewBrwEfSbreXVUGRjJ1fMJ1R9iRHTFhuUsg8fjReVEbNGNZGJIQKepywhgJOoCb/mJIa+1AhECpaWRNyqp/+idH4CtfwDs9B1l5XKlgeo1xvIWTI082ZFEsFyhXnDGDFax/LNT74gDqU+sDQUBTWveB4fYpPWAdDHujILZMS92lvwjfKtqIdjju6byJFfELtyh8oVzkrHGGDrdtIzhLEccVUcF+bdtjDXOQ19dAxCnaWj8DkQqYuUoXjJgaiF7PtB+lbZ/YVu7Upz05guJixQaunn7BXYs97na56nTvgIxxVewngy6psvKR5Uto/a/joYV/6KcQ4yPb1Mm4MIk4lx7GMhhx1nh0jauY6+dLwSMQMWIaJFG6RTycGot0l2T7rkymAn8qYl74RkVjmNuEl9XYVR9pbvKyDABDhI9sDxiU+s3Hv6YvTvFotro4O0Cbj8ASp4CTjd8pLGLGjzkClXloVUqGHLfeDADPJcMJFdkHYeuIBfoRIbWnoMAXehbQRFe6bhKnLBwg9i+j23DdKbxm1Ep3tdVwlVlULzuLrOY/giMlHUDjmgE9BbahPibyR21XX/sTpYyzlm5hI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(10070799003)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?a1p0F/nO5nYF1v4LO+A4In2eZzSaH3iXhry1y7MLw6n2hc7PYHnSEgIGL6xl?=
 =?us-ascii?Q?xGGVKXuWjfjGUusvNhr6RGX3YowbmKQdi0aNdjM5sSwVBRvtnK1CWG+sTShi?=
 =?us-ascii?Q?/X1RwwFb8jPSYoYBZyPynFl6B0wfkzQ4pgHoxGGoZTUY6+V2zy7BgZlrWgRI?=
 =?us-ascii?Q?QCOugLHKURy64YXs7EviKya81YfFaNA02JxXIT5ll3jjZd2q+HijMeuXQhEw?=
 =?us-ascii?Q?FMWKX3vr0fzNWZ9iZoDDrMw6utrWRJi6Drxvm9HO8nOmXPNKYytHhQjJgZ4I?=
 =?us-ascii?Q?IDs8dtT4gBp/9mVw67AZGuQ/w9U4xmIhEFqODWMdYgoLMUzfLf16zGorJ/C7?=
 =?us-ascii?Q?ZojGNtx7ErYtSq1dPpTZ3GDqkx+ykTe/DdhjFimExeIBfHJqrlq1vIvAoaF2?=
 =?us-ascii?Q?rGnV/UWQbvb7rvIJXJtUh4aUTqxm+plGyXrCo/xItBpo/1MsBdGwIB3C+dcu?=
 =?us-ascii?Q?5Iqia5vx25twf967KTEpM96CoyydQHBBMgn/79bzx5ecbLzzinc7uioMe8qs?=
 =?us-ascii?Q?OH3Ohu8pX7k/i8Gw5WxBPYMH61aJRyaWMbJZduX2Hquj19k0TygIaDNC0oWM?=
 =?us-ascii?Q?+3+oFzusXjGVGcJxqepjOGzs0I82EjM8tQ/RXNAXwtFHQ+xfYht9nk0upmJ7?=
 =?us-ascii?Q?7T9xPD/IAVYZkanOBzqGlZ2atsXAhb70jxOwrSuSeazU2fJZPE66cK8QqNiW?=
 =?us-ascii?Q?6v4KxhiAubTqPXy59WI93XY/8RQt09ZW1rin4SY+kWmevyGVHCSFfmi6LNF6?=
 =?us-ascii?Q?9ghmeddCQshv+SyD8YNSo79ZQZiI3tUsPZHyGIVKqGtHMvZGm1JGvrdVZj5P?=
 =?us-ascii?Q?29zXjkV+vJXmtV66vapcDbd8B1s5XU+BydHQYngF3Mco37wCg8/aNN9hba+O?=
 =?us-ascii?Q?MCt5X/iLdQ4NljDyrdlmSzrixO+ZDAsCJusc6BHE7Lxb63eqQrRWgvHdJiy9?=
 =?us-ascii?Q?vgychfLD5JdmbnuEjOQQHLn9+4/d6FKA+5v0SPbFxkMn/KzAYJPLdXont7ab?=
 =?us-ascii?Q?bSwmaj+KKv+11edG0+gHGs+RHqwOeTbGOjX1pryqQulhaeggCQb6Ubt+Wri4?=
 =?us-ascii?Q?md1y/R9pcy8quAefo8SDs8yXp36o0i1ES/zH7BvrDa9UQYNFTtCThFj3HB62?=
 =?us-ascii?Q?+2puMG0EzjuBOba5SpZRVglJoLNbhcb3kv27oahgjuQPVCaC1/CE3Z0cSUv9?=
 =?us-ascii?Q?fJoS1DzxUmP9qI/CbUpglorn57rZzujj05fmpuw169Zpy0KHe5Wp+S5jLLly?=
 =?us-ascii?Q?9FwstT2MgQvHTk/O2Wx+c8BeDqk607RW48fORsoFYPSeSM1ed5CpdWXljV6F?=
 =?us-ascii?Q?vCZhd3WNh5xx9am5KKBU8jRzHEP2fedDUYO3tS4OxeglZ7ksOItjQjpCZISy?=
 =?us-ascii?Q?e+Q951YSrDPXjMFdW3/KbuNxv4hih3MbIUwLEdZtfPzJcPmbZuHaoQkNaXLg?=
 =?us-ascii?Q?iQPmFCJvcJllp6a6zqbnMgj98/h/eWDHTlZe2gDUqlxR7Z7OL9YZc2GDGxGJ?=
 =?us-ascii?Q?ZnVrTUs2Hir+5OlZ9AI11E8JtUMRRA8nLmKxUFiY/aNq45OOCLjm2yiwXql6?=
 =?us-ascii?Q?3ABeUf6PjCohGcHJs8/qaV6wSmcMrjNaQd0uytYqVPdd4tWIGzDd7do0HCSL?=
 =?us-ascii?Q?KSkdcmLu3E1KwYlQCIGfvOL29C2s+EnBBnhk5gWMBs4G751nUUvaiQ2iR1B8?=
 =?us-ascii?Q?VtepDs4MUQr4jtMmIkimnV6DdT0Srst+x+WKGlIxwDyj07XRIg9FZOS5By/W?=
 =?us-ascii?Q?xIxdYwWRImWvFKTrkkrzhQXHM6h7ANFyofXhFnt4Z6yOrsKmr6e8nP+XYSxd?=
X-MS-Exchange-AntiSpam-MessageData-1: s/wLtj9lh63lZv2y2otbjI5yYNelXvFMD2M=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc625275-68d0-492e-68c4-08de8479aeca
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:29.2900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5kEdmgdsjK7y1GDVvoDywjaKiy8JfU+Mtg15o8UnShsyoljDKytXgwAq+K4LRJV0Ww67kHEvTxmxP/ZRHfuAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7022
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7106-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,hansenpartnership.com:email,oracle.com:email,linaro.org:email,samsung.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E64F52B39B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Exynos host controller driver is clearly a PHY consumer (gets the
ufs->phy using devm_phy_get()), but pokes into the guts of struct phy
to get the generic_phy->power_count.

The UFS core (specifically ufshcd_link_startup()) may call the variant
operation exynos_ufs_pre_link() -> exynos_ufs_phy_init() multiple times
if the link startup fails and needs to be retried.

However ufs-exynos shouldn't be doing what it's doing, i.e. looking at
the generic_phy->power_count, because in the general sense of the API, a
single Generic PHY may have multiple consumers. If ufs-exynos looks at
generic_phy->power_count, there's no guarantee that *ufs-exynos* is the
one who previously bumped that power count. So it may be powering down
the PHY on behalf of another consumer.

The correct way in which this should be handled is ufs-exynos should
*remember* whether it has initialized and powered up the PHY before, and
power it down during link retries. Not rely on the power_count (which,
btw, on the writer side is modified under &phy->mutex, but on the reader
side is accessed unlocked). This is a discouraged pattern even if here
it doesn't cause functional problems.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chanho Park <chanho61.park@samsung.com>

v3->v4: none
v2->v3:
- add Cc Chanho Park, author of commit 3d73b200f989 ("scsi: ufs:
  ufs-exynos: Change ufs phy control sequence")
v1->v2:
- add better ufs->phy_powered_on handling in exynos_ufs_exit(),
  exynos_ufs_suspend() and exynos_ufs_resume() which ensures we won't
  enter a phy->power_count underrun condition
---
 drivers/ufs/host/ufs-exynos.c | 24 ++++++++++++++++++++----
 drivers/ufs/host/ufs-exynos.h |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 76fee3a79c77..274e53833571 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -963,9 +963,10 @@ static int exynos_ufs_phy_init(struct exynos_ufs *ufs)
 
 	phy_set_bus_width(generic_phy, ufs->avail_ln_rx);
 
-	if (generic_phy->power_count) {
+	if (ufs->phy_powered_on) {
 		phy_power_off(generic_phy);
 		phy_exit(generic_phy);
+		ufs->phy_powered_on = false;
 	}
 
 	ret = phy_init(generic_phy);
@@ -979,6 +980,8 @@ static int exynos_ufs_phy_init(struct exynos_ufs *ufs)
 	if (ret)
 		goto out_exit_phy;
 
+	ufs->phy_powered_on = true;
+
 	return 0;
 
 out_exit_phy:
@@ -1527,6 +1530,9 @@ static void exynos_ufs_exit(struct ufs_hba *hba)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 
+	if (!ufs->phy_powered_on)
+		return;
+
 	phy_power_off(ufs->phy);
 	phy_exit(ufs->phy);
 }
@@ -1728,8 +1734,10 @@ static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 	if (ufs->drv_data->suspend)
 		ufs->drv_data->suspend(ufs);
 
-	if (!ufshcd_is_link_active(hba))
+	if (!ufshcd_is_link_active(hba) && ufs->phy_powered_on) {
 		phy_power_off(ufs->phy);
+		ufs->phy_powered_on = false;
+	}
 
 	return 0;
 }
@@ -1737,9 +1745,17 @@ static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 static int exynos_ufs_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
+	int err;
 
-	if (!ufshcd_is_link_active(hba))
-		phy_power_on(ufs->phy);
+	if (!ufshcd_is_link_active(hba) && !ufs->phy_powered_on) {
+		err = phy_power_on(ufs->phy);
+		if (err) {
+			dev_err(hba->dev, "Failed to power on PHY: %pe\n",
+				ERR_PTR(err));
+		} else {
+			ufs->phy_powered_on = true;
+		}
+	}
 
 	exynos_ufs_config_smu(ufs);
 	exynos_ufs_fmp_resume(hba);
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index abe7e472759e..683b9150e2ba 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -227,6 +227,7 @@ struct exynos_ufs {
 	int avail_ln_rx;
 	int avail_ln_tx;
 	int rx_sel_idx;
+	bool phy_powered_on;
 	struct ufs_pa_layer_attr dev_req_params;
 	struct ufs_phy_time_cfg t_cfg;
 	ktime_t entry_hibern8_t;
-- 
2.43.0


