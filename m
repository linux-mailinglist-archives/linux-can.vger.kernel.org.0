Return-Path: <linux-can+bounces-3967-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C618FB01EDC
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 16:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6411CA7ABD
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789B2E4992;
	Fri, 11 Jul 2025 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="dm1lniAd";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="fO5YZ8bs"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9D22D0C84;
	Fri, 11 Jul 2025 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752243484; cv=fail; b=swXDjmCZHU1mbt6zUHE2FX+X7lPdJ6rqrvdxXTLWY/IVLGAFb43b5eOv37wj/5NtqIVN1BUIEqPkrlrK8hwj24FoKczgHHTtYoprH07nv2jd/x0XQjM6jhpvmfRjB5qug6HzHO3A5jQJDsFAp/EL2wRJKP3uoQ4efQB8XAEwbBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752243484; c=relaxed/simple;
	bh=S0NLZaLCN4c0EmfdZWjglSb3g5RloRN8OZL/RLPHeX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8v4j0cr88UV0UNbLP6EkeMpuvphoi87VCnxJRTt+QRAq9SrcWAkVJMCkSajc3fLlvRlAxgE8sHFTh47vOxXSw1E+lxJwzXtTb3WrDMImG2G5UnzygQxHsWWYOXO25HxFa+6LY2gwcoHnmetfBMdvNnYjeDDR79p+sBNaQelQ58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=dm1lniAd; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=fO5YZ8bs; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220295.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B8NFAJ025526;
	Fri, 11 Jul 2025 09:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=uGbqe
	wZiK47Mz1A1RYmKo6WVBU4AegWA8I6vKAThXBE=; b=dm1lniAdDQLbmMpJ3m4nq
	rcgkbxRoIn0hC2rkO0KvJ99/4H2nwtbcoz6X3BtM2YhV+yTK7a/kbXEb19AmaOpA
	O3qKvC1hF36h0Rt4/Xw2BUbHE/1DNYzFXHQD62h2XgGY/w9ZNntsdVgiLKelJhAG
	1zAizkmLRplgUHoHYQGSJ4io/ED9kpU0DRAUiwfd49+LeZ+nUNFtVa/f/Ph4G1fy
	816OqWirXuqIAqT50BOKUHVeNsqzXVq9kJrhGNmdm6rpzIE6mslsrhQf284GRJS0
	26SBBJl+hsJ4yVJx9tNMcsD+oH989K/GYi2pOAl3bGAaS5MmAL+sB1dMnjNslPK2
	g==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2135.outbound.protection.outlook.com [40.107.101.135])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 47ty1srm9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 09:17:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebERa/6Yyq8OiePbfpKbmUyN4UW1p9o4dnQ1UpgExDN/5mKwcZF2I/ilRufTM7RJ3JJ0Nj+7oMh8k13JdzcCgpUQGxCRXEnjrZCnbRa5W3AOqvSLow3xJR/U03VO8pdHnkx4wE2nLRlgfoh36Y1/GnTukb7gJk6A1muFQUi/bmjXWCKi2v3es4MmQV5uhfzgTgf1i7MmxDj8kMT8M+oi/5FQc9Knb7T/1wehND3bmPcJmI09HZ/f1BUroBEklV06bwxPKR95FrmMrDHF1SyxBAhPub6/PxPeofeZYdu3++Psgxa+h/z8Ie0RQXS60XaFF8J6iuMGKIBlf2jQ9R7FGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGbqewZiK47Mz1A1RYmKo6WVBU4AegWA8I6vKAThXBE=;
 b=pY1ZL1tMAcbW+kkhYQ/AeO+ktjOeXtEcYWz3dClSp76V9eRAGNrhE0G4i/tvbDx487b9nmRvNpETUgzDXVb97qyXVjjz2IpXNNUBHT8rDV5Vl4v55aPk0eZfrZQedQQqdr+ecccJHQXJLXRn1TJsngK6efjD/IKH7riOzgBazAYykfgPi99s3dvWxRr5/Ue5bBlKf6yPwKJb+Z9IBtvtre38hWkeXgscQFdSiOXrY9qfbBC4X7Gyc4L1zr35tYUKFxYVeSbZ1qJrE/GSHNGk4gmyuMvtLztGhe8btIRGbNsT8ZAdXUo5LSg+yQGBAesBuTnk8g3FbUGqH0j4pNxoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=garmin.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGbqewZiK47Mz1A1RYmKo6WVBU4AegWA8I6vKAThXBE=;
 b=fO5YZ8bsgSH00B/lj2lsH6I7AM3hnbc4TE2voqZkybpM9u25IhUgt858SqqxQSF6CFA29CdECveXBkjVY41mOuH1b9zuK2xtteKyAZ+EvPT2e/RVnt4suUX5d3EfuiElPiMJKYRl8IxI62uyoQeSuuRpjhFAI1npy6JUPv1B2IaI2cMdh2YJwmc13slz773+7d+V2cs2k1fSO8KfhQITuNlLFtCKWUgAXOoAulCXeofYXkgGHVRSYm28xp77ISmHeZ8IAYbLsTWoVIzWfHQAwFs0CJQBK36UPEY3BlTgrC58DyNhXp2zR6EBFJIFaQ/0b+5M/P5Ibe43qZLfbVTOVQ==
