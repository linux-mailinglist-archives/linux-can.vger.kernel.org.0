Return-Path: <linux-can+bounces-7267-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HYhKc7RxmkhPAUAu9opvQ
	(envelope-from <linux-can+bounces-7267-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:51:58 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB82349545
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E726C30A34FA
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C7630215A;
	Fri, 27 Mar 2026 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="afLtgcGR"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC09830CDB6;
	Fri, 27 Mar 2026 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637325; cv=fail; b=FZIZHu0Fsip1airhd7H1j9h/1ZVygnsiUbuf5PVjflQv0+QaJKxhUMZBXKGyaE6/LuVoNDx5bNFaLOVAbC938qJia4SoAMeUzAUt84MLi5WqPp4nhEAmYtoZ/BeEcrEV7hvsW8k5CJRzCcdstjX5bvCuZt+c/oZ1SKeiiQAVA8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637325; c=relaxed/simple;
	bh=XgN8lfQTbtLUGpFdk6IhSP7FbQ4VuB/Bxb9+rf+FGF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lcUrUXQds/AfQCyl+KjmiApNHi3ZLYjbXRIKt4LZCbpeP5XHvavY+z8EJ+ErnQg2zL7M4xnvUnbwPq0N9MeDbMqQIw5vDPKJNV/1PoZITCpfvXtcig5jUVtOtVEDXLjFFjJZTaUx4sIRX95t2Dw7a4UAPg8upoR/734aW+Oe4Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=afLtgcGR; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyORp+neUyWe6h5BJWUQe5OFFBqlkFc2SFkylVENgnqkKQKUKwAWY5ZcweBVlGn+u/1yJBnsBXZwf2/kCs2KH7QgRuZnvM0eAwPPJ5YZujNDv4kZGkMMl91G8zbHIuhtX5caVW8BYphhUs5LECWfJGZPGPEqfRwGXtEON02b5UM0Dz98pTIJ7B5R45g0KOlPvyMWzSzVPJUQqGHcx6p9CxLGAAHdK5PkdHwF3Qm/VgkDCF3/3eIND61wxT2tcvP42LszKtx4ZZrWMBWU7P7P1J/udr/NlkRof3FH4IFkU51MIRttCt0Jl+NQIjcpofIAHdDkB/3iT0Y0ZN3Ccd1Nnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HxD0fDZKv4y+yv55+7ZCY9qLarNtQ6qqm8o2xNuXOo=;
 b=DNP3X0+8OTC3K100DzHObXhuVzkwT/RxqP/mpRVt5iHvIoqeyWm8a/PoaFAKMf4FnAqBh5KNot9DT82kupId0ByX3sWbWJIKULggvoKzuVrSb/EtYJoYRuE+yEjEQIY7wVTygCcmXVE+UkyWKa4XPXqRalmfjGppEaMCTUcwZ/OON/NIGKdRNROZrPyrTpgqg9X6hbDiwfTGwB2ZqXr96ZXVPw56XHW/sTX9AVhueHFPbr2Q2GKLph0+wolX7cufpyfyrobzqxbhA+S71ddwT3nP5mAh6IC1/8YbANG9o0tMjCbysPcJk7Bv6DJ4fssYaXyVv7u9ZzE+nEfnY08hjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HxD0fDZKv4y+yv55+7ZCY9qLarNtQ6qqm8o2xNuXOo=;
 b=afLtgcGR1mnDeIo7U+phrTWq2wE++XMv8CgFLHjSfoQdNbIDPHlKlzXSUq82yIpwJu1CDzpdgMJtfYRk0lc02kOIVCZ3SLlX+Hocd7wn1et7fExbRSMCPKcM74frnI7RQOyDOpdRinX1iJmgkRXp/mqmiWcL9Tid89SMhTliK3rPtOgN3fVOweoraC/rNxjOmb73zfwiarMRwQiUM2k65LuhGp7fjgaGK35gAjYudvVmA+T0FPbxNrcioYY2b5IISWxnY8fTLmLFGuWhwlrSfw8w6HpYSeDRr7Ui9ejWWqWJJxERLYhc+0KIqa4xS/OF5ArBRuyO+LKn07xWQcez3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by MRWPR04MB11287.eurprd04.prod.outlook.com (2603:10a6:501:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 18:48:36 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:48:36 +0000
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
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Yixun Lan <dlan@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: [PATCH v6 phy-next 02/28] PCI: Add missing headers transitively included by <linux/phy/phy.h>
Date: Fri, 27 Mar 2026 20:46:40 +0200
Message-ID: <20260327184706.1600329-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIXP296CA0002.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::12) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|MRWPR04MB11287:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa4a6ae-7795-41ae-b4ba-08de8c317426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xzl6cguwBDN1PFigv1w+gKpYe5QVQavLZI+o2EHO6XShfoduglQY4L2EF9hAVPtwJhghl+ZVjhPWHxkbBUzwa53wrmjL1GF0aCHDTFQ8riVkO3cHme551yUGf94s92fRd+XJruUUIq0z35ieZah1vhSFnF4K388Sxtqx6qQ6FEpAeGi8tcqijS4wizJVxiRY62lUj6ZQ5CVpeA3mYqf2q+yi+7G9YAzb4qPJiDC/erIg9VIQcmKRk8NTR9IlD7Xhw2q3ZX50dVWHgmzxKNcWOHCP6rXYJcT7ytI5NNTHLxHfMXOs3BMJnW65yaBK6tFFZw4AnUR+ahGhbw+zNLzQz6MXAKmKS9UpQgQfh/jvF8/8+x+3TsbwvwwEJk3SiRL6ZEehtfZ5ADvyMr30OqXtHf288KzszCpoYLFfbm4OecLR+yHxNq0GEwN8WC83lNbvarloae3LhC1jLghQrpetiGa5BaLo9hHSGO+DvFMqpQ7i5tLDq+pqmwBubkVdzUNHDJu0FxNl6KqtXkP0vs49S0yRnlOk/SLs05k84dtSRWNiA2EcVtZlNEXgufz+8Ft7SeZsIfYHg3799qRFMyOGvatOBAmX7bCCbgOpC2EfqZn22fK8RlTv2gemT22eG+Wx1Cuvu/ygJ8aqft2niE433IJhcdXAnWQpe93OTqhPx9iTV52XhgMfRt34jpBYvgu4NLewiyiLrkjqRkEHk8sUdC6iZD8SpGbjesl6iKvcL78=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjI5ODZBaXFOcXBRRU1rRjNsRDFmd1JqNzcrQ3VGblRYMEJGTzZQK1J2OS9M?=
 =?utf-8?B?NmhESHh1MGZwdUxaY2RvTzRjSDE5ODJCVDEzU09xOTB4TkJJSlVQZWlwd1Fv?=
 =?utf-8?B?OW1jTnorTE1waUxVNFQyOUplODA3ZnlnTkxCZE1DbkhUdkRYOVpoWmVFcVZ4?=
 =?utf-8?B?NGx6THNZU0NkUGFqYytsK3JiOWtGM1NmL0IxS1NGVXBKZmdTSGVqa2hLd1Vw?=
 =?utf-8?B?dUlQcGppTmF3SEV6QTVYUEg2Vnhpd2RXUHdKZmk0aDFKVFhidWdzQkFMV0h3?=
 =?utf-8?B?WFVvTEVyOE1zb0R5dkFocXZlQXo5U0drVEFrRVQwRnRnSDcxNUZPM0lKOGJj?=
 =?utf-8?B?aVhSSWFzamx5eS93bEVuSzM3d1c2RTh3UlBOZm9wSHVpdnlQQ0gwMUlQQzQ4?=
 =?utf-8?B?M1RiYXFsSjZDMVdLMVF5d0RtNFJveGlJZXRUTE1kWGVOTXRlbitpQS9mQkNT?=
 =?utf-8?B?azRqaTJVRG5lRU90MjkrcXByaW1aOWI0SkFDMTNNMXd2ZmVoQjY3WnFSMjZU?=
 =?utf-8?B?dndYUk02MzhkZ3doenJLV0lDQ3VzRnFNcDhYWWRIYkNxbWhMV1NGeE96cXZS?=
 =?utf-8?B?MVMzNmtMK1U2c0Q1V21qUkN5dUNIM29HeENIM3ZiUnpVREdWZ1p3bE5YVHhm?=
 =?utf-8?B?UnJENTRtTm5ac09rblU5cmpRbXpaWGVReUZJd0Z4bHFxMU81R2JzaTNyQlF6?=
 =?utf-8?B?NEczQktLK0MrQ2I4KzdJekFHUDlOZFoyMmVaZ09ZQjMwczJJcjBmK083dFF4?=
 =?utf-8?B?dVlqUmRsQWlwNTRJa3JnczV6dWhFWlB6bHd3cHl2MW45b0pielBEbHFuYk9M?=
 =?utf-8?B?YTVTTENkYWc3aFYxbmRieXhhZ3NmSHo4anhoNHlsT2JjdnRwUFFiZFBZejV0?=
 =?utf-8?B?OUhzenlSMkxWVklnSVh0WHBSRzEwOEF0NWhqSWhjY1lFRTBjRzNEVEtIMWpw?=
 =?utf-8?B?RG1WZk9uRTRPNEQ0N1dsSlVsbXl4OTBONGdqdFF6VEVKc2tmSDd4Q2ErSUV3?=
 =?utf-8?B?RDcvK0pEVWFEeGwzVHRKQ1RrR3VFaVpiUVpaaUFJNkFneVRaMmJ6SHhSS3Nz?=
 =?utf-8?B?NXRLVVgxNlBUK0Y2R0hBdkVzV00vaXg0QlNOMFRkVzFaRVd4VU0wc2xBbktm?=
 =?utf-8?B?SG5JR0lKUzl0N1hBUHQ1M1J1dzRnU0wwL1ZIcm5BV2Z6Mkg2QVBIK2daM3B3?=
 =?utf-8?B?clEyOUFRT1hlVDB3bmJFdnhBbzQ3TFpNUWJKY0Era3Mza3ZKSzdzQVRwYmVD?=
 =?utf-8?B?d3VIWG9DcUs4TU1Da3lhR29ZLzNDa21lb3JRVXg3YllMU29jNlNjTENXZG41?=
 =?utf-8?B?Z0FRcmpTTDFFdVdjb0dGb1RUNzYyTmR0c1ZlU3JueUc3RXhMUG5ZbXNRenpX?=
 =?utf-8?B?eGtFU21JUE1jRVpBbnJKR1ZyR0hiSkYyTXl0VlN2aVhxc2ttSm02WEZuS20r?=
 =?utf-8?B?VGxQeUwxWDdGdHo5Mmx2bHQ5Yk5CRVpjOSt0c3JmcUlNQ2x4dFBmSFJiRVFa?=
 =?utf-8?B?U21VNTdaZkZjYjZETjBEVlduVnFYMUZRTG44TTFIK2lvUm9jU0c4RDRJWmVq?=
 =?utf-8?B?SmRJVGoySndLZGlZZGxmSkxFQ1cxNXFFa2RVYytRVWNzclZpNUZEUm5ENG9s?=
 =?utf-8?B?Qm1JR2FlVUpQRWlJdzBvUU01dExpNlJBTkZDZXorV29JekNSa296U0Y1Mk9W?=
 =?utf-8?B?OG1JOEt0alRKd0xVcTlpU3BrL3U2U2dyT0ZYZmc2bWwvODJRNEVJWS9YL01L?=
 =?utf-8?B?SDMxYlZFdkJNRmhlWWpEVXk3OHMzY3lrajdGaXpZK2liUDZWR1BXQ2pmL0sx?=
 =?utf-8?B?ZWxZSFM0OFcyMzY1K3NhT0d2KzNiYjZJWE4xM3FSSUczNzFvb3hwRWczeHBG?=
 =?utf-8?B?TFBLeG81TGppZFd6SzBOTndNL0tOUUJNUzRxcU01TzBiQWlQTFdDb2VWREZs?=
 =?utf-8?B?Njh6NkU4a29ySXl0U1ZSUE5CeFBuSUl6bjZ5SUk1TFgrYXVJRGV1T0R3ZEhH?=
 =?utf-8?B?dVZnRjFKVUl2RTNQbHk1QUNKeWpaSTUxNXdiYWMwSjB6V2M3aVdrb0ZsZWtF?=
 =?utf-8?B?b3hSenpUY3RKdzRWS3Jod21SckoxeXRyOWZaMlY5OEMwMThxdkdnendwRGow?=
 =?utf-8?B?OEVpTDZnOGlaRWRndzYvWVRMakFUUVY5LzU0eTl2R2FDbjBvSjR2d0lQYS9t?=
 =?utf-8?B?TlFsTXZBVTlhS2s2ZmpZYURIYVhiMFVxcGxOZ0JWOUljS0Qza1owRkRrWkxH?=
 =?utf-8?B?bWhRbG1SS1hOZzlHT3VoYi9VajdXSGREVndMaDlieDVLeGN0TjdhV081Wk56?=
 =?utf-8?B?ZFU5dGJ3NlArNjRCOVZTTlVDQTMrenNEMmVlclBpUGlORURMbnJ2NUpwMDN6?=
 =?utf-8?Q?oNY8TkHofVsrs6gXgCkA3lRD9V82aN0W75ryyNYo6TQz5?=
X-MS-Exchange-AntiSpam-MessageData-1: 21RUo40S/oET0/CaMpWSA03EUABonfsMqAE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa4a6ae-7795-41ae-b4ba-08de8c317426
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:48:36.4174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3o34+iVsLfhNSlIlSTNkAzVS5FLPmgO2LQKFDbg2R7gglgUgdUIt0BanCsLOSvf59m6Pte8lfQM1nicP7TEKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11287
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7267-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,google.com,sntech.de,gmail.com,nvidia.com,rock-chips.com,starfivetech.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid,rock-chips.com:email,sntech.de:email,linaro.org:email,nvidia.com:email]
X-Rspamd-Queue-Id: 3EB82349545
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The tegra as well as a few dwc PCI controller drivers uses PM runtime
operations without including the required <linux/pm_runtime.h> header.

