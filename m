Return-Path: <linux-can+bounces-7038-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCbTE4Ecr2lIOAIAu9opvQ
	(envelope-from <linux-can+bounces-7038-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:16:17 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ACD23F852
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80F24318974F
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C613FFAC6;
	Mon,  9 Mar 2026 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BQ1b8tFE"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CBB3F0777;
	Mon,  9 Mar 2026 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083387; cv=fail; b=bFRCBEfbOdgpxy4jXwOgWv5cpci4WGu5gJ3O8CRuoodU9D2IFwm6ZW8PtakQrOCIlxxstXEA+pnPDHHY7pklMxisTxLBNg/Cg072DE+HHwRpC8RTgfl944ZUFdH68porTegnSpZQryRQY8NifFZkH+9dyF9x8ZW81nvRpMokO1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083387; c=relaxed/simple;
	bh=A750KnHIxGrfzKYIT2RMRGGFLsWkXENqhlTZ2hJ3ivI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQ7dJ42tEdqB9ttyDv9YumTFE0vZCu27UvT+J+fNjZ+33QvlAEnprm19ZDCNLeXdCyqI8xfrEOO5v7p4JCdna4mAius7xSzkKlBGr1tL9qgt8HIjJwU7Y1Lfq9SvpGOfOhvuK/FWgVtOGL9Tx4RYJbXkJIvVCxMjw94y350Dz/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BQ1b8tFE; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHY1yiC0CmwhdXa9WuNiDEmogzsd//23QvIcF1YE+Yfre1RAbqLzm8NnHZre0LtzLwca1woastQBEP/DdDZbtjTRMQ2rLL5UDaLwgTMEBo6BdrIk412oR/3qhthJXHCU9jSZb3dH9o7VElkNQGpob8wpO7fJfBEiZJR0NnDxfey85IdKKP4TV1sp2VeH/ue8eJu8tdZhMBRh6eOcyX7GDZeIOb0QUtvsU2Cd2L9gdXBCRR+9ByMsbE8u/omk3q1t1SiK5aOJZy5pN+3Wrsm7Hkm1Pij264FVDXedjhGfFKmDy/E5wScrsHTojFOPKUFhvM7tDcjR/trALX8z7yvu0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmS9KBfQea2O+dTupwy5sE9Uj0fLSTJYjZsAJfwOkdg=;
 b=dza4iUTUMJaIBdTJKsNyUr4hikHz5I+fZq+tqoa196OTR3U/wS9lvHZYG3IuxHvi9YqRhN+9KMcnE9+OpxkFR5cnJlSCpdKUvjszG+w7/4PsAYFBmG9WKAm2yBOdJaE+9rsYSshTEMceEuOGtVeSU4xZJTy2fRjzYNAEEcVqfD0MsHdtoOhn+6Q35wh9+BcZ4EuUAAYbyMaaVXITniBf/ksv1jrQqy0bRv0nsyYq43X6KXrIGcF7nQk7+/+zq4uegZ7kOsAQ78TPjuQW/JOc/gwSMadkUxftIZT9r/RpJQBYkz0H0YlCUL8LwQq58wr35imLI7R/JF5hTaD+1ElLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmS9KBfQea2O+dTupwy5sE9Uj0fLSTJYjZsAJfwOkdg=;
 b=BQ1b8tFEfLU6431Qe6MOefdNb+qMjriP4kQLlTrbmxxauw2JxGaUIpYXHNM1C5g4cGtHKnw4d+kBEg1VeiI1VFx15aAmhQXaJZzzO7+ZblbFxYhRuY7b5SaYR1NyUSLq6BgEfNyEQo4kKfWnWV6teleoIjMbvphY1Gk+BImG+RQ85NwfHwlShbTQ+KpxejiAgXDFFKdIlnITuT4YJCA00hBWrN37F3qmKEB+ttsdmUivoVD5MGHzC+61PBySflPEgiI2Cm0ZPmPhuufHUne5hZLFEHxMXp2PMIDIgsyG2vkOWlYpXNoU2NJ+2BHCqMipDYrsWvov909lS846NXbizQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:09:28 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:09:28 +0000
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
Subject: [PATCH v3 phy-next 10/24] drm/rockchip: dw_hdmi: avoid direct dereference of phy->dev.of_node
Date: Mon,  9 Mar 2026 21:08:28 +0200
Message-ID: <20260309190842.927634-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0902CA0044.eurprd09.prod.outlook.com
 (2603:10a6:802:1::33) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eaf30cf-b5b6-4c6c-1e2d-08de7e0f6314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	XYO9VnbvoybktQ4Furv3KSo4w8ZCgs329K9xDBh3mrn3arsSmBVGwfVKixjKlo75ZAag+5143gs3MhdYrToQ2wu6jG9rrikuwqEtujOWTSUPsUuCVrscPVUSW/mS5FyDAU1ypsT3WxfNKjkpUr70SZ9JP2TU5/2QMWhfwu5c/ik10SX2t78SpjQYCt7ueApctsD6YN2gTBPPzUcU5AV8jK6kJtGDBVoCH3fzKIAjxgPgiv9IXxDAXS4mb5IjRCbivL3Tjmo7uoRlhleWXMzCyzwHEvAkmGwGfBxQaIVgVLDatYNqUCtyB1h4nyRtJTwvmg9dDd4c3IRdc3hNkETQfKSfXXa+FLyFQuDhV/W+35cCul8IR7rZFRJzJZv797ifc/k9PJy2ieXivtbs2ZP9UuqKtcDbUgL23elZFYZqRjMqvNUMJSrqpA0xWHHFCAp4mZ9ddEN9hP9gRebIN/87Bi1lX8zUDf4SRWJPiJEk/TP+XOB1U2McLiFj6ik7OiF/+C+Q/8/gb4hoUVVt1CZkSpGSO70f3XG2JgSNdrC6DvOn2lrA00DoIzgjbyH3kiG4+BfT4SQJyQQjVY7xVJKdl7lTi0sOXHrjlT3hgfxQm+1pNZ9i0D0Xy33C1RvGhBVsWoILmig+qvbBl7aoqjTundf9+aVXZ1+bkDdewMMaGfzHv3tVJOUrxmhyjoWCnUo5ANos5osdZ/LFo1ABtHfH2/cmiAGSVCZ9V4LQE6omVWs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0h6WkwxRGZSZmcvSTAzZE14c2swVVFnam5ZNVpxSXVoNE1sbkZFQnNRdExJ?=
 =?utf-8?B?R2pIY0xRSFpxYlJLMDlwYklLdjJjYXhvbmN0OEtlWCtQdHNLampXazRWcG5F?=
 =?utf-8?B?aWd1T0ZtTGZ0em1nRWtjdWhMcGd3ZXNWODExdFg4bmkxWVVIQ3pweXVhQ3M1?=
 =?utf-8?B?THFCckQ3VjFIUEJJZzNvZVlrM2hkbUFzU2Vxa0RQazN4aGh3QnlpRDRQaUVi?=
 =?utf-8?B?NE12YlF0elFLYkxGZmNubmM2UHhFdGdyNUU2NEREY2lMRyt1UmthdFIyN2k5?=
 =?utf-8?B?Y0hxR3ZnVFVteGJWTllVVWtidWU2ODgrdUwyQlFqN0h0aXV1REZ2bFBoOWMz?=
 =?utf-8?B?SDJWekw3cVU1ekxMU3pIWFJWdHcraGtmYm11WHlQQkN1cU1hdVhBYWRwaVBC?=
 =?utf-8?B?SEhEWlVkYThCRTEvQXpFUXNrTi9pTklFQ0RUUGE2dzk0WndxN1l4VjBMZnFR?=
 =?utf-8?B?Q1M4K2ljb1k4VlI5aW40Ui9hanMrdTd6b1J3NHRHSlBmeStMWWplR1cvMUZx?=
 =?utf-8?B?Z3AvM0ljeFd1eEtUUkROWHNpVzFqdS96UzlqS0JJUVpDYmQyWG5oeThuV255?=
 =?utf-8?B?SjNOQUFtaXc3NGRKMEZaVXA3M3hpT0hOWDRTOXp6TCtaWUNCRkJCdkQvYjhM?=
 =?utf-8?B?NDVWeW1sRmZPdit1d3BydDJMUkZ2U0Iyb0NHS0pzVmk0L0t6WVlsOG1YdTNE?=
 =?utf-8?B?MW8vMEVpUy8xOExLbCtKY0thZElzOXhRSk1iNWN3TUNHTlVRUlpXWExsdDlp?=
 =?utf-8?B?NzVYRndUSTRiMzhya3cvZlQydDhjSUlXZ3FEODdNZExQWmFWZTdyZDlGMFlv?=
 =?utf-8?B?YnREL1U5T2RSK0MyT3J1REtGcHBhZS9BK2lCR0ZzQk5QcE02dzA2WEZUNFJC?=
 =?utf-8?B?UkxBZENpSk1qWWErR0lsYVJ4N2xpSG90dEM5Y041b1lKcU4vdEN4RlJtVEtN?=
 =?utf-8?B?Z1VlMDZWdHVMcmJ5RGx6WndnK3QyMEpYamN4T2dvUzBJZkhLM2krRFh1cVR0?=
 =?utf-8?B?dTFOb0VKb3N5WTdiZkg3cEtDYi9TSXBlMm1HSXd4bFlTUmFiZWp0dmx5d3JO?=
 =?utf-8?B?L1dFdmNsTGZlTThsYkNxNHF4d2dEaVJROFlJVVEwRVBHdEFtaDFzbXhGR2Q3?=
 =?utf-8?B?d29hbllIOW1EeXgwTHVzVlBoWU1BSTVkTnhaRlFmU2hod1crRmNtWW9kY0p5?=
 =?utf-8?B?ejRZSzF2TlBpQ1JXcnl6Q3VkSVNkVnh6a0M1K0NtTXBCSVA3NEtweFBMVE5Z?=
 =?utf-8?B?QjB5OXhCa1FlMzB2d2toTUJwVmdVZTMwZHJLbG5BVDFtSzl4TGYyUytjL3Bj?=
 =?utf-8?B?dnFueDIrdUxlUkp1a2FNWlVZbDQ1Vlg2SkoxYmg4SlhVaGpOcWEwTkNSYmti?=
 =?utf-8?B?L3oyYXJiRXhYTXd2TmtISFg0M0k1NThZeDFvK2dSa3FwZVdMUTE4Z3R3NU5o?=
 =?utf-8?B?OVFDYWFvT205K1BoSzFPVW5DK0VZRjJyNlMyRUZreUZHeGdJSW5tSDV4cldz?=
 =?utf-8?B?SVNLTmNrSldEWG1vUzJoUmNSYU9aaVBIcXBDSjNQZGppWDh4SXMxNWRXVUhF?=
 =?utf-8?B?dEQ5MkdtS2xzRTVvV1pqR0Z3bHN2VmRkR3FoQjhMeUdFSXFNcU5zZ20rYUkv?=
 =?utf-8?B?d3lkUEl3UllUN3J6YkxYRTBmVHRteEFKRnJRd2ZMWHVaMVhxTDU2NWlIU3V1?=
 =?utf-8?B?eTBvR1NMeStzaFBUVFhLQTc5TGcyak0wekNMTllBeHY1MXdhV0c0c0RwUmtx?=
 =?utf-8?B?SERreVJaaXNVT29KVmtHNzQ1YldRa1laZCszN1ZrSnVVRENaaHNMYTB6NjdM?=
 =?utf-8?B?RnpteUErYWoxZTRQOU5FOWV3dEJjM3J2bjQ3NUxqcWVaWDRGb3g3R0NkRjI4?=
 =?utf-8?B?SUtyVFVYVUN0WHB2V0k3bFk5eDZ5bGpWd1dieWlXQzJKTnhuMEhLZEhtVWt2?=
 =?utf-8?B?YmREMTh0dWE0SnJsNzZTU3BEbHdRMUlTeHpRa01IRzRmeVhZWEpJemt4ZDBE?=
 =?utf-8?B?aEk3UEkvN1hSYzhYcjBYQ3RzSTI3ZlEwajlPMS8ydXd6Tm1XdEVxOXVjLzJ4?=
 =?utf-8?B?SGZ1ZDRhR2p3dXZnVDcwZDRMU1d6bEhISFg1YzZhUVNQOFo4dm1PSW00NWgw?=
 =?utf-8?B?ZlB5R2tjbk9ZNGlLOVhpZVN2c3FJdXdqWmFGQmVsZ1l3UnJhQnRESGNhcUxJ?=
 =?utf-8?B?c2R4eE5CYm1IYXJHaGlSNFl3QVJtRTlLZ2hqTXZWazBidWQ3V21Zb3ljTmNP?=
 =?utf-8?B?Wkh6UFp2K3IwRHVWOVZzeUM1VmJQTjJRN29JS1VuME5hcHBPenhJVEk5NXRt?=
 =?utf-8?B?d0lIY2tyKzlZZmFWQ0lDdjVyalN1WXdJSnJqMVBETXNHQUVNVDh0d2RpSjlL?=
 =?utf-8?Q?CY4fWFVtXH8Pz3W/aNlLz687hFitI4o6tGVTKV1x9WznX?=
X-MS-Exchange-AntiSpam-MessageData-1: B4WtVxcUn2ZezDiKFmgw+vaRgmX+FQXlkRI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eaf30cf-b5b6-4c6c-1e2d-08de7e0f6314
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:09:28.6058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+pr+dnsQgG25StZQZZgiJZmjDw7G1CWNvAriUxqHPqHLvpslWNNeH7D9XxAsqYvvW03qr7hxylJO/wquDxR2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540
X-Rspamd-Queue-Id: A2ACD23F852
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,rock-chips.com,sntech.de,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-7038-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rock-chips.com:email,intel.com:email,clkspec.np:url,ffwll.ch:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,sntech.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Action: no action

The dw_hdmi-rockchip driver validates pixel clock rates against the
HDMI PHY's internal clock provider on certain SoCs like RK3328.
This is currently achieved by dereferencing hdmi->phy->dev.of_node
to obtain the provider node, which violates the Generic PHY API's
encapsulation (the goal is for struct phy to be an opaque pointer).

Refactor dw_hdmi_rockchip_bind() to perform a manual phandle lookup
on the "hdmi" PHY index within the controller's DT node. This provides
a parallel path to the clock provider's OF node without relying on the
internal structure of the struct phy handle.

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

v1->v3: none
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 25 ++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 0dc1eb5d2ae3..7abb42e486c0 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -537,21 +537,22 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 				 void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *np = dev_of_node(dev);
 	struct dw_hdmi_plat_data *plat_data;
 	const struct of_device_id *match;
 	struct drm_device *drm = data;
 	struct drm_encoder *encoder;
 	struct rockchip_hdmi *hdmi;
-	int ret;
+	int ret, index;
 
-	if (!pdev->dev.of_node)
+	if (!np)
 		return -ENODEV;
 
 	hdmi = devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);
 	if (!hdmi)
 		return -ENOMEM;
 
