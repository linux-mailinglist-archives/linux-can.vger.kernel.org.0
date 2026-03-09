Return-Path: <linux-can+bounces-7039-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AYLIgwcr2lIOAIAu9opvQ
	(envelope-from <linux-can+bounces-7039-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:14:20 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CD723F6C7
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7933E306C12C
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2580F40B6D9;
	Mon,  9 Mar 2026 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D3TvpWoi"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011054.outbound.protection.outlook.com [40.107.130.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2978D3EFD37;
	Mon,  9 Mar 2026 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083388; cv=fail; b=dxwxtxQJgB5yX9slozPPAZjPbm6+9LQiXbXU3hOn9E/xyP3wKVJwNwMFnsTliX84k5kl4CZg0GEWRlvyiZ78akpTmPTnZnp+2ghMSXbqprZ9R1OFiSMnt1+j5QEzZOv1RirHT94UJU1T1tkaCJG8SXbPfUxbVnj6VTxU4GC4QGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083388; c=relaxed/simple;
	bh=ujVhvUqMvZA/0CE+1VRPXh3Pyd7KDJu4CPzsVFHxblI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tiM6BgYeGYtNPVlxLnIwtW/PFa4gmAlnaQ6rGm0D135SGDuy0mXhA+covfuFfiUqbnnfVCPcfxwitLNvkrh/M1HY33JS2cWvhIfaV7tAoEbATaDhaZJAGdC5rclZoml2wH+MVtGIUnsDqkZY0s49dzDnVDHrIyAZukUEXvnep98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D3TvpWoi; arc=fail smtp.client-ip=40.107.130.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9/HzrCcLP5rRI7F6EO8ts7RtGDaJitMTNbXA5TvLZ7bwq25gVhMeliIuzJSDiiLS+XpljbTLvNOrWJox7TIRWpzcrfaOEnAYB7h3FjdXIrTgod4kEfRj4+BwIF0F3jqAxYE2foRUjE+oFPsqir9rVr33ImxKkhyawr3x4IgvzgoHIW1U5gJhphw48G4ATyRKzIldWurAFwFYP08NiVhFNE/31xB9QRIOW4xPyPbEZGvDngrr7KKIgGTxDRLJxw17IuNmm5rQx1GIAI6D3JtckpoDAioCAjvlr8M+uOdSpy8ygKXY6M6LWuffvfYqTXrZRQ/UskCP3PgLR8Wf34/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QC9/sSLN5UkKL9tIAayTYN/AUCaa7JCPPvv3/PSxahM=;
 b=ojTw65fgKcZXx8edFjzjiYAgIxfcwyWw2j3CVWXKcDmas3laVKY+K30rL0wzZsrS7K/tfArc1QthREnBPECgYl/TjbqGmBN1516HAl2erb5FlB5DzHRKf9TyKd0REkyMtCZOnz0FNMdokg6XyZh1lZI5pDU+Gd5xUpXjpy+Zv7u9+nLJPRKVYEC0hWk2L1I6IS48Re6wijbM65HLn2sRhrvSxVbpwwvX6rl+syPGSLJ9OwHmMt+Ze9J4YyuvcP8UD89Z58euBe+OipWCaC0z0eWk61fFJaH9yVJDARhTOyjLbhiQCnlXkpTwwCf1SGiFvQcC+WSPn2v/NAkRX+AY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QC9/sSLN5UkKL9tIAayTYN/AUCaa7JCPPvv3/PSxahM=;
 b=D3TvpWoizcOm0LqtgKFCalHH/Ksp1ckXOPdtwKBcn7poXdifKun0vP871VUePHdVKeDFAqrE9t3lE+G7/wixgfz6MAUHQsG9Glt5QZnHP1lLF8r3vAShvgdJBPZ/TimaaBDYHP1dCCo6BwrXQ9KXp8LUznjtnqNs2/ljq3j/KhiYFHnQ6OfbJpf+p9+24ePUs1+0d/MYG7h3iPSss9R1RE3NZ0kuwCpsLrphXwk1QJXKl+Xi4vXr5LREP7pJreU0mbTclijZAbgeTY+i1FHcu9k1y2LvtQbN/byZ5slNXCK6+cEA6bFAboSaPkIteZk1HYn+8jKbk05637omqpTlhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB9841.eurprd04.prod.outlook.com (2603:10a6:10:4ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:09:39 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:09:39 +0000
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
Subject: [PATCH v3 phy-next 15/24] drm/rockchip: dsi: include PHY provider header
Date: Mon,  9 Mar 2026 21:08:33 +0200
Message-ID: <20260309190842.927634-16-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0098.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::27) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB9841:EE_
X-MS-Office365-Filtering-Correlation-Id: efd08f86-4f81-4deb-3744-08de7e0f6943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	iYyl80P7aIoRbSIvsYnpwFlEbNFHtEtt7hXYdZM0R8qfo//GJU5W4W70VgdUS8GNm2aw5yqkd48jjMca4chP1XUplxLdz6KmanRVpBBc3JwOGMHxP7OmRMGHuB6RzfOi8dEzLP02IZ7Usfk2pVOU0wI3Do4nb8tw03VyxO6RPNPpljp/xPiYRMrmFNz+HJBFSO7lJ/R0p2Snep9K6L+SAKtGxCkZL66aTM47ydsrureVVZesKAofKF03HFi5pG1MvybUKqbZ8YX8OZgjkc64nC65c47I7uoj0H8wChiIsUVtdav1Tl/+c3HvvXHCf+FwmCbqbzEcGg5wAucxtHz/YX+PIy0dXP+JkUaiMrt8Lbo2zEawFHFEP0F1tXyzARj9+h+RwQGENwgchOaNuHpU/t0TgguHFKyVK1bXkQGQJy6WWE1asD5Tl/dyOt1eVFKTpj+ZkscetkzuIoICPYtZEwAY0XkS2GJ3HV57DMtkTRG4jyNtlXATP3DQvz+F7K+tBZoQBZBJbLkSvOIAqz5clsMn6avcQS65YXNEAl/TyDzLPBnWbDvFGgYZpVloTd3gw/vqPM5awQ3bTbsuVq6CGMpXonN5NvZkJVegZ+ix2/wefPR9bZLhomVkaISK+mT9wZWYE0kQLtMnjglFW8AGKHZ/mY5aMDgzGqfaGN85+rLO3Xulc/X6oU6f+jdLrbTOBDtr7KKzgZSoqkmDvo7yK6mGw0oEj5jjAFMawX2uhho=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0pnc0RqRURDa1pic0krOTVpekJUTmo3dUxoODk1U1hNSitaWUlRclBDTmRy?=
 =?utf-8?B?N0xJZlk1ZTh4MnBiU0o4Wkt0elJKei9FUW92bkQwaWxCTTJuaGJUREZVd3Ns?=
 =?utf-8?B?R09OVEFNMk9GTjJIdlYxSWF4aXdCWkZ1MmtoSUR1dktvOEVWSm9paitEUUtl?=
 =?utf-8?B?ZU0vcHFZY2tCT1FUR2tjRDdQeTBJMHI4M1JUSlhhbTJLdGdhSWtZaVVnU1or?=
 =?utf-8?B?V1A0VVMzeDJSRTd2STBsSG1tQk13RUxITUpPSkRIQ3hoMURXeGRYYXVueGFs?=
 =?utf-8?B?ZUFJUzcxMEFIaEgxRy9CblBnaU5oVTVwVzVQcFBFSkdVOW5yY2V1SmVaRTJm?=
 =?utf-8?B?NmlCYnpYZFJMRVlDK1EvRmpUb3hpVmNGOWF0QjFVd3l1dXY5YWFNTER4eUZG?=
 =?utf-8?B?eTVtK2dNSjRnMFRxK2xUTTRpT3h5dnZpdVNLYmJUUjBJZGU3c2ZzVVpPR3Jp?=
 =?utf-8?B?SnpDSmJLVWowWTVOdE4vbW0vUTkyQnh6MEU5T0NEOWNnTGtYSmNweEthMnNH?=
 =?utf-8?B?VHY2SXk5empOSkdhb0w0UWU5dzNtUWUxU2dsS0RPVDVrQ2FYZ2xxdFdtMG9Z?=
 =?utf-8?B?ZFo1WWw1aHE3YzBoTlNnYXJMeTdOckhXTFlFUHl6SXJ1WXZMSFlxVDlWMWM0?=
 =?utf-8?B?OEE0SEpiWEdxUzRNdHg2NUlobGpaRVQyQzRwaEl2aG5mV3ZIbjgyWEdXUzgy?=
 =?utf-8?B?NXNaYUg2WFF5Y0R1NDlibjA2Z2E3bjV5WTVnWGxybkoxTmFJTElVdkoxcTF5?=
 =?utf-8?B?emNVeWNWV3o4ZDdnWWJEbnBDQUZzOEp2VDVLZHA2Z2FwdW50MFI4SElqS3hL?=
 =?utf-8?B?NFVlSWFyM3pRM0xzY2VnYUFqeEwwaXZkOHhNYWxxVjdVdnZqTjR3K2g0Qms4?=
 =?utf-8?B?SUF1UVplRTkybi9FMTZDdUpLaUR4N21LRmhuaFR0cWVHUmZWN3JUNkhXbWVJ?=
 =?utf-8?B?RWxmWTc1QVcwZ0NidER4eVIzUGVSS25MZGQweU8rRm1ha3ExY2w4V01jT205?=
 =?utf-8?B?UUFpd25XNEJzOU9ZWlNwQ1lUMW5uSUhmSkRjSzNjNy9RODVPRkJIRmVrSzZl?=
 =?utf-8?B?dk50NjBuQXo5a2drMW9qNjk3ZW9QaXVVSEN1d0xjQVIyNUtrM0N1M2k0Nk4z?=
 =?utf-8?B?MEUyNmt2WWlGM3dYcGk5R2lGYmJVdUViK3FRaWtMME9jdG1vZVRpRTlycXhs?=
 =?utf-8?B?U0xWRFJCRThwNG03WFA2bmdWN0FqZHN4TXJ5cjd6ZXo2b1Q4M200R0VyaXFq?=
 =?utf-8?B?WnpqSGlKK3p3WE1SRjc1S1hhRTdLOHNuR2pya09yM3J4VTVzV1JPYkN2MmhS?=
 =?utf-8?B?VTdoV1dPRlhhdEtpOWpFT2VpNTlXTW8xd1Rmdm8rN0o5dWFnKzVJSG9TMHFx?=
 =?utf-8?B?WHBoWlpML3pyRmI0NnJ3R0lzM2tBeGxsZjJqOUo3KzFPOUNDZFAzdnd0QXQx?=
 =?utf-8?B?cU5pMGw2bElxcFllR2dQNkxNaHRCcnVFc2RRanhTOWZkeXkrMG5peDU5SGhG?=
 =?utf-8?B?TUlKOFRsWkV2U2xkbzRMQjByeVNhUWVRbmFBcmNaaXEzOGpTN1NPRGRkdEli?=
 =?utf-8?B?ZXE1cDB0OTVaVE54TUZXbFE5bWpPVUhiYm1McUw4WEM4M2RzT1o3MjBBNGtB?=
 =?utf-8?B?dmY1ZkswbUZzMk14VVdPMjE2K3Q4c0hLS2JBSjkxNThBd0RtTXdqWHc2SGZI?=
 =?utf-8?B?a09hM3ptNzVPOVJBbkJCZy9tdGk1eXBVUEZLM25NNmozM1cvZlFaY3R3Tytw?=
 =?utf-8?B?VDA4OFJjbGpTT0Q4QVFMNUtNeXRJZjJPWlBySlJHQTJQRDNHQWlKNFVxNFlO?=
 =?utf-8?B?N2dnbzdObXR1UFY2eUJaYU5YcjF0ZVRRNlRIK041dzFxVW13YnVwUmVtRHBR?=
 =?utf-8?B?QVlzb3BvRFJsNWRSajg2VG80T0tYVWpCeXVsM0FtMkorVDJwb0k2QnptbXdX?=
 =?utf-8?B?RWxlcEI1Z3JrNWJlQWF1OXZMSFVVbHg4SFA4alpoendhbXl3c1htdWRuVGsr?=
 =?utf-8?B?TTRNKzJwQlNsaHltY2thQ0lDc3ZUVGVwTUxVK1VFMnYvaXo5TFNRdjlPOEpE?=
 =?utf-8?B?cHNTaWhzc3ByUy9OZFlIVktaclNhLzBIL0V1TTE0Q3QvUGo2QjRCOUp0WndR?=
 =?utf-8?B?UmhudEFzQUthNjlMOURDeGFlOFdCRXZ5aUJHUzNxVkw2YnljQ3VEQm9CKzNV?=
 =?utf-8?B?VWJNOEhjNFJtMkRiYmhsMmVHbmJvTkZZUmplY0dXM1dJSHJIWkpKVWNrTDhJ?=
 =?utf-8?B?TGxUZDZMTHZRUlp2czRoZDlDeEJpQlZVRWFsa0FpaUtBcVVrV3ZVUlNJT2Jo?=
 =?utf-8?B?bVNUMTlIeUEybTRBNUkxSTA5ZXNPMlgwMVNReWdMYS9RdFFDYUJTQmhNMFlp?=
 =?utf-8?Q?gqD2LiqB2z6cmQ4QsR/Y1sVonhAKMl0k8dJgCRTSjTdX8?=
X-MS-Exchange-AntiSpam-MessageData-1: BnN7BzgvsvPWytflRCcsSpF0Ro4R97WwwrM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd08f86-4f81-4deb-3744-08de7e0f6943
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:09:39.2352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90LpvrWESBK4fhDES1KebOwfiV7Cy4No3d+43raclu6H0ir2mEn5vjrNOgATdMmKsbYmsAoP7yjHX8OkCYEL8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9841
X-Rspamd-Queue-Id: 30CD723F6C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,rock-chips.com,sntech.de,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-7039-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sntech.de:email,suse.de:email,ffwll.ch:email,rock-chips.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
2.43.0


