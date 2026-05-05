Return-Path: <linux-can+bounces-7504-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPw9CFfE+WmxDQMAu9opvQ
	(envelope-from <linux-can+bounces-7504-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:20:07 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E4A4CAF3E
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FF7031B2CFC
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FE0425CE3;
	Tue,  5 May 2026 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mWqKXI4I"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB440B6DC;
	Tue,  5 May 2026 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975584; cv=fail; b=Zg1/jEnMv5VlDnmeQtL2WPTmnwSPYflVQut4RCUoYkUQhYdL4VUeGm22+IaFQrLmNjE2hXscyrFsx4MvBb58srZKyVSWAGK2ah7K2GCCBM2ZGuio/4YszCEW64NtP0/BhEQV2lyh7DM42IkJHnCZ+CX08RqfnwyJ0FyXe0Dy9a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975584; c=relaxed/simple;
	bh=WnGfCsYXelYE4uk5S9Q8SDA3ZV3VHra4flbS3FpzxxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ulFTLQCGbumtm0VE5Fm+Dvl+szpemiGrgluM1y2gMpzDlM/lgdiOezMd53nVkQWvkyFL+XbX2gSjGrt30qdbx9p9skYZ/C9jz16ahoCUxHyTYqXsF26hzSuW/pcSZS5GtXqjoJ3150yHU1q7BcA7zfVO77gGspc/oCJsMbi707g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mWqKXI4I; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcQFGQpzZ/GzkOX0Ok1zah9S2bL1las+yCy2cSLtwZ7rFEkh29EW7olbCtrcLxnH7vGyIufxvL6BBYhKxgHIZSC1ZUqPR18Wg5URXeRCUmdZNVK3xsxQ9/KoWdXEzWTwYdUiHafoAwFLZk3tTqi4K6jIcZxEuZiF8ORCWcLLlfNQHZhO5vUVKoNdhqFOsfXWlRHMn2Yu2vCgrtvHVHcyVcpF+2S9HEZRBlFxPDP2TMQn362zdeHAvPLOicOPYI17lJN8TaqkKc0dxOfm6uH9MfEpxIXBjqVDBiZskBiflq3oJksimxpqnrKuzQCT0a/TWCvSmF0btKHacNQKJvF5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weEL2i1hxJGgS7vYKMcDgw10jYGVvvghvREqdK1mtnw=;
 b=VDj0/wpsiGj/jrf3prqjc73KlNj+i0169+7/fhKcBAlhd1ZBZQ/kwbN5v2qSsdFluKz1t61AdPfmv/4aWjZdDsPRi8Af5Fasm8GCNn+A4hntNa1y3WMrC9OvorSeASvFANMiUQJuF7z+WsRKPCH8CWlDhFUgqW21fsZyWgdRAYhph6HgCqTuiQMf/iGhBo3IDBLsDZzgsm4xdI8xbyW97fVOE1NZxnb9OwYP9FXEdXbI/wirzNjAPj9I1NI2+6CKOxPJaFVxXQet5yOH9sB1juOME+0xL7CJ89lx+Fp1taXpe62G6x7DiStnHlruYQusR5DcyzBN2Fz7mhUxcNSWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weEL2i1hxJGgS7vYKMcDgw10jYGVvvghvREqdK1mtnw=;
 b=mWqKXI4IEyGl6jFikGfGK+Y4z0flmVn3hQTps4magKszUXNbO9idM1qdw2xWZzdW7baCIMtV19E5LF4WHJ8oI9kwhq22wnPfmjZKjBUbgZPTcDM4EGmECV/hOT359O36rA8ngxp7tyjopcuy7jZe1a/1nS3SnIwofcY96UmfUs2uqdIk0vdPNcKyjklCGOPFops57kYQ42mQpffOHOMQNIV0DKWdVl+PIxVjiGR7kJ3LQBdNotO1WFy9RhDRrc8U1MBs8AmvSc/rDUTGXRJcnY72vyBt8FqA67HyvmYdkp6ifnhMjGLumWcH3pjWhdP69gqcupjah2+JjAq858QJyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:06:11 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:09 +0000
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
	Heiko Stueber <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v8 phy-next 15/31] drm/rockchip: dw_hdmi: avoid direct dereference of phy->dev.of_node