Similarly, pcie-rockchip-host, pcie-starfive as well as a few dwc PCI
controllers use the regulator consumer API without including
<linux/regulator/consumer.h>.

pcie-spacemit-k1.c uses of_get_next_available_child() and of_node_put()
without including <linux/of.h>.

It seems these function prototypes were indirectly provided by
<linux/phy/phy.h>, mostly by mistake (none of the functions it exports
need it).

Before the PHY header can drop the unnecessary includes, make sure the
PCI controller drivers include what they use.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Yixun Lan <dlan@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>

v5->v6: none
v4->v5: fix pcie-spacemit-k1 driver, previously missed due to limited
        build coverage
v2->v4: none
v1->v2: collect tag, adjust commit title
---
 drivers/pci/controller/dwc/pci-keystone.c     | 1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
 drivers/pci/controller/dwc/pcie-histb.c       | 1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 1 +
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 3 +++
 drivers/pci/controller/dwc/pcie-tegra194.c    | 1 +
 drivers/pci/controller/pci-tegra.c            | 1 +
 drivers/pci/controller/pcie-rockchip-host.c   | 1 +
 drivers/pci/controller/plda/pcie-starfive.c   | 1 +
 9 files changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 20fa4dadb82a..642e4c45eefc 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 5b17da63151d..e0079ec108ab 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -21,6 +21,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
 #include "../../pci.h"
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index a52071589377..432a54c5bfce 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/resource.h>
 #include <linux/reset.h>
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 18460f01b2c6..e417122da51d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -19,6 +19,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/module.h>
diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index be20a520255b..41316aa54106 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -13,9 +13,12 @@
 #include <linux/gfp.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/types.h>
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 06571d806ab3..3378a89580ab 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/resource.h>
 #include <linux/types.h>
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 512309763d1f..a2c1662b6e81 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -36,6 +36,7 @@
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..46adb4582fcc 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
 #include "../pci.h"
 #include "pcie-rockchip.h"
diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 298036c3e7f9..22344cca167b 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include "../../pci.h"
 
-- 
2.43.0


