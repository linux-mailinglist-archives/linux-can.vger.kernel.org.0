Return-Path: <linux-can+bounces-7011-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNMEOwFkrWme2AEAu9opvQ
	(envelope-from <linux-can+bounces-7011-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Mar 2026 12:56:49 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF21B22FEFD
	for <lists+linux-can@lfdr.de>; Sun, 08 Mar 2026 12:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C85B3304E352
	for <lists+linux-can@lfdr.de>; Sun,  8 Mar 2026 11:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60FE392813;
	Sun,  8 Mar 2026 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BuXNuJUh"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013029.outbound.protection.outlook.com [52.101.83.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E8392C26;
	Sun,  8 Mar 2026 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772970218; cv=fail; b=rJ8CW7hRz+uElgJ9ytsGXcmrOG6QkqQJSOa6qIFB8LPBiLectCZizOOOIj/i+RsIsXVNJc4q+tg3N+Ch2o3cU0taAcACglf9C6J63nj7goKjGZGvMtGAu2X397H0p6/s3k3+VP7i48w6S6knyrCr9/Y6o/Fb6Kolrri2RenHY2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772970218; c=relaxed/simple;
	bh=V+GOJPqNHZC43NthNdwkEiDNWEw6Q8ceg3mJKGFbiwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M/15YiYSsxivH8UxCYvTLfMGONCculmg/3KLDB/2vBVT3wmVMJic4Oh/ICvTt4Ac6V3qfbwxngDzKmIWR9RyUpVR4x8fyeLCQH+VmQ1WPkA/LXo+MPkWguKeuTWytH1qS4GzjSDBu+/5BeM0lSI8W+yfRxLGbPWlD6PT2VpGK+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BuXNuJUh; arc=fail smtp.client-ip=52.101.83.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8G8XzebWx7tvlL2r5EPYr0p6h97qiBnPi7kv8JtBiQNshsWxTI5cRvygylZ2e5S2mlRKYMMEKOvYM7qWCfTQlfWAqO/Jswzq297xB3hQHWvrq1psP3JCoCaGYaNo8G/qOhtsR1w0T1/jD8+ECSMB39w//JX8GMlxq6OS2CMCvEXpklE5qktM2RfUw/KZDCYxGav8ZqJW//jT6SkyxmfkA1IAI6Zz63s7zl7E5JBdHitIwaZVDWR7qcmG3ZAvwHzRlqtNMztkZfTI9zlBxzIohCIzIyQa/VFS1oaLJveI/7AaAAMdW6veO/K3OnMC2z439RKv1jovS2jdBd6bTGXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjpOLCK8Evm5uFJzPij261ZYt1GD7LRBErxYcKS+3lI=;
 b=NmXPgKRL+lopCRm+Uz9nCFwKPhFHAhDanMKgpR4TD2kIV5ELiyNdhTmgTUsEKzmdcrhxaJ5tOdz/ySJutk59WE7VyU6yCvjYhZVqYai9t2TvSCjivZ2OzlE3WZk8fjEOw3vr7f5dRtacdoAEBv9LBFYmWU8wxUF4AgpGX490ZgZIVcpMk3/FQ+IEsbCxeGj2UvHDz7U90WgAN7D6FP8vXXz8FyDC+Eyt3pHTJQ8awbTGbkccfjRJT1TUXuD5SCGiFA50hDErvfgMjspxY7bHLUpaUqbTNL23UiTbFGD8j0LNp4g1YnqrJeZ3JqzyVlYB5MrID622Unah41Voxp15lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjpOLCK8Evm5uFJzPij261ZYt1GD7LRBErxYcKS+3lI=;
 b=BuXNuJUheHBtEzA5an5Lkhf4tqt4nQ2iS2xxHE6AZdXnaT5oMQ1IYrVo1fOB4HXH9Gk3EFwwdxejsp1Qpm2KaNdEuynsN47KpDrcVet+CrDSWVyBAVH/5wHwU/mx22AOQLwGkN8eftCL7llbtkhSjWquRGKn/7XGl5X7lzt35ZC9EYj1JRBS1064e82pn1yyLXKclAvx+ULe1JBX5h/abqL63C0WVruca4YCH9nV84tvXFhZVKj4mwo+rGojVKhfz43Pmak/FfFwtLZBPaiDdXJqS7ra3fEPjjDo2ZZoM/T4Opua6pzXiZynT19vr3J1RGJN1GnRkrGFoAv1gTG2iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB8211.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Sun, 8 Mar
 2026 11:43:33 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Sun, 8 Mar 2026
 11:43:33 +0000
From: vladimir.oltean@nxp.com
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
Subject: [PATCH v2 phy-next 19/24] pinctrl: tegra-xusb: include PHY provider header
Date: Sun,  8 Mar 2026 13:40:04 +0200
Message-ID: <20260308114009.2546587-20-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260308114009.2546587-1-vladimir.oltean@nxp.com>
References: <20260308114009.2546587-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR02CA0063.eurprd02.prod.outlook.com
 (2603:10a6:802:14::34) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e37fc6-e591-43ad-0f4a-08de7d07ed37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|19092799006|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	IF7PxuuF0iEdvBEDzejK0DELRsr6ssj0042qQzJK2oN7FuKGWv0nQ8kAhPV6K7HTWigl8IaaGEI9HsbSEoQvvSZ3EJLmvEU3wxpKjxOLcT/NTlF0nCh/1fA1jQR8U9g04teTDZ44nwNDdYCU0wynFND5JffMrb2hd1anJhkAHmXIu0nJ3Nd/uYumMgLGuShgOIQk9PIt8qpM/BxDll5BSLMAJ9u3bfEUHEcUHKonJocINJQ5Ce7+9SEX6tvzCWwCNyjAOUcjwLCA1JzGPfc2OGZkk/F7eSrmtnvzSUC9vlFxnM2fmdf5wRgzcmOzxV60/fGj2ho6rZk4p6GBbnXm1SdA7O/0TUUf1PcyujYBvxBjdDXsiwhHjYbjHSdaH1TVqWeAjdJvXiH5yHUcdWbKEaPhJoMWGIC0HxjbSF42NS+5bbLaC7/CIaUnHq4V0QtnNPoIOzBdk9nfTU/CdMq8SlGzN1rAI04M/u3b3MCiSeT9vb3jewgSKBwMlDqyikWo63CV19yaddcVy+ULIcFUCc1oF/tVMWJ1dXHnEJOCe52mrH65G2IV/NWtNckrwUfPcOMSJaLQj5xrtPYF9reqfnp/QB4bkZluXEd09lL5+WmL1B1x7U6eVfYbOvZGsfZAOUizci57z2boBpwBKdNGXytbx1qZzh1LqCcwmFrqbK+RHboMjr5Pd/mmFyGKD8VzX/BJ9MsYLURqg1puLM6sRn7eLBVypjfcJHm91DCwRhM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(19092799006)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2pR33bS58X/w36/n8qPqJFbRNcSRmtBYThoi7hpKZkN+ghw/8+cQvdxG6cvG?=
 =?us-ascii?Q?Hbr9jvRRacVTJPk1rMzu1UGOnTMNt5koBeEsdFBGFWfbYfHfyF6t9Bv197Kx?=
 =?us-ascii?Q?1l5Ety8q6cuUOpnik4LxwyM4S4mu8fELDA7DgOrLIkqvv1NzXZ/oSNToF0Lw?=
 =?us-ascii?Q?/IZVEwV3H7gt+b92TNgr2r8USzwIArs314EqdTbpMw6gp1Fhb/1T5TmSCrxW?=
 =?us-ascii?Q?Fjpp/fIa+c2JKmptF3e3p1y+o5IK5Eo7e5TfRiVLSsPNVgqq3sNVr7LUR3Zr?=
 =?us-ascii?Q?+U2zOYwr5IHEXu8y7+N9T/Le8bd9QCdlSsWU7RzxkMsvERj/5dWBMylQShxK?=
 =?us-ascii?Q?JtctAi5xNAabk6XxW+fOPSZufqpQADk4WM0/LWypAv7jJBDLhoIFytkXf7KY?=
 =?us-ascii?Q?Y7i335fhfvKvMgrvSU9O2F8fp3lFra6GTvnagJZzS4pFan03qtPkV7EFCN9D?=
 =?us-ascii?Q?QH4VWRMup8KPCXd6rzPHg7BpEFmP6AasUbCtZj4nAR7E2SHk+uFKEQ2nSkCs?=
 =?us-ascii?Q?ZKD4gIS4hwdHYkqN6riFrL+OFg7t9z+vrBJY/JlBihv/CVLRZ7WaRX29jkI+?=
 =?us-ascii?Q?FblhSbvDgD5W+CVBY4YXZyd5VecrI2y2tY7Ifvqj1QUIhvVF1E7Owug8Si7i?=
 =?us-ascii?Q?835usdISswkoBgM9L7VAjjSnfeRYyUXmymRok2JEcoGKRCaNETh+g2qxon4o?=
 =?us-ascii?Q?1XAE2MZ576Zk1bcmyF2UYgPYDo9LrHJuZYtOoRSpBgC2aZoACf3hD+dQ/Eyc?=
 =?us-ascii?Q?C0J7GY84Uicsj2ZLgTVRtWC83j4gZnhmVnv4PpRKbq5wfp+hfDUarNpfVnV/?=
 =?us-ascii?Q?idm/+UGN0jHE/PnZPN34vqHqEgC1FKgO9y8CH1DVIKMKwrjFfYTTlLGDR+nm?=
 =?us-ascii?Q?edjrZIOoqe5IwizfX3dt88Oi8pp07VmTyGWGXbu+VIThkTFDlhvqehfhCG3B?=
 =?us-ascii?Q?J8jmXQ8AnfrRB8aKbfi+1GaRwGDfALbzacu9Oa2g6Yprh3z+NAmPHB5OX1bu?=
 =?us-ascii?Q?yT5thnvWSXXGWSLg84mcBTSTdawty48WWlwAZvt8tAA22c6qjBmIA0OF1c1p?=
 =?us-ascii?Q?m7lnr6bZSB4WGYjDxAfawao4G2bVOqs6eA7+UZQNkRt46pFETOfjKOeWF/qg?=
 =?us-ascii?Q?RFuGRTV0m7LW+trYQmneG1KDMClsgk03d+oWfmiQwBJWlZn7MwD0qKX/bbYw?=
 =?us-ascii?Q?W022aupYCUYZZpVtVd3ICOrOCnWL/IP2sKg6njrNpK0zItxgVmT602Uvfebx?=
 =?us-ascii?Q?1N+DUMrwN6QbEf1AHkHcpDXU+aJdKVLxRUJZj3D4djlSUBSDWKfQGr+FSxp7?=
 =?us-ascii?Q?o4nt8ruGwAwrmRmCvNq1Sdk2rFCwDj54QXCpMOCIRxlR6PWsJWg2cdsVQa6u?=
 =?us-ascii?Q?GFIWTRl171FwDuUpCO3s5wjqdrtGQC2MHlFqZJbjJn+NPoHp7br8QOoJ2Eiw?=
 =?us-ascii?Q?z6IOKl7dYC+GB0QTvCunJOOEo48PY7x6RX+G7EwbwppGE662rbuNh1CEt3B6?=
 =?us-ascii?Q?jboUbJDtrq1qNZ0T00ORnkYtaCCpSw7Xy20bfx+vBa9VcteObhQzu3M0Qrsu?=
 =?us-ascii?Q?f1Z+bVd5QxsbmQIYiCPzy8eRPOs33EnVNs6uEmApFsnLJ4UxSOntOweoGwxQ?=
 =?us-ascii?Q?ulmqAc8ANxtOLcIPOsqhQkLLs44Xe/ZOEarBooPa2ZRGDNTj1qep8dmmZqUZ?=
 =?us-ascii?Q?QwvZWpgzwsDBMYEHFyCxFCvMfsJiEV4pEON4x/wr0r4xhp5PMHcUB9YsVHT9?=
 =?us-ascii?Q?ZljB+BXNUpkHNEtFy5wheuZlXZAoba78vXDEjmUeKCHhzW/SuheOSV5thvBM?=
X-MS-Exchange-AntiSpam-MessageData-1: Im8nZ93WRDU+eXhLsmsEBw5gqvvC13YuF8Q=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e37fc6-e591-43ad-0f4a-08de7d07ed37
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 11:43:33.3491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtl+W0EwA0GreUH2DEPdQozAnjEtUxzJWS2b1QpjLr5wSA46GOPmEZJOXwMgfp7xt55VNOLYr1ZTbGaYtrTmLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8211
X-Rspamd-Queue-Id: AF21B22FEFD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,gmail.com,nvidia.com,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7011-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
2.43.0


