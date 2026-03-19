Return-Path: <linux-can+bounces-7180-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF6+OLB6vGnOzAIAu9opvQ
	(envelope-from <linux-can+bounces-7180-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:37:36 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF242D34A6
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C405E3029754
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D532341C2F2;
	Thu, 19 Mar 2026 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MqYh4NZX"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34BF407567;
	Thu, 19 Mar 2026 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959610; cv=fail; b=WFLtlj9gHi5j1u3s5IB5eOW2fKmdYvS90N5nBOFoblUcHnBh1QPuUvrQrnfVqH+hGbNa5HQTADtpIy23WyHM2sEwe1cC79uO1fuDslWnGqsEQf/6+P29KSAIwi3JOsC0FKvBPgBLJ8tSPQH8y7Q3lks2JFHVvoJvK4e1zMvd2C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959610; c=relaxed/simple;
	bh=XhxBXeCynE/3g1p/x3egvXCVwaKU6ocOAFxZPDZzmo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qE4iLSXaxpE1s3wXm8Oo+TsfdukvQ090djnxpgCLjR8/028xYP5biDHkPqMegHDzSRUEhha9tcufMsdzESH8TQdV8kQglIF57rH9Oo4clopNGvrpfVxxNv2KM6ea+kO6W3q9668jslsHrH+h1dotK3yrkiPRIRarfVcaQyexDhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MqYh4NZX; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGRGr/tIkC4KJCUP4V6s8dQ24DPTUDoubjY5mTyz+YsA3Sx35c8ZMYbixU+GurE6y/A361OaWuyZ3OeinvkEa5CEhPDYUpSBZKoU+i6A7P711Q+Is8QdtcyauGXj1hwH4zObLekY4lP9rP1xQwAeHnDIqPtWTIdbIoyjjP6gUnwl3FWz1oaNvw/b3Z8ITY+FUDbAUQ+T98MFslTlrQarAItGSAb1q99Txj/lb4jboZ5VGGxfrOStIEqsw3mZt8am7xwPw3aCZRsHMbHZVtxdHcdBVsY4mWvFFRdoRi5uaY3Q1TP6A19lJGfpFkkaapiZ6Ab/LFJKJUmBAwenSgv5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sif9q1Lijj+wlG1FcmxkRNgP31fZoUneA5ChpZGmSTw=;
 b=TBfILjqgrAluIYRRjAy+JCCcNRUTxvE6P9nQXD4n6w6dH0wJCEQ+dAE6jYxifczG+dhfOfhEHmXz0qEJZsbZ/kiD18wi/hii5uU7aRONIJbCKuUkXzJCAYxLDnF8BrATn8ug9eYpelpM7w8Htmkdimo5UNDa69x4d/dMlVGL7XZHr3orKt6PqwLj9iwj7guJVWtZfnl5DCjhNOTslUFGDQ2RCQlRZnUqDszs4HhniKHayOHPSZjOjHiwiTkZ2pBwUx2oTSUbavQ5/2x7Q2X9w6gUKj2/d0NVSXNJWE3OxSohqOZevZRuPL0N0YYdTgcVEeuKGvJfh1MXlIoQkqTAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sif9q1Lijj+wlG1FcmxkRNgP31fZoUneA5ChpZGmSTw=;
 b=MqYh4NZXDPMBPWGidavMBa+NDTScqpmGwS8DeUtOkwmw6ljNUd9KYvkgJ6DInu3EhHfOB+rsKYRUaFJ9GQ2WfzfqQ+wH7EaAGE5Av12gS61GwxKddOwMIVh3x2f1xQGbY6ptsnKPb2oM+q909k2kcpwVxd35A0vl/KygMITcGIQaGGUhHslwkrqE2/3RBCqOxA/U5etfet7F6sT7e6R6JeoaEi5D8ss+K/5sf99cvcWo7bmeaz6kpGNYlVOX/Xuwldf93Ck4o/gdVi+tsJuFK8HAFy6Lm75JcE0A6L7B9ml+tYLBPQ2rh9bQF6Muz73+RpXFTaZWWz3BgFsejwylqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8079.eurprd04.prod.outlook.com (2603:10a6:102:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:33:13 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:33:08 +0000
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v5 phy-next 14/27] drm/msm/dp: remove debugging prints with internal struct phy state
Date: Fri, 20 Mar 2026 00:32:28 +0200
Message-ID: <20260319223241.1351137-15-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0038.eurprd03.prod.outlook.com
 (2603:10a6:803:118::27) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bd2202-7827-427a-71ca-08de86077e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IDAMfuRJOpH9ZEFgFW47w12QTWeYUd5EBWU7Y24L51g+CujXdQYyMoQEgR3YriUGigoHAZMVtfzba8WpC/XLPq9IqXqUDRjA/Mgy6yQ51TfHCqlO/ZVEF5z9kn46TSoS2c85VOqN3BO4ilSppXsLo6K60i1BNfpoMXIobBjy25f/SEP7wdzMYw7oMVeD7kSe6ZRzuVrZT678/ILr69lwrJ/YXRur7So9irtszTbKtQq+xpHI+ueEH3nzpD8d1Lq3p3NW8/piGFQaGy/YJuAfhh/M7l4V7r2krTQzLePtoSBn85iTZSqGhLh1PCXPE1TgMSyUbU4GD/15CGPOuq21jxq20eH7Jms7yzNwv8ib4Py2GdwFkh93UnunZqW7uITzU22mIn99gUZQP7ptYaz9d08X/0Fvq7cH90sNeS470PQadoEfivlPftUBVQ+VcpoVFTQU46vNASzE68hvJshLD5EuhJimzYRdYi1OFUgMDrZJPNdeF7JSg4nEAVg/Xq2fBoxXkKyhVhNlkZnhFCms+cIdZ1Lu7UdXP6J4saI/WQ0kk8f6FPOG1oQbgIG819VrFtonNy3R5gLlxBmAdH26T6htRWVdsGOK284RAU+OEBv/PFRLkidcP1/UPGErNBSl9K6z0fn44+UL0GtIDzDleGZ76KPcpBpW37dtZKhYPYtkmHnYNEhBGeq/d9fakisWUeTkAeP3lwThnSc8fblcthJQL3XNZhzQQHty9ckt4C4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?izTiplA+QZVkfTIZbfTv2MrNuqZEhemCM/7KXb6fy1MwisBIVCZcHzx3ouRL?=
 =?us-ascii?Q?p5uMWu1CpFGyWt9O/aAZsIPFVoemicvVtUmbqL6/QLeKAc7Flc+lfNJb0esN?=
 =?us-ascii?Q?PfKoer7iawkeuBtCA3qf6Ak8/g/4nNl9xZrH3OPfAmv2TWV0wNOrh2sLr1rU?=
 =?us-ascii?Q?qSfwWe82poNBMWKs3skzHRgL/pCuvvcyFuTnXbNnt5qoUym/a2KTFcGqT9ND?=
 =?us-ascii?Q?kQWZ2RqgjCxBCrMlG9/4hT+O/bS7bjnuH1LANSyuFVGOuw6i7BdTpPeRVfWD?=
 =?us-ascii?Q?Cp5Etn8C7ZB4TC76Ao+g+cHuc026IME46ijsu6tUCNOBUvfYA9ljb7vxsIIH?=
 =?us-ascii?Q?DmgiMmTMltgIt7Ba4jLiakphBBu2BFwdLF+Yum7N0cdEAianvQW2WCduFuFB?=
 =?us-ascii?Q?WPBym3rZaT0Tz+vNNLLnfKc1JlQwfXzWnD3LRoz6JYxh2iEAPcBZRdkrc7oq?=
 =?us-ascii?Q?Wnex6TPSmspgLTQDTsWnO9KcL1P5z7JDIFdMdxX2G9nDP2ikZWnoAczD/ERU?=
 =?us-ascii?Q?CmAn3l3Atv7hMxon7HfNYtFHtPuTXVQCR9kKrNrEqo72kwclr/IQHAFpWUh4?=
 =?us-ascii?Q?utQcNESz25cJXgzP/vBNCPcqypzzkX85ly8dXB7bLwdfartEuVGmiQNhfjY8?=
 =?us-ascii?Q?5pI7sUEN2QXIGpnAU45WMj4D6vrsbyW5QW4CaWP0mW4Rtg3GWi5uhuLxOGak?=
 =?us-ascii?Q?6I8LndZZ9T2sRvokhPCHXSfnx/sf1NFIWZ0innGkJld7N4aMcMCY3KZHTlEV?=
 =?us-ascii?Q?OF9u4jVwKEcx8AtPOCH4LehQt+5lQ1qYS4C4KqOZg62/KmvmeTuOO/hd6fX8?=
 =?us-ascii?Q?3pWzvLLVy5h2zJOYWUIQsYD8gld4L/cRfyKa7q8aASH2D6PE3NCGkO3eTDNi?=
 =?us-ascii?Q?WAlVPa4zRBPUYdTUBAh5vO1pGbTFZasQEJajWxXi65ZR4XXelHhZQdBuoCJV?=
 =?us-ascii?Q?ab2/Som5ymIRRkWGPJz6v2xXlePOhh5Oqf2Rwn0DWnSmv8JrxHFlc69MRP8s?=
 =?us-ascii?Q?kv4HzVCBgcdvMTshGtZ7zoZ7lFzRy6k6K3t0L+/BgEKqO0+NIv1ffnzInQpy?=
 =?us-ascii?Q?iyf1TIWMtIT+GyZhU8dBL5iQLnd8XBGRnrohbCQgd6DW87RUT4trvLQH+8x0?=
 =?us-ascii?Q?qijDjTIwAjjoYxPKkVUsdcPJ1mGtIs0okVVf1qwGb1OhuI7Y04e5nScGD/ov?=
 =?us-ascii?Q?1y9x7S+mlpXWtinP98MgTl8aLd6KvwcNwEn9+jkAAKT/lO7DrwguoFRhoDv/?=
 =?us-ascii?Q?Fc9zFq968uKjjE6q0TGtmgID3ethvPNNRsKnlkDk6qG+3ynDF/xKbn6HGt0W?=
 =?us-ascii?Q?bgHoKIuHqXvW68QUiDBTWq9pRxlLwSh4dzNgOpsh7nObx5xUUYGZWsdOjuYd?=
 =?us-ascii?Q?M/a9cAWJIRmY2qOsoQ1S1u4CgsOPClkeHFbxIiWkDhJcTVpO9D/TGBNyKIgH?=
 =?us-ascii?Q?Uos+fsmnTOszhVmzt/qSID5E9r9VXCF8/uxEWS4QwnenBdYNFYj8IfcnWb1d?=
 =?us-ascii?Q?T0WPCt6R5YIvJaKGZQodgu+fuyOvOp2oARnW/WMmgltIOuO7opMD4YIQijkV?=
 =?us-ascii?Q?8ffbiR8Q44jJ1KLcQbCiINX66IPUBisinJAZwmev0ftEePwoTbZPOXjZfXKq?=
 =?us-ascii?Q?NPjbdVGCtx/PWIvP64mVRzGl99l44YHEumM5VvX945sC5hRtn061LMKWUwM/?=
 =?us-ascii?Q?5Vn/UkaVTErbUC0DN0Ae9PsykDZ8ilmxy1CtC0dYoRKo+8z09visEB25MB+I?=
 =?us-ascii?Q?+DrMR12rPXlyi7QXXZn4DHBvSPwWo92pxVzNaVBConVI9SjgZKt3JE4DnIqC?=
X-MS-Exchange-AntiSpam-MessageData-1: koogdrY/n4fuvMSm9CQvvItQKnG4EumcE1k=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bd2202-7827-427a-71ca-08de86077e7c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:33:08.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcMvl2IQcLQbnZkam8ucHe+0HnP/xd5vSzM9gsKUNApyN8tO307wisu2AS8k5ahh1E+/1RDXB1fHOrhP5K00cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8079
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,oss.qualcomm.com,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7180-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[somainline.org:email,ffwll.ch:email,linux.dev:email,poorly.run:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 9AF242D34A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These do not provide much value, and will become hard to maintain once
the Generic PHY framework starts hiding the contents of struct phy from
consumers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

v3->v5: none
v2->v3: collect tag
v1->v2: none
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index ef298c7d3e5e..cba8a71a2561 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1928,9 +1928,6 @@ void msm_dp_ctrl_phy_init(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_ctrl_phy_reset(ctrl);
 	phy_init(phy);
-
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 void msm_dp_ctrl_phy_exit(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -1943,8 +1940,6 @@ void msm_dp_ctrl_phy_exit(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_ctrl_phy_reset(ctrl);
 	phy_exit(phy);
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 static int msm_dp_ctrl_reinitialize_mainlink(struct msm_dp_ctrl_private *ctrl)
@@ -1996,8 +1991,6 @@ static int msm_dp_ctrl_deinitialize_mainlink(struct msm_dp_ctrl_private *ctrl)
 	phy_exit(phy);
 	phy_init(phy);
 
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 	return 0;
 }
 
@@ -2588,9 +2581,6 @@ void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	/* aux channel down, reinit phy */
 	phy_exit(phy);
 	phy_init(phy);
-
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -2606,13 +2596,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
-	DRM_DEBUG_DP("Before, phy=%p init_count=%d power_on=%d\n",
-		phy, phy->init_count, phy->power_count);
-
 	phy_power_off(phy);
-
-	DRM_DEBUG_DP("After, phy=%p init_count=%d power_on=%d\n",
-		phy, phy->init_count, phy->power_count);
 }
 
 void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -2638,8 +2622,6 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
 	phy_power_off(phy);
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl)
-- 
2.43.0


