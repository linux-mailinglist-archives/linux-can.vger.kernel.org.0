Return-Path: <linux-can+bounces-7284-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC2fGHPVxmmtPAUAu9opvQ
	(envelope-from <linux-can+bounces-7284-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:07:31 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0664349D1A
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAD783183AF4
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7494D3B47C4;
	Fri, 27 Mar 2026 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VZnQLtwT"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE933AE185;
	Fri, 27 Mar 2026 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637361; cv=fail; b=Z7w3+WsRPSIsH6VX7R6IuRKsWv8CjjD0m+APMag1RDODbF2zSxa1RcbCV3ucO++Nu+bfMiuj8VyQXFyUMin8jk5rrlpaM4r3T5pDEm5UN+lNWwCBcdmo1nV5nIZpE+jIJgLiuP8JqbvCW82Y3BX3xnlGKN52wuD7PtU66W/7yQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637361; c=relaxed/simple;
	bh=gfuNJhfwggPfeXsHrDokBecyy0UAlub8whIrFERq0VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZfRIllsTvv84ZpkCMCsl/dWEDIbLHPN8j2Lm6UIO/jfCsXTLe8DRkHmgOHkk6rlmFtllqFmePNQJ3NRryZy8UsQO+X/G7wd2iBbCCo87ThX/Uz8JbSEREToS3gVXhrlsv+HwRza/nV5ai0w+479pL8tUuAR0pIDNy9HnRUZLTQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VZnQLtwT; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wduoZ2SQgRDEQnuc3ahdYG1I08VOoiB77x6xAL62fIs7wxwh9oxgAOJtKd1wj8r24ievSxSNSmx7K31wb4R7ZU0dzh6kUpMNp4rtrOH0ofTrtBuv2vsjF6CxlTtHcqZXcKtmKUSh/sxTp+6qTetDOPOOoBwdCeX93UUoKi1y7fLjU/nEWD1FI3KPLMttYLyiVXjA5KtKrSZskaJRF78KqsQhpx41rE/pHrEfwGLXyslysyS7x1s5voryZAwxNs6NHcQAj6cPf/yrOGcp+QcViswREftsY6OnpRSPe5J3qKs9f0VXGi+XiqfbreFKl8fMleTvr/2pdf6u97i18Yo5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpT9pn5BU+LoCqTdWJAVa1gkZ+1qJNIw4rDxJ1geZMU=;
 b=By2vmc8fTYvBvFg3QEllR36RL9TewZb8oSn2xhhdS6pmVBNbXGmjKUbu16SwW+gX8exq6ZPNDCxZhh8VqEd/c6WwTkpdjefq7nyDbpUEEA3duZqQJGa++u3K3Unq1sqBO6rRwYyg2hAkjByia0FJJRWIOAXH1yxwTHeTsFMzafWAHEO+Y8Pn5GMowDnvj17SgpbruCykcS2CYgtOkgEMvSWKZQdkmXGdZIXGMhyVmg0oCbBJVvgbzCR2C18HTE3FCxUSlJcli4YDtJZ6AOFD0HM6EkTzxScqZ2DBS6pJqo3R9yr3MtujZPdZxjec2mo195IvBCKHj8qYzeGBeQZKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpT9pn5BU+LoCqTdWJAVa1gkZ+1qJNIw4rDxJ1geZMU=;
 b=VZnQLtwTRK2ZjHuFzdSQ2jiXONSzr8OO4Q02D2jjFxQgaBPLxI2CmpRs+RomBLGHLZc15uFRKzZqcch+hgEp4mcc4Fksv2S8WT6d+SHlbBUI4tN6571a5ABFhiKOjh3/2m363SpiJ18FpmXZ2xOqLrMfOezYEGpBvfWDYaBHqyyCWmGmAhIpRUXmjBUu2LgGHX6l0hiPcJ8ttgkVfYbbddSnlyvLOU6YRr0lvGWg91o9zVaPX2OS+G2D3KCYEsYTmxEbtLBWkuX4thKnxRJh/B3xtlF1A5y80/+7BmLjoS8hnFx51LqSFKMvNdBGQJBJ6kj5bEbZZFLZbzHumO8iKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by GV1PR04MB9515.eurprd04.prod.outlook.com (2603:10a6:150:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 18:49:14 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:49:14 +0000
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
Subject: [PATCH v6 phy-next 19/28] drm/rockchip: dsi: include PHY provider header
Date: Fri, 27 Mar 2026 20:46:57 +0200
Message-ID: <20260327184706.1600329-20-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0040.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::24) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|GV1PR04MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 781bf337-2572-453b-0413-08de8c318adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	y6dwoaMuDpuuPIarH3RPGQUx+7MUHbrd7ZGf5AH82PrcNUArAR0x9qqJh2enrJ11OlSoVJeR1N1P2IfDDKv6VJ7VOvT4JubTqBx+7JPd/8U6s43/AasO7SHvClLO4oHdtGpYyzTveSCM+FmECmWIMaBRGPebddeh8N3JChF2hStTi6xMvlbcB8EVEyI4L2pJpW5SMOjo5EdsxQhXNPydYcnlK9H8a8mL2mQfCZ0LUwjeZ147pTjxLM4drMpsvK12N7fZy7dXdbhaBwv3CIuRRE5XvwbXZM4euUUqIqrjy6Ec0vvdIc5XfuLI9LQfE2j+3R7CSmsscJbTI4uAVrmUA8EHzbW39E0Iw+pQ/2nG0ZSIgNDnoXdyWP8ZcszCpUGK5gbJ9gg10VRT0wHmErbfxHku6p0Su9iRFn3PiaBs5ytpkCULhjN9sezcFmVadxuscCJloQTud2k/4xhpVtmMu+GWfVfDyJCcnu3iUPYY55vnALtc+RGv73J1PmZ37DXBEM6+7tE7gjVy4e/aZtqZZijo9qSzWCkZi/35pVDcsYfcNfdl8tRCgCD8wqJZKRO8drJYI49gCmrHVPhTrzfHR7PNkAmAmxWLGEcYRFeA7coZfXa9jAze9Q+SQQJaUMEVkS9kGRnxZ7pff/atjjJSDRzwcJ+/FPvuDJQjazTJaWveOuiQt434b/+mb0UUVRPwvMgusx56I+M7UD2fANQUk9tooamh2+/FHlqA7WJgtT0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0JQNTdaNkhKTUZ2VlF4Y01XUDZYekNjZVhRck1ZZmdFTzRvNUdQWjJ2bEtF?=
 =?utf-8?B?UW1FTUpTbHZ2Z3k0WGJ3TFBnZFdzSnU0Y0lPSWVXOXZ1T1RWV0tGdkljM2oy?=
 =?utf-8?B?Zk9LNWJxMHdjZ0ZYYUxDQk1qVjY0Ly9WM2NzOHNxNFpPak16TkV1VzNGVHRB?=
 =?utf-8?B?cXFNa0EvV2s5aDBaTVdIZ0VjVStGV1MvVzJ4NGJXT0ZKQU1tVEFhbnE1emtm?=
 =?utf-8?B?UUVGRUFNeDY5STlqamhhTHR1V2E5WDRTVStkS2E4QUlrK3JHY0VSV0swOW9U?=
 =?utf-8?B?YXYwZkp5T3JtbEl6bW43K2JqM0VsOUFZK0hLdEZjODd6L3FsdE5WbDRhZWlG?=
 =?utf-8?B?Y0NpeGprMDJFRVZ4QzVZRHRYQStoVlhvRFNoQnN4Y3dLS2xZdTVMcGNrcXJT?=
 =?utf-8?B?aE9Na081YVFmcWlaUjVCSHk4c2dyT21YV1dpUnN2U00vcDU3ZDE4bGtIM0dG?=
 =?utf-8?B?c1M4NDVHQ3NNemFqQitNVVVwc0xHeHZkM1plOWFvVHZBbFFORTZqaDNqK0Zn?=
 =?utf-8?B?TG56K2tkWEIyc0tYbVgwK054Y21IR3hxUGEzY0JEdkljVGtKU1hnQ0U3Q25L?=
 =?utf-8?B?QzJTUTd6NGxNaTJzV1FqcFZkRFVOMmJSbjVqY0djdG1uWXdRNzRFSEpsZ044?=
 =?utf-8?B?R1hES3pES0Vqa29YZVRORUdPTFVNNzhQcURPS25VT3VwSDBRQUlGR1FHdUlr?=
 =?utf-8?B?aFFpRmFDK0FZbnVsOXlwOTh5a1NRcFFPNVRUOStNa0FhSmJDNFh4emgzZUtu?=
 =?utf-8?B?TFQ3Sk51WmszUjRhZlg1Ymxmbnk2ZmtyQmhjMkVJaU02NWFWSnpxMXRsSzJT?=
 =?utf-8?B?RStzaHhFSElvcTVZeksyWW9NK2dVSnYrMGI1NTZORklEUlAyUWNIYlJWOXl5?=
 =?utf-8?B?bWZyTHR2UkRoVTMzblhtUUViV3AxcERsM3FSNWxuSHJsMnIwK3RPVVVHSUFN?=
 =?utf-8?B?WHZOeUd4RVFOQ2REakZmVmNRRGtaazYxTk5DWmdCNWgzbFRGK2FNNnVqRndE?=
 =?utf-8?B?eFJFSG1uYnQ4YTF6UFhPR2d1aFRtTGFBSlBKOGNvRFRyL016NjN2Y08vZUtR?=
 =?utf-8?B?czJQQks3ajF4SzUvdTZkRENvZzUvc3F2OG1kWThDYVFPL2ZrdkVxMTVCZVov?=
 =?utf-8?B?SDJrODRPbTlZcWZVaEZTK3NpTlNkR0drN2NvUS9oZk9XOHpwb0IvK082MVhr?=
 =?utf-8?B?K2loWXd6NFQ1b2xMelhtcmhGU3ZvUncyUU9qSmVuSkxsYzAyQldIL3hJaDFL?=
 =?utf-8?B?UGNtR2taSDd6REF6NDlyZUZQYzdHM1VqUWVRaVdSUDgzM2FhalE0U1FlbXUy?=
 =?utf-8?B?VlpOYTgweWtFVHUwUTZOMTRqMUpMK0VUUy9icElydnd6WGIxRXVnMkJ0L2Fo?=
 =?utf-8?B?SkREam1LMTBFQmVqM01kNkhrYU13d3c0NlR1aW8vZnREa2Y1VTcvaUlDc2ph?=
 =?utf-8?B?TTFTU3UrUWVTSU5sTWtYblgwenlqWFlQb0pINEp5M2RsaHJxNmVnbHBBY1Jo?=
 =?utf-8?B?a2hTRlIzL0lIWVZUeU5Vc21vc1RuUFVEY1pjYUtnYXNGNldCWTNnb0NKb3NW?=
 =?utf-8?B?aWVUTXB5Ri9ER05DQXE5RklPNGlsNk1DYXk1TFF4SlRCSEpoNjVMU0RaVDQw?=
 =?utf-8?B?Y2xLUklRL1ZncjJic0FEVHZVSnRtdnVZTGJxMitUZW12UzQxa2dDU1R2TjhL?=
 =?utf-8?B?U1h3MEVBVHlrc1RsVzkyVERmU3BJRzdDWmNrVGtoL08wSEljYlpFODluMnBS?=
 =?utf-8?B?ZE5SUk10YjRnS25kY21GZkQzM1ZiZUMyNjBVSE51MHZLQ3UyNFFtcDlnU09t?=
 =?utf-8?B?eG5mTDFwNzlOdGZYbUJmcUtCaVVFbmNpczJERWQzNHZJYjNJSnl3YUlhUm1W?=
 =?utf-8?B?bm50ZitIbmM0MEZzVCtKRFM3REN2eXlZZHBmZnNmWnA5TnNHSFkycTR3RlhG?=
 =?utf-8?B?WElqTUZoNXd2ZGJvem5SVTAvVHorK2lGbi9tZ2ZwdWI2U2JvSXJSMUFMTnB1?=
 =?utf-8?B?TWJNVkJCWGJkaHZ6QzR0ZnNYVmIrekx2cU5KWXl6b3NjOXF4NTZpWDlRN1Nl?=
 =?utf-8?B?QVU2UGk2V2tPbnUrU2NQNjBBVzVuQnNkK0lsVTc3K3ZDMGFHSDFPNUJWZUJ6?=
 =?utf-8?B?VWJ2dE05b0hwenZHOXJXWXBxclZkSVp0S1V2ZDB6RDZlTDhqNzJ0TkhGaFR2?=
 =?utf-8?B?d0hwUm4ya0lOaVk1WGVHREFDR3BmNGh4VHpuL1RKRkZsV2tmQ1ZCN1pRdnFM?=
 =?utf-8?B?K09acVgvN09NQW03ZzhzeEQ3a3ErYU5iSTdLZHd0blo3RGplME9KelNDOGRL?=
 =?utf-8?B?VzRiYmJHdS9oSHB1Tkp5citOUnFtMzN2eGhwTGhmaGZ6cDRXeXVSZlFEWDlN?=
 =?utf-8?Q?Rta5cEcEUNetrHt3fenHDgesmp/NsQOa6quxiljFjQVBw?=
X-MS-Exchange-AntiSpam-MessageData-1: H7AFXJIgkqtC21E6yHsrznrw4erQHDMTDZ8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781bf337-2572-453b-0413-08de8c318adf
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:49:14.5567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0htPVBd4credQHKlsxV/g7SnTH1GWAK0PSWa4kas5CzNqykrAOdHTLJ74x1yj6bWpO/bwKnvpA5qYxUfhqzvtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9515
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,rock-chips.com,sntech.de,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-7284-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sntech.de:email,ffwll.ch:email,rock-chips.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: E0664349D1A
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

v3->v6: none
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


