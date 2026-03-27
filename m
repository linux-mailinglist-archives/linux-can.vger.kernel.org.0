Return-Path: <linux-can+bounces-7294-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB91GPDpxmloQAUAu9opvQ
	(envelope-from <linux-can+bounces-7294-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 21:34:56 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F22C34B105
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 21:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D61830F183B
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8723A2579;
	Fri, 27 Mar 2026 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sj7IiXU3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TN9hJ3DF"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD33A3E67;
	Fri, 27 Mar 2026 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642804; cv=fail; b=ZTXttcZ1YEKzEWM5GyVWM/di4WfOs7R+5XOMnW+0fiAnHk0SQAgxqVXevaX8ILwjlFzaByYAq19zsf1FyQlRgeJoPgmSY2zUCSsq4XZQ22TuSEeQzFaIHIaCqkwVul7DRJmc/7OzDWfFmqFl0sjCJU/AilK6lYZa4HxWhBPN64g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642804; c=relaxed/simple;
	bh=1pI8wbzhiYp978IbHanXMTOkaI+c+WYZIkg1V6BH4Uo=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=O3PoRcb/EGEj9mI/isNCnWTYFeRkNPid9ty7jEmj5xgRHeb2Unczx2kiCMtek896BRQGdiQUU0V43phDnMvgVMP9UKK4YkYeTIxBZo1DG3I/JeBmycF3ISSWp84vlwU2LmMOEe4phXBNSdnIianQO1gDeQ3DK07TT2orQ4Dzf9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sj7IiXU3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TN9hJ3DF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RGtxew2632402;
	Fri, 27 Mar 2026 20:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cqFpaiUiYhZJV9sJcU
	wqGpk3TcUc2GGQ1rDfuwV49BM=; b=sj7IiXU3NmAorHj2KAifRNT7p8ovJka/54
	ZtsngaCEl/70iwNj9jJJRpzVq0/vduQffd+fbiwjOwgKYCHR52s/dVE5XNHHYVAq
	HOMzMLYHMDzkJTjDgZkfmPfWn/6IJReITq8D0nC3UewXfKwfgFf/RxMgu0MMaucc
	Z4mxzsi+LgpfYfVURxuRBNIEwm7UmM+V6YmspFkpq6rxRCVnoQPEqD8LtGRPOO9b
	BBNsyjFwoJf9boxwOFR5iH4UhevamhVbZGUdxdF6qO242V3D/gXWdHHm/ftgPFv7
	YThYqEVjsmQjdgAaNjF8hN4acJGt3E0C+wtYYwiHP60zDrjhp1/A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1khw2tyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 20:19:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62RIB8wZ012635;
	Fri, 27 Mar 2026 20:19:34 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010000.outbound.protection.outlook.com [52.101.193.0])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsejgan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 20:19:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpVl40Bgi8ZPQHwsJS6bbHRCvUez+jp55xbR0DnhURm6hvI/7R+9kkqYXePVseGCxLwcnRZeqpziD/SEMwxH0S0km+gJOWWvQ4XsTEKlWn4L+zIRxUVIBZqUbA3eyBtgtqJJ2QXYAgev/lCosV3NYRxV6mLQp3I21iVT6B7OAc6Bu1FDpq1GmMe2aPOuXrpn8vWEX7bb09/4cJKUl5sisfOARatbIC59iOEkWxoZMtmel/TQeExEWucJd8zIU9DeAw0z+5voAjQ7Jup0ezwKC+cm66FViHPxrpXnDto5anOM92LvK2xVhs3fJRqNsb7wpL09GGc4V/KWrk2tSO0ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqFpaiUiYhZJV9sJcUwqGpk3TcUc2GGQ1rDfuwV49BM=;
 b=bYiD92MrblTz96zYz/IIBX+RVMrjhQh/Ot604ht13oWa5YcWRD3nOLYnfJFaYMa2Hf2gT2pOIbJ379AJc946sVMdkiDpLISwFmv/Ck4+rocBj1Yh1+2rlbJmmemBgQENFDpi2p0Sq4bXjY/vM6vIXbje6sZnkAsWPmlAoS8wefPIqMhmT1yLJLO38iWq6u6S8P0eqaWnTi4LwgDIwV8G5m4bfYxMA3vQhQ+1uNVj7FKdI7amcX9bYeNQSEx7v2sKWSxjBKWnQqDE64on9UW3JFDhY9YIRzElUQniG9UzOIaD4C+CfGsmrIt8uAqqVhrn1CRpnGzHcfjWqeLkJN6F9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqFpaiUiYhZJV9sJcUwqGpk3TcUc2GGQ1rDfuwV49BM=;
 b=TN9hJ3DFm139nBAIKy7CGhMof0Vgkur21gXhxzcaCTzI0KPKtZP+Np9b4THzeSaHo9QSDWXUCkxB4N9PSo+Rudu4WY3JYq8zV817f18LAy0dVLwbMwglSiV2X3SCRpL51Ss7wv73PuHLvwsNy4tQXbjA+Bc7ixuhfem0ZUYL1BI=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CY8PR10MB6850.namprd10.prod.outlook.com (2603:10b6:930:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 20:19:28 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 20:19:28 +0000
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: <linux-phy@lists.infradead.org>, Vinod Koul <vkoul@kernel.org>,
        Neil
 Armstrong <neil.armstrong@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-sunxi@lists.linux.dev>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
        <spacemit@lists.linux.dev>, <UNGLinuxDriver@microchip.com>,
        Bart Van
 Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Peter Griffin <peter.griffin@linaro.org>,
        "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH v6 phy-next 09/28] scsi: ufs: exynos: stop poking into
 struct phy guts
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260327184706.1600329-10-vladimir.oltean@nxp.com> (Vladimir
	Oltean's message of "Fri, 27 Mar 2026 20:46:47 +0200")
Organization: Oracle Corporation
Message-ID: <yq1zf3t9gc5.fsf@ca-mkp.ca.oracle.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
	<20260327184706.1600329-10-vladimir.oltean@nxp.com>
Date: Fri, 27 Mar 2026 16:19:26 -0400
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::32) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CY8PR10MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e69b93-b016-4624-4b8a-08de8c3e257a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HfXrAZxF/jac9F1RLYWHkrgZVLzrCYQA3TtATgKztagbNfp5AvZ2Yi1z8JKL2QEjvMDuK+zpb0uueV31dn4T+qlym8adZK4ljmBUf6jH7hotD37QUG1iHgfiFSJzu0jGQAU/1UVxzwDrHl5PdIQAFVH1XuTljFHOP5FXWz0cVWGy5IdGyHDNcxLGMgpeq7QdJCp18Qa86voGXhGIY46/vT2Udsc7+kw+8kRM17K3tIADHEAt5Ro/LGHzFaJKi/j9TSTYEbeg/XM3tIC86x8Rk2UYoWahcgDeT5JtqloBxhgjpyTSmwh1bPEr42YmaQvv9uuO4MTNsxQibfJzvCc8HNdpOplzRHsV1r2Cb+9ZfOb5pamkiNfdhDTZBpY+tai7AwZSKsrxcEjOeomUuMrazYuVebHWzRhtklBtq7D+hW4kc3AmUNhAlBOTeCv8GPDcReQ5qEvLNsTSKlLRUPToT1wwBFBFDO821TtLMJ4QNeVoVXftUDKnBPUa9yqGmLH24grEQlp68ZWl2gblg3YBONJQKh05hiF1IfcGQ506SnWlJ9BFbI22pYvydEsz4s50Wu1PgLh+FPOjIsGKU48asXIGAydgFGQ2d+CLL2a2y18uhKJhLuxXOLoP8/weRr9ulVDUByaHBByl66caFHI62scJ/eSMDZom0wCOOBkbfpd0W3U058tI1UTb0F00P3Jmg98Kj8HFZysATG7yrm7gRpYNi4mEooAsSxDuPiAI7ak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5iqZaBhuySgCrhf7EnC3Iec9JgLDNcGDcZuN/Ijt5tUlmhIdhZOtKXA7PzEC?=
 =?us-ascii?Q?PQQPzVOJ7dpsR8pvVCYfBnsR1Xs0Rmd4AaLw/3YBC7QP8um6buV5Tcqakk7/?=
 =?us-ascii?Q?MdSmQG9uiCbvvn0tsDwppDSnE9tsqQ+BD8WQFDmjKL6YBBiyfDoDAAAUC0sQ?=
 =?us-ascii?Q?YZ2zRZTcjMNueD/SOpn92+LWkj5XTQV72/Bej9tkASuMlo4BbSO8txswYFjM?=
 =?us-ascii?Q?7cp7KN34tSuGA5ETbA4JXiyCYFNqMesFFoqJ71yvcNtrubK1EpX7EvoKpiXC?=
 =?us-ascii?Q?QXVRzSEPfxkVNGTJaOKZ0mG1z40Jq7cRexbcDivFhSc+l9lB2qqYqpS/Cbty?=
 =?us-ascii?Q?uYyn4FQcyIVlIyQcEkzG7WKUG6gAFGWnVw+ddhIPZ0rr51PabMP3BWfGQ9qs?=
 =?us-ascii?Q?qxwAYHnsHk9zZ5N2Vt+5UYmME+6U9B3qpcYA+k8jJqHHSosH7onsGYIPyD/K?=
 =?us-ascii?Q?di/Vzg3QerGhuCIk+Q6sSY7oIaC/kk1DEH3Srq4b44s7kTutsSdE8UvoN3fE?=
 =?us-ascii?Q?P8Kq4vv6SVJPOIfFQfcXOjtq2kSekJJ0csW2cECzJtNe0qS5iTVSXcQDoxrv?=
 =?us-ascii?Q?JWhhK6hB1V5X67/1V7+2pMYVNVnP9PyCg1MJV8A8CqGFd36n3FyesfH3aPYp?=
 =?us-ascii?Q?HNZ319HNgihswF2GRL6FAOef1SnTvwlaGCRrdXhkLxHHM32RkVBDeXMnNB6f?=
 =?us-ascii?Q?0NZMDEzi7K9N9auDj4jfxtqGzA6rKOkn26I6quKsR+Ad327PTeqoYyKouH00?=
 =?us-ascii?Q?DJ9q8clUXMWKxX8WFcY05GbL/1w5jXDKe2XGs0S/U1UqrKcsFiikw2cm4xrv?=
 =?us-ascii?Q?9TVq/UMYp4n8Is+24PuRjE79xt+apN1chkCXj32ZVtPIlIBzZGo+TebkxKe3?=
 =?us-ascii?Q?X+NeFqFoiHIfz8ZAUOEsHhRumVXt6tfDydZh5zDMexf1ZqwzWEzJV+YPOndI?=
 =?us-ascii?Q?LILQWiMSgVR37jTgTioHJl8ehxQCD8+kh31h06YLfP0GDZY0OhI1LNzLCfGx?=
 =?us-ascii?Q?+Q/i6fNV31cwjWjOnul/VqSGf6SukALG6zU16YndutVMKIPfsPIV8BOyUR75?=
 =?us-ascii?Q?gNLowclhKCXuZIKyO9coB8GlDGkI6fXscmlfkFoTt0NGmdQavfcIMwogGGnl?=
 =?us-ascii?Q?U+7MoWoi2cqbqL21lIBB6KJWMl14tbdTmuGGk58J4JHi+NGvKv3rBoerJ3Nf?=
 =?us-ascii?Q?ir4/I/9aXdT3K01vh7ydDnig8RrTFR4hwszkRH5B2Z+bXR24F0puhKT5X+qK?=
 =?us-ascii?Q?cPb5+UhRWwZlTOq/luIJTuPM5Z4B33CErbo6EOE/yTrwrEq8KMF5Cxfyu7vi?=
 =?us-ascii?Q?Cj7MsvKBFvlu8P85TKVc/ySiMwJV9Kif5x/fmkHGwFCmcdOlFA5il/IiiyfY?=
 =?us-ascii?Q?i7Eth+O2brIoKmvfJCgVrQs/JecgXOgT9NCZlnAEMJvDoMgAziaHGo+2SRGn?=
 =?us-ascii?Q?onJXm2atnk81an3SwEPTdgp6ky74a7c4N7GNQocL2v8W526nX06uFzzmIDmn?=
 =?us-ascii?Q?MzwS6lTeZ+K/ZsrbWqgLzGxqE9/BUD7bfgBuYL0wf55DhUa9LirNolmDBWxd?=
 =?us-ascii?Q?SZ6FiCs0gkT0alUlvsZMB/U8KTRJxITcfm/gcqy4Jqa03HLBwWaAQgXGEXFK?=
 =?us-ascii?Q?luetRM0PdF8+ujahaBXfQaWSHbk2rRZItpJSmvMyzmdiXkOx33vzOOhMKeDQ?=
 =?us-ascii?Q?ARHuojCed+NWkb/h0ri9yzB4g6xUIrIJLFt6eIhSxw2KpM5rt+x+EnBN3nby?=
 =?us-ascii?Q?MJmIiZkbcE/xV+D9U976oF3AV1K50rU=3D?=
X-Exchange-RoutingPolicyChecked:
	PbmQAC00LKw8k/YjiuMp5Ru1qiU1WR1gvBFSoQ+nxZ4fKIzHcxqrpWTucCvweTgyarIMxU45S1hSoXe7STVKxg/xANU6biYvvZRnJ/moj1+3r7G1Vu1Aa07+GRuLQz5OpP5oc5DeSIYvK3aSIISlwcZL8nolKdsD/CQHRy9++KXV4WtpwGG6Nsebc7mCotlUiYd0yl6gtWsO9Judhjoc8X2MPDB/HARPDTj2jGn2nXvCqji+1b3L56l83MWQL/mNrYXfHlkBgfe/mDyDbw6zBW7NQB1E3C7O9wB1HHNdJWwgZE9y+vBU+4hkeHv9/8U1SogtKnbThnWQDq7RM9CvFQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lCd+6SuQlBGO6+FCW3VpCSCd4jkPJEBjVbt8l2uAOAOFUMrQV6fqNKe9DISRMoLvFmzEb2oTbgKgrCR3PJies7GAU85efYBPC+5WSEQvwQ204H33fsFQXBHLquwUM3SN7L3+WRQ/RI+gOmcdE3kxQzdBlg6rFBJ6ssaVWQBgW3ad1DtQgU0nBh9f3zp/gwXmCNv0zePsSaXBATp9zWpTaSHVUz2724xeFe75z6lXId3El/iBO85giyIhrGLGyDLvj0xrBMGwGXlvY1N0j/RKXpkwKfpYeytemXBkRfqhloHY7UqeAWnRHnthWBSf4jwK/dHbXSx8xUeaYcZLPzGjZF4CGWyWY5BOnvdq0i2v/MnZqK+QcWWr3+s/SKSTIZbyoSraqJP39SsWwrwT1lhMz7xzPrjmEQTAVLyoxBP4bafGizurTGRFw25jzmpOFY1C0+U2gYrG4nXgMPxN3WcOUmvCS1vZwta39XqITM5XP4iVksLBugqfj0KEUXcI2jEoJSFWAuDIiQWhpQ65IU50avUxzXs/Lx22CWm7bDKoBAukDvsuhWhDUuYir10jfq+dbx9cdbKHY4mVRYGJdZX2JpVml2ErTHV8/aFCQZcEy5s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e69b93-b016-4624-4b8a-08de8c3e257a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 20:19:27.9220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LK5QnGJeluLl6RUVMduc8qqhvz3NLDibxzf/jomR3/D3tx2JHLAccsy9n+h5jGP7AXyVbQE6D5wTGMz/D2JSLXQPFN4Rd0sAgIz9oo8KSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603270142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDE0MiBTYWx0ZWRfX1XH1GaoCCOEO
 qsxhYZ5npBuJ2gudCoR2lKJyjbYABpU4oOakSARk6imMJpRKZYuNu9BNfGo5+r85yY6BBLo0KDz
 f44W07fJFuX6YTpyHktKP1u34yBiBgZuDme+5RiCwnrDeNKzmjIzosShdPG6PrlUhFGFQ7hlQmq
 hyPVoi351ID+TZZsC61gYumrAuXDq5CFufJ9BbRW038QWyOdNvHRbaOn1KDIvkkvaEJIEJTccys
 PwJ+erNAJJh8D1APEs/5SPMrZoFW/2r7UuFc0sBTpWIdJp1OtOsqfP/u7TXag4tRXzyro94kgI8
 wK8NpFV/vAzXJwEr7oNSeSu5xmA1NuFlntWDIvC6rRTUsNLPDtKQ19w04QP9c+JUUD+O+akA9Mu
 aZ9Vob+HoFkqBSK57fp7CWjkHhQara6QwtabaOEorz6BFA/9MY5EFGj/QJdXwM6NM5MewCMwQRP
 mTy1i8HhMhzgWJBPLrg==
X-Authority-Analysis: v=2.4 cv=VIXQXtPX c=1 sm=1 tr=0 ts=69c6e657 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=6mumWSTpUwaCtAzzPUsA:9
 a=MTAcVbZMd_8A:10
X-Proofpoint-GUID: ezV6grP-geTb0GSzJTOtB3O7MOsjfBSY
X-Proofpoint-ORIG-GUID: ezV6grP-geTb0GSzJTOtB3O7MOsjfBSY
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7294-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ca-mkp.ca.oracle.com:mid,oracle.com:dkim,oracle.com:email,oracle.onmicrosoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5F22C34B105
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Vladimir,

> The Exynos host controller driver is clearly a PHY consumer (gets the
> ufs->phy using devm_phy_get()), but pokes into the guts of struct phy
> to get the generic_phy->power_count.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

