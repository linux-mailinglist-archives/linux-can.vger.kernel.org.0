Return-Path: <linux-can+bounces-7277-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA7KDsTSxmkhPAUAu9opvQ
	(envelope-from <linux-can+bounces-7277-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:56:04 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C69F1349721
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BAA630A2D96
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F10399018;
	Fri, 27 Mar 2026 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nhvxVNe4"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2FE393DFD;
	Fri, 27 Mar 2026 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637346; cv=fail; b=Z4chlFldZmCMcOf6V3V+Rxbn864BJxoH9svDK+P+6fwc0Xh0xtdYkl0RzkhFOUhnGc+DH0XPO9Khw81lFP9uNiTZda4DecefUeoCfhTkZ6cdVZ0dRae2f6UHILucxWkU3sdLzJEO/k/0d+oNwdCOJ/IJZ7J3MnNWiM+9DV6bn7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637346; c=relaxed/simple;
	bh=NRFEG6ehqBcKgFcwj/0u0in6gzPJ30IFq1bV52oCC6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AAJRZw4R6WsE479Shtx9jlHdqQd+9ztCkyAkNpUId1TQJcnxgxoM9PvTSaEfXmvYD+uhqmQ0WrBh5zHC7qO6rgGOQbGUNLZYzBZA44ecZUzvxKqXoxhUzwEGhqJiltm5hvZE4IErKwP5w3fwsFfGV4jPg4UvjjUL7e10BGySKp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nhvxVNe4; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEHx6I07Xl9TbMFm+HJTb3unqA432EjutWxDi08/gxZiMT9iXSJMFwEHS1ETY/xIgUMsrPVCczMMTfQouSLCptv7MS+giZ5dDZFKetI/di4Uehi9YJax1X9Vqs6YE3NOV7dR+Xvh40Wz85AhhjLPdLgAvkfb3YuS+J2hjUSpdeDr/r3S8TF1u2u1CtlUcRhkqxyqQkMxKdcETQWDXBuOxiQnQscdIdmVc4It7uNioCYJeAMhH6rq99pWbXCVxIg3yC0j8dwM5BsrKmzkO7RfUZbzjExyTQpkeWDtwjFNqHckFJHhh7XDQkWPc7kQRl0VF5rDOdc+a8BqfYVcTjjweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S48+hgH2VmzfEjLMOCn4XbeTFUmmqXzy8WudOwilpqY=;
 b=q5ZYrz/jK9v7ckFnoJHLO15fHGEqTe8ilBND6NtbJgxMmF9cL5S/XhTnUNuzayDcN6KucwPanp9RnUTEKwaolCLJ23qhK1iRfjzyverWNz3iuYjHfp2cjW77hSKIm3mmf8O1ahgpH3HY1DwMMsU+1q7icfvJYsaFZAomxf4u4fiky2J8zvvDkruDu4sGA8bX1oMbP2lbOJxDYX551VHmTjxiGK3kLdxMGpSeZiboLKs7YOiUz6YR4KkOi/6OmNutRpVY10HjQtnJhOfDua62uoC4Yma9GGOQAMRPLScxTIr4fgREHtD7CvWOIuCinanl3uQ0/TsVQtDS8s6/pOZTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S48+hgH2VmzfEjLMOCn4XbeTFUmmqXzy8WudOwilpqY=;
 b=nhvxVNe4j2xzpTT1/OlIgj8h0f5Q7y1IqgrfEv26ZbxxoFay4/W3QSrsAUlWlNVF+/UZMpC+5XjDgFXnGGL0D75ZLDmM+SPGgXENETSK4Zqv+7JbbaYb4mtuJZvQxL+vGBk87ntauokV2ai76T4zG3oaK+0cz0I6UjPoEPt5VynAO5WkUCJFN0P2DSZMainWlrUhwH1kEvapa64Cq/x6B0YV0eGuagnvouDT4mMA9edLZomxsAdmyoKAvD/D2wgCS6n8oWk5LxMTEeSmW3JFDW2YJS7Zhy1fqALzdh35rScptXhDyt5hyyxlasfzncGCQU+qDygY85l7djfjktya9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by MRWPR04MB11287.eurprd04.prod.outlook.com (2603:10a6:501:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 18:48:59 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:48:59 +0000
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
Subject: [PATCH v6 phy-next 12/28] drm/rockchip: dw_hdmi: avoid direct dereference of phy->dev.of_node
Date: Fri, 27 Mar 2026 20:46:50 +0200
Message-ID: <20260327184706.1600329-13-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF00000222.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f8) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|MRWPR04MB11287:EE_
X-MS-Office365-Filtering-Correlation-Id: 3704dbb6-f262-4fb4-0b09-08de8c31818a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JOgDEosucolsegjG+RBZNlvvP04/WDTKtyetSAeAyLQPryahvNMUotnzm3c3fHmiCcurQ4TkFLizKMTsRh30aA6zPX7WgMXyAhOo+jALXjHM7/5w3RcIgBy1ths7L1r0mfquguICjzC9j0TMSTT4BuwlKEWI/whKAU8+4Zoe5zgJDIw/QqCobe9xrdKPTO7QKi+J5N7xRNYDpoeddnyYo77gXF05puMMi2SRLcXLR7XZXUM2dbQUGuYztNCJ+eg3INMsMRJIawfFUWuEhPNte3MPSMZjEGlHsdPuJAnmZVKQzM4G8ih6FLu7Gg5Z6hZJPbu1mxTRf+S2QEDSeqtmrXsYkYxwH0LcgXX08tgzURaF/Q1P+hj8sJv+kSfbTtsbUpm50GNEgnsQ0cnzbH4Vz7iAD8tapwcATK58qYR5eXMsP9SD04oUmycPxNu1yzG3msNtr103VfBLYvgH67OIXyRZ1yJBMcXf/UbYYR4hAYIRDdR4sSiodCDNgh0nq6h0wyZul7iQromImM0et6GaNRUbm2XcFV62vcHHB8vAsQGiZ0WvLEBIGpx7k85Rtneh6rRyVNdh7TPGCkSWqLQKwp6yCpsIPeYjpsb1lTyVcunoYwTSiKVeNGrpxzygrg/dMt7Sk4g6sYYc28LuBOh1SpvqqYfQr1MXjh7B6Y+RalIBsiZYOiY4LLlMFLGHAZ6onTUtvyNm8ewqZqkaRWrupdtC3AofGT2mvUzOTQPjmsQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjljbXRraHN5K3k3WGNUYVpOeGhLRlowZWhSWElPMGhkS3UyU0xwU3RITnBq?=
 =?utf-8?B?T1haT2xORzFEQ1ZnMW5TdU9Cc2VmUmprSTVNQXVFc1lPejIwdHF1cy90b3lC?=
 =?utf-8?B?V0pEUjczdjQyYWpDVjZScnVINmdMM1l4L0FQbzFsZXRTRW5yUjRxZE9vSzhL?=
 =?utf-8?B?cTV3UEd0cHc4djhCRGFGQWdQTG5yZGRVNTNuTHhoTkdEa2cxWnFWenA3OGhK?=
 =?utf-8?B?NUZEcVBGM0lQUjNzemx1YzhWdksyb29oc29JWitaZ3RHRTd0RVVjazRReFlr?=
 =?utf-8?B?OEpoMjlkOUgrRVQ0Tzh0MGFpbWt0eGtGVW4yVS9paWxNQUM4UzJ5bk1OemIy?=
 =?utf-8?B?OU85MkErbk9INmppWnk5UHZVUW1PRmM2MTNvNHF0MVB6Zm96YUVUVmJYWGNW?=
 =?utf-8?B?NzZkL085eGMwRnhOSFBBdHR2MXFRZFpsQkJUR2M3SlZJazhGNGFMRHUxbktG?=
 =?utf-8?B?U2l1SHM0VU5hdXd1cUhjbUxJYlV5V24rS3BiSS91a1JMNEdGMlI2VWJPSlIv?=
 =?utf-8?B?bjFHb0hzYTJSRUxGdmx0cm5RMTBabzZ1NFNWN3R5R1Q3RXFwSEJqV1dSU29r?=
 =?utf-8?B?NmhEWGt5MmFIdlhQZ25NQUlJOVM3QVVCQlkzenR4Sm1wWHJKeWtBcnlXYlNz?=
 =?utf-8?B?VjBwNm9VN29heUZVVEZwcUNMRC9HSTNiV2g1aXJPTUdLRHVoZnBXQi9IUGpE?=
 =?utf-8?B?UEFYdHU4dTdVMURldWd1UTMvb3BnRXJLcXM5eHpYeEh0OHJ4ZzluMTRjSzBV?=
 =?utf-8?B?eVF6Z0d6cW1UcjBld090anVBNFZZd0NuMUNTWEhpSEphVTM1L2FzeUtmdWdP?=
 =?utf-8?B?RU5NV3dLOVRzY2FDZzcxWjBpUjNoNVh5M1U5Vjk4VDRBS2QzbE9WRUtwZC9E?=
 =?utf-8?B?dmRlejNpWXYrTWhDL09mY2dhQ1VEOGtNcUZ3MEY5R282Y3hLeWo3VTRMKysw?=
 =?utf-8?B?SFl6VDVPcTRxYmJ6ekIxMGNpNFRTayt3WCs1bDdKSk9OaWVQdWkwbnp5Z2NS?=
 =?utf-8?B?aW5FMmwydklmcGZCS3BxOGRTTE9Ia1lOS0N2NVJadkJNMU1yaXhyZGFmdFlU?=
 =?utf-8?B?VTVEMWUvUTZPRllUeXBnc2wxU3Azdmc0WmdsZFpHOVlkRTFnWFRNQUViakpF?=
 =?utf-8?B?WkUxKzRpUzdPVVlIZ2ZWeUUxL2pUTkdBS1ZGWjJvVzFZVzJCaDlFQm91OGRE?=
 =?utf-8?B?cytwM21vWk85OVJxbFloaEd0akwwWHRGQWQwSXZveTNxaUczT29vQ0JlVk5i?=
 =?utf-8?B?a1VQWXBHSXEvZ3ViT0NkZWFEbVNXdlowMmhRL05mdzBXd2NnS3FWT3FmSlo0?=
 =?utf-8?B?VFhSbVQyOHppVHpTcFN1UmZ5d3o0Q2I2NlNEUHlOaFBiSzlPVUJEbUZNWVRT?=
 =?utf-8?B?VUdhc1FBSnpFTFpNV1dxb2NKL3JrQ3BsOFVrdGxISk05T0Q5Z01PZXBZN0tL?=
 =?utf-8?B?NTlYRXZaaEowWm1Va2kxKzNLVmNhcGxwQWZ4Uk9QWDF3dFhSOUNJZEszRCtD?=
 =?utf-8?B?Y2xuWCtadWxJRWlkakpYR2hrekV2ZjZ2K1FWNEQzNFIvSjdnTXlHUW5ZdytZ?=
 =?utf-8?B?elJ4S2J6M25LQlZUWXF4VkI5K2oyakpsVVlIQ1hpeFZkclNlVXZTems2ZklH?=
 =?utf-8?B?UjJaZ09pOWRhTDNKMENFZVV2MVZMaldIUi9TVVVWQVZDemNoKzNta2xBcENz?=
 =?utf-8?B?ZTZxRjJIT21uNG9kbFI3Y1ZSY0VvSytDKzhXMGpCZ0NRK3oyTGdYWnRsUElM?=
 =?utf-8?B?RDlFazQ2V3lkQk1Ib0t3Nkw1Yk1hWFZYclp2ODZ5K1ExdkJZeWF4WW5SVS9W?=
 =?utf-8?B?TVI2TWNBVmRxT3ZQZ2lkSGJQa2Nua3Y0dDNWUHlGTFd0akN1eGpoVjBuc0E5?=
 =?utf-8?B?c2dUb05GOFgvWCtFQzU3bEEvWWhVNlNhajZnYld0K2Q0MHp0NlZTcTMrdkhw?=
 =?utf-8?B?ZnVlcUJWMUQrUEg5UEhJRHlYMllMRDlPM2tJYTdrdy9ibk1iOFhtZE1meVpt?=
 =?utf-8?B?NVhqZ1JIUXZjanBSWEFucFdtcENGNHFpN3AxUGpFT3EzMFhBUk43SzFFaGFY?=
 =?utf-8?B?OExlbUF0L0RXcnZnTXQ0M3VGY09wREtHWFJZV1dlRFpwS2VuV3hnb3BqSG1V?=
 =?utf-8?B?ZWRHOS9xNHkzS2FYbmVZdlZQZ21mQVY2MkpUek52czJvanVEVm44SittSXRH?=
 =?utf-8?B?Tm9xL01TUHM3QWxVbzBmQ2NBSnM2V1dNRk9qemFVcGJTeGd6UEJlamJTazlP?=
 =?utf-8?B?YlRDUXkwY1RvZWtJOS85Q242ckxnQTYvZkFKZVpubU1iazdPdSsxcVhJcERp?=
 =?utf-8?B?a1d4eEh3TVBZL3B0aXVUQzUxZVdYRTB3eDRmb2JBaFVlRXNzMGtvalkzbFRX?=
 =?utf-8?Q?cm7WpHv+IaDd7+XUBSVkhjNhgiUz03YLQBUOuyEFoixQK?=
X-MS-Exchange-AntiSpam-MessageData-1: 7Bctp4s+Lqf4u55zlkR5YlhM+thUVaDp7vw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3704dbb6-f262-4fb4-0b09-08de8c31818a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:48:58.8939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2xy9Waqoe3oDnieZjJn8K6urlUMP+z12bYBm/vwALevdIxoC5VaypuViU+lWoz8F20/jKFzZot/cpZqOwnaDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11287
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,sntech.de,rock-chips.com,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-7277-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[clkspec.np:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sntech.de:email,rock-chips.com:email,ffwll.ch:email,intel.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,suse.de:email]
X-Rspamd-Queue-Id: C69F1349721
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v4->v6: none
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
2.43.0