Date: Tue,  5 May 2026 13:05:07 +0300
Message-Id: <20260505100523.1922388-16-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 870da5f8-44a6-4f9d-d93c-08deaa8dedb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	u0NM0OmiL2uEkl0JKrW/x8bqQIGgXTfgEFALncSozU/TOAOriN30VcpKhecBk4/86NEUZXHNf02VMpgYkYA1Yor0qiqK0s2Z2+fsbbSPmNYg4QM5Ni6MbTCQBHKaO3IuWFuowP8VOCqQw3nWGtf7Ci42G+UiOplO8zHmF/Va7pbc/fUcoGU+83o4BDF25P+hmo594wAexusZZmj9htlxIYhndnPMm97Ks5Kh0FwW3e9Kqt2FjesdbcSpI4cM6/fvmWnYoQSCZFUfNZkjbQyN1zIqxj3n+jvLKktIMGXIKzLp7jxXjnmid4uxrsIpFWO6I1rNmBXTBmc3PU1Ro2O3LwRp++/EJKWITADcprBpxGFaC2ORcByTdWsdPrym2wef582M69z6lZ0TswkewyT1N653mRS2TjCFpEmyjUw+om1o0lTX2lLRe3cycctP/rHtu76NzSS+NUDKMbLyWV208PMHlB214vrwz7XNOt4+qfFnwlufNH++bUqQzhleJ8m6vr5LdLHoQbeFfhcRJcUyJdjNJwd5f26rft3QgfWs8hn4Z34M3hK13+duTG6C6gbWI4LesfJlHRDp4lTdxdFWFaPUvKSA6iJ9KkEyyEFKB+0Ret6maRuZ26pcoi534f6IbGq9flca6S2USh65h3xQfKA/q1G9tuQzPKua/m6Kv2jEoH9v+lHA0/br15dn1zOl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck5VelJPVFpydzcybTc3S0xGQmxQRjdFbExjSk95cktKL2dmblVNTkpoZVFo?=
 =?utf-8?B?RWVObWNsQmU4akNtOUJwQmNmMWdqSkRhZWFBN3VZU2VmUlVlL0xIODlWdlY5?=
 =?utf-8?B?UDVEUk1VWnAvd09FdWZxQS9VWCtzbGVkeWRKdlhiZEF1TVJaWU80djVUaGRj?=
 =?utf-8?B?eXVmeW1YRzF1QmRsOU9jMll6Qm9lU0JYcWVXNTVNajVzait4T0wxdkZKOFVK?=
 =?utf-8?B?SERaMjBNTVlVc3RyQkZLb2Vmd1FTM3k3QUFjc0laY2VJT0pGV2g3R3pQc3VP?=
 =?utf-8?B?eHMvOGNTYi8zbE5ZR1k4SlVmNGFHdWlta0cwODdSWGdEUmpzRDM0SGF6MHYr?=
 =?utf-8?B?eVMzdDg4R3JmVlJ6YTJ1WU92MkJRVVowUFgxYnd0NEJiZ2lnZTkxMDl2VFN5?=
 =?utf-8?B?VlJSVzZGcE9Xb25uNmpqU2VTeXhBZGpDZDFBb1F0MzlrSUtxaWR4UmVFcFVT?=
 =?utf-8?B?Y1lESzZhdnVkbk1XNWordFVkV3JWc3hmMWdZRVlmTVllazA2UDRoQ2JUajVv?=
 =?utf-8?B?ZEJPSUs2eVNqNjIxL0dUbWVHWnNqZUtSc05ldVZVVTdLMVluRGtFeFl5dlFw?=
 =?utf-8?B?djJPQlM2SzBubmV3aDk2SHpWT3JyWkRrM0ZvSGhxc3U3Y0FOb3hTMTBuKzZJ?=
 =?utf-8?B?dEtRTXZYaC9HT1JyNVkxYjlNTW9tS3N0aE4yUzM0MXp0cmhTYytzcHlMTkFL?=
 =?utf-8?B?a0F6SnpIb0FEc0VHeFY5RWZSU2QzdFF6YnZpemcwT3NRTVl0L3p2Q1JRT0ZL?=
 =?utf-8?B?UFcwV3BlRTc1NVprMmREcUJCVGYxMVJwWUVrWDhDNWQzbzlaZFkrQi95ZEFV?=
 =?utf-8?B?ZDVtVFdsK0dwUG9OY1RKWFNNL1Arck5yM2g0dEdFZktUSXVQT3VOS3hlb1N4?=
 =?utf-8?B?OUsxUHBFdUZSTjFPbGxoVzI0Wm1ZR09POHZmbko1NG0yTkljUmVhUVFnWUFr?=
 =?utf-8?B?b2lxNzJtWUs4cmg4YmkyQ0U3eHpvTEUzQzluT0EyUE1QQWlxaThLeFppQzRI?=
 =?utf-8?B?K09RWXN2U2M0eU0rNWIzazF0TGZXd3lmcml3amN4YVh5STFqYmVyQlVQUGZj?=
 =?utf-8?B?eWlwTXZkOFFGeE1TOHpzb0dhdGJqSXZjdVhXWUtwUSsxdmV1OE1TV000ZFR1?=
 =?utf-8?B?ZUdBVzBKcTBNZkVFczgwbzJJUmZnWW9POGhmZWlPNXVoRUg4eE1GU0RGdS9G?=
 =?utf-8?B?cS8zTWU0V0tMaUY0UjBlSmV3YmtldldLeGtmSTFnaCtOWlkyeC91RTFORjdG?=
 =?utf-8?B?bUZVNVhqYkVCbDYvME9qQXdBSXlUamhFOERKNi9zWVVWVmRLRzZscFpNN0Mr?=
 =?utf-8?B?bVp2NGJoODl4QThqWWVRODhERGZtcVlRak43RWlLMTlmcFRYTEJGQ25PNFB2?=
 =?utf-8?B?WlBSOThkT3hHMmFuTFlJUTRKa3lYd1hlbUxMSFhWNURDZENmcHljM2p4M2Rx?=
 =?utf-8?B?VGtycUEwcmxJQVNON2tuVWhlR0JvazlMMDFHZHI0UXhTdngzeFkvN2Y1bm5X?=
 =?utf-8?B?VEhKcFRYVlZmT2U1eTZ0VGxQcUt3RFRXdWl2U09KUVN0L3hxeVJ2WFB6QlRq?=
 =?utf-8?B?bWJmU0N3ZWRBNkVhRXJlUzJrSVpadTZqREQvYUFLM2RINWk0UmV1TVI4TVBQ?=
 =?utf-8?B?TGE4SmJ4UC9sTVhMUThxVE9BemZJcVlRNjJsakhxekp1TE11Nzg3QzNuS0Fy?=
 =?utf-8?B?bjkvcitXeEsvQlROUFIzNUZkU05kQlp1c0ZZUjhYVkZzUUlraXRXSWxOVUtT?=
 =?utf-8?B?bVlaMW53cXY2ZWkwZU1WcDRDUExDVW1YYnhUUDRzdWVKUDA0ZWEzU0paUFAz?=
 =?utf-8?B?ZmFqQ0hGNXRZeHh6eFRnUUFSUzBhU0RwOXhyam92ZEVxRG10QXF4N2Y0OWM1?=
 =?utf-8?B?YWNOOUZsYXNDQitvL3dMSVVNdE04MlZodnNJejNJMDl6RHNqZTdZR2UydnhV?=
 =?utf-8?B?YXRYbXNKSWIwSytuWnVRZ3BsUXdkaW0wdk9HSm1YSHdmZzVYL2FjMWc2djBT?=
 =?utf-8?B?VzlVOVk0ajNNc1hVK0lkd01ic1Nuc0N1dndKTGo4aWpmdmY2WCtGemRpd0lX?=
 =?utf-8?B?NitBeXJMd0FDdGdqNE56b2lYM3JrVStUeEdJVGcrR3ZGOXI3emZqbi9sSFp2?=
 =?utf-8?B?OU1sNEVVYjdqV21VMzFZRjUyQityWk0ya1J0MDNuM0NuUDdQL01TT01TU2Uz?=
 =?utf-8?B?TW5adFBIZ3VvYmJueXhNeDZ2cFZMdG0wQzUxcWJWTHFvWFVwa0dKMDFLZHJo?=
 =?utf-8?B?RU5waHFSMmJWdVEwVHhBTG5vMk4wa2ZsZVFKVlVwZDdENUhnUHgvUE16b0lN?=
 =?utf-8?B?dm1XSC9VYmN0akhhT0NuWG9kbXJxamZucDJZaTRVaXlOMSs5SlV2QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870da5f8-44a6-4f9d-d93c-08deaa8dedb2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:09.0236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VE54NA+2Sy1ZKD9hVo3xgupbnUsTDWezPvbMNAUlnvYb17QEvxjZy9qAFjmznGYEaikADoW2u7+/y+k2q1SZlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: C7E4A4CAF3E
X-Rspamd-Action: no action
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
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,sntech.de,rock-chips.com,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-7504-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[clkspec.np:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,nxp.com:email,nxp.com:dkim,nxp.com:mid]

The dw_hdmi-rockchip driver validates pixel clock rates against the
HDMI PHY's internal clock provider on certain SoCs like RK3328.
This is currently achieved by dereferencing hdmi->phy->dev.of_node
to obtain the provider node, which violates the Generic PHY API's
encapsulation (the goal is for struct phy to be an opaque pointer
with a hidden definition, to be interacted with only using API
functions or NULL pointer checks, for the case where optional variants
of phy_get() did not find a PHY).

Refactor dw_hdmi_rockchip_bind() to perform a manual phandle lookup
on the "hdmi" PHY index within the controller's DT node. This provides
a parallel path to the clock provider's OF node without relying on the
internal structure of the struct phy handle.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Heiko Stueber <heiko@sntech.de>
---
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

v4->v8: none
v3->v4: add commit message clarification of what is understood by
        "opaque pointer"
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
2.34.1


