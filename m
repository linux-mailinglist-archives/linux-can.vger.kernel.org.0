Return-Path: <linux-can+bounces-7116-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDXlDGHguWk7PAIAu9opvQ
	(envelope-from <linux-can+bounces-7116-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:14:41 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD402B3FFD
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 853003189201
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A6D450F2;
	Tue, 17 Mar 2026 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ehyIrMs7"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22EF3FB078;
	Tue, 17 Mar 2026 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788762; cv=fail; b=jcULZzEwJ7TsiqZQ9bE/cXPMLhXW4nR7d9h66/cMGGcC8r+bq+6VUD9ddATFbAI7MEaZCOpD1EGS079lT6tD/rCK63/OKhBR7Gk7xf0KWPXSgMJBRFsLphNKw6t5MAhwMedHlrUcdYVIyIWkXi1OsviGcLT4U8IglJ6/+jBSuLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788762; c=relaxed/simple;
	bh=5aExXgFv55g18QX+rkGe6ixdhzhxuOX1bpX6lOy5cP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uzSnVfqV6FJ5kWtYUNuMmAgphjBRhCdUC44juwJMvxneRQ8ay4ucl9VNW+wRuipktmcnoc/3+je7F9934sObjvHBsn09K+ZjQd2n3Llb7uPH8AGkQH0AhwxkzccHzYr5BtLLXGS1i5cYfMU3M4pG/cchU8qTQNL/2agirSjhTaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ehyIrMs7; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abUj6e4W32qWSdYv+AEivS9klO3so+tNbC6XOZLp8NVbDnGhbAIdHXd+Zt7Y9hONWUHMaZCsHaxSsxrlbp2pY9FtJxs8Uy3VA98t44pGWEUyInBqGB3KuDqOLDLm26t9EuQQhQYMJQfPS+Tt6kpT9j/4Q9KVusoePjeXf/I0oloRnlCeggbv1khLLfJ5wjEWA59Q5VGoGQAkm7ZVbXU/vgBWyq964/L5qJMf9uchF0kIEqHeEU/zVT0zA43QPJhkXVUyUllOPB+JumtrJX6cqTu8vE0tAT6Jdjawfv+iTz3aBzDBi0Wd8y6JmNyufAcce9vjY5FQXiOl5S09b669CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoVZVBTZ7dBWIHOoGBbqy/52z4K4Sqh5AuYCoWy/lmM=;
 b=aqiu7VGhIS3446b3w7WIJ9w1yR1NVljh41p6qr5YdwOBYYn2Y2kP6Lq4cHFWlVXaebJM0q1g7/74SRgf3K8hajRoimigViy0fVndjfKPQb+0vphQvlP7zK89vuEGQJRstprCp0BMOat1mi2Guz2HZdH8BNRwexS4pEEcZj7M3hYy5ktwD7PLD0joHa9bSCYRykZaY3Je2I4+UkFNfehfFmlFV8GicxHbxd+qhpscydFEbyz8rN0v35kY4Rrb56G3YR2yjfLkn/yixEy8AneLQ/Wq8q+Y8qRNVoiFMGcph4vgEgtyNkRAtpzGGoQwbpWiECIhH+rbBDwMYQbpEXEczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoVZVBTZ7dBWIHOoGBbqy/52z4K4Sqh5AuYCoWy/lmM=;
 b=ehyIrMs7Fvtt3GhaJj4oBu+EHiS9BLvru9vVqwuBYcaCOY0AUYvGD6B2SDRbdrOLYFh9LAMxs40GHM30PL6r/t8Yxny7e7wLUT3lqTnlqMQ/xMfu34Sv4EQcjMfMLI6D0NfQZNYo7JNf6Ew8Kz270tMUSRsmcWOHFIYkR2/tBbH99xcEQpAWb80/QVjH9nXl6Xl7GurGFd4DBTKmKq31v94/KD43eOhQt8yipAy6e0ef69Ey9/qn/Iz9xIeo61RtFro64oDG7ziqFrZm6Fz3xgBxR29G6IibTIEIxWI16grDYtX9kvVSrod8gcotLDaiipBP53u+8115E6hVP8uY/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBBPR04MB7643.eurprd04.prod.outlook.com (2603:10a6:10:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:41 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:41 +0000
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
Subject: [PATCH v4 phy-next 15/24] drm/rockchip: dsi: include PHY provider header
Date: Wed, 18 Mar 2026 01:04:51 +0200
Message-ID: <20260317230500.2056077-16-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::12) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBBPR04MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a1114e-08ea-496e-8161-08de8479b5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GavIaAF+d3Y/BOpp2vg98v4XPWEuHrccRPFHpwv1nx73AGRZ5aiGne+2LtF07ToB9z8mTeYuQier/FDyXzGRnunvlWPzoAy5xhOdv2qAAyPVJX/oqIvvRmcHwIsC/X8FZodPc4SPWCfNcM5QEV8VTy54iCqcMVM4y1jt5Osln8TKQ+bvPpfdr7UqfqOcidcMra0p4nd5IUX1TKk+PuumcL+4PZCe8eQ/lZNq/olAB8K/id6KeylXyi8iVa7ZNanFiD1Q5fWyGoDfe4laH64RlCky2widHJIT+SPPGwAVNuNg7kXSlhAYhGiG8sb9J3QJvPamUYsweO2fJCJMxbsgRFuqIgIJ+h+xwrmAt/UqTdaG4FU7Sk9x3IR5jYLgBUuvpVuWC/zH6yIjzFo14gEpB+AW7k6iSdmAzFSJkWQNvR8NmljLokkKVsU9MnVEa7DCs+kMbBcCog2+ElLFJLjrOdAJhMe6aG9M8lqVroFCNYDIJDWYI3Zmjwz9DU4OyaLz9fX4fwlSvRyNeQ9RTDXBFEqcNzjC2+PpR7Qiso+8rDUSAVsl5I9IQMIaMlWj8BYyGXsPWt2M88LpH/mu18XVyPanS/eEZwxkbVmpG2TBsqab2c3cv7eCsClm16wPS48/VtJlcgkJ+6jGCHKG4jd8/IfFE0MS9DJ1sJLJidjgxIJwDd1qUVk9/SrXSdQFeQI4Sd+a0SRWayXe5RSE5A3rPjh3WZ9E1yUt0ZCsZY0iWbc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2ZTZ0l0L1YxdlJXdDgzVk5RSUZSS09oWnJNdGRURkpqN1dGT3lCSUVKKzdC?=
 =?utf-8?B?UGNRUXBiaTlGOWJJb2R4QXBPaGNkSFhXWFVqZWhpNFUvZnlOM0tnZEo4akUw?=
 =?utf-8?B?Mjl2UlJYUlBSNUUrd0pBNnB3UGd1YUdHUGxSTi8xMzVaSW1FY0E3VSs4MFFW?=
 =?utf-8?B?UEFxR0pycDlCZVI1anoycXdsQnE2dDRLTnVvTTk1Mk1EWE9sMDJ4UHdLbllM?=
 =?utf-8?B?TGhXNWhoczFKRThkSjZoQkwzYnp0bXErNjVXOE5KR0tVSGNVT1FoRktCY0FV?=
 =?utf-8?B?QmtPVEFIRnhCSzJBREFzUzYybHlDVDdZQ1pVeVJDcVB3djNsa3JIV3Y1NHZS?=
 =?utf-8?B?TTMrVWdIRUxEQVdDWXNYQXEwYkxSd2EyMS93cjhVVndUZlhZS0ZNTWJPdXFk?=
 =?utf-8?B?N3RvS3R3SmRYWXlDVmVhakJCYVNGWXcwYjdzYXVnQ28rNXhiNjFJNDZXZWFT?=
 =?utf-8?B?SDRINk5HdW92WkRiRXU1Wko4aWxUazNiL2RTeVowQUxDOStMQWVrcWVoL29a?=
 =?utf-8?B?QTRodFpEU3d5UkZ5anFRMTJzUXBnbkVXZmcyTWFKK2F0NzBGeDFSNEJpMlM4?=
 =?utf-8?B?dXFrWXVNWlc2L1l1dlEvb3RTckdnV0ZIb2NHWG12Um1kOE5IU2ovRnRrYlpP?=
 =?utf-8?B?TWZJRlJwMytWMXZpayt2eHhFYS9SeVhibFRGbjBhQlNSVEthL0hFUHY3Z1Ar?=
 =?utf-8?B?WVBTUit4YWNoMS8rZ1B5bFU3SndIRDUrOUZJQzJ1R0JJMGszRlY0NjF4bmVk?=
 =?utf-8?B?cWF2QjRZQ1VuWkZYTWlOVEFOVnUxcnZGMFlHdGdlR0xuMW5nU1NsL2JXV2Nk?=
 =?utf-8?B?a2pCR1E3NUtUYXkxcmVrbU1JVUtxY2hVYklOamh1ZXNhdEZ0NXVsNE0wT0dS?=
 =?utf-8?B?V2FCeEMzQjBjbEMxTWlodWFTQXdkWTBHYU0zbi82OVh6UWZiOGR4d21ac3dp?=
 =?utf-8?B?SU5yOFFVSEdNZHEvcWlIbzF1L1hTQ1ZiYVhYOHZhVy9NZzNHeWQ3aEsySk5S?=
 =?utf-8?B?c3huYUxuN2J2aSttWEUwYjVTeWNubkFaMFVUVHQxRTRFTlBBeFh6eFl3cGF2?=
 =?utf-8?B?YjFXbEI0Rm96VEFPbVNRNEdlL1F5Z0N2Ri84ME5YUG1zbEJiRXltbWdSeVN5?=
 =?utf-8?B?VzNZUE5NSG1nc01BK2g0RTdLUXdNMkRkRFM0TWVsaW9aVFhqRUpZd29yS2c1?=
 =?utf-8?B?VlNZdDhteEVZVFVLZHJ1NHpiVVFQUTNLOGMveGtPRndyWFhheUdrckg2Vzd5?=
 =?utf-8?B?eGF5UkZ4YTYxNnI1NU5BeExOSHhhZEVmNGUzRnNYeWk0ZXoxNkdkQU1xUTlW?=
 =?utf-8?B?c0NrdlFtdjNGZFZwbVRqaTFWWWU4TUpXaVV5bDg1a1ZBa1V0QkxRRDI5NWVO?=
 =?utf-8?B?NFJ5WFE5cFIzaTl2eUlFZVFQb29hY3VvdGhOdWRZQVN1bjBISWZXdzV5VjFv?=
 =?utf-8?B?ZVRtNkdaVGQ3eUJDa0NvYWVkb0xMWWNhdWhBeWRrbWFkTVF4WXJoTHBublYw?=
 =?utf-8?B?UHJhSDA3TWg1MDE5S1RoTkJaNFlKYkxRUCtraVcxM2pmQlJldDJEV3g2VXN0?=
 =?utf-8?B?RFE1M3lZek9GbmpFK1ZxZFJ1Y0dmVjkxeVJGYXJZczJGazM5dzVka1FFUjZ3?=
 =?utf-8?B?QWNUMUZxVWpuTk44YVh6YloreUdXSjRuOVo1cVBmc1pQakhrUHdDN0RYL09r?=
 =?utf-8?B?aWtuY3d1c3N3L0JSbyt4aWczU3NVNXlTYUpJNFo5UitoTmRJRkVVak1VWW5r?=
 =?utf-8?B?WThLSzY3U1dKWjIrVU1jTHZTMzAwSVgrS0hWQld5eHJpWU9QeUpJMU5SRDNR?=
 =?utf-8?B?dEpzcjY0Y0UzVUZTVC9NQVF5ZEtsNEZyZjRRbHdaY1FhMnNEbXlpSnVOOFR3?=
 =?utf-8?B?LzFYS0IzbVhMZGtzV2xBa2xiQitaTFcyYmlhb2dVR1NGTlBDbkkyRmF5czRC?=
 =?utf-8?B?TTVQeFhkeCs0d25IWmsvUzgwV0Z1eUV1Q3g1U1NSQWNPaUo5RkRzRTd6NWo0?=
 =?utf-8?B?WlZsdUhhVHNXY2YzNkVON0t5VDM5OXFrbGJiMXRWM0Z0WHVsRDZ6bVRDNjh6?=
 =?utf-8?B?WHBqKzh6ZjR1R2JNTGV3cHZ1ZmdDSWJESEUxTXdmT2pDVVdBY1BzRHNXRitM?=
 =?utf-8?B?S2thT1Z6SjF3SEJ2U2tVV0pZZ0IzZ2U4U2hGejRQS21OVGN1QUJaVUgwSE9H?=
 =?utf-8?B?TEx0ZGVIVGh1OE4vS2tvOTRoMjROSDBsbjhVYW9mRzJPeC9NRlMyYmFrK0px?=
 =?utf-8?B?eEhaMnBPVlNRaFlXWkxuTXBnWm1zSktrTTNSRnNBVzNFTGg2dnpmeGVKMjh4?=
 =?utf-8?B?UTBQejZ0Q0FGcnNWRlBtWnFKYnhaWDJNQVYzeGVReXl4cmVYN2JyemdsZXJ5?=
 =?utf-8?Q?EiZ0dWYGKDG0ucczuR+dn/+GpYpyWgvXZkJEcv1KC+6am?=
X-MS-Exchange-AntiSpam-MessageData-1: Jwqj/DWS5knkTg09n7izZG8plZp0slxhvqw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a1114e-08ea-496e-8161-08de8479b5e2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:41.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5fuEuJP8x7pRVTChOAIAcoM23DwB49+52lc/f8UtBIw4B68Y5EW0QOaJySw3ayZexu/pcrUhOFs2jUOExXz/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7643
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,rock-chips.com,sntech.de,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-7116-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,suse.de:email,rock-chips.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ffwll.ch:email,sntech.de:email]
X-Rspamd-Queue-Id: 8DD402B3FFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v3->v4: none
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


