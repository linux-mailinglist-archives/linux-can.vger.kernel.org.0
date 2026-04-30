Return-Path: <linux-can+bounces-7446-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI5JJx8682mFygEAu9opvQ
	(envelope-from <linux-can+bounces-7446-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:16:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EE44A1B2F
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EACC430217BA
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE1542B73A;
	Thu, 30 Apr 2026 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AulHh/vv"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED542981F;
	Thu, 30 Apr 2026 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547261; cv=fail; b=cLL6ZtndgmV2rAhrxbfbJwxTLOSeoaSqHwHFHHu+yRcTDY3UJ9I2yE4EeN89Fe04ZGVJbsw062xBuOZwtH/Z0zd9xmYFkTsnsxnzLRpwRqkItoWDnCSku7F/G7ibieWeh5RTSkSD2TqamZMwYOlTMHcK+CsE/N8qR8Q089NbNPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547261; c=relaxed/simple;
	bh=L3OuW8nGSEtX7+jZo3zXESoFDVERkMb0ebeWARdhQz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k+WiWBy53WEnHxsHQTaI9z6iIRAJw3VvCLGBP5/63AnGADHIdks7CwXH66k7e/u8pwdx0sfYsEfoxycZDWot/0ueG/cJolu29pHKbR49V7tfD5fDDhGYsGpEmzsIASXtPCGYmFcnxxoQywZTj1u++j0we7hrnJ+/gS2fPOyz8sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AulHh/vv; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OF2/MMQO4G53vgqEf005ferzpxnqMMrfXMtlBHxvBSYwZKcHxvpPNlATu5L5QMBJSAd49KKpb72TufDaEPDoWGaEnRuW7Io9FQcfDOzivvU3KghfznQQpQjUxpGy/uhDnWSrg4fOJA8Ld7nrQbe8RDpawPxaVGwEaYO0CZ9TzvAUM6Oad3Jnv14rZ//sCq468wGd2/U1Ty1k740c7oD6LmY+8FfdQp7IDBJ/VNIpLFr9yEgQjG7ppwMcGHErYDp4INVcZ/fj3ZkcbvoI7TfSwyHpeLQuR63f/xG4SyN0JJ6jz4nJZgWLWFXh8slDnwnPfeNiyVDZ7N/Fnv1iRyta7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYEA3WBNYo+AsAnEBH4YZSbMHpGmNo94b2KnUaCvH4k=;
 b=sMiGo3FjTB7EaNttBxkRtZ4FNR6pgfcVm3lwU6LGkKttz753KEYlhoFjWPOaLNnPL3QJ9m8rSzi8D9OKSCwy+yNwyo1W+fYwSh4pA4j4uc6r/X9f7Tgh3TwmncptLRp/zXTLsfvto84Rmax4O44YZ88NJaTNTUhENkysKY9i+m03pX1BEmfaFZ90KPcLiNKWk6TcLpBu8Vt9niWAniDfCwQHN3StTIDjsI2HmmbhaT7rpk3FrGe6E/Y0Le+sxk6jv5ZvWaw3UbdAISBD0w3xQkEn6oULv2caVUPRjMo9FeNXxmtu7cZToEzicIL6cTheSjF3rC+wVSFRJ9MQx+AX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYEA3WBNYo+AsAnEBH4YZSbMHpGmNo94b2KnUaCvH4k=;
 b=AulHh/vv+0fW4G3cwhNJT1DaILqJm3Pz8onnR7MnB8WRBuMHzeys3bQOsKeu/8q02E2Um/qvsrtPJCnFmz6WlrzJs9DZU0BSn/Qu2MEdgBWQpwY78V4ki4FMDa41guRcI27GJHryeapFmcQ+3UWpwuLC1zFy/vLOA1AHaAvuz+gqIM1mBcbmdD3CZqYAKTDaM/UzcNXY1KHb8Q+urnjWJBlR6pkErQbp9pwylwQVuHlBl/EP9xBTLP/QxSVecTX+UDUJo/wwZg6oZv0mFmR0sOBFV69XjK3bTplKDEQRnN49DBGv6lTUOGB5ZShX+4BqalH3A0jpRNVQ9Q9yyqgwFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:07:29 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:28 +0000
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
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v7 phy-next 18/27] drm/rockchip: dsi: include PHY provider header
Date: Thu, 30 Apr 2026 14:06:43 +0300
Message-Id: <20260430110652.558622-19-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0017.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::22) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc9f532-e0c5-4af6-ffab-08dea6a8aac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|19092799006|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yCbuz0nS3J3dbPuhi4tjTaamZNkKK4xvcxAaCWsTj/P95RjllAMm89kSGyZsXsk5PtROgZ1crYS1e9NFVjn2fKQj/2BOdmMFY3FjvI2tohIf7/cuDQfY6cLKdwNVu41vZAbpp7Y4GHtOf8SS4911PaCsepM9eM2eZPH3IBJ2dpq3NNQbqs0JtDMsMN09e0HTNL6IvJ1FQX0Tgj6PuPPv+JZTjBqcYPS7DTZXbjQYcwjtQElKzR8pHlXUnVAVt0VahN45iueMkYZhAXvWpvCzSLf7/Q07r1/2Aao1fzjHfFAnbtNLSF3CKsax9dajtbKAXwnMdcZyZwBiKEJAtXLHcKAOAOusWA2CyULuUjAZJPRyimAsxPvIXUsYK5Ygn7w23w7qsniwdY9j1kss6OPLJs3r1YmRcIl4NnKEwFe8+ekX4bMgrqvBZ3JqWeun4tX/TlgqjsktalHscshh0b9wdFe0wXvkA51q0hF7QAsM6wYV4j/WFULg/n34tiFdQJZVBKkO2ETDT3biNV2Ip1I4qSRO6cCFijylGci9JClyKV5XI8lvnoFarvji344I6NFYJ4q9qNZbQjLRpN8owBXPvtLb3m4ujvcZMkGBusiZup/HZFupcAhVQFX8B1DU6P1XDdZWZg+bJNFbf7rdYxW3bNsWmQSyWp3hLWluCPkX36TJUI1wXr1tHvwgL+WNL8CUl5CiI3Gz1Qog+a6DblfBp90D1WXpj7x9Ulzi1WeqEpM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amRZLzNseXBTNFJ0ZktieFJQQ0JtK0kxOTFudERxeWNxV2IwMFphUVdBZzJi?=
 =?utf-8?B?ZVh1NU5KS0JneTAxSHIvaFBzZUFuQWZFRko4ZXhIeTlkVzlCL0NwRDNia3VN?=
 =?utf-8?B?VTNtbXI3VWE0VkRtN0NjUCs0Q2VuN0s2d3pVczhVNFBSMnZBV1VrUUtHNFNj?=
 =?utf-8?B?QWxldHRocHo5cUZ3dGhQY1ExYzJCRjFKd3pQOHNHRks5NTM5K3hxcVEvbVV5?=
 =?utf-8?B?RTJPNEx4aXVzTzRyZGVEOTBXUEJUTW5KMlpKUDVMenhjT1doZWNoOHB2b3NS?=
 =?utf-8?B?T3FkYlgwMTkzYTVoVUpWM1BKenBKSkxBeEtiVjRVa3ZtM0lmRk90SHM4blVQ?=
 =?utf-8?B?Wld5bzg4clVGUHFMeXU5ME5WRzJRc05WaU43RFpySXE4YS9uNFk0VS9uZ0Jq?=
 =?utf-8?B?VUp6SStZbFJjVHZ6WjlhSjFjdVBsdXoyU0FHamJUZWtQNHhpWWxsNWIzeG9q?=
 =?utf-8?B?VVRzOGJzVnd4ODcxUjEyZU9uMlZTK0dROHdFTkg5dzZJMndxMXoxc3ZLT2Ra?=
 =?utf-8?B?QTI1ZUkzR1M2bEluUXI2VmpKOG0weW9VWnNpSG5DdnFXT3U5dFBFd05KTy9T?=
 =?utf-8?B?TGtOUmhtbUhLVHpsbU9aVEtZMEJrbkkzcGFzVmZOcmloRENUMEN1RncrU3F4?=
 =?utf-8?B?bWVPNUlXUDBZSVozMmZMRGIwOXJrdXhVYjhCSHhETlpONVIyK0pBRXdYWlRN?=
 =?utf-8?B?RXJ1c2UyM0NKRFVnRjQ2djNmNFhzNTM0TTNDWkRrS0R0TllBUU0rYk1aUGNu?=
 =?utf-8?B?d09GVUFWZzF4M2U4OUNES0VQVGErdHpMcHNqU3BDVURUSjRTMlk3R3J0aE9q?=
 =?utf-8?B?Z2dHZTF5NWs3bVdqZm43cWJvK2w4RnkwUmJDV2FRdy9ncE4vV1BEUW9yM2hP?=
 =?utf-8?B?ZFpubjVNNDJOUkcrUHBHYmgrTjZwK1I0eGVsQWZFRmkyYjhjMGtpSCs2bnhs?=
 =?utf-8?B?bWYvcWRuQmVEUnFFUUJxRDBYMTZnaXFSS3JGeEdWSURBbHcwVVJmNTF4NDBQ?=
 =?utf-8?B?RFFGRE16c29aa0RhNDVLQnlYNXZEeDBOcjlPM1VVOHZadVhZNmhvR2VXcFp2?=
 =?utf-8?B?c0U4eStibnhuZ3dSTjhMMkdQeXRWMG1BZWdmNjBBR2RqdEJ0REt6YXdZMWYr?=
 =?utf-8?B?clZ0SjdkOGtYNFFId2lZelgyNzd1SDJUeFJLeE1XeDBTM0NDNlhHSDFaKzRR?=
 =?utf-8?B?U3JkOHVzK3BDWTZkcEQ0VDhiazV6OVBZcDVBcUFmRlJtajgyeFFEVjcvTk4y?=
 =?utf-8?B?OHptVGM3Um0wMHIvOXRxbldpUE1WdGZPTXBjT3U0a1NTTVRhcHl1UGx5YThD?=
 =?utf-8?B?M2pDa2UwQmdTQVhoK3UxRGpjeFlReTBKQUpGZHdTd0M2cVRJMmZtWTJkKzlz?=
 =?utf-8?B?TWdCamJTOWwvRy90bUZMV014Y0QraUtGYThuQ1dmeFBBN2tOaU02T1lGaXpE?=
 =?utf-8?B?M2NUd0ZXOHVlZmordmQ1RXF0VDk0UTExNlkrWU5CWVUvSE8wTkgyQWJySzdw?=
 =?utf-8?B?b3lYK1JUNEtGUE5oU1VOQWdJR3JVTWRXOVpmQXl2SWpJWVF6QmlPb2dBRjlr?=
 =?utf-8?B?N2JYbWxyanRxNFliMTUwa3BEN0FUMyt6WUdOZ3pSMElBQ2lIMFZ2S2NzZmNI?=
 =?utf-8?B?L1Q2cU9WMmVYYWd1L2hrQUdhcW42aDZCN1A5ZUM1bEpySFd6c3NidU9RRDhv?=
 =?utf-8?B?cUVENmFEUFBoc29DTzc3a1ZMbnhjVWp3SUxhOGo4OG1EL2RNbFBSSlRlbEx0?=
 =?utf-8?B?dW1FRXZuY2Rvak5kWjdIY1N5QnhPd1Z5SzhRUU5ONEYvVCttaXZTMS9aQndF?=
 =?utf-8?B?SW80QzliMCt4a0pXWXlqU1FZU0dxTklDaGlPSkh3S3FpbUgxRGVPaVBSeEtI?=
 =?utf-8?B?cUdjcC9VV3krNC9RT0IrTjlna2J6SmxNM044TnlCeEV1NmpJMnZRWDBaM2sr?=
 =?utf-8?B?YVBzSXM3RkVGV2JDVW1reWgyYjdYZ1hQSXFtVFhYYy9BYWEzRkl6Y09sOUpy?=
 =?utf-8?B?ZGRtbk5ZQm42R0NTM3A1QVpzdEV2WXFEbjRpT3Z3RGx3SGd2OWZPeVJKMFFO?=
 =?utf-8?B?UlJSTC9OVzhsK2lHRTg1aUJKb3RQdlg4RDJOWHdZNEwxbkU2eVZZamYxQUVM?=
 =?utf-8?B?enZSeUgzMVVpZVhLRSthS1B5T2xjUGxRQVAxNHFsWm5pVEpzVG96U0Z2a1hv?=
 =?utf-8?B?VUU5TWhCZDRvWGNEWUE3SmRFejhCZ2hiYjlmOXpyT2IyVGNzaWpzN05kekJ0?=
 =?utf-8?B?cWFQUFEwcmpXeEd3N3h3RUh5cGdYQ25XVWc5NGFUYUdBdkFlZEJDM2MzbHBW?=
 =?utf-8?B?TllXN3NUaVdvVGJNWDRacWpOejlSbDFYcjEyR0t6ZzB4Z2d4V1BVUnU1NGFo?=
 =?utf-8?Q?WZqkmrpaTKfrF/UAlh6tEq7wD7uqYwx9FyI4e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc9f532-e0c5-4af6-ffab-08dea6a8aac9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:28.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Q7tNqvXXPK4T8YdZBy2T8/mWNPq44y0tvaIV96Tv4AZL1CUBMe9bU+2gBUS9DSjSOC8aQW0QvPN2dPik3aXrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Queue-Id: 88EE44A1B2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,rock-chips.com,sntech.de,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-7446-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,suse.de:email,ffwll.ch:email,sntech.de:email,rock-chips.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]

The Rockchip DSI controller is a PHY consumer driver, which is also a
PHY provider (calls devm_phy_create()) that lives out of drivers/phy/.

According to Vinod, this is discouraged, although it would be difficult
for me to address a proper movement here.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

v3->v7: none
v2->v3: fix cc list
v1->v2: none
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
2.34.1


