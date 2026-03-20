Return-Path: <linux-can+bounces-7197-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDe+N9mtvGkb2AIAu9opvQ
	(envelope-from <linux-can+bounces-7197-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 20 Mar 2026 03:15:53 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A73F92D50FD
	for <lists+linux-can@lfdr.de>; Fri, 20 Mar 2026 03:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1761B30151DD
	for <lists+linux-can@lfdr.de>; Fri, 20 Mar 2026 02:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B16D30F958;
	Fri, 20 Mar 2026 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NCm+1Hqh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dYWjLkUZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7026521B9F6;
	Fri, 20 Mar 2026 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773972948; cv=fail; b=PCQbfwWXNfcWS/kI2CHIMcn/G8wn04XpDtDI9Hu/Em7LLMRhUW26AbeT4R/Hr7wy+jqoSN/mfWhxE3ruqV6dFh2DBXrmSfAVnVUq3sW+ksPBrLHhPqirTsL6f52f5i6ZV8bcjFAt0CzCmUjT9LF/Z0Mb+pqgU5sCR7teTw3KvbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773972948; c=relaxed/simple;
	bh=1ZoeDOxMhnex72tLDU2sZJlkSp6Y2R1ch09tJfrzIRw=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=c8p06M05hX626XxFXTgiG9UVIdzJoN7zx+d+SQsh5dHCf09Mnm6SgYTAWF7L1ohhFDF2Qf1uMgn6SfX7Aabm6m1tHOH6UaN21j4gyXF5EGJOjPslAsvMQfhg0zbiO9456jsZRm9PY+HlPVYodC84oj7QS6ng4JHXdhqmE9KccHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NCm+1Hqh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dYWjLkUZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JFudhc1949233;
	Fri, 20 Mar 2026 02:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=e4LFMg2KiFC1HRlDK/
	EH75+9Wt/J7M2f9XJJkwjZW0k=; b=NCm+1Hqh4Zz/N+Y8NYoccvlviaEs8jA3Wx
	K0mzWQBO2DRvDYqD1GnJknzRbcZ9FiTCsFqb6FSP5p+bgLArETde4dd5FYOOcZJy
	nFdjXr991KfHuMKQrx7+GxTj0ud/xEy1bX6TFLX/4CXf8cA+Q5guZL16HFTQaoue
	PpOKRfBFBAwF+tLjVzgsQ0+J7Ru3/uyIkUNZPGhZICdAgP7yrri7UOEEW/vA/JP0
	daEV2GDW3RqQ1QbMPacTfJlBXuDO3jzLXSyX8w3NJfYHD3CRmt7iysKZn/12HHo9
	2Kzmc24eTBAesjipYJFORVQOKeIM6QRtJP0y9CARdtSosw2LaG0w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyj68vsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 02:15:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62K1iJS9014100;
	Fri, 20 Mar 2026 02:15:24 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4dn74n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 02:15:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wkxkx1m5lqxchbh4xs6iimUG961baTvxttfY9bBuMbmezddL8k8q2FwNGJtpRxJOc3zKNdFKiKlBC6oRU4gyQhmh8UWX8UvGXwAeKmnLY4moF97CKqFEN19LLDFte0l6Au8cWdFprsRyzdDG1r03ZBGxD9PVnRrw7nHTIpZ/ahCucUyd58g8Df6kl45PTz738Q/f4KXLp3726d7x8IB8TT0HvD7klYttfX1JCH0go61p/P/bY/gELbLfD1s7LnLieAQ6N8sqZouKndAtUSK0gf53RHpNGJywbhc6f2M74MHv2I+CrSgTcTAFVu+4iU1Xk1X0ZYTD5ztQFiQeKQX9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4LFMg2KiFC1HRlDK/EH75+9Wt/J7M2f9XJJkwjZW0k=;
 b=BPIaHJyP5d2/vP4gcOLx2UNWdBSfboyCS7yK1B/0Ilb2rh5K2hd3VM8/WRjjZaQLZOd332eiBkxe46cT9v4lf3WyEDzhTf2wmEVdyYSyF7Jt8/5JCRtQWn8bS4QLd+HwppJe0QGyKjXTcpM/OkRmwnf+Toh+ue3+BA9bB/GZqHPmh5xNiJc3FEu/x8TQT5OKkuqagHHTJJN+jzo1KhgxRI80E+4tvH4e5usPTI+Q9RdqkM39asdEhlcBHTzp6XeeHtPpeDMMVRUXsbD1C6SV+YjnVLW6K6LoT+1yObKOOFNDcFUnmNVYzVILpiiSYpI4f0nk6JiJMSQsUtL3x4zBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4LFMg2KiFC1HRlDK/EH75+9Wt/J7M2f9XJJkwjZW0k=;
 b=dYWjLkUZuXuVlZmPikv6rIW5O14PwPFXeHrvDgQMCv5br7FZMQgcpK0sir9yuU263Dqp+jksu7rC+XQ88/YjsG8YmHdbc7cvpI1C/K1F3MO/1qSgJK9fIrl1tK/VjPly+Sk4rut4sHBtxgUE2/JnoASHjeuR6VZza/K5JJ5D3J0=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA4PR10MB8587.namprd10.prod.outlook.com (2603:10b6:208:55c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 02:15:19 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 02:15:19 +0000
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
Subject: Re: [PATCH v5 phy-next 09/27] scsi: ufs: exynos: stop poking into
 struct phy guts
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260319223241.1351137-10-vladimir.oltean@nxp.com> (Vladimir
	Oltean's message of "Fri, 20 Mar 2026 00:32:23 +0200")
Organization: Oracle Corporation
Message-ID: <yq1a4w3l04g.fsf@ca-mkp.ca.oracle.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
	<20260319223241.1351137-10-vladimir.oltean@nxp.com>
Date: Thu, 19 Mar 2026 22:15:17 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::6) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA4PR10MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: 9597bd68-9e17-433c-490c-08de86268867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Isij4SalK5vkUb6Sph8ACbKn/vLNdxeK5hYB5pt7n7NkbclMmRMLXUO1JdlxVu8V4t26O6Qgjv6E++vh4Fgg7kxQzrHclDWrxwodpFk4Rf4gbmamLqRYE0xHmtGYkF+2XVmEuTiHnRryu/ynWZIRvN0PrSauHV36bzQCXRZtt4p0EMzHTP9lDfQl+cizsKPX40qrodq9HZFLLIIDKvGFLi6PD2J+r3BZOD1mnwtj2rdEXsL6YI0oeQCGI29NNwhLAZozT6Nd0j/sn8VjPuJq8FkZBBVS0USawqSdPmr5dZTHkC7jP8KoZhPbOUKxHCOCQuoVZ/YbWYPDvFsJeeOtf7Ni4cvPpdu6hve/Kv6eKgZ0FnlCy+zxpERaUKcgeTzikQ6BCoilsO2sL0PjanNWyv1Thcwea/NJoKEIIAz0khAGXtvQf4ZpzvG5BrwejQYsnjQJ2XgdE5WsriBtEn9/hocwqfIZy6KpyqpgIfN+Pav1eun3IYBnpW/F9F70xCg9PzpTnnjVAu3q4MyDSGK5a5gVMyBgFNRNu+EnXCcadQqjwc0PJsJZr1ngYuWRSM06LJZLk9mpPRlSn06CH5OFckfuY7javhy+m51E8SwkCjQCFtNlY1dlWVZ1488BsDdiw0t0Vor0nT0YOVAi2Iqq3ws74VcE0G5NzTk/nhWQEW7p5fb2GxV1aYn4MyENN6OC1tYnXiawVA6ogaJiTxYV+aP2Qnq67KHYVQOzTdaXuSQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GADOBKCndiyZeNbnf8HfwAAJB3xS13V5z7jgy2z5BlkNuLjd5/vTJR3gIe1U?=
 =?us-ascii?Q?RUtuekBA/lYmg2yRS+gSIc+1jARl+VlI9Fs2i5x0UY0I6WLC7faivhYKDv8f?=
 =?us-ascii?Q?tALAS9XsuSzia1D0p3+akxmoBRnS2C4eulYWaFyezUo76eAQH14Hv2OpIxRE?=
 =?us-ascii?Q?Fj/XeKcXZ/pGdxAE1AiZ3Oa8BrQ4xcOYlY3ObT+5rzQYtH4z4NgU2PwWuQut?=
 =?us-ascii?Q?9he1wbaTp7YWTcseTQFUbwhKvLFyU2diIg1Kg+sZrD4dwCopYa0ZYxP7IyMS?=
 =?us-ascii?Q?svY7+wCdI6j0CWO0uIJFlDHaGcnW+eFgoPSBNSiTmOqn4fNpHIbyagQmNPMl?=
 =?us-ascii?Q?n5NpwsVZp9Dmvs0f8EiEOSQIEoG2xIZjw3Y9cLutrgRvgcwnbolE8zM4If8f?=
 =?us-ascii?Q?jP89k5Y0h/fH/IhLfkvpbkLGsJp0sbTUqXXChS6qZyWN5gOn/VRdbaetYpB3?=
 =?us-ascii?Q?KLUfnoPudm1SDQMU54hbUIoVkwDckQYH85niv4kPe9QCBWZIqGm14nZKqlPD?=
 =?us-ascii?Q?xTRBoFTX7kWtqqi1YIp7Kpn98cinr8wNuNfBl4XsPh2McMxu6tjLApq6Si/w?=
 =?us-ascii?Q?lJ3O7Zc5qqsC0nqA6x1xUQFu3kldPAvaosXh6zV50Xq4ntYMr9ykxI0mEg/T?=
 =?us-ascii?Q?0ladsb8qImvtaBhL+H3rQJYqq6rKg/rPAFJ0ZyAeIEO1nQ0PGKwp+2wSTzVM?=
 =?us-ascii?Q?oRqxSN06z475lOxoK3Oe/8IBz6j5wiWlwphm+TkVAio7c2vekagFcZDxzCHB?=
 =?us-ascii?Q?JZXNgtMJNFuO6jXDm4kZ6rgoK6dbPEA+WRMD9nlyVzu0ekzKS5StvNTFJIEC?=
 =?us-ascii?Q?qPz6bUOuHyFg0ZSTIiUKkRFkPQwV65Zh1gYY5GNkffHjPByzB0sa0KmeN74M?=
 =?us-ascii?Q?Ixxkg8D4YBSuNnkBya1C9wwvwg49VdY8nmEyCV4RI61xU1qtCYHL82eCPX+k?=
 =?us-ascii?Q?OR5r4ODhaiekUKmyTtNet1ptWR6k5iDNcookM/CrgfdHru1m8r4hWAKyN7pc?=
 =?us-ascii?Q?15ln1ZhNCrpgHe9/YZPl7g2F1i1/MN/tUb7iX+rPr6mOlivNiK/bU7UGqkgp?=
 =?us-ascii?Q?/nAkaJQRp0T33dZdMAUhVhNomMA7SfkysQf/zpDLDamIb5kA57JsDG6gNfbx?=
 =?us-ascii?Q?BEME7V230bftQe1PauICAte633l38H/NJJhWcHz1oS3efI/YP4Rx6AMvyHiP?=
 =?us-ascii?Q?eiw95SlKMZiDlVzepQP64x+Zln9kVpx6XYn/9MjMS2okFyy+UTwBDdDuLxqg?=
 =?us-ascii?Q?LaxyLRtfJ4PEsMrrSlhJGspmekS5l4i1cQ7o2TLZEiudcv7ilLj5+FME9WiR?=
 =?us-ascii?Q?QlU4nCteXk6MN0aRwBaOeCw7yQGZesGgi8H/1JLBu3hRIGf00ZxPfRFkl9vN?=
 =?us-ascii?Q?Dt5QjzJkNCk8YopNaGLSCAcyOyMfOAyqI6DZuhXYPzEnmtOJ1+syK/IgC84J?=
 =?us-ascii?Q?Hp8V6SEGOJRtnU5r4Vv5r4M2FvhghqwyQuoQvWEKqF+RgGIeG+eCuY2oOYTX?=
 =?us-ascii?Q?h3gB+9UadCT8M30d+Y30Ewzzsy/cXr/UlHnYMWlDcWOBzC4C1xD7gYQ4VzWN?=
 =?us-ascii?Q?sPn5SVcKn0LrFf8jJZxrM5XlVmeTfh3uwoi+p/LVEQ49JHA1yBsbmjrq8tAP?=
 =?us-ascii?Q?nUhjnbf5DCAhzVGdyhyMn9Wy1Zeig9+uoeSpVd0Qbn3BuxDAUqe4Uxj1Y/uS?=
 =?us-ascii?Q?7ApPYXgv5eRXx3Yik5ZKZwpFwwQTv67N/nIMuL9ZGBiCaztev+ZYq/bRkjap?=
 =?us-ascii?Q?dvfu3Cbau1E1UOsxSCkoYAyjCR+xbqg=3D?=
X-Exchange-RoutingPolicyChecked:
	nT+dhkAx6s9DfOKC67xMe4B3rWj0mPlg/55wTOMCxyrOXqOFHLhJefT2JWaJiHaT3oo0amqzAN3Cz2fXH515s8NnkLTLzF2P5Kgn4HhXkVgyHd5BeV0SZCTAVCZ5AH4hDqMpRlntz5hMlbMn22oI5RCpwZihNfXmbuRyOicq4Bdy56bjLSxaz+h5x8PKXqX4nX2wiqy3EA4sPRgWr2gu4W30PoeFUmNXzn+HNv0CsxqLB03TSCcPs0R97culdBZT23U9a8EJOHaYz6CDf8pR2Sb2BgYax50AZ3XBlAmaQgjhqbL2Jw/ItDnQ4E4b2g+xUg4Xfs24wDwk51iH9UqUGA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mhc2D9TyLR68DlFIdp+gaKJqoq98VOrvsExHMWs/jC0qqymj9nUWAhUgpKmGlg7iBCoAOg29Mb/+B9QLlgV8ORL3SDSrym/pCuAdHWzRoHu9NtpVYupU7YW4XRfHG35h8qPLOA/HP2ve6OarB9uurG5QOqZVk0VEwbzDTzOJEbw1EO69/X8DBRBQjTO6LPYqqDq9YIIIq8GijLWvQVy6p/ccB83/6XvWqwURCBSOIueAXiLrb1YSfMCPegkN/TKc8pN4PD7eEXfnnAeIk8bHhjVSTNjpzAEB1ECsffxJfKxbsc/H6FwDrEnQLCRvgrhTwKUxe014qB6yk0KHl9n8Tym9uXag+kNrGPlCqFMJcVgj33Ksxm+aGKyCLDCzEfZkHwaE6rWCbjUtetZvgCN5BDIzimKPQ8c+qklTnvxMe/x3cJIFdNJ0xWdy/hmm93U2rqTfjtKy+0+r5jE/wjVhhHsk0gyKWKtF2bfG7AFzJ/cHhP9TduRZ7XWOAnHKLSkzxu6dN7Rj03AXiPbS2AX0E7Mr8R+SkTI+ogXZnWdHFXlYgv6dgIrChl6rUjjkzyy/8v73Yn7y1w65LswK6rjdi/CqguKzcIBFgx/uEL8y2Ns=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9597bd68-9e17-433c-490c-08de86268867
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 02:15:19.0787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6DJcmw4KePw8UOMFfe+7DYbwBYNUYfLf9gAtUIsoqwwn9IMF2CXZM4FwTBt/yyS6n75ff1hy8Nq4red+2jQMQK/ABvFhO2XxSHaBRZUVxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=750 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603200016
X-Authority-Analysis: v=2.4 cv=LKFrgZW9 c=1 sm=1 tr=0 ts=69bcadbd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=MazYMTbE4VX3fH07rsQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDAxNiBTYWx0ZWRfX8Npg2O1Td+kZ
 tFOGPjoqnEYilc1YHWXI0NIOol/WEca1t0Lj9F3mXZ9wgzUu9hCjsLSzVehdAl11R9Nidpc8JoM
 VKxKt59DR8oOYM3JqibxOybvbF8Vq0ywNfhW68y0zghEsBewiB5iHIwXifpr2nseFr+DD+UukT0
 1g5GbkE1ipZHohNkKs9ungfa/PrHih6Zl5ghvV5bXXzzUzpBCqqSdcdsCCiee1/pECeWAJOG5/q
 Qiu80QGVxX4SB/MuaurYzIeATlVKX2ITmqePhMD/pjw3yqAD/TFSnLYcXuqMYFNNWr6HSpMVrv3
 GVrS+ToNX6gG3RrWAtTpnEM1McdmC8KO6JyxNSRk33Xk+NJNEGPncR828SgZIxmyR/kE7qWCbht
 ZFN5LsWCJ6X1czAJpp+Jb29Lr+vRvaQeyZQt0TklZgQnTnm8VtytJQwuFQQy72ircSKr34Huug+
 jXgDeE951jbaLC0GQ1Q==
X-Proofpoint-GUID: HsO257hzTrCyeZFJCkd6SsHTExLTVyyP
X-Proofpoint-ORIG-GUID: HsO257hzTrCyeZFJCkd6SsHTExLTVyyP
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7197-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ca-mkp.ca.oracle.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:dkim];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A73F92D50FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Vladimir,

> The Exynos host controller driver is clearly a PHY consumer (gets the
> ufs->phy using devm_phy_get()), but pokes into the guts of struct phy
> to get the generic_phy->power_count.

Ah, newer version. Would still like an ack from Samsung.

And I hit the wrong key, I did not actually apply this...

-- 
Martin K. Petersen