Received: from CH5PR05CA0022.namprd05.prod.outlook.com (2603:10b6:610:1f0::14)
 by BY5PR04MB6550.namprd04.prod.outlook.com (2603:10b6:a03:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.31; Fri, 11 Jul
 2025 14:17:44 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::99) by CH5PR05CA0022.outlook.office365.com
 (2603:10b6:610:1f0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.11 via Frontend Transport; Fri,
 11 Jul 2025 14:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 14:17:43 +0000
Received: from OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) by cv1wpa-edge3
 (10.60.4.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Jul
 2025 09:17:29 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Jul 2025 09:17:30 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 CV1WPA-EXMB1.ad.garmin.com (10.5.144.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Jul 2025 09:17:30 -0500
Received: from OLA-JW4GN34.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.72) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Jul 2025 09:17:30 -0500
From: Brett Werling <brett.werling@garmin.com>
To: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>,
        <brett.werling@garmin.com>, <bwerl.dev@gmail.com>
Subject: [PATCH v2] can: tcan4x5x: fix reset gpio usage during probe
Date: Fri, 11 Jul 2025 09:17:28 -0500
Message-ID: <20250711141728.1826073-1-brett.werling@garmin.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250708181154.2987123-1-brett.werling@garmin.com>
References: <20250708181154.2987123-1-brett.werling@garmin.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|BY5PR04MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 66221016-fd79-4599-f869-08ddc085b3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RufeVU08fMlxqBFgf7sb4Z7EB0aNN7jaCVwJedPm7UImrtox/WFs+0P3DsT7?=
 =?us-ascii?Q?G6oDeQgnnSl6vIW+/CFb7SVJR8mawJSUz7n3vRhtv6iuw4PUNuFAfAv7PaTt?=
 =?us-ascii?Q?eWOk4vivmHv19MuDGsNHQxRgwNLa0g8X7LYl17YEyL4AjOp7gaQAxDJKYP5q?=
 =?us-ascii?Q?vRal/khveCFnqzU8dMb594X7rMnae56slM16aFGF//5IvKI2amltIVorx/kD?=
 =?us-ascii?Q?z6UMnCtu4fzUPc5LMzB5YqilcZWDTcqBwSr4+ueTDhUZ3vG56dipeN89OzMz?=
 =?us-ascii?Q?E/QHyfsNfuF0Ab5xzGRGQpJrNqnQp7xxWtqH9K8UkhLmfGGXuy82M8MFqWcv?=
 =?us-ascii?Q?GEd/KfFUm00364hEsIu6u13DjEh0EsXSPwsa4SidmYoK1jxUELVsZU8egXbJ?=
 =?us-ascii?Q?WDTYc0dKRAHT8BYfdivrG3Z1qjW0qsXFyrWizc8O2127bi9VV/zaOyA65nVG?=
 =?us-ascii?Q?gZ125j5UEcvWhB6QWApTCXq/JCb1Zhgy4tZ0O3Gm8IY32835XXlTeytWEAMm?=
 =?us-ascii?Q?SMeAoho3wKk3qn6lfmmyXcGgaGehAp65ZzsUSCVGBGCXkOaO8BJNod9A+KlH?=
 =?us-ascii?Q?5n3oVZWWj7R92YUA2JbrmZcH45Ll7JnskF6e/UhZz7etGWqk/gcBTrhOGQ08?=
 =?us-ascii?Q?T/cR1lMUwYwFZQTFv+Q50EVlVtQi3RY49twOM88963Uf7nI89fNbKR+jroqB?=
 =?us-ascii?Q?MpGX9ehuEPnV2HlMmlfR4EXTz+dw4yZQhSbqskydZZaD4GUH1grZDWJpbLP9?=
 =?us-ascii?Q?I/Gq85zB1uGh585X8QtFm9XBzKIJWpgOgccUQK9ha904xSNkq17Myk7YIc9s?=
 =?us-ascii?Q?c2kkUqFkLA+Jmbo1t0FGOTXBRa61dO0e904R+H0p1lJ0Xs1shXblMSIrZlp0?=
 =?us-ascii?Q?a5v1ovl7F2eZ7el5ZJsdYud8tP3TxlDvgFBkPTThx5YUpYSlaXwJRxhkCa40?=
 =?us-ascii?Q?vftUJ5dG7pRgfgnZu6u12/HjJo2XjRvuXKKerKusm/VP5s9hc7gUcJG87mXB?=
 =?us-ascii?Q?gpUeeZJA3DLKf/k1zd7WfiCgA/agxEhAwCeapkVBJW4kZGlXLhQamOgSDL/K?=
 =?us-ascii?Q?DIKJ2O6UCEtu/9wy8+8xpWn49EC0+cg58wID5Ekdo4YFmhPecfUwsP4m4gu3?=
 =?us-ascii?Q?oQXndTTYcHybWuxT8zUvBpACqWZiOGvzgU8lSHNgMDQAsfkn3g6W9cyHkGY7?=
 =?us-ascii?Q?P7NJNHSEHME85+6sjsnei3aWg63MBdxdjoTgW7XTyjDHicRfigaKWALBKQEZ?=
 =?us-ascii?Q?oLDquyEnnOxd94dvVsBMKhAizaKRANj8o2yG+hrGTSqv8rKuS85+QC7SzWu2?=
 =?us-ascii?Q?l+bbf9atpMSZ+A6UKi5hNLpGy+JRq93BwQ1zW/zKM4EaH8sqwOU00xlqMJWT?=
 =?us-ascii?Q?WMmBfor3JQQXis0txeM7CsILDGgB29PMwWMMhCYtfSXeqSruZVhUyr/iWZBe?=
 =?us-ascii?Q?GtUUT0JtjRAuNbmWdQ1rpzPXwZmTurvO/UZhoYYlAUBCUbPTYC67b/M+LZZu?=
 =?us-ascii?Q?4fDiIAev2XA+GHoz1/CKX0RtPaP45sE68f28?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 14:17:43.6985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66221016-fd79-4599-f869-08ddc085b3e3
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6550
X-Authority-Analysis: v=2.4 cv=NdXm13D4 c=1 sm=1 tr=0 ts=68711d0c cx=c_pps a=cK+zxNpI8eKIrDTBxIddkg==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Wb1JkmetP80A:10 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=A8m-6ulFSmVBG3JXLxQA:9 cc=ntf
X-Proofpoint-GUID: W7ZCsK1gm4xThicScgHzaegefed0ELan
X-Proofpoint-ORIG-GUID: W7ZCsK1gm4xThicScgHzaegefed0ELan
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEwMSBTYWx0ZWRfX8ifpvHgkrfVO EWBjQbt1jiU3EeAs4gCKKCoQGefLo77iPlA25xXDdspTF735t1T61EfH/xuTXX+zFZeD/8F8aaf VyYcz1v6eB+xARoLcnPpiE3PrSwktmFqQxLExhgrVu1OuOxDPdw96R0Hcuex4RpBz1kxkoRc5gF
 vaF1tdVDG0o6PKIcSZ7zzb4zMIIspSQK0u2kknT/ItKiijif29h5kVndCOsG6dfbngghk7yNCES VG42oYExHePf6weDejuSIR02nuJvEDyir5uI84fMv6vv0iHXsmGoR9MlcQylxvRXhKIu7zbvOVt z8eQBrVUqRmk1GTnfOY3whCmK934yAMGwYI4zgt+eAWue2uHR7pdNIupGe7oW7fau8XwBKSShSx
 t0tDcGmEPBqaqyCummpf8kIGxShPIVgnBZDOs+And/94zLRPVoly+G07hXJUSVoUi4aOrfEA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 adultscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2507110101

Fixes reset GPIO usage during probe by ensuring we retrieve the GPIO and
take the device out of reset (if it defaults to being in reset) before
we attempt to communicate with the device. This is achieved by moving
the call to tcan4x5x_get_gpios() before tcan4x5x_find_version() and
avoiding any device communication while getting the GPIOs. Once we
determine the version, we can then take the knowledge of which GPIOs we
obtained and use it to decide whether we need to disable the wake or
state pin functions within the device.

This change is necessary in a situation where the reset GPIO is pulled
high externally before the CPU takes control of it, meaning we need to
explicitly bring the device out of reset before we can start
communicating with it at all.

This also has the effect of fixing an issue where a reset of the device
would occur after having called tcan4x5x_disable_wake(), making the
original behavior not actually disable the wake. This patch should now
disable wake or state pin functions well after the reset occurs.

Signed-off-by: Brett Werling <brett.werling@garmin.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 61 ++++++++++++++++++---------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 8edaa339d590..39b0b5277b11 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -343,21 +343,19 @@ static void tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
 		of_property_read_bool(cdev->dev->of_node, "ti,nwkrq-voltage-vio");
 }
 