-	match = of_match_node(dw_hdmi_rockchip_dt_ids, pdev->dev.of_node);
+	match = of_match_node(dw_hdmi_rockchip_dt_ids, np);
 	plat_data = devm_kmemdup(&pdev->dev, match->data,
 					     sizeof(*plat_data), GFP_KERNEL);
 	if (!plat_data)
@@ -564,9 +565,9 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	plat_data->priv_data = hdmi;
 	encoder = &hdmi->encoder.encoder;
 
-	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
+	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, np);
 	rockchip_drm_encoder_set_crtc_endpoint_id(&hdmi->encoder,
-						  dev->of_node, 0, 0);
+						  np, 0, 0);
 
 	/*
 	 * If we failed to find the CRTC(s) which this encoder is
@@ -588,13 +589,17 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		return dev_err_probe(hdmi->dev, ret, "failed to get phy\n");
 	}
 
-	if (hdmi->phy) {
+	index = of_property_match_string(np, "phy-names", "hdmi");
+	if (index >= 0) {
 		struct of_phandle_args clkspec;
 
-		clkspec.np = hdmi->phy->dev.of_node;
-		hdmi->hdmiphy_clk = of_clk_get_from_provider(&clkspec);
-		if (IS_ERR(hdmi->hdmiphy_clk))
-			hdmi->hdmiphy_clk = NULL;
+		if (!of_parse_phandle_with_args(np, "phys", "#phy-cells", index,
+						&clkspec)) {
+			hdmi->hdmiphy_clk = of_clk_get_from_provider(&clkspec);
+			of_node_put(clkspec.np);
+			if (IS_ERR(hdmi->hdmiphy_clk))
+				hdmi->hdmiphy_clk = NULL;
+		}
 	}
 
 	if (hdmi->chip_data == &rk3568_chip_data) {
-- 
2.43.0