-static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
-			      const struct tcan4x5x_version_info *version_info)
+static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
 	int ret;
 
-	if (version_info->has_wake_pin) {
-		tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
-							    GPIOD_OUT_HIGH);
-		if (IS_ERR(tcan4x5x->device_wake_gpio)) {
-			if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
-				return -EPROBE_DEFER;
+	tcan4x5x->device_wake_gpio = devm_gpiod_get_optional(cdev->dev,
+							     "device-wake",
+							     GPIOD_OUT_HIGH);
+	if (IS_ERR(tcan4x5x->device_wake_gpio)) {
+		if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 
-			tcan4x5x_disable_wake(cdev);
-		}
+		tcan4x5x->device_wake_gpio = NULL;
 	}
 
 	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
@@ -369,14 +367,31 @@ static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
 	if (ret)
 		return ret;
 
-	if (version_info->has_state_pin) {
-		tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
-								      "device-state",
-								      GPIOD_IN);
-		if (IS_ERR(tcan4x5x->device_state_gpio)) {
-			tcan4x5x->device_state_gpio = NULL;
-			tcan4x5x_disable_state(cdev);
-		}
+	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
+							      "device-state",
+							      GPIOD_IN);
+	if (IS_ERR(tcan4x5x->device_state_gpio))
+		tcan4x5x->device_state_gpio = NULL;
+
+	return 0;
+}
+
+static int tcan4x5x_check_gpios(struct m_can_classdev *cdev,
+				const struct tcan4x5x_version_info *version_info)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
+	int ret;
+
+	if (version_info->has_wake_pin && !tcan4x5x->device_wake_gpio) {
+		ret = tcan4x5x_disable_wake(cdev);
+		if (ret)
+			return ret;
+	}
+
+	if (version_info->has_state_pin && !tcan4x5x->device_state_gpio) {
+		ret = tcan4x5x_disable_state(cdev);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -468,15 +483,21 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_m_can_class_free_dev;
 	}
 
+	ret = tcan4x5x_get_gpios(mcan_class);
+	if (ret) {
+		dev_err(&spi->dev, "Getting gpios failed %pe\n", ERR_PTR(ret));
+		goto out_power;
+	}
+
 	version_info = tcan4x5x_find_version(priv);
 	if (IS_ERR(version_info)) {
 		ret = PTR_ERR(version_info);
 		goto out_power;
 	}
 
-	ret = tcan4x5x_get_gpios(mcan_class, version_info);
+	ret = tcan4x5x_check_gpios(mcan_class, version_info);
 	if (ret) {
-		dev_err(&spi->dev, "Getting gpios failed %pe\n", ERR_PTR(ret));
+		dev_err(&spi->dev, "Checking gpios failed %pe\n", ERR_PTR(ret));
 		goto out_power;
 	}
 
-- 
2.50.1


